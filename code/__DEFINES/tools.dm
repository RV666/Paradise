#define TOOL_CROWBAR 		"crowbar"
#define TOOL_MULTITOOL		"multitool"
#define TOOL_SCREWDRIVER 	"screwdriver"
#define TOOL_WIRECUTTER 	"wirecutter"
#define TOOL_WRENCH 		"wrench"
#define TOOL_WELDER 		"welder"

#define MIN_TOOL_SOUND_DELAY 20

//Crowbar messages
#define CROWBAR_ATTEMPT_PRY_CIRCUIT_MESSAGE	user.visible_message("<span class='notice'>[user] начинает снимать печатную плату с [src]...</span>", "<span class='notice'>Вы начинаете снимать печатную плату с [src]...</span>", "<span class='warning'>Вы слышите посторонние шумы.</span>")
#define CROWBAR_PRY_CIRCUIT_SUCCESS_MESSAGE	user.visible_message("<span class='notice'>[user] снимает печатную плату с [src]!</span>", "<span class='notice'>Вы снимаете печатную плату с [src]!</span>", "<span class='warning'>Вы слышите посторонние шумы.</span>")

//Screwdriver messages
#define SCREWDRIVER_SCREW_MESSAGE			user.visible_message("<span class='notice'>[user] затягивает винты на [src]!</span>", "<span class='notice'>Вы затягиваете винты на [src]!</span>", "<span class='warning'>Вы слышите отвертку.</span>")
#define SCREWDRIVER_UNSCREW_MESSAGE			user.visible_message("<span class='notice'>[user] ослабляете винты на [src]!</span>", "<span class='notice'>Вы ослабляете винты на [src]!</span>", "<span class='warning'>Вы слышите отвертку.</span>")
#define SCREWDRIVER_OPEN_PANEL_MESSAGE		user.visible_message("<span class='notice'>[user] открывает панель на [src]!</span>", "<span class='notice'>Вы открываете панель на [src]!</span>", "<span class='warning'>Вы слышите отвертку.</span>")
#define SCREWDRIVER_CLOSE_PANEL_MESSAGE		user.visible_message("<span class='notice'>[user] закрывает панель на [src]!</span>", "<span class='notice'>Вы закрываете панель на [src]!</span>", "<span class='warning'>Вы слышите отвертку.</span>")

//Wirecutter messages
#define WIRECUTTER_SNIP_MESSAGE					user.visible_message("<span class='notice'>[user] обрезает провода в [src]!</span>", "<span class='notice'>Вы обрезаете провода в [src]!</span>", "<span class='warning'>Вы слышите резку.</span>")
#define WIRECUTTER_ATTEMPT_DISMANTLE_MESSAGE	user.visible_message("<span class='notice'>[user] начинает разрезать [src]... </span>", "<span class='notice'>Вы начинаете разрезать [src]...</span>", "<span class='warning'>Вы слышите резку.</span>")
#define WIRECUTTER_DISMANTLE_SUCCESS_MESSAGE	user.visible_message("<span class='notice'>[user] режет на куски [src]</span>", "<span class='notice'>Вы режете на куски [src]!</span>", "<span class='warning'>Вы слышите резку.</span>")

//Welder messages and other stuff
#define HEALPERWELD 15
#define WELDER_ATTEMPT_WELD_MESSAGE			user.visible_message("<span class='notice'>[user] начинает варить [src]...</span>", "<span class='notice'>Вы начали варить [src]...</span>", "<span class='warning'>Вы слышите сварку.</span>")
#define WELDER_WELD_SUCCESS_MESSAGE			to_chat(user, "<span class='notice'>Вы закончили сварку [src]!</span>")
#define WELDER_ATTEMPT_REPAIR_MESSAGE		user.visible_message("<span class='notice'>[user] начинает чинить [src]...</span>", "<span class='notice'>ВЫ начали чинить [src]...</span>", "<span class='warning'>Вы слышите сварку.</span>")
#define WELDER_REPAIR_SUCCESS_MESSAGE		to_chat(user, "<span class='notice'>Вы починили [src]!</span>")
#define WELDER_ATTEMPT_SLICING_MESSAGE		user.visible_message("<span class='notice'>[user] начинает прорезаться сквозь [src]...</span>", "<span class='notice'>Вы начали прорезаться сквозь [src]...</span>", "<span class='warning'>Вы слышите сварку.</span>")
#define WELDER_SLICING_SUCCESS_MESSAGE		to_chat(user, "<span class='notice'>Вы прорезались сквозь [src]!</span>")
#define WELDER_ATTEMPT_FLOOR_SLICE_MESSAGE	user.visible_message("<span class='notice'>[user] начинает отделять [src] от [get_turf(src)]...</span>", "<span class='notice'>Вы начали отделять [src] от [get_turf(src)]...</span>", "<span class='warning'>Вы слышите сварку.</span>")
#define WELDER_FLOOR_SLICE_SUCCESS_MESSAGE	to_chat(user, "<span class='notice'>Вы отделили [src] от [get_turf(src)]!</span>")
#define WELDER_ATTEMPT_FLOOR_WELD_MESSAGE	user.visible_message("<span class='notice'>[user] начинает приваривать [src] к [get_turf(src)]...</span>", "<span class='notice'>Вы начали приваривать [src] к [get_turf(src)]...</span>", "<span class='warning'>Вы слышите сварку.</span>")
#define WELDER_FLOOR_WELD_SUCCESS_MESSAGE	to_chat(user, "<span class='notice'>Вы приварили [src] к [get_turf(src)]!</span>")

//Wrench messages
#define WRENCH_ANCHOR_MESSAGE				user.visible_message("<span class='notice'>[user] затягивает болты на [src]!</span>", "<span class='notice'>Вы затягиваете болты на [src]!</span>", "<span class='warning'>Вы слышите гаечный ключ.</span>")
#define WRENCH_UNANCHOR_MESSAGE				user.visible_message("<span class='notice'>[user] ослабляете болты на [src]!</span>", "<span class='notice'>Вы ослабляете болты на [src]!</span>", "<span class='warning'>Вы слышите гаечный ключ.</span>")
#define WRENCH_UNANCHOR_WALL_MESSAGE		user.visible_message("<span class='notice'>[user] unwrenches [src] from the wall!</span>", "<span class='notice'>You unwrench [src] from the wall!</span>", "<span class='warning'>Вы слышите гаечный ключ.</span>")
#define WRENCH_ANCHOR_TO_WALL_MESSAGE		user.visible_message("<span class='notice'>[user] affixes [src] to the wall!</span>", "<span class='notice'>You affix [src] to the wall!</span>", "<span class='warning'>Вы слышите гаечный ключ.</span>")

//Generic tool messages that don't correspond to any particular tool
#define TOOL_ATTEMPT_DISMANTLE_MESSAGE	    user.visible_message("<span class='notice'>[user] begins to disassemble [src] with [I]...</span>", "<span class='notice'>You begin to disassemble [src] with [I]...</span>", "<span class='warning'>Вы слышите какой-то инструмент.</span>")
#define TOOL_DISMANTLE_SUCCESS_MESSAGE  	user.visible_message("<span class='notice'>[user] dismantles [src]!</span>", "<span class='notice'>You dismantle [src]!</span>", "<span class='warning'>Вы слышите какой-то инструмент.</span>")
