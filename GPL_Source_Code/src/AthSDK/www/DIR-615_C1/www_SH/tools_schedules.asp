<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language=JavaScript>
var submit_button_flag = 0;
	var data_list = new Array();
	var rule_max_num = 32;
	var from_edit = 0;

	function edit_row(index){
		if (index < 10){
			var temp_rule = get_by_id("schedule_rule_0" + index).value;
		}else{
			var temp_rule = get_by_id("schedule_rule_" + index).value;
		}
		
		var rule = temp_rule.split("/");					
		
		for (var l=0 ;l <=rule_max_num ;l++){
			if(l<10){
					var temp_vs_rule = get_by_id("vs_rule_0" + l).value;
					var temp_port_rule = get_by_id("port_forward_both_0" + l).value;
					var temp_application_rule = get_by_id("application_0"+l).value;
			}else{
				if(l<24){
						var temp_rule = get_by_id("schedule_rule_" + l).value;
						var temp_vs_rule = get_by_id("vs_rule_" + l).value;
						var temp_port_rule = get_by_id("port_forward_both_" + l).value;
						var temp_application_rule = get_by_id("application_"+l).value;	
					}
				}
			
				var vs_rule = temp_vs_rule.split("/");	
				var port_rule = temp_port_rule.split("/");
				var application_rule = temp_application_rule.split("/");
				var email_rule = get_by_id("log_email_schedule").value.split("/");
				var access_rule = get_by_id("asp_temp_01").value;
					
				var vs_rule_schedule = vs_rule[6];			
				var port_rule_schedule = port_rule[5];
				var application_rule_schedule = application_rule[6];
				var email_rule_schedule = email_rule[3];
				var temp_wlan0_rule = get_by_id("wlan0_schedule").value;
				var wlan0_rule = temp_wlan0_rule.split("/");	
				var wlan0_rule_schedule = wlan0_rule[0];
				
			if((rule[0] == email_rule_schedule)||(rule[0] == access_rule)||(rule[0] == vs_rule_schedule)||(rule[0] == port_rule_schedule)||(rule[0] == application_rule_schedule)||(rule[0] == wlan0_rule_schedule)){
						alert("The rule be using in other rule, you can't edit");
						return;
			}
		}
						
		var week_str = new Array(7);
		var num=0;
		
		get_by_id("name").value=rule[0] ;
		
		for (var i = 0; i < 7; i++){
			if (rule[1].charAt(i) == "1"){
				week_str[i] = 1;
			}else{
				week_str[i] = 0;
			}
		}
		

		var p_all_week = get_by_name("all_week");
		if(rule[1] == "1111111"){
			p_all_week[0].checked = true;
		}else{
			p_all_week[1].checked = true;
			
			for(var j=0;j<7;j++){
				if(week_str[j]== 1){
					var temp_check = get_by_id("day" + j);
					temp_check.checked= true;	
				}else{
					var temp_check = get_by_id("day" + j);
					temp_check.checked= false;
				}
			}
			
		}


		var all_day = 0;
		var st_hour,st_min,en_hour,en_min;
		if(rule[2]=="00:00" && rule[3]=="24:00"){
			all_day = 1;						
		}else{						
			var temp_s= rule[2].split(":");
			var temp_e= rule[3].split(":");
			
			st_min= temp_s[1];
			en_min= temp_e[1];
			get_by_id("start_min").value = st_min;
			get_by_id("end_min").value = en_min;
			
			if(parseInt(temp_s[0],10)>11){
				get_by_id("start_time").selectedIndex = 1; //pm
				st_hour=parseInt(temp_s[0],10)-12;
				if(st_hour < 1){
					st_hour = parseInt(12);
				}
				if(st_hour < 10){
					get_by_id("start_hour").value = "0" + st_hour;
				}else{
					get_by_id("start_hour").value = st_hour;
				}
			}else{
				get_by_id("start_time").selectedIndex = 0;  //am
				st_hour=parseInt(temp_s[0],10);
				if(st_hour < 1){
					st_hour = parseInt(12);
				}
				if(st_hour < 10){
					get_by_id("start_hour").value = "0" + st_hour;
				}else{
					get_by_id("start_hour").value = st_hour;
				}
			}
			
			if(parseInt(temp_e[0],10)>11){
				get_by_id("end_time").selectedIndex = 1; //pm
				en_hour=parseInt(temp_e[0],10)-12;
				if(en_hour < 1){
					en_hour = parseInt(12);
				}
				if(en_hour < 10){
					get_by_id("end_hour").value = "0" + en_hour;
				}else{
					get_by_id("end_hour").value = en_hour;
				}
			}else{
				get_by_id("end_time").selectedIndex = 0;  //am
				en_hour=parseInt(temp_e[0],10);
				if(en_hour < 1){
					en_hour = parseInt(12);
				}
				if(en_hour < 10){
					get_by_id("end_hour").value = "0" + en_hour;
				}else{
					get_by_id("end_hour").value = en_hour;
				}
			}
		}
		
		var p_time_type = get_by_id("time_type");
		if(all_day == 1){
				p_time_type.checked =true;
				get_by_id("start_hour").value = "12";
				get_by_id("start_min").value = "00";
				set_selectIndex(0,get_by_id("start_time"));
				get_by_id("end_hour").value = "12";
				get_by_id("end_min").value = "00";
				set_selectIndex(0,get_by_id("end_time"));
		}else{
				p_time_type.checked =false;
		}


		get_by_id("edit").value = index;
		change_color("table1", index+1);
		from_edit = 1;
		show_day();
		show_time();
	}
	
	function del_row(row){	
		if (row < 10){
			var temp_rule = get_by_id("schedule_rule_0" + row).value;
		}else{
			var temp_rule = get_by_id("schedule_rule_" + row).value;
		}		
		var rule = temp_rule.split("/");
		
		for (var l=0 ;l <=rule_max_num ;l++){
			if(l<10){
					var temp_vs_rule = get_by_id("vs_rule_0" + l).value;
					var temp_port_rule = get_by_id("port_forward_both_0" + l).value;
					var temp_application_rule = get_by_id("application_0"+l).value;
			}else{
				if(l<24){
						var temp_rule = get_by_id("schedule_rule_" + l).value;
						var temp_vs_rule = get_by_id("vs_rule_" + l).value;
						var temp_port_rule = get_by_id("port_forward_both_" + l).value;
						var temp_application_rule = get_by_id("application_"+l).value;	
					}
				}
			
				var vs_rule = temp_vs_rule.split("/");	
				var port_rule = temp_port_rule.split("/");
				var application_rule = temp_application_rule.split("/");
				var email_rule = get_by_id("log_email_schedule").value.split("/");
				var access_rule = get_by_id("asp_temp_01").value;
					
				var vs_rule_schedule = vs_rule[6];			
				var port_rule_schedule = port_rule[5];
				var application_rule_schedule = application_rule[6];
				var email_rule_schedule = email_rule[3];
				var temp_wlan0_rule = get_by_id("wlan0_schedule").value;
				var wlan0_rule = temp_wlan0_rule.split("/");	
				var wlan0_rule_schedule = wlan0_rule[0];
				
			if((rule[0] == email_rule_schedule)||(rule[0] == access_rule)||(rule[0] == vs_rule_schedule)||(rule[0] == port_rule_schedule)||(rule[0] == application_rule_schedule)||(rule[0] == wlan0_rule_schedule)){
						alert("The rule be using in other rule, you can't delete");
						return;
			}
		}
		if (confirm(msg[DEL_SCHEDULE_MSG])){
					get_by_id("del_row").value = row;
					delete_data();
					get_by_id("button").click();
				}else{
					return ;
				}
		
	}
	
