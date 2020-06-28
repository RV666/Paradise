GLOBAL_VAR_INIT(security_level, 0)
//0 = code green
//1 = code blue
//2 = code red
//3 = gamma
//4 = epsilon
//5 = code delta

//config.alert_desc_blue_downto
GLOBAL_DATUM_INIT(security_announcement_up, /datum/announcement/priority/security, new(do_log = 0, do_newscast = 0, new_sound = sound('sound/misc/notice1.ogg')))
GLOBAL_DATUM_INIT(security_announcement_down, /datum/announcement/priority/security, new(do_log = 0, do_newscast = 0))

/proc/set_security_level(var/level)
	switch(level)
		if("green")
			level = SEC_LEVEL_GREEN
		if("blue")
			level = SEC_LEVEL_BLUE
		if("red")
			level = SEC_LEVEL_RED
		if("gamma")
			level = SEC_LEVEL_GAMMA
		if("epsilon")
			level = SEC_LEVEL_EPSILON
		if("delta")
			level = SEC_LEVEL_DELTA

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_DELTA && level != GLOB.security_level)
		if(level >= SEC_LEVEL_RED && GLOB.security_level < SEC_LEVEL_RED)
			// Mark down this time to prevent shuttle cheese
			SSshuttle.emergency_sec_level_time = world.time

		// Reset gamma borgs if the new security level is lower than Gamma.
		if(level < SEC_LEVEL_GAMMA)
			for(var/M in GLOB.silicon_mob_list)
				if(isrobot(M))
					var/mob/living/silicon/robot/R = M
					if(istype(R.module, /obj/item/robot_module/combat) && !R.crisis)
						R.reset_module()
						to_chat(R, "<span class='warning'>Кризисный режим отключен. Боевой модуль больше ндоступен и ваш модуль был сброшен.</span>")

		switch(level)
			if(SEC_LEVEL_GREEN)
				GLOB.security_announcement_down.Announce("Все угрозы станции исчезли.  Все оружие должно храниться в кобуре, и законы о приватности вновь полностью соблюдаются.","Внимание! Уровень безопасности понижен до Green.")
				GLOB.security_level = SEC_LEVEL_GREEN

				post_status("alert", "outline")

				for(var/obj/machinery/firealarm/FA in GLOB.machines)
					if(is_station_contact(FA.z))
						FA.overlays.Cut()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_green")
						FA.update_icon()

			if(SEC_LEVEL_BLUE)
				if(GLOB.security_level < SEC_LEVEL_BLUE)
					GLOB.security_announcement_up.Announce("Станция получила достоверную информацию о возможной враждебной деятельности на станции. У сотрудники службы безопасности могут открыто носить оружие, и разрешены случайные обыски.","Внимание! Уровень безопасности повышен до Blue.")
				else
					GLOB.security_announcement_down.Announce("Непосредственная угроза прошла. Охранники могут больше не брать оружие в любое время, но могут продолжать держать их видимыми. Случайный обыск все еще разрешен.","Внимание! Уровень безопасности понижен до Blue.")
				GLOB.security_level = SEC_LEVEL_BLUE

				post_status("alert", "default")

				for(var/obj/machinery/firealarm/FA in GLOB.machines)
					if(is_station_contact(FA.z))
						FA.overlays.Cut()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_blue")
						FA.update_icon()

			if(SEC_LEVEL_RED)
				if(GLOB.security_level < SEC_LEVEL_RED)
					GLOB.security_announcement_up.Announce("Существует непосредственная и серьезная угроза для станции. У сотрудников службы безопасности всегда может быть оружие без кобуры. Случайные обыски разрешены и рекомендуются.","Внимание! Код Red!")
				else
					GLOB.security_announcement_down.Announce("Механизм самоуничтожения станции был деактивирован, но все еще существует непосредственная и серьезная угроза для станции. У сотрудников службы безопасности всегда может быть оружие без кобуры. Случайные обыски разрешены и рекомендуются.","Внимание! Код Red!")
				GLOB.security_level = SEC_LEVEL_RED

				var/obj/machinery/door/airlock/highsecurity/red/R = locate(/obj/machinery/door/airlock/highsecurity/red) in GLOB.airlocks
				if(R && is_station_level(R.z))
					R.locked = 0
					R.update_icon()

				post_status("alert", "redalert")

				for(var/obj/machinery/firealarm/FA in GLOB.machines)
					if(is_station_contact(FA.z))
						FA.overlays.Cut()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_red")
						FA.update_icon()

			if(SEC_LEVEL_GAMMA)
				GLOB.security_announcement_up.Announce("Центральное командование установило уровень безопасности Gamma на станции. Служба безопасности всегда носит оружие экипированным, и все гражданские лица должны немедленно найти ближайшего главу для транспортировки в безопасное место. Гамма арсенал станции был разблокирован и готов к использованию.","Внимание! Gamma уровень безопасности установлен!", new_sound = sound('sound/effects/new_siren.ogg'))
				GLOB.security_level = SEC_LEVEL_GAMMA

				move_gamma_ship()

				if(GLOB.security_level < SEC_LEVEL_RED)
					for(var/obj/machinery/door/airlock/highsecurity/red/R in GLOB.airlocks)
						if(is_station_level(R.z))
							R.locked = 0
							R.update_icon()

				for(var/obj/machinery/door/airlock/hatch/gamma/H in GLOB.airlocks)
					if(is_station_level(H.z))
						H.locked = 0
						H.update_icon()

				post_status("alert", "gammaalert")

				for(var/obj/machinery/firealarm/FA in GLOB.machines)
					if(is_station_contact(FA.z))
						FA.overlays.Cut()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_gamma")
						FA.update_icon()

			if(SEC_LEVEL_EPSILON)
				GLOB.security_announcement_up.Announce("Центральное командование установило уровень безопасности Epsilon на станции. Считайте, что все ваши контракты с корпорацией расторгнуты.","Внимание! Epsilon уровень безопасности установлен!", new_sound = sound('sound/effects/purge_siren.ogg'))
				GLOB.security_level = SEC_LEVEL_EPSILON

				post_status("alert", "epsilonalert")

				for(var/obj/machinery/firealarm/FA in GLOB.machines)
					if(is_station_contact(FA.z))
						FA.overlays.Cut()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_epsilon")
						FA.update_icon()

			if(SEC_LEVEL_DELTA)
				GLOB.security_announcement_up.Announce("Механизм самоуничтожения станции задействован. Весь экипаж обязан соблюдать все приказы, данные главами. Любые нарушения этих приказов могут быть наказаны смертью. Это не учения.","Внимание! Delta уровень безопасности установлен!", new_sound = sound('sound/effects/deltaalarm.ogg'))
				GLOB.security_level = SEC_LEVEL_DELTA

				post_status("alert", "deltaalert")

				for(var/obj/machinery/firealarm/FA in GLOB.machines)
					if(is_station_contact(FA.z))
						FA.overlays.Cut()
						FA.overlays += image('icons/obj/monitors.dmi', "overlay_delta")
						FA.update_icon()

		if(level >= SEC_LEVEL_RED)
			GLOB.atc.reroute_traffic(yes = TRUE) // Tell them fuck off we're busy.
		else
			GLOB.atc.reroute_traffic(yes = FALSE)
		SSnightshift.check_nightshift(TRUE)

	else
		return

