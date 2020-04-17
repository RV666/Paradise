
#define DEPOT_VISITOR_START	1
#define DEPOT_VISITOR_END	2
#define DEPOT_VISITOR_ADD	3


// Generic parent depot computer type

/obj/machinery/computer/syndicate_depot
	name = "depot computer"
	icon = 'icons/obj/computer.dmi'
	icon_keyboard = "syndie_key"
	icon_screen = "tcboss"
	light_color = LIGHT_COLOR_PURE_CYAN
	req_access = list(ACCESS_SYNDICATE)
	var/security_lockout = FALSE
	var/sound_yes = 'sound/machines/twobeep.ogg'
	var/sound_no = 'sound/machines/buzz-sigh.ogg'
	var/sound_click = 'sound/machines/click.ogg'
	var/area/syndicate_depot/core/depotarea
	var/alerts_when_broken = FALSE
	var/has_alerted = FALSE


/obj/machinery/computer/syndicate_depot/New()
	. = ..()
	depotarea = areaMaster

/obj/machinery/computer/syndicate_depot/attack_ai(mob/user)
	if(req_access.len && !("syndicate" in user.faction))
		to_chat(user, "<span class='warning'>A firewall blocks your access.</span>")
		return 1
	return ..()

/obj/machinery/computer/syndicate_depot/emp_act(severity)
	return

/obj/machinery/computer/syndicate_depot/emag_act(mob/user)
	to_chat(user, "<span class='notice'>Электронная система в этой консоли защищена от вашего примитивного хакерскского устройства.</span>")
	return

/obj/machinery/computer/syndicate_depot/allowed(mob/user)
	if(user.can_advanced_admin_interact())
		return 1
	if(!isliving(user))
		return 0
	if(has_security_lockout(user))
		return 0
	return ..()

/obj/machinery/computer/syndicate_depot/proc/has_security_lockout(mob/user)
	if(security_lockout)
		playsound(user, 'sound/machines/buzz-sigh.ogg', 50, 0)
		to_chat(user, "<span class='warning'[src]  находится под блокировкой системы безопасности.</span>")
		return TRUE
	return FALSE

/obj/machinery/computer/syndicate_depot/proc/activate_security_lockout()
	security_lockout = TRUE
	disable_special_functions()

/obj/machinery/computer/syndicate_depot/attack_hand(mob/user)
	if(..())
		return
	if(stat & (NOPOWER|BROKEN))
		return
	if(!allowed(user))
		to_chat(user, "<span class='warning'>Доступ запрещён.</span>")
		return
	user.set_machine(src)
	var/dat = get_menu(user)
	user << browse(dat, "window=computer;size=575x450")
	onclose(user, "computer")


/obj/machinery/computer/syndicate_depot/set_broken()
	. = ..()
	if(alerts_when_broken && !has_alerted)
		has_alerted = TRUE
		raise_alert("[src] повреждён.")
	disable_special_functions()

/obj/machinery/computer/syndicate_depot/proc/disable_special_functions()
	return

/obj/machinery/computer/syndicate_depot/Topic(href, href_list)
	if(..())
		return 1
	if((usr.contents.Find(src) || (in_range(src, usr) && istype(loc, /turf))) || (istype(usr, /mob/living/silicon)))
		usr.set_machine(src)
	if(href_list["первичный"])
		primary(usr)
	if(href_list["вторичный"])
		secondary(usr, text2num(href_list["вторичный"]))
	add_fingerprint(usr)
	updateUsrDialog()

/obj/machinery/computer/syndicate_depot/Destroy()
	disable_special_functions()
	if(alerts_when_broken && !has_alerted)
		raise_alert("[src] уничтожен.")
	return ..()


/obj/machinery/computer/syndicate_depot/proc/get_menu(mob/user)
	return ""

/obj/machinery/computer/syndicate_depot/proc/primary(mob/user)
	if(!allowed(user))
		return 1
	return 0

/obj/machinery/computer/syndicate_depot/proc/secondary(mob/user, subcommand)
	if(!allowed(user))
		return 1
	return 0

