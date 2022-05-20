﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
	function onPageLoad(){
		get_by_id("apply_2nd_cgi_parameter").value = "";
		get_by_id("apply_2nd_cgi").value = "";
		get_by_id("time_zone").selectedIndex = get_by_id("time_zone_area").value;
		set_checked("<% CmoGetCfg("time_daylight_saving_enable","none"); %>", get_by_id("daylight_enable"));

		set_selectIndex("<% CmoGetCfg("time_daylight_saving_start_month","none"); %>", get_by_id("m_start"));
		set_selectIndex("<% CmoGetCfg("time_daylight_saving_start_week","none"); %>", get_by_id("s_start"));
		set_selectIndex("<% CmoGetCfg("time_daylight_saving_start_day_of_week","none"); %>", get_by_id("w_start"));
		set_selectIndex("<% CmoGetCfg("time_daylight_saving_start_time","none"); %>", get_by_id("t_start"));
		set_selectIndex("<% CmoGetCfg("time_daylight_saving_end_month","none"); %>", get_by_id("m_end"));
		set_selectIndex("<% CmoGetCfg("time_daylight_saving_end_week","none"); %>", get_by_id("s_end"));
		set_selectIndex("<% CmoGetCfg("time_daylight_saving_end_day_of_week","none"); %>", get_by_id("w_end"));
		set_selectIndex("<% CmoGetCfg("time_daylight_saving_end_time","none"); %>", get_by_id("t_end"));

		set_checked("<% CmoGetCfg("ntp_client_enable","none"); %>", get_by_id("ntp_enable"));
		get_by_id("ntp_server").value = "<% CmoGetCfg("ntp_server","none"); %>";

		var temp_time = get_by_id("system_time").value;
		var Dtime = temp_time.split("/");
		set_selectIndex(Dtime[0], get_by_id("year"));

		var days = getDaysInMonth(Dtime[1], Dtime[0]);
		for(var i = 0 ; i < days; i++){
			get_by_id("day").options[i] = new Option(i+1, i+1);
			get_by_id("day").length = days;
		}

		set_selectIndex(Dtime[1], get_by_id("mon"));
		set_selectIndex(Dtime[2], get_by_id("day"));
		
		if(parseInt(Dtime[3]) > 11){
			get_by_id("hour").value = parseInt(Dtime[3]) - 12;
			set_selectIndex(1, get_by_id("ampm"));
		}else{
			get_by_id("hour").value = parseInt(Dtime[3]);
			set_selectIndex(0, get_by_id("ampm"));
		}

		set_selectIndex(parseInt(Dtime[4],10), get_by_id("min"));
		set_selectIndex(parseInt(Dtime[5],10), get_by_id("sec"));

		disable_daylight();
		//set_time();
	}
	
	function selectDate(){
		var year = get_by_id("year").value;
		//if (isFourDigitYear(year)){
			var mon = get_by_id("mon").selectedIndex;
			mon = parseInt(mon);
			year = parseInt(year);
			var days = getDaysInMonth(mon+1, year);
			for (var i = 0; i < days; i++){
				get_by_id("day").options[i] = new Option(i+1, i+1);
				get_by_id("day").length=days;
			}
		//}
	}

	function show_time(){
		var time_type = get_by_id("ntp_enable");
		
		//get_by_id("manual_sync").disabled = time_type.checked;
		get_by_id("ntp_server").disabled = !time_type.checked;
		get_by_id("ntp_server_list").disabled = !time_type.checked;
		get_by_id("year").disabled = time_type.checked;
		get_by_id("mon").disabled = time_type.checked;
		get_by_id("day").disabled = time_type.checked;
		get_by_id("hour").disabled = time_type.checked;
		get_by_id("min").disabled = time_type.checked;
		get_by_id("sec").disabled = time_type.checked;
		get_by_id("ampm").disabled = time_type.checked;
		get_by_id("clone").disabled = time_type.checked;
	}

	function disable_daylight(){
		var daylight_enable = get_by_id("daylight_enable");
		
		//get_by_id("offset").disabled = !daylight_enable.checked;
		get_by_id("m_start").disabled = !daylight_enable.checked;
		get_by_id("w_start").disabled = !daylight_enable.checked;
		get_by_id("s_start").disabled = !daylight_enable.checked;
		get_by_id("t_start").disabled = !daylight_enable.checked;
		get_by_id("m_end").disabled = !daylight_enable.checked;
		get_by_id("w_end").disabled = !daylight_enable.checked;
		get_by_id("s_end").disabled = !daylight_enable.checked;
		get_by_id("t_end").disabled = !daylight_enable.checked;
	}	
	function set_month_list(){
		for(var i = 0; i < month.length; i++){
			document.write("<option value=" + (i+1) + " >" + month[i] + "</option>");
		}
	}

	function set_week_list(){
		for(var i = 0; i < Week.length; i++){
			document.write("<option value=" + (i+1) + " >" + Week[i] + "</option>");
		}
	}

	function set_seq_list(){
		for(var i = 0; i < sequence.length; i++){
			document.write("<option value=" + (i+1) + " >" + sequence[i] + "</option>");
		}
	}
	
	function send_request(){
		//if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
		if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
			return false;
		}
		get_by_id("time_daylight_saving_enable").value = get_checked_value(get_by_id("daylight_enable"));
		get_by_id("time_zone_area").value = get_by_id("time_zone").selectedIndex;

		if(get_by_id("daylight_enable").checked){
			get_by_id("time_daylight_saving_start_month").value = get_by_id("m_start").value;
			get_by_id("time_daylight_saving_start_week").value = get_by_id("s_start").value;
			get_by_id("time_daylight_saving_start_day_of_week").value = get_by_id("w_start").value;
			get_by_id("time_daylight_saving_start_time").value = get_by_id("t_start").value;
			get_by_id("time_daylight_saving_end_month").value = get_by_id("m_end").value;
			get_by_id("time_daylight_saving_end_week").value = get_by_id("s_end").value;
			get_by_id("time_daylight_saving_end_day_of_week").value = get_by_id("w_end").value;
			get_by_id("time_daylight_saving_end_time").value = get_by_id("t_end").value;		
		}

		get_by_id("ntp_client_enable").value = get_checked_value(get_by_id("ntp_enable"));
		var time_type = get_by_id("ntp_enable");
		if (time_type.checked== false){
			var year = get_by_id("year").value;
			var mon = get_by_id("mon").value;
			var day = get_by_id("day").value;
			if(get_by_id("ampm").selectedIndex == 0)
				var hour = get_by_id("hour").value;
			else
				var hour = parseInt(get_by_id("hour").value) + 12;
			
			var minu = get_by_id("min").value;
			var sec = get_by_id("sec").value;
			
			var dat = year +"/"+ mon +"/"+ day +"/"+ hour +"/"+ minu +"/"+ sec;
			get_by_id("system_time").value = dat;
			
			get_by_id("apply_2nd_cgi_parameter").value = dat;
			get_by_id("apply_2nd_cgi").value = "system_time.cgi";	
		}else{
			if(get_by_id("ntp_server").value == ""){
				//alert("Please enter NTP Server");
				alert(which_lang[YM185]);
				return false;
			}
		}
		
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}
	
	function set_time(){
		var date = new Date();
		var year = date.getFullYear();
		var mon = date.getMonth();
	
		mon = parseInt(mon);
		year = parseInt(year);
		var days = getDaysInMonth(mon+1, year);
		for(var i = 0 ; i < days; i++){
			get_by_id("day").options[i] = new Option(i+1, i+1);
			get_by_id("day").length = days;
		}
		set_selectIndex(date.getFullYear(), get_by_id("year"));
		get_by_id("mon").selectedIndex = date.getMonth();
		get_by_id("day").selectedIndex = date.getDate() - 1;

		if(parseInt(date.getHours()) > 11){
			get_by_id("hour").value = parseInt(date.getHours()) - 12;
			set_selectIndex(1, get_by_id("ampm"));
		}else{
			get_by_id("hour").value = date.getHours();
			set_selectIndex(0, get_by_id("ampm"));
		}
		
		//get_by_id("hour").selectedIndex = date.getHours(); 
		
		get_by_id("min").selectedIndex = date.getMinutes(); 
		get_by_id("sec").selectedIndex = date.getSeconds();
	}

	var nNow, gTime;
	function get_time(){
		if (gTime){
			return;
		}
		gTime = "<% CmoGetStatus("system_time"); %>";
		var time = gTime.split("/");
		gTime = month[time[1]-1] + " " + time[2] + ", " + time[0] + " " + time[3] + ":" + time[4] + ":" + time[5];		
		nNow = new Date(gTime);
	}

	function STime(){
		nNow.setTime(nNow.getTime() + 1000);
		get_by_id("show_systime").innerHTML = nNow.toLocaleString();
		setTimeout('STime()', 1000);
	}
	
