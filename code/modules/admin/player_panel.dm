
/datum/admins/proc/player_panel_new()//The new one
	if(!usr.client.holder)
		return
	var/dat = {"<html><meta charset="UTF-8"><head><title>Admin Player Panel</title></head>"}

	//javascript, the part that does most of the work~
	dat += {"

		<head>
			<script type='text/javascript'>

				var locked_tabs = new Array();

				function updateSearch(){


					var filter_text = document.getElementById('filter');
					var filter = filter_text.value.toLowerCase();

					if(complete_list != null && complete_list != ""){
						var mtbl = document.getElementById("maintable_data_archive");
						mtbl.innerHTML = complete_list;
					}

					if(filter.value == ""){
						return;
					}else{

						var maintable_data = document.getElementById('maintable_data');
						var ltr = maintable_data.getElementsByTagName("tr");
						for( var i = 0; i < ltr.length; ++i )
						{
							try{
								var tr = ltr\[i\];
								if(tr.getAttribute("id").indexOf("data") != 0){
									continue;
								}
								var ltd = tr.getElementsByTagName("td");
								var td = ltd\[0\];
								var lsearch = td.getElementsByTagName("b");
								var search = lsearch\[0\];
								//var inner_span = li.getElementsByTagName("span")\[1\] //Should only ever contain one element.
								//document.write("<p>"+search.innerText+"<br>"+filter+"<br>"+search.innerText.indexOf(filter))
								if( search.innerText.toLowerCase().indexOf(filter) == -1 )
								{
									//document.write("a");
									//ltr.removeChild(tr);
									td.innerHTML = "";
									i--;
								}
							}catch(err) {   }
						}
					}

					var count = 0;
					var index = -1;
					var debug = document.getElementById("debug");

					locked_tabs = new Array();

				}

				function expand(id,job,name,real_name,image,key,ip,antagonist,mobUID,clientUID,eyeUID){

					clearAll();

					var span = document.getElementById(id);

					body = "<table><tr><td>";

					body += "</td><td align='center'>";

					body += "<font size='2'><b>"+job+" "+name+"</b><br><b>Real name "+real_name+"</b><br><b>Played by "+key+" ("+ip+")</b></font>"

					body += "</td><td align='center'>";

					body += "<a href='?src=[UID()];adminplayeropts="+mobUID+"'>PP</a> - "
					body += "<a href='?src=[UID()];shownoteckey="+key+"'>N</a> - "
					body += "<a href='?_src_=vars;Vars="+mobUID+"'>VV</a> - "
					body += "<a href='?src=[UID()];traitor="+mobUID+"'>TP</a> - "
					body += "<a href='?src=[usr.UID()];priv_msg="+clientUID+"'>PM</a> - "
					body += "<a href='?src=[UID()];subtlemessage="+mobUID+"'>SM</a> - "
					body += "<a href='?src=[UID()];adminplayerobservefollow="+mobUID+"'>FLW</a>"
					if(eyeUID)
						body += "|<a href='?src=[UID()];adminplayerobservefollow="+eyeUID+"'>EYE</a>"
					body += "<br>"
					if(antagonist > 0)
						body += "<font size='2'><a href='?src=[UID()];check_antagonist=1'><font color='red'><b>Antagonist</b></font></a></font>";

					body += "</td></tr></table>";


					span.innerHTML = body
				}

				function clearAll(){
					var spans = document.getElementsByTagName('span');
					for(var i = 0; i < spans.length; i++){
						var span = spans\[i\];

						var id = span.getAttribute("id");

						if(!(id.indexOf("item")==0))
							continue;

						var pass = 1;

						for(var j = 0; j < locked_tabs.length; j++){
							if(locked_tabs\[j\]==id){
								pass = 0;
								break;
							}
						}

						if(pass != 1)
							continue;




						span.innerHTML = "";
					}
				}

				function addToLocked(id,link_id,notice_span_id){
					var link = document.getElementById(link_id);
					var decision = link.getAttribute("name");
					if(decision == "1"){
						link.setAttribute("name","2");
					}else{
						link.setAttribute("name","1");
						removeFromLocked(id,link_id,notice_span_id);
						return;
					}

					var pass = 1;
					for(var j = 0; j < locked_tabs.length; j++){
						if(locked_tabs\[j\]==id){
							pass = 0;
							break;
						}
					}
					if(!pass)
						return;
					locked_tabs.push(id);
					var notice_span = document.getElementById(notice_span_id);
					notice_span.innerHTML = "<font color='red'>Locked</font> ";
					//link.setAttribute("onClick","attempt('"+id+"','"+link_id+"','"+notice_span_id+"');");
					//document.write("removeFromLocked('"+id+"','"+link_id+"','"+notice_span_id+"')");
					//document.write("aa - "+link.getAttribute("onClick"));
				}

				function attempt(ab){
					return ab;
				}

				function removeFromLocked(id,link_id,notice_span_id){
					//document.write("a");
					var index = 0;
					var pass = 0;
					for(var j = 0; j < locked_tabs.length; j++){
						if(locked_tabs\[j\]==id){
							pass = 1;
							index = j;
							break;
						}
					}
					if(!pass)
						return;
					locked_tabs\[index\] = "";
					var notice_span = document.getElementById(notice_span_id);
					notice_span.innerHTML = "";
					//var link = document.getElementById(link_id);
					//link.setAttribute("onClick","addToLocked('"+id+"','"+link_id+"','"+notice_span_id+"')");
				}

				function selectTextField(){
					var filter_text = document.getElementById('filter');
					filter_text.focus();
					filter_text.select();
				}

			</script>
		</head>


	"}

	//body tag start + onload and onkeypress (onkeyup) javascript event calls
	dat += "<body onload='selectTextField(); updateSearch();' onkeyup='updateSearch();'>"

	//title + search bar
	dat += {"

		<table width='560' align='center' cellspacing='0' cellpadding='5' id='maintable'>
			<tr id='title_tr'>
				<td align='center'>
					<font size='5'><b>Player panel</b></font><br>
					Hover over a line to see more information | [check_rights(R_ADMIN,0) ? "<a href='?src=[UID()];check_antagonist=1'>Check antagonists</a> | Kick <a href='?_src_=holder;kick_all_from_lobby=1;afkonly=0'>everyone</a>/<a href='?_src_=holder;kick_all_from_lobby=1;afkonly=1'>AFKers</a> in lobby" : "" ]
					<p>
				</td>
			</tr>
			<tr id='search_tr'>
				<td align='center'>
					<b>Search:</b> <input type='text' id='filter' value='' style='width:300px;'>
				</td>
			</tr>
	</table>

	"}

	//player table header
	dat += {"
		<span id='maintable_data_archive'>
		<table width='560' align='center' cellspacing='0' cellpadding='5' id='maintable_data'>"}

	var/list/mobs = sortmobs()
	var/i = 1
	for(var/mob/M in mobs)
		if(M.ckey)

			var/color = "#e6e6e6"
			if(i%2 == 0)
				color = "#f2f2f2"
			var/is_antagonist = is_special_character(M)

			var/M_job = ""

			if(isliving(M))

				if(iscarbon(M)) //Carbon stuff
					if(issmall(M))
						M_job = "Monkey"
					else if(ishuman(M))
						M_job = M.job
					else if(isslime(M))
						M_job = "slime"

					else if(isalien(M)) //aliens
						if(islarva(M))
							M_job = "Alien larva"
						else
							M_job = "Alien"
					else
						M_job = "Carbon-based"

				else if(issilicon(M)) //silicon
					if(isAI(M))
						M_job = "AI"
					else if(ispAI(M))
						M_job = "pAI"
					else if(isrobot(M))
						M_job = "Cyborg"
					else
						M_job = "Silicon-based"

				else if(isanimal(M)) //simple animals
					if(iscorgi(M))
						M_job = "Corgi"
					else
						M_job = "Animal"

				else
					M_job = "Living"

			else if(istype(M,/mob/new_player))
				M_job = "New player"

			else if(isobserver(M))
				M_job = "Ghost"

			M_job = replacetext(M_job, "'", "")
			M_job = replacetext(M_job, "\"", "")
			M_job = replacetext(M_job, "\\", "")

			var/M_name = M.name
			M_name = replacetext(M_name, "'", "")
			M_name = replacetext(M_name, "\"", "")
			M_name = replacetext(M_name, "\\", "")
			var/M_rname = M.real_name
			M_rname = replacetext(M_rname, "'", "")
			M_rname = replacetext(M_rname, "\"", "")
			M_rname = replacetext(M_rname, "\\", "")

			var/M_key = M.key
			M_key = replacetext(M_key, "'", "")
			M_key = replacetext(M_key, "\"", "")
			M_key = replacetext(M_key, "\\", "")

			var/M_eyeUID = ""
			if(isAI(M))
				var/mob/living/silicon/ai/A = M
				if(A.client && A.eyeobj) // No point following clientless AI eyes
					M_eyeUID = "[A.eyeobj.UID()]"
			var/clientUID = M.client ? M.client.UID() : null
			//output for each mob
			dat += {"

				<tr id='data[i]' name='[i]' onClick="addToLocked('item[i]','data[i]','notice_span[i]')">
					<td align='center' bgcolor='[color]'>
						<span id='notice_span[i]'></span>
						<a id='link[i]'
						onmouseover='expand("item[i]","[M_job]","[M_name]","[M_rname]","--unused--","[M_key]","[M.lastKnownIP]",[is_antagonist],"[M.UID()]","[clientUID]","[M_eyeUID]")'
						>
						<b id='search[i]'>[M_name] - [M_rname] - [M_key] ([M_job])</b>
						</a>
						<br><span id='item[i]'></span>
					</td>
				</tr>

			"}

			i++


	//player table ending
	dat += {"
		</table>
		</span>

		<script type='text/javascript'>
			var maintable = document.getElementById("maintable_data_archive");
			var complete_list = maintable.innerHTML;
		</script>
	</body></html>
	"}

	usr << browse(dat, "window=players;size=600x480")

//The old one
/datum/admins/proc/player_panel_old()
	if(!usr.client.holder)
		return
	var/dat = {"<html><meta charset="UTF-8"><head><title>Player Menu</title></head>"}
	dat += "<body><table border=1 cellspacing=5><B><tr><th>Name</th><th>Real Name</th><th>Assigned Job</th><th>Key</th><th>Options</th><th>PM</th><th>Traitor?</th></tr></B>"
	//add <th>IP:</th> to this if wanting to add back in IP checking
	//add <td>(IP: [M.lastKnownIP])</td> if you want to know their ip to the lists below
	var/list/mobs = sortmobs()

	for(var/mob/M in mobs)
		if(!M.ckey) continue

		dat += "<tr><td>[M.name]</td>"
		if(isAI(M))
			dat += "<td>AI</td>"
		else if(isrobot(M))
			dat += "<td>Cyborg</td>"
		else if(issmall(M))
			dat += "<td>Monkey</td>"
		else if(ishuman(M))
			dat += "<td>[M.real_name]</td>"
		else if(istype(M, /mob/living/silicon/pai))
			dat += "<td>pAI</td>"
		else if(istype(M, /mob/new_player))
			dat += "<td>New Player</td>"
		else if(isobserver(M))
			dat += "<td>Ghost</td>"
		else if(isalien(M))
			dat += "<td>Alien</td>"
		else
			dat += "<td>Unknown</td>"


		if(istype(M,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = M
			if(H.mind && H.mind.assigned_role)
				dat += "<td>[H.mind.assigned_role]</td>"
		else
			dat += "<td>NA</td>"


		dat += {"<td>[(M.client ? "[M.client]" : "No client")]</td>
		<td align=center><A HREF='?src=[UID()];adminplayeropts=[M.UID()]'>X</A></td>
		<td align=center><A href='?src=[usr.UID()];priv_msg=[M.client ? M.client.UID() : null]'>PM</A></td>
		"}
		switch(is_special_character(M))
			if(0)
				dat += {"<td align=center><A HREF='?src=[UID()];traitor=[M.UID()]'>Traitor?</A></td>"}
			if(1)
				dat += {"<td align=center><A HREF='?src=[UID()];traitor=[M.UID()]'><font color=red>Traitor?</font></A></td>"}
			if(2)
				dat += {"<td align=center><A HREF='?src=[UID()];traitor=[M.UID()]'><font color=red><b>Traitor?</b></font></A></td>"}

	dat += "</table></body></html>"

	usr << browse(dat, "window=players;size=640x480")



/datum/admins/proc/check_antagonists_line(mob/M, caption = "", close = 1)
	var/logout_status
	logout_status = M.client ? "" : " <i>(logged out)</i>"
	var/dname = M.real_name
	if(!dname)
		dname = M

	return {"<tr><td><a href='?src=[UID()];adminplayeropts=[M.UID()]'>[dname]</a><b>[caption]</b>[logout_status][M.stat == 2 ? " <b><font color=red>(DEAD)</font></b>" : ""]</td>
		<td><A href='?src=[usr.UID()];priv_msg=[M.client ? M.client.UID() : null]'>PM</A></td>[close ? "</tr>" : ""]"}

/datum/admins/proc/check_antagonists()
	if(!check_rights(R_ADMIN))	return
	if(SSticker && SSticker.current_state >= GAME_STATE_PLAYING)
		var/dat = {"<html><meta charset="UTF-8"><head><title>Round Status</title></head><body><h1><B>Round Status</B></h1>"}
		dat += "Current Game Mode: <B>[SSticker.mode.name]</B><BR>"
		dat += "Round Duration: <B>[round(ROUND_TIME / 36000)]:[add_zero(num2text(ROUND_TIME / 600 % 60), 2)]:[add_zero(num2text(ROUND_TIME / 10 % 60), 2)]</B><BR>"
		dat += "<B>Emergency shuttle</B><BR>"
		if(SSshuttle.emergency.mode < SHUTTLE_CALL)
			dat += "<a href='?src=[UID()];call_shuttle=1'>Call Shuttle</a><br>"
		else
			var/timeleft = SSshuttle.emergency.timeLeft()
			if(SSshuttle.emergency.mode < SHUTTLE_DOCKED)
				dat += "ETA: <a href='?_src_=holder;edit_shuttle_time=1'>[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]</a><BR>"
				dat += "<a href='?_src_=holder;call_shuttle=2'>Send Back</a><br>"
			else
				dat += "ETA: <a href='?_src_=holder;edit_shuttle_time=1'>[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]</a><BR>"

		dat += "<a href='?src=[UID()];delay_round_end=1'>[SSticker.delay_end ? "End Round Normally" : "Delay Round End"]</a><br>"
		if(SSticker.mode.syndicates.len)
			dat += "<br><table cellspacing=5><tr><td><B>Syndicates</B></td><td></td></tr>"
			for(var/datum/mind/N in SSticker.mode.syndicates)
				var/mob/M = N.current
				if(M)
					dat += check_antagonists_line(M)
				else
					dat += "<tr><td><i>Nuclear Operative not found!</i></td></tr>"
			dat += "</table><br><table><tr><td><B>Nuclear Disk(s)</B></td></tr>"
			for(var/obj/item/disk/nuclear/N in GLOB.poi_list)
				dat += "<tr><td>[N.name], "
				var/atom/disk_loc = N.loc
				while(!istype(disk_loc, /turf))
					if(istype(disk_loc, /mob))
						var/mob/M = disk_loc
						dat += "carried by <a href='?src=[UID()];adminplayeropts=[M.UID()]'>[M.real_name]</a> "
					if(istype(disk_loc, /obj))
						var/obj/O = disk_loc
						dat += "in \a [O.name] "
					disk_loc = disk_loc.loc
				dat += "in [disk_loc.loc] at ([disk_loc.x], [disk_loc.y], [disk_loc.z])</td></tr>"
			dat += "</table>"

		if(SSticker.mode.head_revolutionaries.len || SSticker.mode.revolutionaries.len)
			dat += "<br><table cellspacing=5><tr><td><B>Revolutionaries</B></td><td></td></tr>"
			for(var/datum/mind/N in SSticker.mode.head_revolutionaries)
				var/mob/M = N.current
				if(!M)
					dat += "<tr><td><i>Head Revolutionary not found!</i></td></tr>"
				else
					dat += check_antagonists_line(M, "(leader)")
			for(var/datum/mind/N in SSticker.mode.revolutionaries)
				var/mob/M = N.current
				if(M)
					dat += check_antagonists_line(M)
			dat += "</table><table cellspacing=5><tr><td><B>Target(s)</B></td><td></td><td><B>Location</B></td></tr>"
			for(var/datum/mind/N in SSticker.mode.get_living_heads())
				var/mob/M = N.current
				if(M)
					dat += check_antagonists_line(M)
					var/turf/mob_loc = get_turf(M)
					dat += "<td>[mob_loc.loc]</td></tr>"
				else
					dat += "<tr><td><i>Head not found!</i></td></tr>"
			dat += "</table>"

		if(GAMEMODE_IS_BLOB)
			var/datum/game_mode/blob/mode = SSticker.mode
			dat += "<br><table cellspacing=5><tr><td><B>Blob</B></td><td></td><td></td></tr>"
			dat += "<tr><td><i>Progress: [blobs.len]/[mode.blobwincount]</i></td></tr>"

			for(var/datum/mind/blob in mode.infected_crew)
				var/mob/M = blob.current
				if(M)
					dat += "<tr><td>[ADMIN_PP(M,"[M.real_name]")][M.client ? "" : " <i>(ghost)</i>"][M.stat == 2 ? " <b><font color=red>(DEAD)</font></b>" : ""]</td>"
					dat += "<td><A href='?priv_msg=[M.client ? M.client.UID() : null]'>PM</A></td>"
				else
					dat += "<tr><td><i>Blob not found!</i></td></tr>"
			dat += "</table>"
		
		if(SSticker.mode.blob_overminds.len)
			dat += check_role_table("Blob Overminds", SSticker.mode.blob_overminds)

		if(SSticker.mode.changelings.len)
			dat += check_role_table("Changelings", SSticker.mode.changelings)

		if(SSticker.mode.wizards.len)
			dat += check_role_table("Wizards", SSticker.mode.wizards)

		if(SSticker.mode.raiders.len)
			dat += check_role_table("Raiders", SSticker.mode.raiders)

		/*if(ticker.mode.ninjas.len)
			dat += check_role_table("Ninjas", ticker.mode.ninjas)*/

		if(SSticker.mode.cult.len)
			dat += check_role_table("Cultists", SSticker.mode.cult, 0)
			dat += "<br> use <a href='?src=[UID()];cult_mindspeak=[UID()]'>Cult Mindspeak</a>"
			if(GAMEMODE_IS_CULT)
				var/datum/game_mode/cult/cult_round = SSticker.mode
				if(!cult_round.narsie_condition_cleared)
					dat += "<br><a href='?src=[UID()];cult_nextobj=[UID()]'>complete objective (debug)</a>"

		if(SSticker.mode.traitors.len)
			dat += check_role_table("Traitors", SSticker.mode.traitors)

		if(SSticker.mode.implanted.len)
			dat += check_role_table("Mindslaves", SSticker.mode.implanted)

		if(SSticker.mode.shadows.len)
			dat += check_role_table("Shadowlings", SSticker.mode.shadows)

		if(SSticker.mode.shadowling_thralls.len)
			dat += check_role_table("Shadowling Thralls", SSticker.mode.shadowling_thralls)

		if(SSticker.mode.abductors.len)
			dat += check_role_table("Abductors", SSticker.mode.abductors)

		if(SSticker.mode.abductees.len)
			dat += check_role_table("Abductees", SSticker.mode.abductees)

		if(SSticker.mode.vampires.len)
			dat += check_role_table("Vampires", SSticker.mode.vampires)

		if(SSticker.mode.vampire_enthralled.len)
			dat += check_role_table("Vampire Thralls", SSticker.mode.vampire_enthralled)

		if(SSticker.mode.devils.len)
			dat += check_role_table("Devils", SSticker.mode.devils)

		if(SSticker.mode.xenos.len)
			dat += check_role_table("Xenos", SSticker.mode.xenos)

		if(SSticker.mode.superheroes.len)
			dat += check_role_table("Superheroes", SSticker.mode.superheroes)

		if(SSticker.mode.supervillains.len)
			dat += check_role_table("Supervillains", SSticker.mode.supervillains)

		if(SSticker.mode.greyshirts.len)
			dat += check_role_table("Greyshirts", SSticker.mode.greyshirts)

		if(SSticker.mode.eventmiscs.len)
			dat += check_role_table("Event Roles", SSticker.mode.eventmiscs)

		if(ts_spiderlist.len)
			var/list/spider_minds = list()
			for(var/mob/living/simple_animal/hostile/poison/terror_spider/S in ts_spiderlist)
				if(S.ckey)
					spider_minds += S.mind
			if(spider_minds.len)
				dat += check_role_table("Terror Spiders", spider_minds)

				var/count_eggs = 0
				var/count_spiderlings = 0
				for(var/obj/structure/spider/eggcluster/terror_eggcluster/E in ts_egg_list)
					if(is_station_level(E.z))
						count_eggs += E.spiderling_number
				for(var/obj/structure/spider/spiderling/terror_spiderling/L in ts_spiderling_list)
					if(!L.stillborn && is_station_level(L.z))
						count_spiderlings += 1
				dat += "<table cellspacing=5><TR><TD>Growing TS on-station: [count_eggs] egg[count_eggs != 1 ? "s" : ""], [count_spiderlings] spiderling[count_spiderlings != 1 ? "s" : ""]. </TD></TR></TABLE>"

		if(SSticker.mode.ert.len)
			dat += check_role_table("ERT", SSticker.mode.ert)

		dat += "</body></html>"
		usr << browse(dat, "window=roundstatus;size=400x500")
	else
		alert("The game hasn't started yet!")

/datum/admins/proc/check_role_table(name, list/members, show_objectives=1)
	var/txt = "<br><table cellspacing=5><tr><td><b>[name]</b></td><td></td></tr>"
	for(var/datum/mind/M in members)
		txt += check_role_table_row(M.current, show_objectives)
	txt += "</table>"
	return txt

/datum/admins/proc/check_role_table_row(mob/M, show_objectives)
	if(!istype(M))
		return "<tr><td><i>Not found!</i></td></tr>"

	var/txt = check_antagonists_line(M, close = 0)

	if(show_objectives)
		txt += {"
			<td>
				<a href='?src=[UID()];traitor=[M.UID()]'>Show Objective</a>
			</td>
		"}

	txt += "</tr>"
	return txt
