/////////////////////////////////////////
/////////////////Weapons/////////////////
/////////////////////////////////////////

/datum/design/nuclear_gun
	name = "Advanced Energy Gun"
	desc = "An energy gun with an experimental miniaturized reactor."
	id = "nuclear_gun"
	req_tech = list("combat" = 5, "magnets" = 5, "powerstorage" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_GLASS = 2000, MAT_URANIUM = 3000, MAT_TITANIUM = 1000)
	build_path = /obj/item/gun/energy/gun/nuclear
	locked = 1
	category = list("Weapons")

/datum/design/decloner
	name = "Decloner"
	desc = "Your opponent will bubble into a messy pile of goop."
	id = "decloner"
	req_tech = list("combat" = 5, "materials" = 5, "biotech" = 6, "plasmatech" = 7)
	build_type = PROTOLATHE
	materials = list(MAT_GOLD = 5000,MAT_URANIUM = 10000)
	reagents_list = list("mutagen" = 40)
	build_path = /obj/item/gun/energy/decloner
	locked = 1
	category = list("Weapons")

/datum/design/flora_gun
	name = "Floral Somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells. Harmless to other organic life."
	id = "flora_gun"
	req_tech = list("materials" = 2, "biotech" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 500)
	reagents_list = list("radium" = 20)
	build_path = /obj/item/gun/energy/floragun
	category = list("Weapons")

/datum/design/ioncarbine
	name = "Ion Carbine"
	desc = "How to dismantle a cyborg : The gun."
	id = "ioncarbine"
	req_tech = list("combat" = 5, "magnets" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_SILVER = 6000, MAT_METAL = 8000, MAT_URANIUM = 2000)
	build_path = /obj/item/gun/energy/ionrifle/carbine
	locked = 1
	category = list("Weapons")

/datum/design/wormhole_projector
	name = "Bluespace Wormhole Projector"
	desc = "A projector that emits high density quantum-coupled bluespace beams."
	id = "wormholeprojector"
	req_tech = list("combat" = 5, "engineering" = 5, "bluespace" = 7, "plasmatech" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_SILVER = 2000, MAT_METAL = 5000, MAT_DIAMOND = 2000, MAT_BLUESPACE = 3000)
	build_path = /obj/item/gun/energy/wormhole_projector
	locked = 1
	access_requirement = list(access_rd) //screw you, HoS, this aint yours; this is only for a man of science---and trouble.
	category = list("Weapons")

/datum/design/large_grenade
	name = "Large Grenade"
	desc = "A grenade that affects a larger area and use larger containers."
	id = "large_Grenade"
	req_tech = list("combat" = 3, "engineering" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000)
	build_path = /obj/item/grenade/chem_grenade/large
	category = list("Weapons")

/datum/design/pyro_grenade
	name = "Pyro Grenade"
	desc = "An advanced grenade that is able to self ignite its mixture."
	id = "pyro_Grenade"
	req_tech = list("combat" = 4, "engineering" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_PLASMA = 500)
	build_path = /obj/item/grenade/chem_grenade/pyro
	category = list("Weapons")

/datum/design/cryo_grenade
	name = "Cryo Grenade"
	desc = "An advanced grenade that rapidly cools its contents upon detonation."
	id = "cryo_Grenade"
	req_tech = list("combat" = 3, "materials" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_SILVER = 500)
	build_path = /obj/item/grenade/chem_grenade/cryo
	category = list("Weapons")

/datum/design/adv_grenade
	name = "Advanced Release Grenade"
	desc = "An advanced grenade that can be detonated several times, best used with a repeating igniter."
	id = "adv_Grenade"
	req_tech = list("combat" = 3, "engineering" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 3000, MAT_GLASS = 500)
	build_path = /obj/item/grenade/chem_grenade/adv_release
	category = list("Weapons")

/datum/design/tele_shield
	name = "Telescopic Riot Shield"
	desc = "An advanced riot shield made of lightweight materials that collapses for easy storage."
	id = "tele_shield"
	req_tech = list("combat" = 4, "materials" = 3, "engineering" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 4000, MAT_GLASS = 4000, MAT_SILVER = 300, MAT_TITANIUM = 200)
	build_path = /obj/item/shield/riot/tele
	category = list("Weapons")

