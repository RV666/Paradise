/datum/event/radiation_storm/setup()
	startWhen = 3
	endWhen = startWhen + 1
	announceWhen = 1

/datum/event/radiation_storm/announce()
	priority_announcement.Announce("Опасность! Зафиксирован высокий уровень радиации. Персоналу, найти укрытие и доложить о своем состоянии медицинскому персоналу.", "Радиация", 'sound/AI/radiation.ogg')
	//sound not longer matches the text, but an audible warning is probably good

/datum/event/radiation_storm/start()
	SSweather.run_weather(/datum/weather/rad_storm)