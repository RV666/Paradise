/obj/item/clothing/head/helmet/space/new_rig/combat

/obj/item/rig/combat
	name = "combat hardsuit control module"
	desc = "A sleek and dangerous hardsuit for active combat."
	icon_state = "security_rig"
	suit_type = "combat hardsuit"
	armor = list(melee = 35, bullet = 45, laser = 25, energy = 20, bomb = 35, bio = 100, rad = 60)
	active_slowdown = 1
	offline_slowdown = 3
	offline_vision_restriction = 1

	helm_type = /obj/item/clothing/head/helmet/space/new_rig/combat
	allowed = list(/obj/item/gun,/obj/item/flashlight,/obj/item/tank,/obj/item/melee/baton)


/obj/item/rig/combat/equipped


	initial_modules = list(
		/obj/item/rig_module/mounted,
		/obj/item/rig_module/vision/thermal,
		/obj/item/rig_module/grenade_launcher,
		/obj/item/rig_module/ai_container,
		// /obj/item/rig_module/power_sink,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/chem_dispenser/combat
		)
