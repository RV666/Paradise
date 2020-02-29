var/global/geoip_query_counter = 0
var/global/geoip_next_counter_reset = 0
var/global/list/geoip_ckey_updated = list()
var/global/list/proxy_whitelist = list()

/datum/geoip_data
	var/holder = null
	var/status = null
	var/country = null
	var/countryCode = null
	var/region = null
	var/regionName = null
	var/city = null
	var/timezone = null
	var/isp = null
	var/mobile = null
	var/proxy = null
	var/ip = null

/datum/geoip_data/New(client/C, addr)
	INVOKE_ASYNC(src, .proc/get_geoip_data, C, addr)

/datum/geoip_data/proc/get_geoip_data(client/C, addr)

	if(!C || !addr)
		return

	if(C.holder && (C.holder.rights & R_ADMIN))
		status = "admin"
		return

	if(!try_update_geoip(C, addr))
		return

	if(!C)
		return

	if(status == "updated")
		var/msg = "[holder] connected from ([country], [regionName], [city]) using ISP: ([isp]) with IP: ([ip]) Proxy: ([proxy])"
		log_admin(msg)
		if(SSticker.current_state > GAME_STATE_STARTUP && !(C.ckey in geoip_ckey_updated))
			geoip_ckey_updated |= C.ckey
			message_admins(msg)

		if(proxy == "true")
			if(C.ckey in proxy_whitelist)
				proxy = "<span style='color: orange'>whitelisted</span>"
			else
				proxy = "<span style='color: red'>true</span>"

			if(config.proxy_autoban)
				var/reason = "Your IP was detected as proxy. No proxy allowed on server."
				AddBan(C.ckey, C.computer_id, reason, "SyndiCat", 0, 0, C.mob.lastKnownIP)
				to_chat(C, "<span class='danger'><BIG><B>You have been banned by SyndiCat.\nReason: [reason].</B></BIG></span>")
				to_chat(C, "<span class='red'>This is a permanent ban.</span>")
				if(config.banappeals)
					to_chat(C, "<span class='red'>To try to resolve this matter head to [config.banappeals]</span>")
				else
					to_chat(C, "<span class='red'>No ban appeals URL has been set.</span>")
				ban_unban_log_save("SyndiCat has permabanned [C.ckey]. - Reason: [reason] - This is a permanent ban.")
				log_admin("SyndiCat has banned [C.ckey].")
				log_admin("Reason: [reason]")
				log_admin("This is a permanent ban.")
				message_admins("SyndiCat has banned [C.ckey].\nReason: [reason]\nThis is a permanent ban.")
				feedback_inc("ban_perma",1)
				DB_ban_record_SyndiCat(BANTYPE_PERMA, C.mob, -1, reason)
				del(C)
				return

/datum/geoip_data/proc/try_update_geoip(client/C, addr)
	if(!C || !addr)
		return FALSE

	if(addr == "127.0.0.1")
		addr = "[world.internet_address]"

	if(status != "updated")
		holder = C.ckey

		var/msg = geoip_check(addr)
		if(msg == "limit reached" || msg == "export fail")
			status = msg
			return FALSE

		for(var/data in msg)
			switch(data)
				if("country")
					country = msg[data]
				if("countryCode")
					countryCode = msg[data]
				if("region")
					region = msg[data]
				if("regionName")
					regionName = msg[data]
				if("city")
					city = msg[data]
				if("timezone")
					timezone = msg[data]
				if("isp")
					isp = msg[data]
				if("mobile")
					mobile = msg[data] ? "true" : "false"
				if("proxy")
					proxy = msg[data] ? "true" : "false"
				if("query")
					ip = msg[data]
		status = "updated"
	return TRUE

/proc/geoip_check(addr)
	if(world.time > geoip_next_counter_reset)
		geoip_next_counter_reset = world.time + 900
		geoip_query_counter = 0

	geoip_query_counter++
	if(geoip_query_counter > 130)
		return "limit reached"

	var/list/vl = world.Export("http://ip-api.com/json/[addr]?fields=205599")
	if (!("CONTENT" in vl) || vl["STATUS"] != "200 OK")
		return "export fail"

	var/msg = file2text(vl["CONTENT"])
	return json2list(msg)

