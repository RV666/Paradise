//Ancient cryogenic sleepers. Players become NT crewmen from a hundred year old space station, now on the verge of collapse.

/obj/effect/mob_spawn/human/oldsec
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a security uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a security officer"
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<span class='big bold'>Вы - офицер Службы безопасности, работающий на Нанотразен</span><b>, находитесь на борту современной исследовательской станции. Вы смутно припоминаете, \
	как залезли в криогенную капсулу из-за надвигающейся радиационной бури. Последнее, что вы помните, - это автономная система жизнеобеспечения, сообщающая всем, что вы будете спать только \
	восемь часов. Когда вы открываете криогенную капсулу, все кажется ржавым и сломанным. После выхода из криосна вы замечаете странную лужу под крио. Работайте в команде со своими товарищами по несчастью и не бросайте их.</b>"
	uniform = /obj/item/clothing/under/retro/security
	shoes = /obj/item/clothing/shoes/jackboots
	id = /obj/item/card/id/away/old/sec
	r_pocket = /obj/item/restraints/handcuffs
	l_pocket = /obj/item/flash
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldsec/Destroy()
	new /obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldmed
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a medical uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a medical doctor"
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<span class='big bold'>Вы - доктор, работающий на Нанотразен</span><b> находитесь на борту современной исследовательской станции. Вы смутно помните как заходили в криокапсулу \
	из-за надвигающейся радиационной бури. Последнее, что вы помните, - это автономная система жизнеобеспечения, сообщающая всем, что вы будете спать только \
	восемь часов. Когда вы открываете криогенную капсулу, все кажется ржавым и сломанным. После выхода из криосна вы замечаете странную лужу под крио. Работайте в команде со своими товарищами по несчастью и не бросайте их.</b>"
	uniform = /obj/item/clothing/under/retro/medical
	shoes = /obj/item/clothing/shoes/black
	id = /obj/item/card/id/away/old/med
	l_pocket = /obj/item/stack/medical/ointment
	r_pocket = /obj/item/stack/medical/ointment
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldmed/Destroy()
	new /obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldeng
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise an engineering uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "an engineer"
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<span class='big bold'>Вы - инженер, работающий на Нанотразен</span><b> находитесь на борту современной исследовательской станции. Вы смутно помните как включали и готовили криокапсулы \
	из-за надвигающейся радиационной бури. Последнее, что вы помните, - это автономная система жизнеобеспечения, сообщающая всем, что вы будете спать только \
	восемь часов. Когда вы открываете криогенную капсулу, все кажется ржавым и сломанным. После выхода из криосна вы замечаете странную лужу под крио. Работайте в команде со своими товарищами по несчастью и не бросайте их.</b>"
	uniform = /obj/item/clothing/under/retro/engineering
	shoes = /obj/item/clothing/shoes/workboots
	id = /obj/item/card/id/away/old/eng
	gloves = /obj/item/clothing/gloves/color/fyellow/old
	l_pocket = /obj/item/tank/emergency_oxygen
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldeng/Destroy()
	new /obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldsci
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a science uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a scientist"
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<span class='big bold'>Вы - учёный, работающий на Нанотразен </span><b>находитесь на борту современной исследовательской станции. Вы смутно помните как включали и готовили криокапсулы \
	из-за надвигающейся радиационной бури. Последнее, что вы помните, - это автономная система жизнеобеспечения, сообщающая всем, что вы будете спать только \
	восемь часов. Когда вы открываете криогенную капсулу, все кажется ржавым и сломанным. После выхода из криосна вы замечаете странную лужу под крио. Работайте в команде со своими товарищами по несчастью и не бросайте их.</b>"
	uniform = /obj/item/clothing/under/retro/science
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/away/old/sci
	l_pocket = /obj/item/stack/medical/bruise_pack
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldsci/Destroy()
	new /obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/structure/showcase/machinery/oldpod
	name = "damaged cryogenic pod"
	desc = "A damaged cryogenic pod long since lost to time, including its former occupant..."
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper-open"

/obj/structure/showcase/machinery/oldpod/used
	name = "opened cryogenic pod"
	desc = "A cryogenic pod that has recently discharged its occupant. The pod appears non-functional."