function delete_data(){
	var num =get_by_id("del_row").value;
	var num_next = parseInt(num)+1;

	for(i=num_next ; i < rule_max_num ;i++)
	{
		var pre_name, next_name;
		
		if (i - 1 < 10){
			pre_name = "schedule_rule_0" + (i-1);
		}else{
			pre_name = "schedule_rule_" +  (i-1);
		}
		
		if (i < 10){
			next_name = "schedule_rule_0" + i;
		}else{
			next_name = "schedule_rule_" +  i;
		}
		get_by_id(pre_name).value = get_by_id(next_name).value;
	
	}
	get_by_id("schedule_rule_09").value = "";
}
	
	
	function show_day(){
		var all_week = get_by_name("all_week");
	
		for (var i = 0; i < 7; i++){
			get_by_id("day" + i).disabled = all_week[0].checked;
		}
	}
	
	function show_time(){
		var time_type = get_by_id("time_type");
		
		get_by_id("start_hour").disabled = time_type.checked;
		get_by_id("start_min").disabled = time_type.checked;
		get_by_id("start_time").disabled = time_type.checked;
		get_by_id("end_hour").disabled = time_type.checked;
		get_by_id("end_min").disabled = time_type.checked;
		get_by_id("end_time").disabled = time_type.checked;
	}

