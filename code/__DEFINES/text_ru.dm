// Тут лежат процессы, предназначенные для работы с кириллицей.
// В частности, большая часть кода, фиксящего "я", находится именно тут.
// Документация тоже туточки. Читаем и мотаем на ус.

/*
Суть фикса "я":

Эта ублюдочная буква имеет код символа 255, а он зарезервирован в BYOND для своих ублюдочных целей.
В частности, "я" (0xFF) используется как первый байт "макросов" \proper, \improper, \red, \green и подобных им.
Да, BYOND юзает свою собственную двухбайтовую кодировку в качестве надстройки над ASCII. Браво макакам-разработчикам!

Чтобы "я" отображалась нормально, не исчезала и не пыталась красить цвет в зелёный, необходимо заменять её HTML-кодом символа.
Однако этот процесс ломает "макросы" бьенда. Обычно они не отображаются, но после замены "я" на код они вылезают в виде "я~" или "y~", где "~" - хуита.
Поэтому самые частые макросы, \proper, \improper и \t, мы тоже выпилим.


Буква "я" должна заменяться, либо на входе, либо на выходе, процессами:
  sanitize_russian() - заменяет "я" и срезает макросы.
  rhtml_encode() - заменяет "я", срезает макросы и эскейпит HTML вшитыми средствами бьенда. Полезно на большинстве входов.

Замена происходит на "&#x044f;" - HTML код "я", стандарт Unicode.
Этот стандарт юзается HTML-окошками, на которых держатся почти все интерфейсы.

По дефолту в фиксе "я" эти процессы вставляются в stripped_input(), stripped_multiline_input() и reject_bad_text().
Это покрывает собой почти все входы, используемые игроками.

Ещё в reject_bad_text() закомментирована строчка "//if(127 to 255) return", которая заставляет реджектор слать кириллицу лесом.


Есть ещё один нужный процесс:
  russian_html2text(msg) - заменяет "&#x044f;" на "&#255;", стандарт CP1251.

Нужен он потому, что чат и не-HTML часть интерфейсов бьенда принимает только кодировку системы, а она у нас CP1251.
По дефолту используется в to_chat() и везде, где нужно вывести русский текст в бьендоокна вроде input().
Ещё Win-1251 используется в "name" объектов, но кириллица в "name" в любом случае вызывает дохуя проблем. Видите такое говно - смело выпиливайие.
*/

/*
Суть фикса TG UI:

Все динамические данные попадают в TG UI в виде JSON-объектов. Объекты берутся из бьендопроцесса json_encode().
Вот только этот процесс считает, что на входе всегда CP1292, и переубедить его нельзя. Как результат, русские буквы кодируются в абракадабру.
К тому же "буква 255" и тут выходит боком: бьенд режет её и символ за ней, принимая их за макрос.

JSON на выходе - строго ASCII, строки закодированы в Unicode, все Unicode-символы имеют вид "\u0000", где 0000 - код символа.

Процесс r_json_encode() - обёртка над json_encode().
Перед энкодом он заменяет "я" на код. После энкода заменяет коды всех "кривых" символов на правильные руские, и TG UI начинают работать как надо.
*/

// Revised by RV666
#define ASCIICODE_RUS 192 // ASCII-код первого русского символа. Все коды после этого - русские буквы
#define LTR255_ANSI ascii2text(255)
#define LTR255_CP51 "&#255;"
#define LTR255_UNIC "&#x044f;"
#define LTR255_ANSI_UNIC(t) replacetext(t, LTR255_ANSI, LTR255_UNIC)
#define LTR255_UNIC_ANSI(t) replacetext(t, LTR255_UNIC, LTR255_ANSI)
#define LTR255_ANSI_CP51(t) replacetext(t, LTR255_ANSI, LTR255_CP51)
#define LTR255_CP51_ANSI(t) replacetext(t, LTR255_CP51, LTR255_ANSI)
#define LTR255_CP51_UNIC(t) replacetext(t, LTR255_CP51, LTR255_UNIC) // Меняет стандарт "я" с CP1251 на Unicode
#define LTR255_UNIC_CP51(t) replacetext(t, LTR255_UNIC, LTR255_CP51) // Меняет стандарт "я" с Unicode на CP1251

/proc/has_ru_letters(text)
	var/L = length(text)
	for(var/i=1 to L)
		var/ascii_char = text2ascii(text,i)
		if(ascii_char == 255) return 2
		if(ascii_char >= ASCIICODE_RUS) return 1

