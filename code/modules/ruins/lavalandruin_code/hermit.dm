//Malfunctioning cryostasis sleepers: Spawns in makeshift shelters in lavaland. Ghosts become hermits with knowledge of how they got to where they are now.
/obj/effect/mob_spawn/human/hermit
	name = "malfunctioning cryostasis sleeper"
	desc = "A humming sleeper with a silhouetted occupant inside. Its stasis function is broken and it's likely being used as a bed."
	mob_name = "a stranded hermit"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	allow_species_pick = TRUE
	mob_species = /datum/species/human
	flavour_text = "<span class='big bold'>Эта ужасная божья тюрьма держит меня тут больше, чем я могу вспомнить.</span><b> Каждый день, каждую минуту, словно ужасный сон я выживаю тут в своём \
	ужасно построеном импровизированом убежище, около страшных существ, около ублюдских драконов пожирающих всех своим огненым пламенем. Я уже не помню когда последний раз видел траву, запах свежего \
	воздуха родной Земли... Эти мысли рассеиваются еще одним воспоминанием о том, как я сюда попал... "
	assignedrole = "Hermit"

/obj/effect/mob_spawn/human/hermit/Initialize(mapload)
	. = ..()
	var/arrpee = rand(1,5)
	switch(arrpee)
		if(1)
			flavour_text += "вы были помошником [pick("Главы Персонала", "инженера", "капитана")] на торговой станции недалеко отсюда. Рейдеры что атаковали вашу станцию уничтожили её но я вовремя успел спастись на \
			одноместном поде. Вы взяли его и запустили в одиночку, но похоже когда я взлетал за дверью пода слышались звуки. Они кричали, просили о помощи но их мольбы были заглушены взрывом двигателей. \
			Этот кусок истории вы не забудете никогда.</b>"
			outfit.uniform = /obj/item/clothing/under/assistantformal
			outfit.shoes = /obj/item/clothing/shoes/black
			outfit.back = /obj/item/storage/backpack
			id = /obj/item/card/id/away/old

		if(2)
			flavour_text += "вы были игнаны из корпорации Тигр. Их технологический фанатизм заставил вас усомниться в силе Экзолитов, и они увидели в вас еретика .После много часовых пыток \
			ваш высокопоставленный друг сумел обеспечить вам капсулу, зашифровал координаты ее назначения и запустил ее. Вы очнулись от стазиса, когда приземлились, и с тех пор вы не выходили на поверхность... это ведь не космос, правда?</b>"
			outfit.uniform = /obj/item/clothing/under/color/orange
			outfit.shoes = /obj/item/clothing/shoes/orange
			outfit.back = /obj/item/storage/backpack
			id = /obj/item/card/id/prisoner/random
		if(3)
			flavour_text += "вы были врачом на одной из космических станций корпорации Нанотразен, но оставили позади тиранию этой проклятой станции и всего, что она олицетворяла. \
			Переходя от метафорического ада к буквальному, вы тем не менее обнаруживаете, что вам не хватает рециркулированного воздуха и теплых полов того, что вы оставили позади... но тут все равно лучше, чем там.</b>"
			outfit.uniform = /obj/item/clothing/under/rank/medical
			outfit.suit = /obj/item/clothing/suit/storage/labcoat
			outfit.back = /obj/item/storage/backpack/medic
			outfit.shoes = /obj/item/clothing/shoes/black
			outfit.id = /obj/item/card/id/medical
		if(4)
			flavour_text += "твои друзья всегда подшучивали над тобой за то, что ты \"не играешь с полной колодой\", как они так любезно выразились. Похоже, они были правы, когда вы, совершая экскурсию по одному из самых современных исследовательских центров Нанотразена, оказались в одной из \
			спасательных капсул и увидели красную кнопку. Она была большая и блестящая, и сразу бросалася в глаза. Вы нажали на нее, и после ужасающей и быстрой езды в течение нескольких дней, вы приземлились здесь. \
			У тебя было время поумнеть с тех пор, и ты думаешь, что твои старые друзья не смеялись бы сейчас.</b>"
			outfit.uniform = /obj/item/clothing/under/color/grey/glorf
			outfit.shoes = /obj/item/clothing/shoes/black
			outfit.back = /obj/item/storage/backpack
			outfit.id = /obj/item/card/id
			outfit.glasses = /obj/item/clothing/glasses/sunglasses
		if(5) //от меня дополнительно
			flavour_text += "когда то давно ты был Ядерным Оперативником но после одной из вылазок ваша комманда была повержена силами станции! Вы единственный спаслись и \
			после удачной попытки сбежать от космического Ада вы попали в другой, уже походящий на настоящий Ад. Во время прибывания в криосне ваш имплант был выведен из строя и теперь у вас нет ни нанимателей, ни кого либо ещё.</b>"
			outfit.uniform = /obj/item/clothing/under/color/grey/glorf
			outfit.shoes = /obj/item/clothing/shoes/black
			outfit.back = /obj/item/storage/backpack
			outfit.id = /obj/item/card/id/syndicate
			outfit.r_pocket = /obj/item/gun/projectile/automatic/pistol

/obj/effect/mob_spawn/human/hermit/Destroy()
	new/obj/structure/fluff/empty_cryostasis_sleeper(get_turf(src))
	return ..()