/datum/design/lasercannon
	name = "Accelerator Laser Cannon"
	desc = "A heavy duty laser cannon. It does more damage the farther away the target is."
	id = "lasercannon"
	req_tech = list("combat" = 5, "magnets" = 5, "powerstorage" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_GLASS = 3000, MAT_DIAMOND = 3000)
	build_path = /obj/item/gun/energy/lasercannon
	locked = 1
	category = list("Weapons")

/datum/design/plasmapistol
	name = "Plasma Pistol"
	desc = "A specialized firearm designed to fire lethal bolts of toxins."
	id = "ppistol"
	req_tech = list("combat" = 5, "magnets" = 5, "powerstorage" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 1000, MAT_PLASMA = 3000)
	build_path = /obj/item/gun/energy/toxgun
	locked = 1
	category = list("Weapons")

//WT550 Mags

/datum/design/mag_oldsmg
	name = "WT-550 Auto Gun Magazine (4.6x30mm)"
	desc = "A 20 round magazine for the out of date security WT-550 Auto Rifle"
	id = "mag_oldsmg"
	req_tech = list("combat" = 1, "materials" = 1)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 4000)
	build_path = /obj/item/ammo_box/magazine/wt550m9
	category = list("Weapons")

/datum/design/mag_oldsmg/ap_mag
	name = "WT-550 Auto Gun Armour Piercing Magazine (4.6x30mm AP)"
	desc = "A 20 round armour piercing magazine for the out of date security WT-550 Auto Rifle"
	id = "mag_oldsmg_ap"
	materials = list(MAT_METAL = 6000, MAT_SILVER = 600)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtap

/datum/design/mag_oldsmg/ic_mag
	name = "WT-550 Auto Gun Incendiary Magazine (4.6x30mm IC)"
	desc = "A 20 round armour piercing magazine for the out of date security WT-550 Auto Rifle"
	id = "mag_oldsmg_ic"
	materials = list(MAT_METAL = 6000, MAT_SILVER = 600, MAT_GLASS = 1000)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wtic

/datum/design/mag_oldsmg/tx_mag
	name = "WT-550 Auto Gun Uranium Magazine (4.6x30mm TX)"
	desc = "A 20 round uranium tipped magazine for the out of date security WT-550 Auto Rifle"
	id = "mag_oldsmg_tx"
	materials = list(MAT_METAL = 6000, MAT_SILVER = 600, MAT_URANIUM = 2000)
	build_path = /obj/item/ammo_box/magazine/wt550m9/wttx

/datum/design/rapidsyringe
	name = "Rapid Syringe Gun"
	desc = "A gun that fires many syringes."
	id = "rapidsyringe"
	req_tech = list("combat" = 2, "biotech" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 1000)
	build_path = /obj/item/gun/syringe/rapidsyringe
	category = list("Weapons")

/datum/design/stunshell
	name = "Stun Shell"
	desc = "A stunning shell for a shotgun."
	id = "stunshell"
	req_tech = list("combat" = 3, "materials" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 200)
	build_path = /obj/item/ammo_casing/shotgun/stunslug
	category = list("Weapons")

/datum/design/stunrevolver
	name = "Tesla Revolver"
	desc = "A high-tech revolver that fires internal, reusable shock cartridges in a revolving cylinder. The cartridges can be recharged using conventional rechargers."
	id = "stunrevolver"
	req_tech = list("combat" = 4, "materials" = 4, "powerstorage" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_GLASS = 10000, MAT_SILVER = 10000)
	build_path = /obj/item/gun/energy/shock_revolver
	locked = 1
	category = list("Weapons")

/datum/design/temp_gun
	name = "Temperature Gun"
	desc = "A gun that changes the body temperature of its targets."
	id = "temp_gun"
	req_tech = list("combat" = 4, "materials" = 4, "powerstorage" = 3, "magnets" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 500, MAT_SILVER = 3000)
	build_path = /obj/item/gun/energy/temperature
	category = list("Weapons")