</script>

</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">

	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();">DIR-615</a></td>
        <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
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
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(which_lang[_support])</script></a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_admin])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[_time])</script></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(which_lang[_syslog])</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(which_lang[_email])</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(which_lang[_system])</script></a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(which_lang[_firmware])</script></a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(which_lang[_dyndns])</script></a></div></li>
                                    <li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(which_lang[_syscheck])</script></a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(which_lang[_scheds])</script></a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_time.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="application">
			
			<input type="hidden" id="apply_2nd_cgi" name="apply_2nd_cgi" value="">
			<input type="hidden" id="apply_2nd_cgi_parameter" name="apply_2nd_cgi_parameter" value="">
			<input type="hidden" id="system_time" name="system_time" value="<% CmoGetStatus("system_time"); %>">
			
			<input type="hidden" id="time_zone_area" name="time_zone_area" value="<% CmoGetCfg("time_zone_area","none"); %>">
			<input type="hidden" id="time_daylight_saving_start_month" name="time_daylight_saving_start_month" value="<% CmoGetCfg("time_daylight_saving_start_month","none"); %>">
			<input type="hidden" id="time_daylight_saving_start_week" name="time_daylight_saving_start_week" value="<% CmoGetCfg("time_daylight_saving_start_week","none"); %>">
			<input type="hidden" id="time_daylight_saving_start_day_of_week" name="time_daylight_saving_start_day_of_week" value="<% CmoGetCfg("time_daylight_saving_start_day_of_week","none"); %>">
			<input type="hidden" id="time_daylight_saving_start_time" name="time_daylight_saving_start_time" value="<% CmoGetCfg("time_daylight_saving_start_time","none"); %>">
			<input type="hidden" id="time_daylight_saving_end_month" name="time_daylight_saving_end_month" value="<% CmoGetCfg("time_daylight_saving_end_month","none"); %>">
			<input type="hidden" id="time_daylight_saving_end_week" name="time_daylight_saving_end_week" value="<% CmoGetCfg("time_daylight_saving_end_week","none"); %>">
			<input type="hidden" id="time_daylight_saving_end_day_of_week" name="time_daylight_saving_end_day_of_week" value="<% CmoGetCfg("time_daylight_saving_end_day_of_week","none"); %>">
			<input type="hidden" id="time_daylight_saving_end_time" name="time_daylight_saving_end_time" value="<% CmoGetCfg("time_daylight_saving_end_time","none"); %>">
			

			<td valign="top" id="maincontent_container">
			<div id="maincontent">
                  
          <div id=box_header> 
            <h1>
              <script>show_words(which_lang[_time])</script>
            </h1>
                     
            <p>
              <script>show_words(which_lang[tt_intro_Time])</script>
            </p>
            <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
			<input name="button2" id="button2" type=button class=button_submit value="" onclick="page_cancel('form1', 'tools_time.asp');">
			<script>get_by_id("button").value = which_lang[_savesettings];</script>
			<script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
                  </div>
                    
          <div class=box> 
            <h2>
              <script>show_words(which_lang[tt_TimeConf])</script>
            </h2>
                      <table width="525" class=formarea>
                        <tr>
                          
                <td class="duple">
                  <script>show_words(which_lang[tt_CurTime])</script>&nbsp;:<br></td>
                          <td>&nbsp;&nbsp;<span id="show_systime"></span></td>
                        </tr>
                        <tr>
                          <td class="duple"><script>show_words(which_lang[tt_TimeZ])</script> : </td>
                          <td><span class="form_label">&nbsp;
                            <select id="time_zone" name="time_zone" size=1>
                              <option value="-192"><font face=Arial><script>show_words(which_lang[up_tz_00])</script></font></option>
			                  <option value="-176"><font face=Arial><script>show_words(which_lang[up_tz_01])</script></font></option>
			                  <option value="-160"><font face=Arial><script>show_words(which_lang[up_tz_02])</script></font></option>
			                  <option value="-144"><font face=Arial><script>show_words(which_lang[up_tz_03])</script></font></option>
			                  <option value="-128"><font face=Arial><script>show_words(which_lang[up_tz_04])</script></font></option>
			                  <option value="-112"><font face=Arial><script>show_words(which_lang[up_tz_05])</script></font></option>
			                  <option value="-112"><font face=Arial><script>show_words(which_lang[up_tz_06])</script></font></option>
			                  <option value="-96"><font face=Arial><script>show_words(which_lang[up_tz_07])</script></font></option>
			                  <option value="-96"><font face=Arial><script>show_words(which_lang[up_tz_08])</script></font></option>
			                  <option value="-96"><font face=Arial><script>show_words(which_lang[up_tz_09])</script></font></option>
			                  <option value="-96"><font face=Arial><script>show_words(which_lang[up_tz_10])</script></font></option>
			                  <option value="-80"><font face=Arial><script>show_words(which_lang[up_tz_11])</script></font></option>                  
			                  <option value="-80"><font face=Arial><script>show_words(which_lang[up_tz_12])</script></font></option>
			                  <option value="-80"><font face=Arial><script>show_words(which_lang[up_tz_13])</script></font></option>
			                  <option value="-64"><font face=Arial><script>show_words(which_lang[up_tz_14])</script></font></option>
			                  <option value="-64"><font face=Arial><script>show_words(which_lang[up_tz_15])</script></font></option>
			                  <option value="-64"><font face=Arial><script>show_words(which_lang[up_tz_16])</script></font></option>
			                  <option value="-48"><font face=Arial><script>show_words(which_lang[up_tz_17])</script></font></option>
			                  <option value="-48"><font face=Arial><script>show_words(which_lang[up_tz_18])</script></font></option>
			                  <option value="-48"><font face=Arial><script>show_words(which_lang[up_tz_19])</script></font></option>
			                  <option value="-48"><font face=Arial><script>show_words(which_lang[up_tz_20])</script></font></option>
			                  <option value="-32"><font face=Arial><script>show_words(which_lang[up_tz_21])</script></font></option>
			                  <option value="-16"><font face=Arial><script>show_words(which_lang[up_tz_22])</script></font></option>
			                  <option value="-16"><font face=Arial><script>show_words(which_lang[up_tz_23])</script></font></option>
			                  <option value="0"><font face=Arial><script>show_words(which_lang[up_tz_24])</script></font></option>
			                  <option value="0"><font face=Arial><script>show_words(which_lang[up_tz_25])</script></font></option>
			                  <option value="16"><font face=Arial><script>show_words(which_lang[up_tz_26])</script></font></option>
			                  <option value="16"><font face=Arial><script>show_words(which_lang[up_tz_27])</script></font></option>
			                  <option value="16"><font face=Arial><script>show_words(which_lang[up_tz_28])</script></font></option>
			                  <option value="16"><font face=Arial><script>show_words(which_lang[up_tz_29])</script></font></option>
			                  <option value="16"><font face=Arial><script>show_words(which_lang[up_tz_29b])</script></font></option>
			                  <option value="16"><font face=Arial><script>show_words(which_lang[up_tz_30])</script></font></option>
			                  <option value="32"><font face=Arial><script>show_words(which_lang[up_tz_31])</script></font></option>
			                  <option value="32"><font face=Arial><script>show_words(which_lang[up_tz_32])</script></font></option>
			                  <option value="32"><font face=Arial><script>show_words(which_lang[up_tz_33])</script></font></option>
			                  <option value="32"><font face=Arial><script>show_words(which_lang[up_tz_34])</script></font></option>
			                  <option value="32"><font face=Arial><script>show_words(which_lang[up_tz_35])</script></font></option>
			                  <option value="32"><font face=Arial><script>show_words(which_lang[up_tz_36])</script></font></option>
			                  <option value="48"><font face=Arial><script>show_words(which_lang[up_tz_37])</script></font></option>
			                  <option value="48"><font face=Arial><script>show_words(which_lang[up_tz_38])</script></font></option>
			                  <option value="48"><font face=Arial><script>show_words(which_lang[up_tz_39])</script></font></option>
			                  <option value="48"><font face=Arial><script>show_words(which_lang[up_tz_40])</script></font></option>
			                  <option value="48"><font face=Arial><script>show_words(which_lang[up_tz_41])</script></font></option>
			                  <option value="64"><font face=Arial><script>show_words(which_lang[up_tz_42])</script></font></option>
			                  <option value="64"><font face=Arial><script>show_words(which_lang[up_tz_43])</script></font></option>
			                  <option value="72"><font face=Arial><script>show_words(which_lang[up_tz_44])</script></font></option>
			                  <option value="80"><font face=Arial><script>show_words(which_lang[up_tz_45])</script></font></option>
			                  <option value="80"><font face=Arial><script>show_words(which_lang[up_tz_46])</script></font></option>
			                  <option value="88"><font face=Arial><script>show_words(which_lang[up_tz_47])</script></font></option>
			                  <option value="92"><font face=Arial><script>show_words(which_lang[up_tz_48])</script></font></option>
			                  <option value="96"><font face=Arial><script>show_words(which_lang[up_tz_49])</script></font></option>
			                  <option value="96"><font face=Arial><script>show_words(which_lang[up_tz_50])</script></font></option>
			                  <option value="96"><font face=Arial><script>show_words(which_lang[up_tz_51])</script></font></option>
			                  <option value="104"><font face=Arial><script>show_words(which_lang[up_tz_52])</script></font></option>
			                  <option value="112"><font face=Arial><script>show_words(which_lang[up_tz_53])</script></font></option>
			                  <option value="112"><font face=Arial><script>show_words(which_lang[up_tz_54])</script></font></option>
			                  <option value="128"><font face=Arial><script>show_words(which_lang[up_tz_55])</script></font></option>
			                  <option value="128"><font face=Arial><script>show_words(which_lang[up_tz_56])</script></font></option>
			                  <option value="128"><font face=Arial><script>show_words(which_lang[up_tz_57])</script></font></option>
			                  <option value="128"><font face=Arial><script>show_words(which_lang[up_tz_58])</script></font></option>
			                  <option value="128"><font face=Arial><script>show_words(which_lang[up_tz_59])</script></font></option>
			                  <option value="144"><font face=Arial><script>show_words(which_lang[up_tz_60])</script></font></option>
			                  <option value="144"><font face=Arial><script>show_words(which_lang[up_tz_61])</script></font></option>
			                  <option value="144"><font face=Arial><script>show_words(which_lang[up_tz_62])</script></font></option>
			                  <option value="152"><font face=Arial><script>show_words(which_lang[up_tz_63])</script></font></option>
			                  <option value="152"><font face=Arial><script>show_words(which_lang[up_tz_64])</script></font></option>
			                  <option value="160"><font face=Arial><script>show_words(which_lang[up_tz_65])</script></font></option>
			                  <option value="160"><font face=Arial><script>show_words(which_lang[up_tz_66])</script></font></option>
			                  <option value="160"><font face=Arial><script>show_words(which_lang[up_tz_67])</script></font></option>
			                  <option value="160"><font face=Arial><script>show_words(which_lang[up_tz_68])</script></font></option>
			                  <option value="160"><font face=Arial><script>show_words(which_lang[up_tz_69])</script></font></option>
			                  <option value="176"><font face=Arial><script>show_words(which_lang[up_tz_70])</script></font></option>
			                  <option value="192"><font face=Arial><script>show_words(which_lang[up_tz_71])</script></font></option>
			                  <option value="192"><font face=Arial><script>show_words(which_lang[up_tz_72])</script></font></option>
			                  <option value="208"><font face=Arial><script>show_words(which_lang[up_tz_73])</script></font></option>
                            </select>
                          </span></td>
                        </tr>
                        <tbody>
						  <tr>
						  	
                  <td class="duple">
                    <script>show_words(which_lang[tt_dsen2])</script>&nbsp;:</td>
						  	<td width="340">&nbsp;
								<input name="daylight_enable" type=checkbox id="daylight_enable" value="1" onClick="disable_daylight();">
								<input type="hidden" id="time_daylight_saving_enable" name="time_daylight_saving_enable" value="<% CmoGetCfg("time_daylight_saving_enable","none"); %>">							
								<!--INPUT type="button" id="manual_sync" name="manual_sync" value="Sync. your computer's time settings" onclick="set_system_time();"-->
							</td>
						  </tr>	
						  <!--
						  <tr>
						  	<td class="duple">Daylight Saving Offset :</td>
						  	<td>&nbsp;
							<select id="offset" name="offset">
								<option value="">-2:00</option>
								<option value="">-1:30</option>
								<option value="">-1:00</option>
								<option value="">-0:30</option>
								<option value="">+0:30</option>
								<option value="">+1:00</option>
								<option value="">+1:30</option>
								<option value="">+2:00</option>
							</select>
							</td>
						  </tr>	
						  -->
                          <tr>
                            
                  <td class="duple"> 
                    <script>show_words(which_lang[tt_dsdates])</script> :</td>
                            <td valign="middle" width="340">
                              <table>
                                <tbody>
                                  <tr>
                                    <td>&nbsp;</td>
									
                          <td>
                            <script>show_words(which_lang[tt_Month])</script>
                          </td>
									
                          <td>
                            <script>show_words(which_lang[ZM21])</script>
                          </td>
									
                          <td>
                            <script>show_words(which_lang[ZM22])</script>
                          </td>
									
                          <td>
                            <script>show_words(which_lang[_time])</script>
                          </td>
                                  </tr>
                                  <tr>
                                    
                          <td>
                            <script>show_words(which_lang[tt_dststart])</script>
                          </td>
									<td>
									<select id="m_start" name="m_start">
									<script>set_month_list();</script>
									</select>
									</td>
									<td>
									<select id="s_start" name="s_start">
									<script>set_seq_list();</script>
									</select>
									</td>
									<td>
									<select id="w_start" name="w_start">
									<script>set_week_list();</script>
									</select>
									</td>
									<td>
									<select id="t_start" name="t_start">
										<option value="0"><script>show_words(which_lang[tt_time_1])</script></option>
										<option value="1"><script>show_words(which_lang[tt_time_2])</script></option>
										<option value="2"><script>show_words(which_lang[tt_time_3])</script></option>
										<option value="3"><script>show_words(which_lang[tt_time_4])</script></option>
										<option value="4"><script>show_words(which_lang[tt_time_5])</script></option>
										<option value="5"><script>show_words(which_lang[tt_time_6])</script></option>
										<option value="6"><script>show_words(which_lang[tt_time_7])</script></option>
										<option value="7"><script>show_words(which_lang[tt_time_8])</script></option>
										<option value="8"><script>show_words(which_lang[tt_time_9])</script></option>
										<option value="9"><script>show_words(which_lang[tt_time_10])</script></option>
										<option value="10"><script>show_words(which_lang[tt_time_11])</script></option>
										<option value="11"><script>show_words(which_lang[tt_time_12])</script></option>
										<option value="12"><script>show_words(which_lang[tt_time_13])</script></option>
										<option value="13"><script>show_words(which_lang[tt_time_14])</script></option>
										<option value="14"><script>show_words(which_lang[tt_time_15])</script></option>
										<option value="15"><script>show_words(which_lang[tt_time_16])</script></option>
										<option value="16"><script>show_words(which_lang[tt_time_17])</script></option>
										<option value="17"><script>show_words(which_lang[tt_time_18])</script></option>
										<option value="18"><script>show_words(which_lang[tt_time_19])</script></option>
										<option value="19"><script>show_words(which_lang[tt_time_20])</script></option>
										<option value="20"><script>show_words(which_lang[tt_time_21])</script></option>
										<option value="21"><script>show_words(which_lang[tt_time_22])</script></option>
										<option value="22"><script>show_words(which_lang[tt_time_23])</script></option>
										<option value="23"><script>show_words(which_lang[tt_time_24])</script></option>
									</select>
									</td>
                                  </tr>
                                  <tr>
                                    
                          <td>
                            <script>show_words(which_lang[tt_dstend])</script>
                          </td>
									<td>
									<select id="m_end" name="m_end">
									<script>set_month_list();</script>
									</select>
									</td>
									<td>
									<select id="s_end" name="s_end">
									<script>set_seq_list();</script>
									</select>
									</td>
									<td>
									<select id="w_end" name="w_end">
									<script>set_week_list();</script>
									</select>
									</td>
									<td>
									<select id="t_end" name="t_end">
										<option value="0"><script>show_words(which_lang[tt_time_1])</script></option>
										<option value="1"><script>show_words(which_lang[tt_time_2])</script></option>
										<option value="2"><script>show_words(which_lang[tt_time_3])</script></option>
										<option value="3"><script>show_words(which_lang[tt_time_4])</script></option>
										<option value="4"><script>show_words(which_lang[tt_time_5])</script></option>
										<option value="5"><script>show_words(which_lang[tt_time_6])</script></option>
										<option value="6"><script>show_words(which_lang[tt_time_7])</script></option>
										<option value="7"><script>show_words(which_lang[tt_time_8])</script></option>
										<option value="8"><script>show_words(which_lang[tt_time_9])</script></option>
										<option value="9"><script>show_words(which_lang[tt_time_10])</script></option>
										<option value="10"><script>show_words(which_lang[tt_time_11])</script></option>
										<option value="11"><script>show_words(which_lang[tt_time_12])</script></option>
										<option value="12"><script>show_words(which_lang[tt_time_13])</script></option>
										<option value="13"><script>show_words(which_lang[tt_time_14])</script></option>
										<option value="14"><script>show_words(which_lang[tt_time_15])</script></option>
										<option value="15"><script>show_words(which_lang[tt_time_16])</script></option>
										<option value="16"><script>show_words(which_lang[tt_time_17])</script></option>
										<option value="17"><script>show_words(which_lang[tt_time_18])</script></option>
										<option value="18"><script>show_words(which_lang[tt_time_19])</script></option>
										<option value="19"><script>show_words(which_lang[tt_time_20])</script></option>
										<option value="20"><script>show_words(which_lang[tt_time_21])</script></option>
										<option value="21"><script>show_words(which_lang[tt_time_22])</script></option>
										<option value="22"><script>show_words(which_lang[tt_time_23])</script></option>
										<option value="23"><script>show_words(which_lang[tt_time_24])</script></option>
									</select>
									</td>
                                  </tr>
                                </tbody>
                              </table>                            
							</td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    
          <div class=box> 
            <h2>
              <script>show_words(which_lang[tt_auto])</script></h2>
                      <table width="525">
                        <tbody>
                          <tr>
						  	
                  <td class="duple">
                    <script>show_words(which_lang[tt_EnNTP])</script> :</td>
                            <td width="340">&nbsp;
                            	<input id="ntp_enable" name="ntp_enable" type=checkbox value="1" onClick="show_time()">
                            	<input type="hidden" id="ntp_client_enable" name="ntp_client_enable" value="<% CmoGetCfg("ntp_client_enable","none"); %>">
                            </td>
                          </tr>
                          <tr>
                            
                  <td class="duple">
                    <script>show_words(which_lang[tt_NTPSrvU])</script>&nbsp;:</td>
                            <td width="340">&nbsp;&nbsp;
								<input type="text" id="ntp_server" name="ntp_server">
								&lt;&lt;
								<select id="ntp_server_list" name="ntp_server_list" onChange="key_word(this, 'ntp_server');">
                                  <option><script>show_words(which_lang[tt_SelNTPSrv])</script></option>
                                  <option value="ntp1.dlink.com">ntp1.dlink.com</option>
                                  <option value="ntp.dlink.com.tw">ntp.dlink.com.tw</option>
                                </select>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                  
          <div class=box> 
            <h2>
              <script>show_words(which_lang[tt_StDT])</script></h2>
                      <table width="525" cellpadding="1" cellspacing="1" class=formarea>
                        <tbody>
                          <tr>
                            <td colspan=2>
                              <table width="100%" border=0 cellpadding=2 cellspacing=0>
                                <tbody>
                                  <tr>
								  	<td class="duple">&nbsp;</td>
                                    <td colspan="7">&nbsp;</td>
                                  </tr>
                                  <tr>
								  	
                          <td class="duple">
                            <script>show_words(which_lang[tt_DaT])</script> : </td>
                                    
                          <td>&nbsp;
                            <script>show_words(which_lang[tt_Year])</script>
                          </td>
                                    <td><font face="Arial, Helvetica, sans-serif" size=2>
                                      <select id="year" name="year" size=1 style="WIDTH: 50px" onchange="selectDate();">
                                        <option value="2002">2002</option>
                                        <option value="2003">2003</option>
                                        <option value="2004">2004</option>
                                        <option value="2005">2005</option>
                                        <option value="2006">2006</option>
                                        <option value="2007">2007</option>
                                        <option value="2008">2008</option>
                                        <option value="2009">2009</option>
                                        <option value="2010">2010</option>
                                        <option value="2011">2011</option>
                                        <option value="2012">2012</option>
                                      </select>
                                    </font></td>
                                    
                          <td>
                            <script>show_words(which_lang[tt_Month])</script>
                          </td>
                                    <td><font face="Arial, Helvetica, sans-serif" size=2>
                                      <select id="mon" name="mon" size=1 style="WIDTH: 50px" onchange="selectDate();">
										<script>set_month_list();</script>
                                      </select>
                                    </font> </td>
                                    
                          <td>
                            <script>show_words(which_lang[tt_Day])</script>
                          </td>
                                    <td><font face="Arial, Helvetica, sans-serif" size=2>
                                      <select size=1 id="day" name="day" style="WIDTH: 50px">
                                      </select>
                                    </font></td>
									<td>&nbsp;</td>
                                  </tr>
                                  <tr>
								  	<td class="duple"></td>
                                    
                          <td>&nbsp;
                            <script>show_words(which_lang[tt_Hour])</script>
                          </td>
                                    <td><font face="Arial, Helvetica, sans-serif" size=2>
                                      <select size=1 id="hour" name="hour" style="WIDTH: 50px">
                                        <option value=0>12</option>
                                        <option value=1>01</option>
                                        <option value=2>02</option>
                                        <option value=3>03</option>
                                        <option value=4>04</option>
                                        <option value=5>05</option>
                                        <option value=6>06</option>
                                        <option value=7>07</option>
                                        <option value=8>08</option>
                                        <option value=9>09</option>
                                        <option value=10>10</option>
                                        <option value=11>11</option>
                                    </select>
                                    </font></td>
                                    
                          <td>
                            <script>show_words(which_lang[tt_Minute])</script>
                          </td>
                                    <td><font face="Arial, Helvetica, sans-serif" size=2>
                                      <select size=1 id="min" name="min" style="WIDTH: 50px">
                                        <option value=0>00</option>
                                        <option value=1>01</option>
                                        <option value=2>02</option>
                                        <option value=3>03</option>
                                        <option value=4>04</option>
                                        <option value=5>05</option>
                                        <option value=6>06</option>
                                        <option value=7>07</option>
                                        <option value=8>08</option>
                                        <option value=9>09</option>
                                        <option value=10>10</option>
                                        <option value=11>11</option>
                                        <option value=12>12</option>
                                        <option value=13>13</option>
                                        <option value=14>14</option>
                                        <option value=15>15</option>
                                        <option value=16>16</option>
                                        <option value=17>17</option>
                                        <option value=18>18</option>
                                        <option value=19>19</option>
                                        <option value=20>20</option>
                                        <option value=21>21</option>
                                        <option value=22>22</option>
                                        <option value=23>23</option>
                                        <option value=24>24</option>
                                        <option value=25>25</option>
                                        <option value=26>26</option>
                                        <option value=27>27</option>
                                        <option value=28>28</option>
                                        <option value=29>29</option>
                                        <option value=30>30</option>
                                        <option value=31>31</option>
                                        <option value=32>32</option>
                                        <option value=33>33</option>
                                        <option value=34>34</option>
                                        <option value=35>35</option>
                                        <option value=36>36</option>
                                        <option value=37>37</option>
                                        <option value=38>38</option>
                                        <option value=39>39</option>
                                        <option value=40>40</option>
                                        <option value=41>41</option>
                                        <option value=42>42</option>
                                        <option value=43>43</option>
                                        <option value=44>44</option>
                                        <option value=45>45</option>
                                        <option value=46>46</option>
                                        <option value=47>47</option>
                                        <option value=48>48</option>
                                        <option value=49>49</option>
                                        <option value=50>50</option>
                                        <option value=51>51</option>
                                        <option value=52>52</option>
                                        <option value=53>53</option>
                                        <option value=54>54</option>
                                        <option value=55>55</option>
                                        <option value=56>56</option>
                                        <option value=57>57</option>
                                        <option value=58>58</option>
                                        <option value=59>59</option>
                                      </select>
                                    </font></td>
                                    
                          <td>
                            <script>show_words(which_lang[tt_Second])</script>
                          </td>
                                    <td><font face="Arial, Helvetica, sans-serif" size=2>
                                      <select size=1 id="sec" name="sec" style="WIDTH: 50px">
                                        <option value=0>00</option>
                                        <option value=1>01</option>
                                        <option value=2>02</option>
                                        <option value=3>03</option>
                                        <option value=4>04</option>
                                        <option value=5>05</option>
                                        <option value=6>06</option>
                                        <option value=7>07</option>
                                        <option value=8>08</option>
                                        <option value=9>09</option>
                                        <option value=10>10</option>
                                        <option value=11>11</option>
                                        <option value=12>12</option>
                                        <option value=13>13</option>
                                        <option value=14>14</option>
                                        <option value=15>15</option>
                                        <option value=16>16</option>
                                        <option value=17>17</option>
                                        <option value=18>18</option>
                                        <option value=19>19</option>
                                        <option value=20>20</option>
                                        <option value=21>21</option>
                                        <option value=22>22</option>
                                        <option value=23>23</option>
                                        <option value=24>24</option>
                                        <option value=25>25</option>
                                        <option value=26>26</option>
                                        <option value=27>27</option>
                                        <option value=28>28</option>
                                        <option value=29>29</option>
                                        <option value=30>30</option>
                                        <option value=31>31</option>
                                        <option value=32>32</option>
                                        <option value=33>33</option>
                                        <option value=34>34</option>
                                        <option value=35>35</option>
                                        <option value=36>36</option>
                                        <option value=37>37</option>
                                        <option value=38>38</option>
                                        <option value=39>39</option>
                                        <option value=40>40</option>
                                        <option value=41>41</option>
                                        <option value=42>42</option>
                                        <option value=43>43</option>
                                        <option value=44>44</option>
                                        <option value=45>45</option>
                                        <option value=46>46</option>
                                        <option value=47>47</option>
                                        <option value=48>48</option>
                                        <option value=49>49</option>
                                        <option value=50>50</option>
                                        <option value=51>51</option>
                                        <option value=52>52</option>
                                        <option value=53>53</option>
                                        <option value=54>54</option>
                                        <option value=55>55</option>
                                        <option value=56>56</option>
                                        <option value=57>57</option>
                                        <option value=58>58</option>
                                        <option value=59>59</option>
                                      </select>
                                    </font></td>
									<td>
									  <select id="ampm" name="ampm">
									  	<option value="0"><script>show_words(which_lang[_AM])</script></option>
										<option value="1"><script>show_words(which_lang[_PM])</script></option>
									  </select>
									</td>
                                  </tr>
								  <tr>
								  	<td class="duple"></td>
								  	
                          <td colspan="7"> 
                            <input name="clone" id="clone" type="button" value="" onClick="set_time()"></td>
							<script>get_by_id("clone").value = which_lang[tt_CopyTime];</script>
								  </tr>
                                </tbody>
                              </table>
                            </td>
                          </tr>
                        </tbody>
                      </table>
                  </div>
				</div></td></form>
				<form id="form2" name="form2" method="post" action="system_time.cgi">
				<input type="hidden" name="html_response_return_page" value="tools_time.asp">
				</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  
          <td id="help_text"> <strong> 
            <script>show_words(which_lang[_hints])</script>
            &hellip;</strong> <p>
              <script>show_words(which_lang[hhtt_intro])</script>
            </p>
							<p><a href="support_tools.asp#Time" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
	show_time();
	get_time();
	STime();
	set_form_default_values("form1");
</script>
</html>