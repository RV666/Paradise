/datum/controller/subsystem/ticker/proc/scoreboard()

	//Print a list of antagonists to the server log
	var/list/total_antagonists = list()
	//Look into all mobs in world, dead or alive
	for(var/datum/mind/Mind in SSticker.minds)
		var/temprole = Mind.special_role
		if(temprole)							//if they are an antagonist of some sort.
			if(temprole in total_antagonists)	//If the role exists already, add the name to it
				total_antagonists[temprole] += ", [Mind.name]([Mind.key])"
			else
				total_antagonists.Add(temprole) //If the role doesnt exist in the list, create it and add the mob
				total_antagonists[temprole] += ": [Mind.name]([Mind.key])"

	//Now print them all into the log!
	log_game("Antagonists at round end were...")
	for(var/i in total_antagonists)
		log_game("[i]s[total_antagonists[i]].")

	// Score Calculation and Display

	// Who is alive/dead, who escaped
	for(var/mob/living/silicon/ai/I in GLOB.mob_list)
		if(I.stat == DEAD && is_station_level(I.z))
			GLOB.score_deadaipenalty++
			GLOB.score_deadcrew++

	for(var/mob/living/carbon/human/I in GLOB.mob_list)
		if(I.stat == DEAD && is_station_level(I.z))
			GLOB.score_deadcrew++

	if(SSshuttle.emergency.mode >= SHUTTLE_ENDGAME)
		for(var/mob/living/player in GLOB.mob_list)
			if(player.client)
				if(player.stat != DEAD)
					var/turf/location = get_turf(player.loc)
					var/area/escape_zone = locate(/area/shuttle/escape)
					if(location in escape_zone)
						GLOB.score_escapees++



	var/cash_score = 0
	var/dmg_score = 0

	if(SSshuttle.emergency.mode >= SHUTTLE_ENDGAME)
		for(var/mob/living/carbon/human/E in GLOB.mob_list)
			cash_score = 0
			dmg_score = 0
			var/turf/location = get_turf(E.loc)
			var/area/escape_zone = SSshuttle.emergency.areaInstance

			if(E.stat != DEAD && (location in escape_zone)) // Escapee Scores
				cash_score = get_score_container_worth(E)

				if(cash_score > GLOB.score_richestcash)
					GLOB.score_richestcash = cash_score
					GLOB.score_richestname = E.real_name
					GLOB.score_richestjob = E.job
					GLOB.score_richestkey = E.key

				dmg_score = E.getBruteLoss() + E.getFireLoss() + E.getToxLoss() + E.getOxyLoss()
				if(dmg_score > GLOB.score_dmgestdamage)
					GLOB.score_dmgestdamage = dmg_score
					GLOB.score_dmgestname = E.real_name
					GLOB.score_dmgestjob = E.job
					GLOB.score_dmgestkey = E.key

	if(SSticker && SSticker.mode)
		SSticker.mode.set_scoreboard_gvars()


	// Check station's power levels
	for(var/thing in GLOB.apcs)
		var/obj/machinery/power/apc/A = thing
		if(!is_station_level(A.z)) continue
		for(var/obj/item/stock_parts/cell/C in A.contents)
			if(C.charge < 2300)
				GLOB.score_powerloss++ //200 charge leeway


	// Check how much uncleaned mess is on the station
	for(var/obj/effect/decal/cleanable/M in world)
		if(!is_station_level(M.z)) continue
		if(istype(M, /obj/effect/decal/cleanable/blood/gibs))
			GLOB.score_mess += 3

		if(istype(M, /obj/effect/decal/cleanable/blood))
			GLOB.score_mess += 1

		if(istype(M, /obj/effect/decal/cleanable/vomit))
			GLOB.score_mess += 1


	// Bonus Modifiers
	//var/traitorwins = score_traitorswon
	var/deathpoints = GLOB.score_deadcrew * 25 //done
	var/researchpoints = GLOB.score_researchdone * 30
	var/eventpoints = GLOB.score_eventsendured * 50
	var/escapoints = GLOB.score_escapees * 25 //done
	var/harvests = GLOB.score_stuffharvested * 5 //done
	var/shipping = GLOB.score_stuffshipped * 5
	var/mining = GLOB.score_oremined * 2 //done
	var/meals = GLOB.score_meals * 5 //done, but this only counts cooked meals, not drinks served
	var/power = GLOB.score_powerloss * 20
	var/messpoints
	if(GLOB.score_mess != 0)
		messpoints = GLOB.score_mess //done
	var/plaguepoints = GLOB.score_disease * 30


	// Good Things
	GLOB.score_crewscore += shipping
	GLOB.score_crewscore += harvests
	GLOB.score_crewscore += mining
	GLOB.score_crewscore += researchpoints
	GLOB.score_crewscore += eventpoints
	GLOB.score_crewscore += escapoints

	if(power == 0)
		GLOB.score_crewscore += 2500
		GLOB.score_powerbonus = 1

	if(GLOB.score_mess == 0)
		GLOB.score_crewscore += 3000
		GLOB.score_messbonus = 1


	GLOB.score_crewscore += meals
	if(GLOB.score_allarrested)
		GLOB.score_crewscore *= 3 // This needs to be here for the bonus to be applied properly


	GLOB.score_crewscore -= deathpoints
	if(GLOB.score_deadaipenalty)
		GLOB.score_crewscore -= 250
	GLOB.score_crewscore -= power


	GLOB.score_crewscore -= messpoints
	GLOB.score_crewscore -= plaguepoints

	// Show the score - might add "ranks" later
	to_chat(world, "<b>The crew's final score is:</b>")
	to_chat(world, "<b><font size='4'>[GLOB.score_crewscore]</font></b>")
	for(var/mob/E in GLOB.player_list)
		if(E.client && !E.get_preference(DISABLE_SCOREBOARD))
			E.scorestats()