/obj/machinery/computer/syndicate_depot/proc/raise_alert(reason)
	if(depotarea)
		depotarea.increase_alert(reason)



// Door Control Computer

/obj/machinery/computer/syndicate_depot/doors
	name = "depot door control computer"
	req_access = list()
	var/pub_access = FALSE

/obj/machinery/computer/syndicate_depot/doors/get_menu(mob/user)
	return {"<meta charset="UTF-8" ><B>Консоль Управления Дверью Депо Синдиката</B><HR>
	<BR><BR><a href='?src=[UID()];primary=1'>Аварийный Доступ К Шлюзу: Переключить</a>
	<BR><BR><a href='?src=[UID()];secondary=1'>Скрытые Двери: Переключить</a>
	<BR>"}

/obj/machinery/computer/syndicate_depot/doors/primary(mob/user)
	if(..())
		return
	if(depotarea)
		pub_access = !pub_access
		if(pub_access)
			depotarea.set_emergency_access(TRUE)
			to_chat(user, "<span class='notice'>Аварийный доступ включён.</span>")
		else
			depotarea.set_emergency_access(FALSE)
			to_chat(user, "<span class='notice'>Аварийный доступ отключен.</span>")
		playsound(user, sound_yes, 50, 0)

/obj/machinery/computer/syndicate_depot/doors/secondary(mob/user, subcommand)
	if(..())
		return
	if(depotarea)
		depotarea.toggle_falsewalls(src)
		to_chat(user, "<span class='notice'>Переключение скрытых дверей.</span>")
		playsound(user, sound_yes, 50, 0)


// Engineering AKA self destruct computer, no useful functions, just a trap for the people who can't resist pushing dangerous-sounding buttons.

/obj/machinery/computer/syndicate_depot/selfdestruct
	name = "reactor control computer"
	icon_screen = "explosive"
	req_access = list()
	alerts_when_broken = TRUE

/obj/machinery/computer/syndicate_depot/selfdestruct/get_menu(mob/user)
	var menutext = {"<B><meta charset="UTF-8" >Управление Термоядерным Реактором Синдикатного Депо</B><HR>
	<BR><BR><a href='?src=[UID()];primary=1'>Отключить Защитное Поле</a>
	<BR>"}
	return menutext

/obj/machinery/computer/syndicate_depot/selfdestruct/primary(mob/user)
	if(..())
		return
	if(depotarea.used_self_destruct)
		playsound(user, sound_no, 50, 0)
		return
	if(depotarea)
		depotarea.activate_self_destruct("Защитное поле термоядерного реактора отключено. Все главы, Эвакуируйтесь. Все главы, Эвакуируйтесь!", TRUE, user)
		playsound(user, sound_click, 20, 1)


// Shield computer, used to manipulate base shield, and armory shield

/obj/machinery/computer/syndicate_depot/shieldcontrol
	name = "shield control computer"
	icon_screen = "accelerator"
	req_access = list(ACCESS_SYNDICATE_LEADER)
	alerts_when_broken = TRUE
	var/area/syndicate_depot/perimeter/perimeterarea

/obj/machinery/computer/syndicate_depot/shieldcontrol/New()
	. = ..()
	perimeterarea = locate(/area/syndicate_depot/perimeter)
	if(istype(perimeterarea) && (GAMEMODE_IS_NUCLEAR || prob(20)))
		spawn(200)
			perimeterarea.perimeter_shields_up()
			depotarea.perimeter_shield_status = TRUE

/obj/machinery/computer/syndicate_depot/shieldcontrol/Destroy()
	if(istype(perimeterarea) && perimeterarea.shield_list.len)
		perimeterarea.perimeter_shields_down()
	return ..()

/obj/machinery/computer/syndicate_depot/shieldcontrol/get_menu(mob/user)
	var menutext = {"<meta charset="UTF-8" ><B>Управление Силовым Полем Депо Синдиката</B><HR>
	<BR>"}
	menutext += {"<meta charset="UTF-8" >(SYNDI-LEADER) Все базовые щиты: [perimeterarea.shield_list.len ? "ON" : "OFF"] (<a href='?src=[UID()];primary=1'>[perimeterarea.shield_list.len ? "Disable" : "Enable"]</a>)<BR>"}
	menutext += {"<meta charset="UTF-8" >(SYNDI-LEADER) Оружейные Щиты: [depotarea.shield_list.len ? "ON" : "OFF"] (<a href='?src=[UID()];secondary=1'>[depotarea.shield_list.len ? "Disable" : "Enable"]</a>)<BR>"}
	return menutext

/obj/machinery/computer/syndicate_depot/shieldcontrol/primary(mob/user)
	if(..())
		return
	if(depotarea.used_self_destruct)
		playsound(user, sound_no, 50, 0)
		return
	if(!istype(perimeterarea))
		return
	if(perimeterarea.shield_list.len)
		perimeterarea.perimeter_shields_down()
		depotarea.perimeter_shield_status = FALSE
	else
		perimeterarea.perimeter_shields_up()
		depotarea.perimeter_shield_status = TRUE
	playsound(user, sound_yes, 50, 0)


/obj/machinery/computer/syndicate_depot/shieldcontrol/secondary(mob/user)
	if(..())
		return
	if(!istype(depotarea))
		return
	if(depotarea.shield_list.len)
		depotarea.shields_down()
	else
		depotarea.shields_up()
	playsound(user, sound_yes, 50, 0)


// Syndicate comms computer, used to activate visitor mode, and message syndicate. Traitor-only use.

/obj/machinery/computer/syndicate_depot/syndiecomms
	name = "syndicate communications computer"
	icon_screen = "syndishuttle"
	req_access = list()
	alerts_when_broken = TRUE
	var/message_sent = FALSE

/obj/machinery/computer/syndicate_depot/syndiecomms/New()
	. = ..()
	if(depotarea)
		depotarea.comms_computer = src

/obj/machinery/computer/syndicate_depot/syndiecomms/Destroy()
	if(depotarea)
		depotarea.comms_computer = null
	return ..()

/obj/machinery/computer/syndicate_depot/syndiecomms/get_menu(mob/user)
	var/menu = "<B>Ретранслятор Связи Синдиката</B><HR>"
	menu += "<BR><BR>Одноразовый канал связи со штаб-квартирой Синдиката: [message_sent ? "ALREADY USED" : "AVAILABLE (<a href='?src=[UID()];primary=1'>Open Channel</a>)"]"
	if(depotarea.on_peaceful)
		menu += "<BR><BR>Приезжие Агенты: ВИЗИТ ПРОДОЛЖАЕТСЯ. "
		if(depotarea.list_includes(user, depotarea.peaceful_list))
			menu += "[user] ЯВЛЯЕТСЯ ПРИЗНАННЫМ ВЫЕЗДНЫМ АГЕНТОМ"
		else
			menu += "[user] НЕ ПРИЗНАНН. (<a href='?src=[UID()];secondary=[DEPOT_VISITOR_ADD]'>Войти как Агент</a>)"
		if(check_rights(R_ADMIN, 0, user))
			menu += "<BR><BR>АДМИН: (<a href='?src=[UID()];secondary=[DEPOT_VISITOR_END]'>Закончить Посещение</a>)"

	else
		menu += "<BR><BR>Приезжие Агенты: NONE (<a href='?src=[UID()];secondary=[DEPOT_VISITOR_START]'>Войти как Агент</a>)"
	return menu

/obj/machinery/computer/syndicate_depot/syndiecomms/primary(mob/user)
	if(..())
		return
	if(!isliving(user))
		to_chat(user, "Ошибка: у терминала не обнаружено никаких признаков жизни, возврат.") // Safety to prevent aghosts accidentally pressing it and getting everyone killed.
		return
	if(message_sent)
		playsound(user, 'sound/machines/buzz-sigh.ogg', 50, 0)
		to_chat(user, "<span class='warning'>[src] уже использовалась для передачи сообщения в Синдикат.</span>")
		return
	message_sent = TRUE
	var/input = stripped_input(user, "Пожалуйста, выберите сообщение для передачи в штаб-квартиру синдиката через квантосеть.  Передача данных не гарантирует получение ответа. Эта функция может быть использована только один раз.", "Для отказа отправьте пустое сообщение ", "")
	if(!input)
		message_sent = FALSE
		return
	Syndicate_announce(input, user)
	to_chat(user, "СООБЩЕНИЕ ОТПРАВЛЕНО")
	log_say("[key_name(user)] отправил сообщение Синдикату по коммуникатору из депо: [input]", user)
	updateUsrDialog()
	playsound(user, sound_yes, 50, 0)

/obj/machinery/computer/syndicate_depot/syndiecomms/secondary(mob/user, subcommand)
	if(..())
		return
	if(has_security_lockout(user))
		return
	if(depotarea)
		if(depotarea.local_alarm || depotarea.called_backup || depotarea.used_self_destruct)
			to_chat(user, "<span class='warning'>Вход посетителей невозможен, пока депо находится в состоянии боевой готовности.</span>")
		else if(depotarea.on_peaceful)
			if(subcommand == DEPOT_VISITOR_END)
				if(check_rights(R_ADMIN, 0, user))
					depotarea.peaceful_mode(FALSE, TRUE)
			else if (subcommand == DEPOT_VISITOR_ADD)
				if(user.mind && user.mind.special_role == SPECIAL_ROLE_TRAITOR)
					if(depotarea.list_includes(user, depotarea.peaceful_list))
						to_chat(user, "<span class='warning'>[user] уже посетитель.</span>")
					else
						grant_syndie_faction(user)
				else
					to_chat(user, "<span class='warning'>Только проверенные агенты синдиката могут войти в систему в качестве посетителей. Все остальные будут расстреляны на месте.</span>")
		else if(subcommand == DEPOT_VISITOR_START)
			if(depotarea.something_looted)
				to_chat(user, "<span class='warning'>Регистрация посетителей невозможна после того, как все необходимое будет взято из шкафчика в депо.</span>")
			else if("syndicate" in user.faction)
				to_chat(user, "<span class='warning'>Вы уже признаны членом Синдиката, и вам не нужно входить в систему.</span>")
			else if(user.mind && user.mind.special_role == SPECIAL_ROLE_TRAITOR)
				grant_syndie_faction(user)
				depotarea.peaceful_mode(TRUE, TRUE)
			else
				to_chat(user, "<span class='warning'>Только проверенные агенты синдиката могут войти в систему в качестве посетителей. Все остальные будут расстреляны на месте.</span>")
		else
			to_chat(user, "<span class='warning'>Нераспознанные команды: [subcommand]</span>")
	else
		to_chat(user, "<span class='warning'>ОШИБКА: [src] не удается подключиться к сети депо.</span>")
	updateUsrDialog()
	playsound(user, sound_yes, 50, 0)

/obj/machinery/computer/syndicate_depot/syndiecomms/proc/grant_syndie_faction(mob/user)
	user.faction += "syndicate"
	depotarea.list_add(user, depotarea.peaceful_list)
	to_chat(user, {"<BR><span class='userdanger'>Добро Пожаловать, Агент.</span>
		<span class='warning'>Теперь вы вошли в систему как посетитель депо.
		Любые другие агенты С ВАМИ должны зарегистрироваться САМИ.
		Вы можете осматривать здесь все комнаты, кроме заболтированых
		Ваш идентификатор агента даст вам доступ к большинству дверей и компьютеров.
		К вашему визиту применяются стандартные правила синдиката.
		Это означает, что если кто-то из вас нападет на персонал объекта, взломает что-либо, саботирует объект или приведет сюда неагентов, то все вы будете немедленно казнены.
		Отдыхайте.</span>
	"})

/obj/machinery/computer/syndicate_depot/syndiecomms/power_change()
	. = ..()
	if(!security_lockout && (stat & NOPOWER))
		security_lockout = TRUE
		raise_alert("[src] теряет энергию.")


// Syndicate teleporter control, used to manage incoming/outgoing teleports

/obj/machinery/computer/syndicate_depot/teleporter
	name = "syndicate teleporter console"
	icon_screen = "telesci"
	icon_keyboard = "teleport_key"
	var/obj/machinery/bluespace_beacon/syndicate/mybeacon
	var/obj/effect/portal/redspace/myportal
	var/obj/effect/portal/redspace/myportal2
	var/portal_enabled = FALSE
	var/portaldir = WEST

/obj/machinery/computer/syndicate_depot/teleporter/New()
	. = ..()
	spawn(10)
		findbeacon()
		update_portal()

/obj/machinery/computer/syndicate_depot/teleporter/Destroy()
	if(mybeacon)
		mybeacon.mycomputer = null
	return ..()

/obj/machinery/computer/syndicate_depot/teleporter/portal_destroyed(obj/effect/portal/P)
	myportal = null

/obj/machinery/computer/syndicate_depot/teleporter/disable_special_functions()
	if(mybeacon)
		if(mybeacon.enabled)
			mybeacon.toggle()
	if(portal_enabled)
		portal_enabled = FALSE
		update_portal()

/obj/machinery/computer/syndicate_depot/teleporter/proc/findbeacon()
	if(mybeacon)
		return TRUE
	for(var/obj/machinery/bluespace_beacon/syndicate/B in myArea)
		mybeacon = B
		B.mycomputer = src
		return TRUE
	return FALSE

/obj/machinery/computer/syndicate_depot/teleporter/proc/choosetarget()
	var/list/L = list()
	var/list/areaindex = list()

	for(var/obj/item/radio/beacon/R in GLOB.beacons)
		var/turf/T = get_turf(R)
		if(!T)
			continue
		if(!is_teleport_allowed(T.z))
			continue
		var/tmpname = T.loc.name
		if(areaindex[tmpname])
			tmpname = "[tmpname] ([++areaindex[tmpname]])"
		else
			areaindex[tmpname] = 1
		L[tmpname] = R
	var/desc = input("Please select a location to lock in.", "Syndicate Teleporter") in L
	return(L[desc])

/obj/machinery/computer/syndicate_depot/teleporter/proc/update_portal()
	if(portal_enabled && !myportal)
		var/turf/tele_target = choosetarget()
		if(!tele_target)
			return
		var/turf/portal_turf = get_step(src, portaldir)
		var/obj/effect/portal/redspace/P = new(portal_turf, tele_target, src, 0)
		myportal = P
		var/area/A = get_area(tele_target)
		P.name = "[A] portal"
		var/obj/effect/portal/redspace/P2 = new(get_turf(tele_target), portal_turf, src, 0)
		myportal2 = P2
		P2.name = "mysterious portal"
	else if(!portal_enabled && myportal)
		qdel(myportal)
		myportal = null
		if(myportal2)
			qdel(myportal2)
			myportal2 = null

/obj/machinery/computer/syndicate_depot/teleporter/get_menu(mob/user)
	var/menutext = "<B>Syndicate Teleporter Control</B><HR>"
	findbeacon()
	if(mybeacon)
		menutext += {"<BR><BR>Incoming Teleport Beacon: [mybeacon.enabled ? "ON" : "OFF"] (<a href='?src=[UID()];primary=1'>[mybeacon.enabled ? "Disable" : "Enable"]</a>)<BR>"}
	else
		menutext += {"<BR><BR>Incoming Teleport Beacon: Reconnecting to beacon..."}
	menutext += {"<BR><BR>Outgoing Teleport Portal: [portal_enabled ? "ON" : "OFF"]"}
	if(check_rights(R_ADMIN, 0, user) || (depotarea.on_peaceful && !portal_enabled))
		menutext += {" (<a href='?src=[UID()];secondary=1'>[portal_enabled ? "Disable" : "Enable"]</a>)<BR>"}
	return menutext

/obj/machinery/computer/syndicate_depot/teleporter/primary(mob/user)
	if(..())
		return
	if(!mybeacon && user)
		to_chat(user, "<span class='notice'>Unable to connect to teleport beacon.</span>")
		return
	var/bresult = mybeacon.toggle()
	to_chat(user, "<span class='notice'>Syndicate Teleporter Beacon: [bresult ? "<span class='green'>ON</span>" : "<span class='red'>OFF</span>"]</span>")
	updateUsrDialog()
	playsound(user, sound_yes, 50, 0)

/obj/machinery/computer/syndicate_depot/teleporter/secondary(mob/user)
	if(..())
		return
	if(!check_rights(R_ADMIN, 0, user) && !(depotarea.on_peaceful && !portal_enabled))
		return
	if(!portal_enabled && myportal)
		to_chat(user, "<span class='notice'>Outgoing Teleport Portal: deactivating... please wait...</span>")
		return
	toggle_portal()
	to_chat(user, "<span class='notice'>Outgoing Teleport Portal: [portal_enabled ? "<span class='green'>ON</span>" : "<span class='red'>OFF</span>"]</span>")
	updateUsrDialog()
	playsound(user, sound_yes, 50, 0)

/obj/machinery/computer/syndicate_depot/teleporter/proc/toggle_portal()
	portal_enabled = !portal_enabled
	update_portal()


/obj/machinery/computer/syndicate_depot/aiterminal
	name = "syndicate ai terminal"
	icon_screen = "command"
	req_access = list()

/obj/machinery/computer/syndicate_depot/aiterminal/get_menu(mob/user)
	var/menutext = "<B>Настройка ИИ Синдиката</B><HR><BR>"
	if(!istype(depotarea))
		menutext += "<BR>ОШИБКА: Не удается подключиться к ИИ."
		return menutext

	if(depotarea.alert_log.len)
		menutext += "журнал событий:<UL>"
		for(var/thisline in depotarea.alert_log)
			menutext += "<LI>[thisline]</LI>"
		menutext += "</UL>"
	else
		menutext += "журнал событий: ПУСТО"
	menutext += "<BR><BR>"

	menutext += "Уничтоженные Злоумышленники: "
	menutext += depotarea.list_gethtmlmobs(depotarea.dead_list)
	menutext += "<BR><BR>"

	menutext += "Доп. Защита Безопасности: "
	menutext += depotarea.list_gethtmlmobs(depotarea.guard_list)
	menutext += "<BR><BR>"

	menutext += "Посетители: "
	menutext += depotarea.list_gethtmlmobs(depotarea.peaceful_list)
	menutext += "<BR><BR>"

	var/has_bot = FALSE
	for(var/mob/living/simple_animal/bot/ed209/syndicate/B in depotarea.list_getmobs(depotarea.guard_list))
		has_bot = TRUE
	if(has_bot)
		menutext += "<BR><BR>Сторожевой Бот: (<a href='?src=[UID()];secondary=1'>выдать приказ об отзыве</a>)"
	else
		menutext += "<BR><BR>Сторожевой бот: (нет в наличии)"
	menutext += "<BR><BR>"

	if(check_rights(R_ADMIN, 0, user))
		if(depotarea.on_peaceful)
			menutext += "<BR><BR>АДМИН: (чтобы завершить режим посетителя, используйте консоль связи.)"
		else
			menutext += "<BR><BR>АДМИН: (<a href='?src=[UID()];primary=1'>Сброс Уровня Предупреждений Депо</a>)"

	return menutext

/obj/machinery/computer/syndicate_depot/aiterminal/primary(mob/user)
	if(..())
		return
	if(!check_rights(R_ADMIN, 0, user))
		return
	if(depotarea)
		depotarea.reset_alert()
		to_chat(user, "Сброс уровня тревоги.")
		playsound(user, sound_yes, 50, 0)

/obj/machinery/computer/syndicate_depot/aiterminal/secondary(mob/user)
	if(..())
		return
	for(var/mob/living/simple_animal/bot/ed209/syndicate/B in depotarea.list_getmobs(depotarea.guard_list))
		depotarea.list_remove(B, depotarea.guard_list)
		new /obj/effect/portal(get_turf(B))
		to_chat(user, "[B] отозван.")
		qdel(B)
		raise_alert("Сторожевой бот отозван экстренно.")
	playsound(user, sound_yes, 50, 0)
