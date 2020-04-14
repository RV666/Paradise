/obj/effect/spawner/lootdrop/seed_vault
	name = "seed vault seeds"
	lootcount = 1

	loot = list(/obj/item/seeds/gatfruit = 10,
				/obj/item/seeds/cherry/bomb = 10,
				/obj/item/seeds/berry/glow = 10,
				/obj/item/seeds/sunflower/moonflower = 8
				)

/obj/effect/mob_spawn/human/seed_vault
	name = "preserved terrarium"
	desc = "An ancient machine that seems to be used for storing plant matter. The glass is obstructed by a mat of vines."
	mob_name = "a lifebringer"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "terrarium"
	density = TRUE
	roundstart = FALSE
	death = FALSE
	mob_species = /datum/species/diona/pod
	flavour_text = "<span class='big bold'>Вы - разумная экосистема,</span><b> пример господства над жизнью, которым обладали ваши создатели. Ваши учителя, как бы великодушны они ни были, \
	создали бесчисленные хранилища семян и распространили их по всей Вселенной на каждую планету, которую они могли бы нанести на карту. Вы находитесь в одном из таких хранилищ семян. \
	Ваша цель состоит в том, чтобы культивировать и распространять жизнь везде, где она будет идти, ожидая контакта с вашими создателями. Последний предполагаемый контакт с вашими создателями: примерно 5x10^3 тысячелетия назад.</b>"
	assignedrole = "Lifebringer"

/obj/effect/mob_spawn/human/seed_vault/special(mob/living/new_spawn)
	var/plant_name = pick("Tomato", "Potato", "Broccoli", "Carrot", "Ambrosia", "Pumpkin", "Ivy", "Kudzu", "Banana", "Moss", "Flower", "Bloom", "Root", "Bark", "Glowshroom", "Petal", "Leaf", \
	"Venus", "Sprout","Cocoa", "Strawberry", "Citrus", "Oak", "Cactus", "Pepper", "Juniper")
	new_spawn.rename_character(null, plant_name)

/obj/effect/mob_spawn/human/seed_vault/Destroy()
	new/obj/structure/fluff/empty_terrarium(get_turf(src))
	return ..()