/proc/get_security_level()
	switch(GLOB.security_level)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_GAMMA)
			return "gamma"
		if(SEC_LEVEL_EPSILON)
			return "epsilon"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/num2seclevel(var/num)
	switch(num)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_GAMMA)
			return "gamma"
		if(SEC_LEVEL_EPSILON)
			return "epsilon"
		if(SEC_LEVEL_DELTA)
			return "delta"

/proc/seclevel2num(var/seclevel)
	switch( lowertext(seclevel) )
		if("green")
			return SEC_LEVEL_GREEN
		if("blue")
			return SEC_LEVEL_BLUE
		if("red")
			return SEC_LEVEL_RED
		if("gamma")
			return SEC_LEVEL_GAMMA
		if("epsilon")
			return SEC_LEVEL_EPSILON
		if("delta")
			return SEC_LEVEL_DELTA

/proc/get_security_level_ru()
	switch(GLOB.security_level)
		if(SEC_LEVEL_GREEN)
			return "ЗЕЛЕНЫЙ"
		if(SEC_LEVEL_BLUE)
			return "СИНИЙ"
		if(SEC_LEVEL_RED)
			return "КРАСНЫЙ"
		if(SEC_LEVEL_GAMMA)
			return "ГАММА"
		if(SEC_LEVEL_EPSILON)
			return "ЭПСИЛОН"
		if(SEC_LEVEL_DELTA)
			return "ДЭЛЬТА"

/proc/get_security_level_l_range()
	switch(GLOB.security_level)
		if(SEC_LEVEL_GREEN)
			return 1
		if(SEC_LEVEL_BLUE)
			return 2
		if(SEC_LEVEL_RED)
			return 2
		if(SEC_LEVEL_GAMMA)
			return 2
		if(SEC_LEVEL_EPSILON)
			return 2
		if(SEC_LEVEL_DELTA)
			return 2

/proc/get_security_level_l_power()
	switch(GLOB.security_level)
		if(SEC_LEVEL_GREEN)
			return 1
		if(SEC_LEVEL_BLUE)
			return 2
		if(SEC_LEVEL_RED)
			return 2
		if(SEC_LEVEL_GAMMA)
			return 2
		if(SEC_LEVEL_EPSILON)
			return 2
		if(SEC_LEVEL_DELTA)
			return 2

/proc/get_security_level_l_color()
	switch(GLOB.security_level)
		if(SEC_LEVEL_GREEN)
			return COLOR_GREEN
		if(SEC_LEVEL_BLUE)
			return COLOR_ALARM_BLUE
		if(SEC_LEVEL_RED)
			return COLOR_RED_LIGHT
		if(SEC_LEVEL_GAMMA)
			return COLOR_AMBER
		if(SEC_LEVEL_EPSILON)
			return COLOR_ORANGE
		if(SEC_LEVEL_DELTA)
			return COLOR_DARK_ORANGE