/proc/ascii2str(text)
	var/t = ""
	var/L = length(text)
	for(var/i = 1 to L)
		var/a = text2ascii(text, i)
		t += ascii2text(a)
	return t

// Срезает бьендовые "макросы" с текста.
/proc/strip_macros(t)
	t = replacetext(t, "\proper", "")
	t = replacetext(t, "\improper", "")
	return t

// Меняет "я" на код, попутно срезая макросы.
/proc/sanitize_russian(t)
	t = strip_macros(t)
	return LTR255_ANSI_UNIC(t)

// Срезает макросы, меняет "я" на код И эскейпит HTML-символы.
// Никогда не пропускайте текст через эту функцию больше чем один раз, на выходе будет каша.
/proc/rhtml_encode(t)
	t = strip_macros(t)
	t = rhtml_decode(t) //idk maybe it'll do
	var/list/c = splittext(t, LTR255_ANSI)
	if(c.len == 1)
		return html_encode(t)
	var/out = ""
	var/first = 1
	for(var/text in c)
		if(!first)
			out += LTR255_UNIC
		first = 0
		out += html_encode(text)
	return out

// По идее меняет коды символов обратно на "я" и меняет HTML-эскейп обратно на символы.
// На деле не используется, ибо зачем?
/proc/rhtml_decode(var/t)
	t = LTR255_UNIC_ANSI(t)
	t = LTR255_CP51_ANSI(t)
	t = html_decode(t) //Подозреваю, именно это имелось ввиду, а не rhtml_decode(t)
	return t

/proc/char_split(t)
	. = list()
	var/L = length(t)
	for(var/x in 1 to L)
		. += copytext(t,x,x+1)

/proc/ruscapitalize(t)
	var/s = 1
	if (copytext(t,1,2) == ";" || copytext(t,1,2) == "#")
		s += 1
	else if (copytext(t,1,2) == ":")
		s += 2
	s = findtext(t, regex("\[^ \]","g"), s) + 1 //find first WORD character (letter char) excluding prefix, +1 because fuck byond, \\w instead of \w because fuck byond, rw instead of \w because fuck byond, fuck this shit I'm out
	return r_uppertext(copytext(t, 1, s)) + copytext(t, s)

/proc/r_uppertext(text)
	var/t = ""
	var/L = length(text)
	for(var/i = 1 to L)
		var/a = text2ascii(text, i)
		if (a > 223)
			t += ascii2text(a - 32)
		else if (a == 184)
			t += ascii2text(168)
		else t += ascii2text(a)
	return uppertext(t)

/proc/r_lowertext(text)
	var/t = ""
	var/L = length(text)
	for(var/i = 1 to L)
		var/a = text2ascii(text, i)
		if (a > 191 && a < 224)
			t += ascii2text(a + 32)
		else if (a == 168)
			t += ascii2text(184)
		else t += ascii2text(a)
	return lowertext(t)

/proc/pointization(text)
	if (!text)
		return
	if (copytext(text,1,2) == "*") //Emotes allowed.
		return text
	if (copytext(text,-1) in list("!", "?", "."))
		return text
	text += "."
	return text

/proc/intonation(text)
	if (copytext(text,-1) == "!")
		text = "<b>[text]</b>"
	return text