function update_data(){
	if(get_by_id("edit").value != -1){
		var days_in_week="";
		var start_time_total,end_time_total;
		var p_all_week = get_by_name("all_week");
		if(p_all_week[0].checked == true){
			days_in_week = "1111111"
		}else{
			for(var i=0;i<7;i++){
				if(get_by_id("day"+ i).checked== true){
					days_in_week += "1";
				}else{
					days_in_week += "0"
				}
			}	
		}
		var p_all_day=get_by_id("time_type");

		if (p_all_day.checked==true){			
			start_time_total= "00:00";
			end_time_total="24:00";
		}else{
			var s_hour,s_min;
			var e_hour,e_min;
			
			//start time
			if(parseInt(get_by_id("start_min").value,10)<10){
				s_min= "0" + parseInt(get_by_id("start_min").value,10);
			}else{
				s_min= get_by_id("start_min").value;
			}
			
			if(get_by_id("start_time").selectedIndex ==1){	//pm
				s_hour = time_hour(parseInt(get_by_id("start_hour").value,10)) +12;
			}else{											//am
				if(time_hour(parseInt(get_by_id("start_hour").value,10))<10){
					s_hour ="0" + time_hour(parseInt(get_by_id("start_hour").value,10));
				}else{
					s_hour = get_by_id("start_hour").value;
				}
			}
			start_time_total =s_hour + ":" + s_min;
			
			//end time		
			if(parseInt(get_by_id("end_min").value,10)<10){
				e_min= "0" + parseInt(get_by_id("end_min").value,10);
			}else{
				e_min= get_by_id("end_min").value;
			}
			
			if(get_by_id("end_time").selectedIndex ==1){	//pm
				e_hour = time_hour(parseInt(get_by_id("end_hour").value,10)) +12;
			}else{											//am
				if(time_hour(parseInt(get_by_id("end_hour").value,10))<10){
					e_hour ="0" + time_hour(parseInt(get_by_id("end_hour").value,10));
				}else{
					e_hour = get_by_id("end_hour").value;
				}
			}
			end_time_total =e_hour + ":" + e_min;
		}
		
		
		
		var dat =get_by_id("name").value +"/"+ days_in_week +"/"+ start_time_total +"/"+ end_time_total;
		var num= parseInt(get_by_id("edit").value,10);
		if (num < 10){
			get_by_id("schedule_rule_0" + num).value = dat;
		}else{
			get_by_id("schedule_rule_" + num).value = dat;
		}
	
	}else{
		if(get_by_id("max_row").value >= parseInt(rule_max_num-1)){
			alert("Schedule rules is Full! Please Delete an Entry.");
		}
			
		var days_in_week="";
		var start_time_total,end_time_total;
		var p_all_week = get_by_name("all_week");
		if(p_all_week[0].checked == true){
			days_in_week = "1111111"
		}else{
			for(var i=0;i<7;i++){
				if(get_by_id("day"+ i).checked== true){
					days_in_week += "1";
				}else{
					days_in_week += "0"
				}
			}	
		}
		
		var p_all_day=get_by_id("time_type");
		if (p_all_day.checked==true){			
			start_time_total= "00:00";
			end_time_total="24:00";
		}else{
			var s_hour,s_min;
			var e_hour,e_min;
			
			//start time
			if(parseInt(get_by_id("start_min").value,10)<10){
				s_min= "0" + parseInt(get_by_id("start_min").value,10);
			}else{
				s_min= get_by_id("start_min").value;
			}
			
			if(get_by_id("start_time").selectedIndex ==1){	//pm
				s_hour = time_hour(parseInt(get_by_id("start_hour").value,10)) +12;	
			}else{											//am
				if(time_hour(parseInt(get_by_id("start_hour").value,10))<10){
					s_hour ="0" + time_hour(parseInt(get_by_id("start_hour").value,10));
				}else{
					s_hour = get_by_id("start_hour").value;
				}
			}
			start_time_total =s_hour + ":" + s_min;
			
			//end time		
			if(parseInt(get_by_id("end_min").value,10)<10){
				e_min= "0" + parseInt(get_by_id("end_min").value,10);
			}else{
				e_min= get_by_id("end_min").value;
			}
			
			if(get_by_id("end_time").selectedIndex ==1){	//pm
				e_hour = time_hour(parseInt(get_by_id("end_hour").value,10)) +12;
			}else{											//am
				if(time_hour(parseInt(get_by_id("end_hour").value,10))<10){
					e_hour ="0" + time_hour(parseInt(get_by_id("end_hour").value,10));
				}else{
					e_hour = get_by_id("end_hour").value;
				}
			}
			end_time_total =e_hour + ":" + e_min;
		}
		
		
		
		var dat =get_by_id("name").value +"/"+ days_in_week +"/"+ start_time_total +"/"+ end_time_total;
		var num = parseInt(get_by_id("max_row").value) +1;
		if (num < 10){
			get_by_id("schedule_rule_0" + num).value = dat;
		}else{
			get_by_id("schedule_rule_" + num).value = dat;
		}	
	}
}

	function time_hour(hour){
		var hour_c = hour;
		if (parseInt(hour,10) >= 12){
			hour_c = 00;
		}
		return hour_c;
	}
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm("Nothing has changed, save anyway?")) {
			return false;
		}
		var time_type = get_by_id("time_type");
		
		if(get_by_id("del_row").value == "-1"){	
			if (get_by_id("name").value.length <= 0){
				alert(msg[SCHEDULE_NAME_ERROR]);
				return false;
			}else{
				var temp_obj = get_by_id("name").value;
				var space_num = 0;
				for (i=0;i<temp_obj.length;i++){
					if (temp_obj.charAt(i)==" "){	
						space_num++
					}
					//Tina remark 2009/4/20
					//if (!check_ascii_key_fun(temp_obj.substring(i, i+1))){
					//	alert("Schedule Name is invalid. the legal characters are 0~9, A~Z, or a~z.");
					//	return false;
					//}
				}
				if(parseInt(space_num) >= parseInt(temp_obj.length)){
					alert(msg[SCHEDULE_NAME_SPACE_ERROR]);
					return false;
				}
						if((temp_obj == "Always")||(temp_obj == "Never") ){
					alert("Schedule Name is default name.");
					return false;
				}
				for (i = 0; i < rule_max_num; i++){
					if (i < 10){
						var temp_rule = get_by_id("schedule_rule_0" + i).value;
					}else{
						var temp_rule = get_by_id("schedule_rule_" + i).value;
					}
					var rule = temp_rule.split("/");
				
							
					if (rule[0] != "" && !from_edit){			
						if (temp_obj == rule[0]){
							alert("The schedule name is already in the list");
							return false;
						}						
					}
				}
			}
			if (!time_type.checked){
				if (!check_integer(get_by_id("start_hour").value, 1, 12) || !check_integer(get_by_id("start_min").value, 0, 59)){
					alert(msg[START_TIME_ERROR]);
					return false;
				}
					
				if (!check_integer(get_by_id("end_hour").value, 1, 12) || !check_integer(get_by_id("end_min").value, 0, 59)){
					alert(msg[END_TIME_ERROR]);
					return false;
				}
				if (get_by_id("start_time").selectedIndex > get_by_id("end_time").selectedIndex){
					alert(msg[TIME_RANGE_ERROR]);
					return false;
				}else{
					var start_hourc = time_hour(parseInt(get_by_id("start_hour").value,10));
					var end_hourc = time_hour(parseInt(get_by_id("end_hour").value,10));
					var temp_start_time = (start_hourc * 60) + (12 * 60 * get_by_id("start_time").selectedIndex) + (parseInt(get_by_id("start_min").value,10));
					var temp_end_time = (end_hourc * 60) + (12 * 60 * get_by_id("end_time").selectedIndex) + (parseInt(get_by_id("end_min").value,10));
					if (temp_start_time > temp_end_time){
						alert(msg[TIME_RANGE_ERROR]);
						return false;
					}
	
					if(temp_start_time - temp_end_time == 0){
						get_by_id("time_type").checked = true;
					}
					
					if((temp_start_time > 1439) && (temp_end_time - temp_start_time > 0)){
						alert(msg[START_TIME_ERROR]);
						return false;
					}
	
					if((temp_end_time > 1440) && (temp_end_time - temp_start_time > 0)){
						alert(msg[END_TIME_ERROR]);
						return false;
					}
				}
			}
			update_data();
		}
		
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}
</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/" onclick="return jump_if();">DIR-615</a></td>
        <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
		<td>&nbsp;</td>
      </tr>
    </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();">SETUP</a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();">ADVANCED</a></td>
			<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();">TOOLS</a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();">SUPPORT</a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();">ADMIN</a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();">TIME</a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();">SYSLOG</a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();">EMAIL SETTINGS</a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();">SYSTEM</a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();">FIRMWARE</a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();">DYNAMIC DNS</a></div></li>
								  	<li><div><a href="tools_vct.asp" onclick="return jump_if();">SYSTEM CHECK</a></div></li>
									<li><div id="sidenavoff">SCHEDULES</div></li>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
	   			<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
	   			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_schedules.asp">
	   			<input type="hidden" id="reboot_type" name="reboot_type" value="application">
				<input type="hidden" id="edit" name="edit" value="-1">
				<input type="hidden" id="del_row" name="del_row" value="-1">
				<input type="hidden" id="max_row" name="max_row" value="-1">
				
				<input type="hidden" id="log_email_schedule" name="log_email_schedule" value="<% CmoGetCfg("log_email_schedule","none"); %>"> <!-- email -->
				<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<% CmoGetCfg("asp_temp_01","none"); %>">	<!-- schedule -->
				<input type="hidden" id="schedule_rule_00" name="schedule_rule_00" value="<% CmoGetCfg("schedule_rule_00","none"); %>">
				<input type="hidden" id="schedule_rule_01" name="schedule_rule_01" value="<% CmoGetCfg("schedule_rule_01","none"); %>">
				<input type="hidden" id="schedule_rule_02" name="schedule_rule_02" value="<% CmoGetCfg("schedule_rule_02","none"); %>">
				<input type="hidden" id="schedule_rule_03" name="schedule_rule_03" value="<% CmoGetCfg("schedule_rule_03","none"); %>">
				<input type="hidden" id="schedule_rule_04" name="schedule_rule_04" value="<% CmoGetCfg("schedule_rule_04","none"); %>">
				<input type="hidden" id="schedule_rule_05" name="schedule_rule_05" value="<% CmoGetCfg("schedule_rule_05","none"); %>">
				<input type="hidden" id="schedule_rule_06" name="schedule_rule_06" value="<% CmoGetCfg("schedule_rule_06","none"); %>">
				<input type="hidden" id="schedule_rule_07" name="schedule_rule_07" value="<% CmoGetCfg("schedule_rule_07","none"); %>">
				<input type="hidden" id="schedule_rule_08" name="schedule_rule_08" value="<% CmoGetCfg("schedule_rule_08","none"); %>">
				<input type="hidden" id="schedule_rule_09" name="schedule_rule_09" value="<% CmoGetCfg("schedule_rule_09","none"); %>">
				<input type="hidden" id="schedule_rule_10" name="schedule_rule_10" value="<% CmoGetCfg("schedule_rule_10","none"); %>">
				<input type="hidden" id="schedule_rule_11" name="schedule_rule_11" value="<% CmoGetCfg("schedule_rule_11","none"); %>">
				<input type="hidden" id="schedule_rule_12" name="schedule_rule_12" value="<% CmoGetCfg("schedule_rule_12","none"); %>">
				<input type="hidden" id="schedule_rule_13" name="schedule_rule_13" value="<% CmoGetCfg("schedule_rule_13","none"); %>">
				<input type="hidden" id="schedule_rule_14" name="schedule_rule_14" value="<% CmoGetCfg("schedule_rule_14","none"); %>">
				<input type="hidden" id="schedule_rule_15" name="schedule_rule_15" value="<% CmoGetCfg("schedule_rule_15","none"); %>">
				<input type="hidden" id="schedule_rule_16" name="schedule_rule_16" value="<% CmoGetCfg("schedule_rule_16","none"); %>">
				<input type="hidden" id="schedule_rule_17" name="schedule_rule_17" value="<% CmoGetCfg("schedule_rule_17","none"); %>">
				<input type="hidden" id="schedule_rule_18" name="schedule_rule_18" value="<% CmoGetCfg("schedule_rule_18","none"); %>">
				<input type="hidden" id="schedule_rule_19" name="schedule_rule_19" value="<% CmoGetCfg("schedule_rule_19","none"); %>">
				<input type="hidden" id="schedule_rule_20" name="schedule_rule_20" value="<% CmoGetCfg("schedule_rule_20","none"); %>">
				<input type="hidden" id="schedule_rule_21" name="schedule_rule_21" value="<% CmoGetCfg("schedule_rule_21","none"); %>">
				<input type="hidden" id="schedule_rule_22" name="schedule_rule_22" value="<% CmoGetCfg("schedule_rule_22","none"); %>">
				<input type="hidden" id="schedule_rule_23" name="schedule_rule_23" value="<% CmoGetCfg("schedule_rule_23","none"); %>">
				<input type="hidden" id="schedule_rule_24" name="schedule_rule_24" value="<% CmoGetCfg("schedule_rule_24","none"); %>">
				<input type="hidden" id="schedule_rule_25" name="schedule_rule_25" value="<% CmoGetCfg("schedule_rule_25","none"); %>">
				<input type="hidden" id="schedule_rule_26" name="schedule_rule_26" value="<% CmoGetCfg("schedule_rule_26","none"); %>">
				<input type="hidden" id="schedule_rule_27" name="schedule_rule_27" value="<% CmoGetCfg("schedule_rule_27","none"); %>">
				<input type="hidden" id="schedule_rule_28" name="schedule_rule_28" value="<% CmoGetCfg("schedule_rule_28","none"); %>">
				<input type="hidden" id="schedule_rule_29" name="schedule_rule_29" value="<% CmoGetCfg("schedule_rule_29","none"); %>">
				<input type="hidden" id="schedule_rule_30" name="schedule_rule_30" value="<% CmoGetCfg("schedule_rule_30","none"); %>">
				<input type="hidden" id="schedule_rule_31" name="schedule_rule_31" value="<% CmoGetCfg("schedule_rule_31","none"); %>">
				
				<input type="hidden" id="port_forward_both_00" name="port_forward_both_00" value="<% CmoGetCfg("port_forward_both_00","none"); %>">
				        <input type="hidden" id="port_forward_both_01" name="port_forward_both_01" value="<% CmoGetCfg("port_forward_both_01","none"); %>">
				        <input type="hidden" id="port_forward_both_02" name="port_forward_both_02" value="<% CmoGetCfg("port_forward_both_02","none"); %>">
				        <input type="hidden" id="port_forward_both_03" name="port_forward_both_03" value="<% CmoGetCfg("port_forward_both_03","none"); %>">
				        <input type="hidden" id="port_forward_both_04" name="port_forward_both_04" value="<% CmoGetCfg("port_forward_both_04","none"); %>">
				        <input type="hidden" id="port_forward_both_05" name="port_forward_both_05" value="<% CmoGetCfg("port_forward_both_05","none"); %>">
				        <input type="hidden" id="port_forward_both_06" name="port_forward_both_06" value="<% CmoGetCfg("port_forward_both_06","none"); %>">
				        <input type="hidden" id="port_forward_both_07" name="port_forward_both_07" value="<% CmoGetCfg("port_forward_both_07","none"); %>">
				        <input type="hidden" id="port_forward_both_08" name="port_forward_both_08" value="<% CmoGetCfg("port_forward_both_08","none"); %>">
				        <input type="hidden" id="port_forward_both_09" name="port_forward_both_09" value="<% CmoGetCfg("port_forward_both_09","none"); %>">
				        <input type="hidden" id="port_forward_both_10" name="port_forward_both_10" value="<% CmoGetCfg("port_forward_both_10","none"); %>">
				        <input type="hidden" id="port_forward_both_11" name="port_forward_both_11" value="<% CmoGetCfg("port_forward_both_11","none"); %>">
				        <input type="hidden" id="port_forward_both_12" name="port_forward_both_12" value="<% CmoGetCfg("port_forward_both_12","none"); %>">
				        <input type="hidden" id="port_forward_both_13" name="port_forward_both_13" value="<% CmoGetCfg("port_forward_both_13","none"); %>">
				        <input type="hidden" id="port_forward_both_14" name="port_forward_both_14" value="<% CmoGetCfg("port_forward_both_14","none"); %>">
				        <input type="hidden" id="port_forward_both_15" name="port_forward_both_15" value="<% CmoGetCfg("port_forward_both_15","none"); %>">
				        <input type="hidden" id="port_forward_both_16" name="port_forward_both_16" value="<% CmoGetCfg("port_forward_both_16","none"); %>">
				        <input type="hidden" id="port_forward_both_17" name="port_forward_both_17" value="<% CmoGetCfg("port_forward_both_17","none"); %>">
				        <input type="hidden" id="port_forward_both_18" name="port_forward_both_18" value="<% CmoGetCfg("port_forward_both_18","none"); %>">
				        <input type="hidden" id="port_forward_both_19" name="port_forward_both_19" value="<% CmoGetCfg("port_forward_both_19","none"); %>">
				        <input type="hidden" id="port_forward_both_20" name="port_forward_both_20" value="<% CmoGetCfg("port_forward_both_20","none"); %>">
								<input type="hidden" id="port_forward_both_21" name="port_forward_both_21" value="<% CmoGetCfg("port_forward_both_21","none"); %>">
								<input type="hidden" id="port_forward_both_22" name="port_forward_both_22" value="<% CmoGetCfg("port_forward_both_22","none"); %>">
								<input type="hidden" id="port_forward_both_23" name="port_forward_both_23" value="<% CmoGetCfg("port_forward_both_23","none"); %>">
								
								<input type="hidden" id="application_00" name="application_00" value="<% CmoGetCfg("application_00","none"); %>">
                <input type="hidden" id="application_01" name="application_01" value="<% CmoGetCfg("application_01","none"); %>">
                <input type="hidden" id="application_02" name="application_02" value="<% CmoGetCfg("application_02","none"); %>">
                <input type="hidden" id="application_03" name="application_03" value="<% CmoGetCfg("application_03","none"); %>">
                <input type="hidden" id="application_04" name="application_04" value="<% CmoGetCfg("application_04","none"); %>">
                <input type="hidden" id="application_05" name="application_05" value="<% CmoGetCfg("application_05","none"); %>">
                <input type="hidden" id="application_06" name="application_06" value="<% CmoGetCfg("application_06","none"); %>">
                <input type="hidden" id="application_07" name="application_07" value="<% CmoGetCfg("application_07","none"); %>">
                <input type="hidden" id="application_08" name="application_08" value="<% CmoGetCfg("application_08","none"); %>">
                <input type="hidden" id="application_09" name="application_09" value="<% CmoGetCfg("application_09","none"); %>">
                <input type="hidden" id="application_10" name="application_10" value="<% CmoGetCfg("application_10","none"); %>">
                <input type="hidden" id="application_11" name="application_11" value="<% CmoGetCfg("application_11","none"); %>">
                <input type="hidden" id="application_12" name="application_12" value="<% CmoGetCfg("application_12","none"); %>">
                <input type="hidden" id="application_13" name="application_13" value="<% CmoGetCfg("application_13","none"); %>">
                <input type="hidden" id="application_14" name="application_14" value="<% CmoGetCfg("application_14","none"); %>">
                <input type="hidden" id="application_15" name="application_15" value="<% CmoGetCfg("application_15","none"); %>">
                <input type="hidden" id="application_16" name="application_16" value="<% CmoGetCfg("application_16","none"); %>">
                <input type="hidden" id="application_17" name="application_17" value="<% CmoGetCfg("application_17","none"); %>">
                <input type="hidden" id="application_18" name="application_18" value="<% CmoGetCfg("application_18","none"); %>">
                <input type="hidden" id="application_19" name="application_19" value="<% CmoGetCfg("application_19","none"); %>">
                <input type="hidden" id="application_20" name="application_20" value="<% CmoGetCfg("application_20","none"); %>">
                <input type="hidden" id="application_21" name="application_21" value="<% CmoGetCfg("application_21","none"); %>">
                <input type="hidden" id="application_22" name="application_22" value="<% CmoGetCfg("application_22","none"); %>">
                <input type="hidden" id="application_23" name="application_23" value="<% CmoGetCfg("application_23","none"); %>">
                
                <input type="hidden" id="vs_rule_00" name="vs_rule_00" value="<% CmoGetCfg("vs_rule_00","none"); %>">
                <input type="hidden" id="vs_rule_01" name="vs_rule_01" value="<% CmoGetCfg("vs_rule_01","none"); %>">
                <input type="hidden" id="vs_rule_02" name="vs_rule_02" value="<% CmoGetCfg("vs_rule_02","none"); %>">
                <input type="hidden" id="vs_rule_03" name="vs_rule_03" value="<% CmoGetCfg("vs_rule_03","none"); %>">
                <input type="hidden" id="vs_rule_04" name="vs_rule_04" value="<% CmoGetCfg("vs_rule_04","none"); %>">
                <input type="hidden" id="vs_rule_05" name="vs_rule_05" value="<% CmoGetCfg("vs_rule_05","none"); %>">
                <input type="hidden" id="vs_rule_06" name="vs_rule_06" value="<% CmoGetCfg("vs_rule_06","none"); %>">
                <input type="hidden" id="vs_rule_07" name="vs_rule_07" value="<% CmoGetCfg("vs_rule_07","none"); %>">
                <input type="hidden" id="vs_rule_08" name="vs_rule_08" value="<% CmoGetCfg("vs_rule_08","none"); %>">
                <input type="hidden" id="vs_rule_09" name="vs_rule_09" value="<% CmoGetCfg("vs_rule_09","none"); %>">
                <input type="hidden" id="vs_rule_10" name="vs_rule_10" value="<% CmoGetCfg("vs_rule_10","none"); %>">
                <input type="hidden" id="vs_rule_11" name="vs_rule_11" value="<% CmoGetCfg("vs_rule_11","none"); %>">
                <input type="hidden" id="vs_rule_12" name="vs_rule_12" value="<% CmoGetCfg("vs_rule_12","none"); %>">
                <input type="hidden" id="vs_rule_13" name="vs_rule_13" value="<% CmoGetCfg("vs_rule_13","none"); %>">
                <input type="hidden" id="vs_rule_14" name="vs_rule_14" value="<% CmoGetCfg("vs_rule_14","none"); %>">
                <input type="hidden" id="vs_rule_15" name="vs_rule_15" value="<% CmoGetCfg("vs_rule_15","none"); %>">
                <input type="hidden" id="vs_rule_16" name="vs_rule_16" value="<% CmoGetCfg("vs_rule_16","none"); %>">
                <input type="hidden" id="vs_rule_17" name="vs_rule_17" value="<% CmoGetCfg("vs_rule_17","none"); %>">
                <input type="hidden" id="vs_rule_18" name="vs_rule_18" value="<% CmoGetCfg("vs_rule_18","none"); %>">
                <input type="hidden" id="vs_rule_19" name="vs_rule_19" value="<% CmoGetCfg("vs_rule_19","none"); %>">
                <input type="hidden" id="vs_rule_20" name="vs_rule_20" value="<% CmoGetCfg("vs_rule_20","none"); %>">
								<input type="hidden" id="vs_rule_21" name="vs_rule_21" value="<% CmoGetCfg("vs_rule_21","none"); %>">
								<input type="hidden" id="vs_rule_22" name="vs_rule_22" value="<% CmoGetCfg("vs_rule_22","none"); %>">
								<input type="hidden" id="vs_rule_23" name="vs_rule_23" value="<% CmoGetCfg("vs_rule_23","none"); %>">
		<input type="hidden" id="wlan0_schedule" name="wlan0_schedule" value="<% CmoGetCfg("wlan0_schedule","none"); %>">
				
                                
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					
				  <div id="box_header"> 
						<h1>Schedules</h1>
						<p>The Schedule configuration option is used to manage schedule rules for various firewall and parental control features.</p>
						<br>
						<input name="button" id="button" type="submit" class=button_submit value="Save Settings" onClick="return send_request()">
						<input name="button2" type=button class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'tools_schedules.asp');">
				  </div>
				  <div class=box>
                    <h2>10 &ndash; ADD SCHEDULE RULE</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                      <tr>
                        <td width="150"><div align="right"><strong>Name&nbsp;:</strong>&nbsp;</div></td>
                        <td width="384" height="20" valign="top">&nbsp;&nbsp;<input id="name" name="name" type="text" size="20" maxlength="16"></td>
                      </tr>
                      <tr>
                        <td width="150">
                          <div align="right"><strong>Day(s)&nbsp;:</strong>&nbsp;</div></td>
                        <td height="20" valign="top">&nbsp;<input type="radio" name="all_week" value="1" onClick="show_day()" checked>
                        All Week
                        &nbsp;<input type="radio" name="all_week" value="0" onClick="show_day()">
                        Select Day(s)                     
					    </td>
                      </tr>
                      <tr>
                        <td width="150">
                          <div align="right"></div></td>
                        <td height="20" valign="top">&nbsp;<input type="checkbox" id="day0" name="day0" value="1">&nbsp;Sun
                        	<input type="checkbox" id="day1" name="day1" value="1">&nbsp;Mon
                        	<input type="checkbox" id="day2" name="day2" value="1">&nbsp;Tue
                        	<input type="checkbox" id="day3" name="day3" value="1">&nbsp;Wed
                        	<input type="checkbox" id="day4" name="day4" value="1">&nbsp;Thu
                        	<input type="checkbox" id="day5" name="day5" value="1">&nbsp;Fri
                        	<input type="checkbox" id="day6" name="day6" value="1">&nbsp;Sat
                        </td>
                      </tr>
                          <tr>
                            <td width="150">
                              <div align="right"><strong>All Day - 24 hrs&nbsp;:</strong>&nbsp;</div></td>
                            <td height="20" valign="middle">&nbsp;<input id="time_type"  name="time_type" type="checkbox" value="1" onClick="show_time()">
                            	<input type="hidden" id="h0" name="h0">
								<input type="hidden" id="h1" name="h1">
								<input type="hidden" id="h2" name="h2">
								<input type="hidden" id="h3" name="h3">
								<input type="hidden" id="h4" name="h4">
								<input type="hidden" id="h5" name="h5">
								<input type="hidden" id="h6" name="h6">
							</td>
                           
                          </tr>
                          <tr>
                            <td width="150"><div align="right"><strong>Start Time&nbsp;:</strong>&nbsp;</div></td>
                            <td height="20" valign="top">&nbsp;&nbsp;<input id="start_hour" name="start_hour" type="text" style="width: 40px" maxlength="2" value="12">:
                            <input id="start_min" name="start_min" type="text" style="width: 40px" maxlength="2" value="00">
                            <select style="width: 50px" id="start_time" name="start_time" value="00">
                            	<option value="0">AM</option>
						    	<option value="1">PM</option>
						    </select>
						    &nbsp;(hour:minute, 12 hour time)</td>
                          </tr>
                          <tr>
                            <td width="150">
                            <div align="right"><span class="form_label"><strong>End Time&nbsp;:&nbsp;</strong></span></div></td>
                            <td height="20" valign="top">&nbsp;&nbsp;<input id="end_hour" name="end_hour" type="text" style="width: 40px" maxlength="2" value="12">:
                            <input id="end_min" name="end_min" type="text" style="width: 40px" maxlength="2" value="00">
                            <select style="width: 50px" id="end_time" name="end_time">
                            	<option value="0">AM</option>
                            	<option value="1">PM</option>
                            </select>
                            &nbsp;(hour:minute, 12 hour time) </td>
                          </tr>
                    </table>
                  </div>
				  <div class=box>
                    <h2>Schedule Rules List : </h2>
                    <table id="table1" cellSpacing=1 cellPadding=1 width=524 border=0>
                      <tr>
                        <td width="165">
                          <div align="center"><strong>Name&nbsp;:</strong>&nbsp;</div></td>
                        <td width="190"><div align="center"><strong>Day(s)&nbsp;:</strong>&nbsp;</div></td>
                        <td width="135"><div align="center"><strong>Time Frame&nbsp;:</strong></div></td>                      
                        <td width="15" valign="top">&nbsp;</td>
                        <td width="15" valign="top">&nbsp;</td>
                      </tr>
					  <script>	
						
				for(i=0;i<rule_max_num;i++){
				
					if (i< 10){
						var temp_rule = get_by_id("schedule_rule_0" + i).value;
					}else{
						var temp_rule = get_by_id("schedule_rule_" + i).value;
					}
					if (temp_rule == ""){
						break;					
					}
					get_by_id("max_row").value = i;
					
					var rule = temp_rule.split("/");					
					var s = new Array();
					for(var j = 0; j < 8; j++){
						if(rule[1].charAt(j) == "1"){
							s[j] = "1";
					}else{
							s[j] = "0";
					}
					}
					
					var s_day = "", count = 0;
					for(var j = 0; j < 8; j++){			
						if(s[j] == "1"){
							s_day = s_day + " " + Week[j];
							count++;
					}
					}
					
					if(count == 7){
						s_day = "All week";
					}
					
					var temp_time_array = rule[2]+ "~" + rule[3];
					if(rule[2]=="00:00" && rule[3]=="24:00"){
						temp_time_array = "All Day";
					}
					document.write("<tr><td align=\"center\">"+ rule[0] +"</td><td align=\"center\">"+ s_day +"</td><td align=\"center\">"+ temp_time_array +"</td><td><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" width=\"15\" height=\"17\" border=\"0\" alt=\"edit\"></a></td><td><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\" width=\"15\" height=\"18\" border=\"0\" alt=\"delete\"></a></td></tr>");
				}
				</script>
					                                      
                    </table>
                    </form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong>Helpful Hints&hellip;</strong>
						<p>Schedules are used with a number of other features to define when those features are in effect.</p>
						<p>Give each schedule a name that is meaningful to you. For example, a schedule for Monday through Friday from 3:00pm to 9:00pm, might be called "After School".</p>
						<p>Click <strong>Save</strong> to add a completed schedule to the list below.</p>
						<p>Click <strong>Edit</strong> icon to change an existing schedule.</p>
						<p>Click <strong>Delete</strong> icon to permanently delete a schedule.</p>
						<p class="more"><a href="support_tools.asp#Schedules" onclick="return jump_if();">More&hellip;</a></p>
					  </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
</body>
<script>
	show_day();
	set_form_default_values("form1");
</script>
</html>