// A recursive function to properly determine the wealthiest escapee
/datum/controller/subsystem/ticker/proc/get_score_container_worth(atom/C, level=0)
	if(level >= 5)
		// in case the containers recurse or something
		return 0
	else
		. = 0
		for(var/obj/item/card/id/id in C.contents)
			var/datum/money_account/A = get_money_account(id.associated_account_number)
			// has an account?
			if(A)
				. += A.money
		for(var/obj/item/stack/spacecash/cash in C.contents)
			. += cash.amount
		for(var/obj/item/storage/S in C.contents)
			. += .(S, level + 1)

/datum/game_mode/proc/get_scoreboard_stats()
	return null

/datum/game_mode/proc/set_scoreboard_gvars()
	return null

/mob/proc/scorestats()
	var/dat = {"<meta charset="UTF-8"><b>Статистика Раунда и Счет</b><br><hr>"}
	if(SSticker && SSticker.mode)
		dat += SSticker.mode.get_scoreboard_stats()

	dat += {"
	<b><u>Общая статистика</u></b><br>
	<u>Хорошее:</u><br>

	<b>Полезных предметов отправленно:</b> [GLOB.score_stuffshipped] ([GLOB.score_stuffshipped * 5] Points)<br>
	<b>Урожай Гидропоники:</b> [GLOB.score_stuffharvested] ([GLOB.score_stuffharvested * 5] Points)<br>
	<b>Руды Накопано:</b> [GLOB.score_oremined] ([GLOB.score_oremined * 2] Points)<br>
	<b>Закусок Приготовлено:</b> [GLOB.score_meals] ([GLOB.score_meals * 5] Points)<br>
	<b>Исследований Завершено:</b> [GLOB.score_researchdone] ([GLOB.score_researchdone * 30] Points)<br>"}
	if(SSshuttle.emergency.mode == SHUTTLE_ENDGAME) dat += "<b>Сбежало на шаттле:</b> [GLOB.score_escapees] ([GLOB.score_escapees * 25] Points)<br>"
	dat += {"<b>Произошло случайных событий:</b> [GLOB.score_eventsendured] ([GLOB.score_eventsendured * 50] Points)<br>
	<b>Вся Станция Запитана:</b> [GLOB.score_powerbonus ? "Yes" : "No"] ([GLOB.score_powerbonus * 2500] Points)<br>
	<b>Ультра Чистая Станция:</b> [GLOB.score_mess ? "No" : "Yes"] ([GLOB.score_messbonus * 3000] Points)<br><br>
	<U>Плохое:</U><br>

	<b>Мертвых тел на Станции:</b> [GLOB.score_deadcrew] (-[GLOB.score_deadcrew * 25] Points)<br>
	<b>Неочищенного беспорядка:</b> [GLOB.score_mess] (-[GLOB.score_mess] Points)<br>
	<b>Проблемы с Энергией на Станции:</b> [GLOB.score_powerloss] (-[GLOB.score_powerloss * 20] Points)<br>
	<b>Несдержанные Болезни:</b> [GLOB.score_disease] (-[GLOB.score_disease * 30] Points)<br>
	<b>ИИ Уничтоженно:</b> [GLOB.score_deadaipenalty ? "Yes" : "No"] (-[GLOB.score_deadaipenalty * 250] Points)<br><br>
	<U>Странное</U><br>

	<b>Еды Съедено:</b> [GLOB.score_foodeaten] bites/sips<br>
	<b>Сколько раз клоун был оскорблен:</b> [GLOB.score_clownabuse]<br><br>
	"}
	if(GLOB.score_escapees)
		dat += {"<b>Richest Escapee:</b> [GLOB.score_richestname], [GLOB.score_richestjob]: $[num2text(GLOB.score_richestcash,50)] ([GLOB.score_richestkey])<br>
		<b>Самый Избитый Беглец:</b> [GLOB.score_dmgestname], [GLOB.score_dmgestjob]: [GLOB.score_dmgestdamage] damage ([GLOB.score_dmgestkey])<br>"}
	else
		if(SSshuttle.emergency.mode <= SHUTTLE_STRANDED)
			dat += "Станция не была эвакуирована!<br>"
		else
			dat += "Никто не сбежал!<br>"

	dat += SSticker.mode.declare_job_completion()

	dat += {"
	<hr><br>
	<b><u>Финальный Счет: [GLOB.score_crewscore]</u></b><br>
	"}

	var/score_rating = "Аристократы!"
	switch(GLOB.score_crewscore)
		if(-99999 to -50000) score_rating = "Даже Синга заслуживает лучшего"
		if(-49999 to -5000) score_rating = "Корм для Синги"
		if(-4999 to -1000) score_rating = "ВЫ ВСЕ УВОЛЕНЫ"
		if(-999 to -500) score_rating = "Трата Прекрасного Кислорода"
		if(-499 to -250) score_rating = "Жалкая Куча Отбросов и Некомпетентности"
		if(-249 to -100) score_rating = "Вас Превзошли Лабораторные Мартышки"
		if(-99 to -21) score_rating = "Нежелательные"
		if(-20 to 20) score_rating = "Неоднозначно Средние"
		if(21 to 99) score_rating = "Не Плохо, но и не Хорошо"
		if(100 to 249) score_rating = "Умелые Слуги Науки"
		if(250 to 499) score_rating = "Одни из Лучших"
		if(500 to 999) score_rating = "Lean Mean Machine Thirteen" // Отсылка на книгу, хуй знает какую аналогию вставить
		if(1000 to 4999) score_rating = "Повышение Всем"
		if(5000 to 9999) score_rating = "Амбассадоры Открытий"
		if(10000 to 49999) score_rating = "Гордость Науки"
		if(50000 to INFINITY) score_rating = "Лучшие Сотрудники Nanotrasen"

	dat += "<b><u>РЕЙТИНГ:</u></b> [score_rating]"
	src << browse(dat, "window=roundstats;size=500x600")
