// SyndiChem
/obj/machinery/vending/syndichem
	name = "\improper SyndiChem"
	desc = "A vending machine full of grenades and grenade accessories. Sponsored by DonkCo(tm)."
	req_access = list(ACCESS_SYNDICATE)
	products = list(/obj/item/stack/cable_coil/random = 5,
					/obj/item/assembly/igniter = 20,
					/obj/item/assembly/prox_sensor = 5,
					/obj/item/assembly/signaler = 5,
					/obj/item/assembly/timer = 5,
					/obj/item/assembly/voice = 5,
					/obj/item/assembly/health = 5,
					/obj/item/assembly/infra = 5,
					/obj/item/grenade/chem_grenade = 5,
	                /obj/item/grenade/chem_grenade/large = 5,
	                /obj/item/grenade/chem_grenade/pyro = 5,
	                /obj/item/grenade/chem_grenade/cryo = 5,
	                /obj/item/grenade/chem_grenade/adv_release = 5,
					/obj/item/reagent_containers/food/drinks/bottle/holywater = 1)
	product_slogans = "It's not pyromania if you're getting paid!;You smell that? Plasma, son. Nothing else in the world smells like that.;I love the smell of Plasma in the morning."
	resistance_flags = FIRE_PROOF

// Spawners
/obj/effect/mob_spawn/human/lavaland_syndicate
	name = "Syndicate Bioweapon Scientist sleeper"
	mob_name = "Syndicate Bioweapon Scientist"
	roundstart = FALSE
	death = FALSE
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper_s"
	flavour_text = "<span class='big bold'>Вы агент синдиката,</span><b> и сейчас вы работаете в сверхсекретном исследовательском центре по разработке биологического оружия. К сожалению, наш ненавистный враг, Нанотразен, начал добычу полезных ископаемых в этом секторе. <b>Продолжайте свои исследования, насколько это возможно, и старайтесь не показываться им на глаза. На базе есть мощная бомба, не покидайте базу и не дайте ей попасть в руки врага!</b> \
	<br><i>Вы можете атаковать любого, кто не связан с синдикатом в непосредственной близости от вашей базы. <font size=6>НИ В КОЕМ СЛУЧАЕ НЕ</font> работайте против персонала Синдиката (например, предателей или ядерных оперативников). Вы можете работать с несиндикатными антагонистами или против них в каждом конкретном случае. <font size=6>И НИКОГДА, НИКОГДА НЕ</font> покидайте базу без разрешения Администратора.</i>"
	outfit = /datum/outfit/lavaland_syndicate
	assignedrole = "Lavaland Syndicate"
	allow_species_pick = TRUE

/obj/effect/mob_spawn/human/lavaland_syndicate/special(mob/living/carbon/human/new_spawn)
	new_spawn.rename_character(new_spawn.real_name, new_spawn.dna.species.get_random_name(new_spawn.gender))

/obj/effect/mob_spawn/human/lavaland_syndicate/Destroy()
	var/obj/structure/fluff/empty_sleeper/syndicate/S = new /obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	S.setDir(dir)
	return ..()

/datum/outfit/lavaland_syndicate
	name = "Lavaland Syndicate Agent"
	r_hand = /obj/item/gun/projectile/automatic/sniper_rifle
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/storage/labcoat
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	r_ear = /obj/item/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	r_pocket = /obj/item/gun/projectile/automatic/pistol
	id = /obj/item/card/id/syndicate/anyone
	implants = list(/obj/item/implant/weapons_auth)

/datum/outfit/lavaland_syndicate/post_equip(mob/living/carbon/human/H)
	H.faction |= "syndicate"

/obj/effect/mob_spawn/human/lavaland_syndicate/comms
	name = "Syndicate Comms Agent sleeper"
	mob_name = "Syndicate Comms Agent"
	flavour_text = "<span class='big bold'>Вы агент синдиката,</span><b> и сейчас вы работаете в сверхсекретном исследовательском центре по разработке биологического оружия. К сожалению, наш ненавистный враг, Нанотразен, начал добычу полезных ископаемых в этом секторе. <b>Следите за действиями противника, насколько это возможно, и старайтесь не попадаться им на глаза. Не покидайте базу.</b> Используйте коммуникационное оборудование, чтобы обеспечить поддержку любым полевым агентам, и используйте дезинформацию против Нанотразен. Не дайте базе попасть в руки врага!</b> \
	<br><i>Вы можете атаковать любого, кто не связан с синдикатом в непосредственной близости от вашей базы. <font size=6>НИ В КОЕМ СЛУЧАЕ НЕ</font> работайте против персонала Синдиката (например, предателей или ядерных оперативников). Вы можете работать с несиндикатными антагонистами или против них в каждом конкретном случае. <font size=6>И НИКОГДА, НИКОГДА НЕ</font> покидайте базу без разрешения Администратора.</i>"
	outfit = /datum/outfit/lavaland_syndicate/comms

/obj/effect/mob_spawn/human/lavaland_syndicate/comms/special(mob/living/carbon/human/new_spawn)
	new_spawn.rename_character(new_spawn.real_name, new_spawn.dna.species.get_random_name(new_spawn.gender))

/obj/effect/mob_spawn/human/lavaland_syndicate/comms/space
	flavour_text = "<span class='big bold'>Вы агент синдиката,</span><b> и вы назначены на небольшую подслушивающую станцию, расположенную рядом с исследовательским объектом типа станция.<b>Следите за действиями противника, насколько это возможно, и старайтесь не попадаться им на глаза. Не покидайте базу.</b> Используйте коммуникационное оборудование, чтобы обеспечить поддержку любым полевым агентам, и используйте дезинформацию против Нанотразен. Не дайте базе попасть в руки врага!</b> \
	<br><i>Вы можете атаковать любого, кто не связан с синдикатом в непосредственной близости от вашей базы. <font size=6>НИ В КОЕМ СЛУЧАЕ НЕ</font> работайте против персонала Синдиката (например, предателей или ядерных оперативников). Вы можете работать с несиндикатными антагонистами или против них в каждом конкретном случае. <font size=6>И НИКОГДА, НИКОГДА НЕ</font> покидайте базу без разрешения Администратора.</i>"

/obj/effect/mob_spawn/human/lavaland_syndicate/comms/space/special(mob/living/carbon/human/new_spawn)
	new_spawn.rename_character(new_spawn.real_name, new_spawn.dna.species.get_random_name(new_spawn.gender))

/obj/effect/mob_spawn/human/lavaland_syndicate/comms/space/Initialize(mapload)
	. = ..()
	if(prob(90)) //only has a 10% chance of existing, otherwise it'll just be a NPC syndie.
		new /mob/living/simple_animal/hostile/syndicate/ranged(get_turf(src))
		return INITIALIZE_HINT_QDEL

/datum/outfit/lavaland_syndicate/comms
	name = "Lavaland Syndicate Comms Agent"
	r_hand = /obj/item/melee/energy/sword/saber
	mask = /obj/item/clothing/mask/chameleon/gps
	suit = /obj/item/clothing/suit/armor/vest

/obj/item/clothing/mask/chameleon/gps/New()
	. = ..()
	new /obj/item/gps/internal/lavaland_syndicate_base(src)

/obj/item/gps/internal/lavaland_syndicate_base
	gpstag = "Encrypted Signal"