GLOBAL_LIST_INIT(rus_unicode_conversion,list(
	ascii2text(192) = "0410", ascii2text(224) = "0430",
	ascii2text(193) = "0411", ascii2text(225) = "0431",
	ascii2text(194) = "0412", ascii2text(226) = "0432",
	ascii2text(195) = "0413", ascii2text(227) = "0433",
	ascii2text(196) = "0414", ascii2text(228) = "0434",
	ascii2text(197) = "0415", ascii2text(229) = "0435",
	ascii2text(198) = "0416", ascii2text(230) = "0436",
	ascii2text(199) = "0417", ascii2text(231) = "0437",
	ascii2text(200) = "0418", ascii2text(232) = "0438",
	ascii2text(201) = "0419", ascii2text(233) = "0439",
	ascii2text(202) = "041a", ascii2text(234) = "043a",
	ascii2text(203) = "041b", ascii2text(235) = "043b",
	ascii2text(204) = "041c", ascii2text(236) = "043c",
	ascii2text(205) = "041d", ascii2text(237) = "043d",
	ascii2text(206) = "041e", ascii2text(238) = "043e",
	ascii2text(207) = "041f", ascii2text(239) = "043f",
	ascii2text(208) = "0420", ascii2text(240) = "0440",
	ascii2text(209) = "0421", ascii2text(241) = "0441",
	ascii2text(210) = "0422", ascii2text(242) = "0442",
	ascii2text(211) = "0423", ascii2text(243) = "0443",
	ascii2text(212) = "0424", ascii2text(244) = "0444",
	ascii2text(213) = "0425", ascii2text(245) = "0445",
	ascii2text(214) = "0426", ascii2text(246) = "0446",
	ascii2text(215) = "0427", ascii2text(247) = "0447",
	ascii2text(216) = "0428", ascii2text(248) = "0448",
	ascii2text(217) = "0429", ascii2text(249) = "0449",
	ascii2text(218) = "042a", ascii2text(250) = "044a",
	ascii2text(219) = "042b", ascii2text(251) = "044b",
	ascii2text(220) = "042c", ascii2text(252) = "044c",
	ascii2text(221) = "042d", ascii2text(253) = "044d",
	ascii2text(222) = "042e", ascii2text(254) = "044e",
	ascii2text(223) = "042f", ascii2text(255) = "044f",

	ascii2text(168) = "0401", ascii2text(184) = "0451"
	))

GLOBAL_LIST_INIT(rus_unicode_fix,null)

GLOBAL_LIST_INIT(rus_utf8_conversion,list(
	"А","Б","В","Г","Д","Е","Ж","З","И","Й","К","Л","М","Н","О","П","Р","С","Т","У","Ф","Х","Ц","Ч","Ш","Щ","Ъ","Ы","Ь","Э","Ю","Я",
	"а","б","в","г","д","е","ж","з","и","й","к","л","м","н","о","п","р","с","т","у","ф","х","ц","ч","ш","щ","ъ","ы","ь","э","ю","я",
	"Ё","ё"
	))

/proc/r_text2utf8(text)
	var/t = ""
	var/L = length(text)
	for(var/i = 1 to L)
		var/a = text2ascii(text, i)
		if(a == 168) a = 256 // Ё
		if(a == 184) a = 257 // ё
		if(a < ASCIICODE_RUS) t += ascii2text(a)
		else t += GLOB.rus_utf8_conversion[a-191]
	return t

// Кодирует все русские символы в HTML-коды Unicode, попутно срезая макросы.
/proc/r_text2unicode(text)
	text = strip_macros(text)
	text = LTR255_CP51_UNIC(text)

	for(var/s in GLOB.rus_unicode_conversion)
		text = replacetext(text, s, "&#x[GLOB.rus_unicode_conversion[s]];")

	return text

/proc/r_text2ascii(t, var/fromcode = 0)
	t = LTR255_UNIC_ANSI(t)
	t = LTR255_CP51_ANSI(t)
	var/output = ""
	var/L = lentext(t)
	for(var/i = 1 to L)
		var/asc = text2ascii(t,i)
		if(asc >= fromcode)
			output += "&#[asc];"
		else
			output += ascii2text(asc)
	return output

// Рекурсивно заменяет "я" на код в листе
/proc/sanitize_russian_list(list)
	for(var/i in list)
		if(islist(i))
			sanitize_russian_list(i)

		if(list[i])
			if(istext(list[i]))
				list[i] = sanitize_russian(list[i])
			else if(islist(list[i]))
				sanitize_russian_list(list[i])


// Фиксит русский Unicode в сгенерированных json_encode() JSON.
/proc/r_json_encode(json_data)
	if(!GLOB.rus_unicode_fix) // Генерируем табилцу замены
		GLOB.rus_unicode_fix = list()
		for(var/s in GLOB.rus_unicode_conversion)
			if(s == LTR255_ANSI) // Буква 255 ломается юникодером, с ней разбираемся отдельно.
				GLOB.rus_unicode_fix[LTR255_UNIC] = "\\u[GLOB.rus_unicode_conversion[s]]"
				continue

			GLOB.rus_unicode_fix[copytext(json_encode(s), 2, -1)] = "\\u[GLOB.rus_unicode_conversion[s]]"

	sanitize_russian_list(json_data)
	var/json = json_encode(json_data)

	for(var/s in GLOB.rus_unicode_fix)
		json = replacetext(json, s, GLOB.rus_unicode_fix[s])

	return json