/datum/design/techshell
	name = "Unloaded Technological Shotshell"
	desc = "A high-tech shotgun shell which can be loaded with materials to produce unique effects."
	id = "techshotshell"
	req_tech = list("combat" = 3, "materials" = 3, "powerstorage" = 4, "magnets" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 1000, MAT_GLASS = 200)
	build_path = /obj/item/ammo_casing/shotgun/techshell
	category = list("Weapons")

/datum/design/xray
	name = "Xray Laser Gun"
	desc = "Not quite as menacing as it sounds"
	id = "xray"
	req_tech = list("combat" = 7, "magnets" = 5, "biotech" = 5, "powerstorage" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_GOLD = 5000, MAT_URANIUM = 4000, MAT_METAL = 5000, MAT_TITANIUM = 2000, MAT_BLUESPACE = 2000)
	build_path = /obj/item/gun/energy/xray
	locked = 1
	category = list("Weapons")

/datum/design/immolator
	name = "Immolator Laser Gun"
	desc = "Has fewer shots than a regular laser gun, but ignites the target on hit"
	id = "immolator"
	req_tech = list("combat" = 5, "magnets" = 5, "powerstorage" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 4000, MAT_GLASS = 1000, MAT_SILVER = 3000, MAT_PLASMA = 2000)
	build_path = /obj/item/gun/energy/immolator
	locked = 1
	category = list("Weapons")

/////////////////////////////////////////
////////////RIG modules//////////////////
/////////////////////////////////////////

/datum/design/ore_scanner
	name = "ore scanner module"
	desc = "ore scanner module"
	id = "orescannermodule"
	req_tech = list("combat" = 1, "engineering" = 5, "programming" = 3, "materials" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000,)
	build_path = /obj/item/rig_module/device/orescanner
	category = list("RIG modules")

/datum/design/drill_mount
	name = "hardsuit drill mount"
	desc = "hardsuit drill mount"
	id = "harddrill"
	req_tech = list("combat" = 1, "engineering" = 5, "programming" = 3, "materials" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_DIAMOND = 2000)
	build_path = /obj/item/rig_module/device/drill
	category = list("RIG modules")

/datum/design/fuel_tank
	name = "welding fuel tank"
	desc = "welding fuel tank"
	id = "hardweldfueltank"
	req_tech = list("combat" = 1, "engineering" = 4, "programming" = 1, "bluespace" = 4, "materials" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_PLASMA = 2000)
	build_path = /obj/item/rig_module/welding_tank
	category = list("RIG modules")

/datum/design/ai_module
	name = "IIS module"
	desc = "IIS module"
	id = "hardaimodule"
	req_tech = list("combat" = 1, "programming" = 5, "materials" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_SILVER = 2000)
	build_path = /obj/item/rig_module/ai_container
	category = list("RIG modules")

/datum/design/mount_cutter
	name = "hardsuit plasma cutter"
	desc = "hardsuit plasma cutter"
	id = "hardplascut"
	req_tech = list("combat" = 3, "engineering" = 4, "programming" = 1, "materials" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_PLASMA = 5000)
	build_path = /obj/item/rig_module/device/plasmacutter
	category = list("RIG modules")

/datum/design/hardsuit_jets
	name = "hardsuit maneuvering jets"
	desc = "hardsuit maneuvering jets"
	id = "hardmanjet"
	req_tech = list("combat" = 1, "engineering" = 5, "programming" = 2, "materials" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_SILVER = 1000)
	build_path = /obj/item/rig_module/maneuvering_jets
	category = list("RIG modules")

/datum/design/hardsuit_meson
	name = "hardsuit meson scanner"
	desc = "hardsuit meson scanner"
	id = "hardmesonscan"
	req_tech = list("combat" = 1, "engineering" = 3, "programming" = 4, "powerstorage" = 2, "materials" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000,)
	build_path = /obj/item/rig_module/vision/meson
	category = list("RIG modules")

/datum/design/hardsuit_night
	name = "hardsuit night vision interface"
	desc = "hardsuit night vision interface"
	id = "hardnight"
	req_tech = list("combat" = 1, "engineering" = 5, "programming" = 2, "biotech"= 3, "materials" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_SILVER = 500)
	build_path = /obj/item/rig_module/vision/nvg
	category = list("RIG modules")

/////////////////////////////////////////////////
///////////////////Medical modules///////////////
/////////////////////////////////////////////////