/proc/DB_ban_record_SyndiCat(var/bantype, var/mob/banned_mob, var/duration = -1, var/reason, var/job = "", var/rounds = 0, var/banckey = null, var/banip = null, var/bancid = null)
	establish_db_connection()
	if(!GLOB.dbcon.IsConnected())
		return

	var/serverip = "[world.internet_address]:[world.port]"
	var/bantype_pass = 0
	var/bantype_str
	var/announceinirc		//When set, it announces the ban in irc. Intended to be a way to raise an alarm, so to speak.
	var/kickbannedckey		//Defines whether this proc should kick the banned person, if they are connected (if banned_mob is defined).
							//some ban types kick players after this proc passes (tempban, permaban), but some are specific to db_ban, so
							//they should kick within this proc.
	var/isjobban // For job bans, which need to be inserted into the job ban lists
	switch(bantype)
		if(BANTYPE_PERMA)
			bantype_str = "PERMABAN"
			duration = -1
			bantype_pass = 1
		if(BANTYPE_TEMP)
			bantype_str = "TEMPBAN"
			bantype_pass = 1
		if(BANTYPE_JOB_PERMA)
			bantype_str = "JOB_PERMABAN"
			duration = -1
			bantype_pass = 1
			isjobban = 1
		if(BANTYPE_JOB_TEMP)
			bantype_str = "JOB_TEMPBAN"
			bantype_pass = 1
			isjobban = 1
		if(BANTYPE_APPEARANCE)
			bantype_str = "APPEARANCE_BAN"
			duration = -1
			bantype_pass = 1
		if(BANTYPE_ADMIN_PERMA)
			bantype_str = "ADMIN_PERMABAN"
			duration = -1
			bantype_pass = 1
			announceinirc = 1
			kickbannedckey = 1
		if(BANTYPE_ADMIN_TEMP)
			bantype_str = "ADMIN_TEMPBAN"
			bantype_pass = 1
			announceinirc = 1
			kickbannedckey = 1

	if( !bantype_pass ) return
	if( !istext(reason) ) return
	if( !isnum(duration) ) return

	var/ckey
	var/computerid
	var/ip

	if(ismob(banned_mob) && banned_mob.ckey)
		ckey = banned_mob.ckey
		if(banned_mob.client)
			computerid = banned_mob.client.computer_id
			ip = banned_mob.client.address
		else
			if(banned_mob.lastKnownIP)
				ip = banned_mob.lastKnownIP
			if(banned_mob.computer_id)
				computerid = banned_mob.computer_id
	else if(banckey)
		ckey = ckey(banckey)
		computerid = bancid
		ip = banip
	else if(ismob(banned_mob))
		message_admins("<font color='red'>SyndiCat attempted to add a ban based on a ckey-less mob, with no ckey provided. Report this bug.",1)
		return
	else
		message_admins("<font color='red'>SyndiCat attempted to add a ban based on a non-existent mob, with no ckey provided. Report this bug.",1)
		return

	var/DBQuery/query = GLOB.dbcon.NewQuery("SELECT id FROM [format_table_name("player")] WHERE ckey = '[ckey]'")
	query.Execute()
	var/validckey = 0
	if(query.NextRow())
		validckey = 1
	if(!validckey)
		if(!banned_mob || (banned_mob && !IsGuestKey(banned_mob.key)))
			message_admins("<font color='red'>SyndiCat attempted to ban [ckey], but [ckey] does not exist in the player database. Please only ban actual players.</font>",1)
			return

	var/a_ckey = "SyndiCat"
	var/a_computerid = "4221007721"
	var/a_ip = "127.0.0.1"

	var/who
	for(var/client/C in GLOB.clients)
		if(!who)
			who = "[C]"
		else
			who += ", [C]"

	var/adminwho
	for(var/client/C in GLOB.admins)
		if(!adminwho)
			adminwho = "[C]"
		else
			adminwho += ", [C]"

	reason = sanitizeSQL(reason)

	var/sql = "INSERT INTO [format_table_name("ban")] (`id`,`bantime`,`serverip`,`bantype`,`reason`,`job`,`duration`,`rounds`,`expiration_time`,`ckey`,`computerid`,`ip`,`a_ckey`,`a_computerid`,`a_ip`,`who`,`adminwho`,`edits`,`unbanned`,`unbanned_datetime`,`unbanned_ckey`,`unbanned_computerid`,`unbanned_ip`) VALUES (null, Now(), '[serverip]', '[bantype_str]', '[reason]', '[job]', [(duration)?"[duration]":"0"], [(rounds)?"[rounds]":"0"], Now() + INTERVAL [(duration>0) ? duration : 0] MINUTE, '[ckey]', '[computerid]', '[ip]', '[a_ckey]', '[a_computerid]', '[a_ip]', '[who]', '[adminwho]', '', null, null, null, null, null)"
	var/DBQuery/query_insert = GLOB.dbcon.NewQuery(sql)
	query_insert.Execute()
	message_admins("SyndiCat has added a [bantype_str] for [ckey] [(job)?"([job])":""] [(duration > 0)?"([duration] minutes)":""] with the reason: \"[reason]\" to the ban database.",1)

	if(announceinirc)
		send2irc("BAN ALERT","[a_ckey] applied a [bantype_str] on [ckey]")

	if(kickbannedckey)
		if(banned_mob && banned_mob.client && banned_mob.client.ckey == banckey)
			del(banned_mob.client)

	if(isjobban)
		jobban_client_fullban(ckey, job)
	else
		flag_account_for_forum_sync(ckey)
