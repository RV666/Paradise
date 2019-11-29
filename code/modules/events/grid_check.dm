/datum/event/grid_check	//NOTE: Times are measured in master controller ticks!
	announceWhen		= 5

/datum/event/grid_check/setup()
	endWhen = rand(30,120)

/datum/event/grid_check/start()
	power_failure(0)
	var/sound/S = sound('sound/effects/powerloss.ogg')
	for(var/mob/living/M in GLOB.player_list)
		var/turf/T = get_turf(M)
		if(!M.client || !is_station_level(T.z))
			continue
		SEND_SOUND(M, S)

/datum/event/grid_check/announce()
	event_announcement.Announce("Внимание! Зафиксирована опасность перепадов высокого напряжения в электросети [station_name()]. Воздержитесь от эксплуатации до разрешения проблем.", "Перепады напряжения", new_sound = 'sound/AI/poweroff.ogg')

/datum/event/grid_check/end()
	power_restore()

/proc/power_failure(var/announce = 1)
	if(announce)
		event_announcement.Announce("Внимание! Зафиксирована опасность перепадов высокого напряжения в электросети [station_name()]. Воздержитесь от эксплуатации до разрешения проблем.", "Перепады напряжения", new_sound = 'sound/AI/poweroff.ogg')

	var/list/skipped_areas = list(/area/turret_protected/ai)
	var/list/skipped_areas_apc = list(/area/engine/engineering)

	for(var/obj/machinery/power/smes/S in GLOB.machines)
		var/area/current_area = get_area(S)
		if((current_area.type in skipped_areas) || !is_station_level(S.z))
			continue
		S.last_charge			= S.charge
		S.last_output_attempt	= S.output_attempt
		S.last_input_attempt 	= S.input_attempt
		S.charge = 0
		S.inputting(0)
		S.outputting(0)
		S.update_icon()
		S.power_change()

	for(var/obj/machinery/power/apc/C in GLOB.apcs)
		var/area/current_area = get_area(C)
		if((current_area.type in skipped_areas_apc) || !is_station_level(C.z))
			continue
		if(C.cell)
			C.cell.charge = 0

/proc/power_restore(var/announce = 1)
	var/list/skipped_areas = list(/area/turret_protected/ai)
	var/list/skipped_areas_apc = list(/area/engine/engineering)

	if(announce)
		event_announcement.Announce("Система электроснабжения станции нормализована.", "Электросеть нормализована", new_sound = 'sound/AI/poweron.ogg')
	for(var/obj/machinery/power/apc/C in GLOB.apcs)
		var/area/current_area = get_area(C)
		if((current_area.type in skipped_areas_apc) || !is_station_level(C.z))
			continue
		if(C.cell)
			C.cell.charge = C.cell.maxcharge
	for(var/obj/machinery/power/smes/S in GLOB.machines)
		var/area/current_area = get_area(S)
		if((current_area.type in skipped_areas) || !is_station_level(S.z))
			continue
		S.charge = S.last_charge
		S.output_attempt = S.last_output_attempt
		S.input_attempt = S.last_input_attempt
		S.update_icon()
		S.power_change()

/proc/power_restore_quick(var/announce = 1)
	if(announce)
		event_announcement.Announce("Система электроснабжения станции нормализована.", "Электросеть нормализована", new_sound = 'sound/AI/poweron.ogg')
	for(var/obj/machinery/power/smes/S in GLOB.machines)
		if(!is_station_level(S.z))
			continue
		S.charge = S.capacity
		S.output_level = S.output_level_max
		S.output_attempt = 1
		S.input_attempt = 1
		S.update_icon()
		S.power_change()