/datum/design/hardsuit_health_scanner
	name = "health scanner module"
	desc = "health scanner module"
	id = "healthcsanmount"
	req_tech = list("combat" = 1, "engineering" = 4, "programming" = 3, "biotech"= 4, "materials" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000,)
	build_path = /obj/item/rig_module/device/healthscanner
	category = list("RIG modules")

/datum/design/hardsuit_med_hud
	name = "hardsuit medical hud"
	desc = "hardsuit medical hud"
	id = "healthhudmount"
	req_tech = list("combat" = 1, "engineering" = 3, "programming" = 3, "biotech"= 4, "materials" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000,)
	build_path = /obj/item/rig_module/vision/medhud
	category = list("RIG modules")

/datum/design/hardsuit_chemdispenser
	name = "mounted chemical dispenser"
	desc = "mounted chemical dispenser"
	id = "chemdismount"
	req_tech = list("combat" = 3, "engineering" = 6, "programming" = 5, "biotech"= 4, "bluespace" = 2, "materials" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_SILVER = 1000, MAT_GOLD = 500)
	build_path = /obj/item/rig_module/chem_dispenser
	category = list("RIG modules")

/////////////////////////////////////////////////
/////////////////SECURITY MODULES////////////////
/////////////////////////////////////////////////

/datum/design/hardsuit_thermal
	name = "hardsuit thermal scanner"
	desc = "hardsuit thermal scanner"
	id = "hardsuitthermal"
	req_tech = list("combat" = 4, "engineering" = 3, "programming" = 3, "biotech"= 5, "materials" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_SILVER  = 1000, MAT_DIAMOND = 1000)
	build_path = /obj/item/rig_module/vision/thermal
	category = list("RIG modules")

/datum/design/hardsuit_security
	name = "hardsuit security hud"
	desc = "hardsuit security hud"
	id = "hardsuitsecurity"
	req_tech = list("combat" = 2, "engineering" = 3, "programming" = 3, "biotech"= 2, "materials" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000)
	build_path = /obj/item/rig_module/vision/sechud
	category = list("RIG modules")

/datum/design/hardsuit_grenade_launcher
	name = "mounted grenade launcher"
	desc = "mounted grenade launcher"
	id = "hardsuitgrenade"
	req_tech = list("combat" = 5, "engineering" = 4, "syndicate" = 3, "programming" = 5, "bluespace" = 3, "powerstorage" = 4, "materials" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_DIAMOND = 5000)
	build_path = /obj/item/rig_module/grenade_launcher
	category = list("RIG modules")

/datum/design/hardsuit_egun
	name = "mounted energy gun"
	desc = "mounted energy gun"
	id = "hardsuitegun"
	req_tech = list("combat" = 5, "engineering" = 4, "programming" = 3, "powerstorage" = 4, "materials" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_SILVER = 3000)
	build_path = /obj/item/rig_module/mounted/egun
	category = list("RIG modules")

/datum/design/hardsuit_flash
	name = "mounted flash"
	desc = "mounted flash"
	id = "hardsuitflash"
	req_tech = list("combat" = 3, "programming" = 3, "powerstorage" = 4, "materials" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000)
	build_path = /obj/item/rig_module/device/flash
	category = list("RIG modules")

/datum/design/hardsuit_taser
	name = "mounted taser"
	desc = "mounted taser"
	id = "hardsuittaser"
	req_tech = list("combat" = 4, "programming" = 3, "powerstorage" = 4, "materials" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000)
	build_path = /obj/item/rig_module/mounted/taser
	category = list("RIG modules")

/////////////////////////////////////////////////
/////////////////ILLEGAL MODULES/////////////////
/////////////////////////////////////////////////

/datum/design/hardsuit_omnivisor
	name = "hardsuit optical package"
	desc = "A complete visor system of optical scanners and vision modes."
	id = "hardsuitomnivisor"
	req_tech = list("combat" = 5, "engineering" = 7, "syndicate" = 4, "programming" = 5, "biotech"= 5, "bluespace" = 4, "powerstorage" = 5, "materials" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_DIAMOND = 2000)
	build_path = /obj/item/rig_module/vision/multi
	category = list("RIG modules")

