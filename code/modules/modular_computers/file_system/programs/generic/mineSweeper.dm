// This is special hardware configuration program.
// It is to be used only with modular computers.
// It allows you to toggle components of your device.

/datum/computer_file/program/mineSweeper
	filename = "minesweeper"
	filedesc = "NMineSweeper"
	extended_desc = "This game is awesome!"
	program_icon_state = "generic"
	unsendable = 1
	undeletable = 0
	size = 6
	available_on_ntnet = 1
	requires_ntnet = 0


/datum/computer_file/program/mineSweeper/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	ui = SSnanoui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		var/datum/asset/assets = get_asset_datum(/datum/asset/simple/headers)
		assets.send(user)
		ui = new(user, src, ui_key, "games_mineSweeper.tmpl", "NMineSweeper", 750, 600)
		ui.set_auto_update(0)
		ui.set_layout_key("program")
		ui.open()

/datum/computer_file/program/mineSweeper/ui_data(mob/user)

	var/list/data = get_header_data()
	return data


/datum/computer_file/program/mineSweeper/Topic(href, list/href_list)
	if(..())
		return
	switch(href_list["action"])
		if("PRG_restart")
			return
