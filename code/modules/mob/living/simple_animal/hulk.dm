//Human hulk
/mob/living/simple_animal/hulk
	name = "Hulk"
	real_name = "Hulk"
	desc = ""
	icon = 'icons/mob/Hulk.dmi'
	icon_state = "Hulk"
	icon_living = "Hulk"
	maxHealth = 400
	health = 400
	speed = 1.25
	harm_intent_damage = 20
	melee_damage_lower = 20
	melee_damage_upper = 20

	speak_emote = list("roars")
	emote_hear = list("roars")
	response_help  = "thinks better of touching"
	response_disarm = "flails at"
	response_harm   = "punches"
	environment_smash = 2

	a_intent = INTENT_HARM
	stop_automated_movement = 1
	status_flags = CANPUSH
	universal_speak = 1
	universal_understand = 1
	attack_sound = list('sound/weapons/punch1.ogg')
	minbodytemp = 0
	var/hulk_powers = list()
	var/mob/living/original_body
	var/health_regen = 1.5

/mob/living/simple_animal/hulk/human
	hulk_powers = list(/obj/effect/proc_holder/spell/aoe_turf/hulk_jump,
	/obj/effect/proc_holder/spell/aoe_turf/hulk_dash)

//Clown Hulk

/mob/living/simple_animal/hulk/clown_hulk
	name = "Champion of Honk"
	real_name = "Champion of Honk"
	icon = 'icons/mob/Hulk.dmi'
	icon_state = "Champion of Honk"
	icon_living = "Champion of Honk"
	maxHealth = 250
	health = 250
	speed = 1
	harm_intent_damage = 5
	melee_damage_lower = 5
	melee_damage_upper = 5

	speak_emote = list("honks")
	emote_hear = list("honks")
	attack_sound = list('sound/items/bikehorn.ogg')
	health_regen = 6

	hulk_powers = list(/obj/effect/proc_holder/spell/aoe_turf/hulk_honk,
	/obj/effect/proc_holder/spell/aoe_turf/hulk_joke)

//Godzilla

/mob/living/simple_animal/hulk/zilla
	name = "Zilla"
	real_name = " Zilla"
	icon = 'icons/mob/zilla.dmi'
	icon_state = "zilla"
	icon_living = "zilla"
	maxHealth = 450
	health = 450
	speed = 1.5
	harm_intent_damage = 30
	melee_damage_lower = 30
	melee_damage_upper = 30

	speak_emote = list("gnaw")
	emote_hear = list("gnaw")
	attack_sound = list('sound/weapons/bite.ogg')
	health_regen = 1.5

	hulk_powers = list(/obj/effect/proc_holder/spell/aoe_turf/hulk_mill,
	/obj/effect/proc_holder/spell/targeted/click/hulk_spit,
	/obj/effect/proc_holder/spell/targeted/click/hulk_lazor)

/mob/living/simple_animal/hulk/Life()
	if(health < 1)
		death()
		return

	var/matrix/Mx = matrix()
	if(health < maxHealth * 0.2)
		Mx.Scale(0.75)
		Mx.Translate(0,-5)
	else if(health < maxHealth * 0.4)
		Mx.Scale(0.8)
		Mx.Translate(0,-4)
	else if(health < maxHealth * 0.6)
		Mx.Scale(0.85)
		Mx.Translate(0,-3)
	else if(health < maxHealth * 0.8)
		Mx.Scale(0.9)
		Mx.Translate(0,-2)
	else
		Mx.Scale(1)
		Mx.Translate(0,0)
	transform = Mx

	var/datum/gas_mixture/environment = loc.return_air()
	if(environment)
		var/pressure = environment.return_pressure()
		if(pressure > 110)
			health -= 7
		else if(pressure <= 5)
			health -= 12
		else if(pressure <= 25)
			health -= 8
		else if(pressure <= 45)
			health -= 5
		else if(pressure <= 55)
			health -= 3

		if(pressure <= 75)
			if(prob(15))
				emote("me",1,"gasps!")

	weakened = 0
	if(health > 0)
		health = min(health + health_regen, maxHealth)
		adjustBruteLoss(-health_regen)
		adjustToxLoss(-health_regen)
		adjustOxyLoss(-health_regen)
		adjustFireLoss(-health_regen)
	..()

/mob/living/proc/hulk_scream(obj/target, chance)
	if(prob(chance))
		visible_message("<span class='userdanger'>[src] has punched \the [target]!</span>",\
		"<span class='userdanger'>You punch the [target]!</span>",\
		"<span class='userdanger'>You feel some weird vibration!</span>")
		playsound(target, 'sound/effects/hulk_hit_airlock.ogg', CHANNEL_BUZZ, 75)
		return 0
	else
		say(pick("RAAAAAAAARGH!", "HNNNNNNNNNGGGGGGH!", "GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", "AAAAAAARRRGH!" ))
		visible_message("<span class='userdanger'>[src] has destroyed some mechanic in the [target]!</span>",\
		"<span class='userdanger'>You destroy some mechanic in the [target] door, which holds it in place!</span>",\
		"<span class='userdanger'>You feel some weird vibration!</span>")
		playsound(target, pick('sound/effects/explosion1.ogg', 'sound/effects/explosion2.ogg'), CHANNEL_BUZZ)
		return 1

/mob/living/simple_animal/hulk/proc/attack_hulk(obj/machinery/door/D)
	do_attack_animation(D)
	changeNext_move(CLICK_CD_MELEE)
	if(istype(D,/obj/machinery/door/airlock))
		var/obj/machinery/door/airlock/A = D
		if(A.welded || A.locked)
			if(hulk_scream(A, 75))
				A.deconstruct(src)
			return
	if(istype(D,/obj/machinery/door/firedoor))
		var/obj/machinery/door/firedoor/F = D
		if(FD_CLOSED)
			if(hulk_scream(F))
				qdel(F)
				return
	if(D.density)
		to_chat(src, "<span class='userdanger'>You force your fingers between \
		 the doors and begin to pry them open...</span>")
		playsound(D, 'sound/machines/airlockforced.ogg', CHANNEL_BUZZ, 30, null, -4)
		D.open(1)

/mob/living/simple_animal/hulk/New()
	..()
	name = text("[initial(name)] ([rand(1, 1000)])")
	real_name = name
	status_flags ^= CANPUSH
	for(var/spell in hulk_powers)
		src.AddSpell(new spell)