/datum/design/hardsuit_electrowar
	name = "electrowarfare module"
	desc = "A bewilderingly complex bundle of fiber optics and chips."
	id = "hardsuitelwar"
	req_tech = list("combat" = 3, "engineering" = 7, "syndicate" = 4, "programming" = 4, "biotech"= 3, "powerstorage" = 4, "materials" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_SILVER = 2000, MAT_DIAMOND = 5000)
	build_path = /obj/item/rig_module/electrowarfare_suite
	category = list("RIG modules")

/datum/design/hardsuit_voice
	name = "hardsuit voice synthesiser"
	desc = "A speaker box and sound processor."
	id = "hardsuitvoice"
	req_tech = list("combat" = 3, "engineering" = 7, "syndicate" = 4, "programming" = 5, "materials" = 6)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000, MAT_GOLD = 500)
	build_path = /obj/item/rig_module/voice
	category = list("RIG modules")

/datum/design/hardsuit_datajack
	name = "datajack module"
	desc = "A simple induction datalink module"
	id = "hardsuitdatajack"
	req_tech = list("combat" = 3, "engineering" = 5, "syndicate" = 3, "programming" = 5, "powerstorage" = 3, "materials" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000)
	build_path = /obj/item/rig_module/datajack
	category = list("RIG modules")

///datum/design/
//  name = ""
//	desc = ""
//	id = ""
//	req_tech = list("combat" = 1, "programming" = 1, "materials" = 1)
//	build_type = PROTOLATHE
//	materials = list(MAT_METAL = 5000, MAT_GLASS = 3000,)
//  build_path =
//	category = list("RIG modules")

/////////////////////////////////////////
////////////////ILLEGAL//////////////////
/////////////////////////////////////////

/datum/design/antimov_module
	name = "Core AI Module (Antimov)"
	desc = "Allows for the construction of a Antimov AI Core Module."
	id = "antimov_module"
	req_tech = list("programming" = 5, "syndicate" = 2, "materials" = 5)
	build_type = IMPRINTER
	materials = list(MAT_GLASS = 1000, MAT_DIAMOND = 100)
	build_path = /obj/item/aiModule/antimov
	category = list("ILLEGAL")

/datum/design/tyrant_module
	name = "Core AI Module (T.Y.R.A.N.T.)"
	desc = "Allows for the construction of a T.Y.R.A.N.T. AI Module."
	id = "tyrant_module"
	req_tech = list("programming" = 5, "syndicate" = 2, "materials" = 5)
	build_type = IMPRINTER
	materials = list(MAT_GLASS = 1000, MAT_DIAMOND = 100)
	build_path = /obj/item/aiModule/tyrant
	category = list("ILLEGAL")

/datum/design/largecrossbow
	name = "Energy Crossbow"
	desc = "A reverse-engineered energy crossbow favored by syndicate infiltration teams and carp hunters."
	id = "largecrossbow"
	req_tech = list("combat" = 5, "engineering" = 3, "magnets" = 5, "syndicate" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 5000, MAT_GLASS = 1500, MAT_URANIUM = 1500, MAT_SILVER = 1500)
	build_path = /obj/item/gun/energy/kinetic_accelerator/crossbow/large
	locked = 0
	category = list("ILLEGAL")

/datum/design/suppressor
	name = "Universal Suppressor"
	desc = "A reverse-engineered universal suppressor that fits on most small arms with threaded barrels."
	id = "suppressor"
	req_tech = list("combat" = 6, "engineering" = 5, "syndicate" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_SILVER = 500)
	build_path = /obj/item/suppressor
	category = list("ILLEGAL")

/datum/design/stechkin
	name = "Stechkin pistol"
	desc = "A reverse-engineered small, easily concealable 10mm handgun. Has a threaded barrel for suppressors."
	id = "stechkin"
	req_tech = list("combat" = 6, "engineering" = 5, "syndicate" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 4500, MAT_SILVER = 1500, MAT_TITANIUM = 5000)
	build_path = /obj/item/gun/projectile/automatic/pistol
	category = list("ILLEGAL")

/datum/design/chameleon_kit
	name = "Chameleon kit"
	desc = "Набор хамелеона изученный с помощью реверс инженеринга."
	id = "chameleon_kit"
	req_tech = list("combat" = 2, "engineering" = 6, "syndicate" = 3, "magnets" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 4500, MAT_GLASS = 3000,)
	build_path = /obj/item/storage/box/syndie_kit/chameleon
	category = list("ILLEGAL")

/datum/design/adrenaline
	name = "Adrenaline implant"
	desc = "Кейс с адреналин имплантов, который позволяет игнорировать шокеры, в течение котороткого времени."
	id = "implant_adrenaline"
	req_tech = list("syndicate" = 2, "programming" = 3, "biotech"= 4, "materials" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 100, MAT_GLASS = 50,)
	build_path = /obj/item/implantcase/adrenaline
	category = list("ILLEGAL")

/datum/design/Freedom
	name = "Freedom implant"
	desc = "Кейс с имплантом, который позволяет освобождаться от наручников ограниченное количество раз."
	id = "implant_freedom"
	req_tech = list("syndicate" = 2, "programming" = 3, "biotech"= 4,"materials" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 10000, MAT_GLASS = 3000,)
	build_path = /obj/item/implantcase/freedom
	category = list("ILLEGAL")

/datum/design/encryptionkey_binary
	name = "Binary encryptionkey"
	desc = "Ключ шифрования, на которой переговариваеются борги и ИИ."
	id = "binarykey"
	req_tech = list("engineering" = 4, "syndicate" = 3, "programming" = 4,"materials" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 1000, MAT_GLASS = 1000,)
	build_path = /obj/item/encryptionkey/binary
	category = list("ILLEGAL")

/datum/design/encryptionkey_syndicate
	name = "Syndicate encryptionkey"
	desc = "Ключ шифрования синдиката, позволяющий перехватывать другие зашифрованные радиоволны."
	id = "syndicatekey"
	req_tech = list("engineering" = 4, "syndicate" = 4, "programming" = 4,"materials" = 3)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 1000, MAT_GLASS = 1000,)
	build_path = /obj/item/encryptionkey/syndicate
	category = list("ILLEGAL")

/datum/design/aiModule_syndicate
	name = "Hacked AI module"
	desc = "A hacked AI law module"
	id = "syndiaimodule"
	req_tech = list("syndicate" = 6, "programming" = 5, "materials" = 5)
	build_type = IMPRINTER
	materials = list(MAT_GLASS = 1000, MAT_DIAMOND = 100)
	build_path = /obj/item/aiModule/syndicate
	category = list("ILLEGAL")

/datum/design/incendiary_10mm
	name = "pistol magazine 10mm incendiary"
	desc = "A gun magazine. Loaded with rounds which ignite the target."
	id = "10mminc"
	req_tech = list("combat" = 4, "syndicate" = 2, "materials" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 100, MAT_PLASMA = 10,)
	build_path = /obj/item/ammo_box/magazine/m10mm/fire
	category = list("ILLEGAL")

/datum/design/radio_jammer
	name = "radio jammer"
	desc = "Device used to disrupt nearby radio communication."
	id = "jammer"
	req_tech = list("engineering" = 4, "syndicate" = 3, "programming" = 3, "materials" = 4)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 2000, MAT_GLASS = 1000, MAT_SILVER = 500)
	build_path = /obj/item/jammer
	category = list("ILLEGAL")

///datum/design/
//   name = ""
//	desc = ""
//	id = ""
//	req_tech = list("combat" = 1, "engineering" = 1, "syndicate" = 1, "programming" = 1, "biotech"= 1, "bluespace" = 1, "powerstorage" = 1, "materials" = 1)
//	build_type = PROTOLATHE
//	materials = list(MAT_METAL = 10000, MAT_GLASS = 3000,)
//  build_path =
//	category = list("ILLEGAL")
//
///datum/design/
//  name = ""
//	desc = ""
//	id = ""
//	req_tech = list("combat" = 1, "engineering" = 1, "syndicate" = 1, "programming" = 1, "biotech"= 1, "bluespace" = 1, "powerstorage" = 1, "materials" = 1)
//	build_type = PROTOLATHE
//	materials = list(MAT_METAL = 10000, MAT_GLASS = 3000,)
//	build_path =
//	category = list("ILLEGAL")
