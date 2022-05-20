﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
var rule_max_num = 10;
var vs_rule_max = 24;
var inbound_used = 3;
var rand_pass = "WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG";
var DataArray = new Array();
var ori_inbound_filter;
var ori_management_port;
var ori_hostname;

	function onPageLoad()
	{
		set_checked("<% CmoGetCfg("remote_http_management_enable","none"); %>", get_by_id("remote_enable"));
		set_checked("<% CmoGetCfg("graph_auth_enable","none"); %>", get_by_id("graphical_enable"));		
		var show_selected = get_by_id("remote_http_management_inbound_filter").value;
		ori_inbound_filter = get_by_id("remote_http_management_inbound_filter").value;
		ori_management_port = get_by_id("remote_http_management_port").value;
		ori_hostname = get_by_id("hostname").value;
		get_by_id("remote_detail").value = get_by_id("remote_http_management_inbound_filter").value;
		if(get_by_id("remote_http_management_inbound_filter").value !="Allow_All" && get_by_id("remote_http_management_inbound_filter").value !="Deny_All"){
			for(i=0;i<DataArray.length;i++){
				if(DataArray[i].Name == get_by_id("remote_http_management_inbound_filter").value){
					get_by_id("remote_detail").value = DataArray[i].sAction +","+ DataArray[i].Show_W;
					show_selected = i;
					break;
				}
			}
		}
		set_selectIndex(show_selected, get_by_id("remote_inbound_filter"));
		disable_obj();
		set_form_default_values("form1");
	}
	
	function disable_obj(){
		get_by_id("remote_http_management_port").disabled = !get_by_id("remote_enable").checked;
		get_by_id("remote_inbound_filter").disabled = !get_by_id("remote_enable").checked;
	}
	
	//name/action/used(vs/port/wan/remote)
	function Data(name, action, used, onList) 
	{
		this.Name = name;
		this.Used = used;
		this.Show_W = "";
		this.OnList = onList;
		var sActionW = "Allow All"
		if(action =="deny"){
			sActionW = "Deny";
		}
		this.sAction = sActionW;
	}
	
	function set_Inbound(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_st;
			var temp_A;
			var temp_B;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("inbound_filter_name_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[0] != ""){
					DataArray[DataArray.length++] = new Data(temp_st[0], temp_st[1], temp_st[2], index);
					temp_A = get_by_id("inbound_filter_ip_"+ k +"_A").value.split(",");
					for(j=0;j<temp_A.length;j++){
						var temp_A_e = temp_A[j].split("/");
						var temp_A_ip = temp_A_e[1].split("-");
						if(temp_A_e[0] == "1"){
							var T_IP_R = temp_A_e[1];
							if(temp_A_e[1] == "0.0.0.0-255.255.255.255"){
								T_IP_R = "*";
							}else if(temp_A_ip[0] == temp_A_ip[1]){
								T_IP_R = temp_A_ip[0];
							}
							if(DataArray[index].Show_W !=""){
								DataArray[index].Show_W = DataArray[index].Show_W + ",";
							}
							DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
						}
					}
					temp_B = get_by_id("inbound_filter_ip_"+ k +"_B").value.split(",");
					for(j=0;j<temp_B.length;j++){
						var temp_B_e = temp_B[j].split("/");
						var temp_B_ip = temp_B_e[1].split("-");
						if(temp_B_e[0] == "1"){
							var T_IP_R = temp_B_e[1];
							if(temp_B_e[1] == "0.0.0.0-255.255.255.255"){
								T_IP_R = "*";
							}else if(temp_B_ip[0] == temp_B_ip[1]){
								T_IP_R = temp_B_ip[0];
							}
							if(DataArray[index].Show_W !=""){
								DataArray[index].Show_W = DataArray[index].Show_W + ",";
							}
							DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
						}
					}
					load_inbound_used(k, temp_st, inbound_used);
					index++;
				}
			}
		}
	}
	
	function show_option_value(){
		for(i=0;i<DataArray.length;i++){
			document.write("<option value=\""+ DataArray[i].OnList +"\">"+ DataArray[i].Name +"</option>");
		}
	}

	function send_request(){
		//if (!is_form_modified("form1") && !confirm("Nothing has changed, save anyway?")) {
		if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
			return false;
		}
		var remote_enable = get_by_id("remote_enable");
		var remote_port = get_by_id("remote_http_management_port").value;
    	var remote_port_msg = replace_msg(check_num_msg, which_lang[ta_RAP], 1, 65535);
    	var remote_port_obj = new varible_obj(remote_port, remote_port_msg, 1, 65535, false);
	    var c_hostname=get_by_id("hostname").value;
		
		if (get_by_id("admin_password1").value != get_by_id("admPass2").value){
			//alert(msg[ADMIN_PASS_ERROR]);
			alert(which_lang[YM173]);
		}else if (get_by_id("user_password1").value != get_by_id("usrPass2").value){
			//alert(msg[USER_PASS_ERROR]);
			alert(which_lang[YM174]);
		}else if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/")){
			//alert("Host name invalid. the legal characters can not enter ',/,''");
			alert(which_lang[DDNS_HOST_ERROR]);
		}else{ 
			if(get_by_id("remote_enable").checked){
				if (!check_varible(remote_port_obj)){
					return false;
				}
			}
			
		if(get_by_id("remote_http_management_enable").value != get_checked_value(get_by_id("remote_enable")))
		{
			get_by_id("remote_http_management_enable").value = get_checked_value(get_by_id("remote_enable"));
			get_by_id("reboot_type").value = "filter";
		}
				
		if(get_by_id("remote_http_management_port").value != ori_management_port)
		{
			get_by_id("reboot_type").value = "filter";
		}
		
		if(get_by_id("remote_http_management_inbound_filter").value != ori_inbound_filter)
		{
			get_by_id("reboot_type").value = "filter";
		}
		
		if(get_by_id("hostname").value != ori_hostname)
		{
			get_by_id("reboot_type").value = "all";
		}
				
			for(var i = 0; i < vs_rule_max; i++){
			//check virtual server public port and remote management port conflict problem
				if(get_by_id("vs_rule_" + i).value != ""){
					var vs_rule = (get_by_id("vs_rule_" + i).value).split("/");
					if(vs_rule[3] != "" && vs_rule[0] == "1" ){
						if(!check_multi_port(remote_port, vs_rule[3])){
						//alert("Remote Management HTTP port conflict with Virtual Server Public port.");	
						alert(which_lang[av_alert_12]);	
						return false;
						}
					}
				}
			//check port forwarding tcp port and remote management port conflict problem
				if(get_by_id("port_forward_both_" + i).value != ""){
					var pf_rule = (get_by_id("port_forward_both_" + i).value).split("/");
					if(pf_rule[3] != "" && pf_rule[0] == "1" ){
						if(!check_multi_port(remote_port, pf_rule[3])){
						//alert("Remote Management HTTP port conflict with Port Forwarding TCP port.");	
						alert(which_lang[tool_admin_portconflict]+which_lang[tool_admin_pfname]+pf_rule[1]+which_lang[tool_admin_check]);	
						return false;
						}
					}
				}
			//check application firewall port and remote management port conflict problem
				if (i > 9){
						temp_appl = get_by_id("application_" + i).value;
					}else{
						temp_appl = get_by_id("application_0" + i).value;				
					}
				if(temp_appl != ""){
					var app_rule = temp_appl.split("/");
					if(app_rule[5] != "" && app_rule[0] == "1" ){
						if(!check_multi_port(remote_port, app_rule[5])){
						//alert("Remote Management HTTP port conflict with Application Firewall port.");	
						alert(which_lang[tool_admin_portconflict]+"与运用防火墙端口相冲突.");	
						return false;
						}
					}
				}
			}
			
			get_by_id("remote_http_management_enable").value = get_checked_value(get_by_id("remote_enable"));
			get_by_id("graph_auth_enable").value = get_checked_value(get_by_id("graphical_enable"));
								
			if (get_by_id("admin_password").value != rand_pass || get_by_id("user_password").value != rand_pass) {
				get_by_id("html_response_return_page").value = "login.asp";
			}
			
			save_inbound_used(get_by_id("remote_http_management_inbound_filter").value, inbound_used);
			
			if(submit_button_flag == 0){
				submit_button_flag = 1;
				return true;
			}else{
				return false;
			}
		}
		return false;
	}
	
	function inbound_filter_name_selector(obj_value){
		if(obj_value != "Allow_All" && obj_value != "Deny_All"){
			get_by_id("remote_http_management_inbound_filter").value = DataArray[obj_value].Name;
			get_by_id("remote_detail").value = DataArray[obj_value].sAction +","+ DataArray[obj_value].Show_W;
		}else{
			get_by_id("remote_http_management_inbound_filter").value = obj_value;
			get_by_id("remote_detail").value = obj_value;
		}
	}
</script>
<title>D-Link公司 | 无线路由器 | 主页</title>

<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
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
								<ul>
									<li><div id="sidenavoff"><script>show_words(which_lang[_admin])</script></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(which_lang[_time])</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(which_lang[_syslog])</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(which_lang[_email])</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(which_lang[_system])</script></a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(which_lang[_firmware])</script></a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(which_lang[_dyndns])</script></a></div></li>
								  	<li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(which_lang[_syscheck])</script></a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(which_lang[_scheds])</script></a></div></li>
								</ul>
								 </div>
						</td>			
					</tr>
				</table>			
			</td>
                <input type="hidden" id="vs_rule_0" name="vs_rule_0" value="<% CmoGetCfg("vs_rule_00","none"); %>">
                <input type="hidden" id="vs_rule_1" name="vs_rule_1" value="<% CmoGetCfg("vs_rule_01","none"); %>">
                <input type="hidden" id="vs_rule_2" name="vs_rule_2" value="<% CmoGetCfg("vs_rule_02","none"); %>">
                <input type="hidden" id="vs_rule_3" name="vs_rule_3" value="<% CmoGetCfg("vs_rule_03","none"); %>">
                <input type="hidden" id="vs_rule_4" name="vs_rule_4" value="<% CmoGetCfg("vs_rule_04","none"); %>">
                <input type="hidden" id="vs_rule_5" name="vs_rule_5" value="<% CmoGetCfg("vs_rule_05","none"); %>">
                <input type="hidden" id="vs_rule_6" name="vs_rule_6" value="<% CmoGetCfg("vs_rule_06","none"); %>">
                <input type="hidden" id="vs_rule_7" name="vs_rule_7" value="<% CmoGetCfg("vs_rule_07","none"); %>">
                <input type="hidden" id="vs_rule_8" name="vs_rule_8" value="<% CmoGetCfg("vs_rule_08","none"); %>">
                <input type="hidden" id="vs_rule_9" name="vs_rule_9" value="<% CmoGetCfg("vs_rule_09","none"); %>">
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
				<input type="hidden" id="vs_rule_24" name="vs_rule_24" value="<% CmoGetCfg("vs_rule_24","none"); %>">

            <input type="hidden" id="port_forward_both_0" name="port_forward_both_0" value="<% CmoGetCfg("port_forward_both_00","none"); %>">
            <input type="hidden" id="port_forward_both_1" name="port_forward_both_1" value="<% CmoGetCfg("port_forward_both_01","none"); %>">
            <input type="hidden" id="port_forward_both_2" name="port_forward_both_2" value="<% CmoGetCfg("port_forward_both_02","none"); %>">
            <input type="hidden" id="port_forward_both_3" name="port_forward_both_3" value="<% CmoGetCfg("port_forward_both_03","none"); %>">
            <input type="hidden" id="port_forward_both_4" name="port_forward_both_4" value="<% CmoGetCfg("port_forward_both_04","none"); %>">
            <input type="hidden" id="port_forward_both_5" name="port_forward_both_5" value="<% CmoGetCfg("port_forward_both_05","none"); %>">
            <input type="hidden" id="port_forward_both_6" name="port_forward_both_6" value="<% CmoGetCfg("port_forward_both_06","none"); %>">
            <input type="hidden" id="port_forward_both_7" name="port_forward_both_7" value="<% CmoGetCfg("port_forward_both_07","none"); %>">
            <input type="hidden" id="port_forward_both_8" name="port_forward_both_8" value="<% CmoGetCfg("port_forward_both_08","none"); %>">
            <input type="hidden" id="port_forward_both_9" name="port_forward_both_9" value="<% CmoGetCfg("port_forward_both_09","none"); %>">
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
			<input type="hidden" id="port_forward_both_24" name="port_forward_both_24" value="<% CmoGetCfg("port_forward_both_24","none"); %>">

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

            <input type="hidden" id="inbound_filter_ip_00_A" name="inbound_filter_ip_00_A" value="<% CmoGetCfg("inbound_filter_ip_00_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_01_A" name="inbound_filter_ip_01_A" value="<% CmoGetCfg("inbound_filter_ip_01_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_02_A" name="inbound_filter_ip_02_A" value="<% CmoGetCfg("inbound_filter_ip_02_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_03_A" name="inbound_filter_ip_03_A" value="<% CmoGetCfg("inbound_filter_ip_03_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_04_A" name="inbound_filter_ip_04_A" value="<% CmoGetCfg("inbound_filter_ip_04_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_05_A" name="inbound_filter_ip_05_A" value="<% CmoGetCfg("inbound_filter_ip_05_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_06_A" name="inbound_filter_ip_06_A" value="<% CmoGetCfg("inbound_filter_ip_06_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_07_A" name="inbound_filter_ip_07_A" value="<% CmoGetCfg("inbound_filter_ip_07_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_08_A" name="inbound_filter_ip_08_A" value="<% CmoGetCfg("inbound_filter_ip_08_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_09_A" name="inbound_filter_ip_09_A" value="<% CmoGetCfg("inbound_filter_ip_09_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_10_A" name="inbound_filter_ip_10_A" value="<% CmoGetCfg("inbound_filter_ip_10_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_11_A" name="inbound_filter_ip_11_A" value="<% CmoGetCfg("inbound_filter_ip_11_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_12_A" name="inbound_filter_ip_12_A" value="<% CmoGetCfg("inbound_filter_ip_12_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_13_A" name="inbound_filter_ip_13_A" value="<% CmoGetCfg("inbound_filter_ip_13_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_14_A" name="inbound_filter_ip_14_A" value="<% CmoGetCfg("inbound_filter_ip_14_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_15_A" name="inbound_filter_ip_15_A" value="<% CmoGetCfg("inbound_filter_ip_15_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_16_A" name="inbound_filter_ip_16_A" value="<% CmoGetCfg("inbound_filter_ip_16_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_17_A" name="inbound_filter_ip_17_A" value="<% CmoGetCfg("inbound_filter_ip_17_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_18_A" name="inbound_filter_ip_18_A" value="<% CmoGetCfg("inbound_filter_ip_18_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_19_A" name="inbound_filter_ip_19_A" value="<% CmoGetCfg("inbound_filter_ip_19_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_20_A" name="inbound_filter_ip_20_A" value="<% CmoGetCfg("inbound_filter_ip_20_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_21_A" name="inbound_filter_ip_21_A" value="<% CmoGetCfg("inbound_filter_ip_21_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_22_A" name="inbound_filter_ip_22_A" value="<% CmoGetCfg("inbound_filter_ip_22_A","none"); %>">
            <input type="hidden" id="inbound_filter_ip_23_A" name="inbound_filter_ip_23_A" value="<% CmoGetCfg("inbound_filter_ip_23_A","none"); %>">
            
            <input type="hidden" id="inbound_filter_ip_00_B" name="inbound_filter_ip_00_B" value="<% CmoGetCfg("inbound_filter_ip_00_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_01_B" name="inbound_filter_ip_01_B" value="<% CmoGetCfg("inbound_filter_ip_01_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_02_B" name="inbound_filter_ip_02_B" value="<% CmoGetCfg("inbound_filter_ip_02_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_03_B" name="inbound_filter_ip_03_B" value="<% CmoGetCfg("inbound_filter_ip_03_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_04_B" name="inbound_filter_ip_04_B" value="<% CmoGetCfg("inbound_filter_ip_04_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_05_B" name="inbound_filter_ip_05_B" value="<% CmoGetCfg("inbound_filter_ip_05_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_06_B" name="inbound_filter_ip_06_B" value="<% CmoGetCfg("inbound_filter_ip_06_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_07_B" name="inbound_filter_ip_07_B" value="<% CmoGetCfg("inbound_filter_ip_07_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_08_B" name="inbound_filter_ip_08_B" value="<% CmoGetCfg("inbound_filter_ip_08_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_09_B" name="inbound_filter_ip_09_B" value="<% CmoGetCfg("inbound_filter_ip_09_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_10_B" name="inbound_filter_ip_10_B" value="<% CmoGetCfg("inbound_filter_ip_10_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_11_B" name="inbound_filter_ip_11_B" value="<% CmoGetCfg("inbound_filter_ip_11_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_12_B" name="inbound_filter_ip_12_B" value="<% CmoGetCfg("inbound_filter_ip_12_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_13_B" name="inbound_filter_ip_13_B" value="<% CmoGetCfg("inbound_filter_ip_13_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_14_B" name="inbound_filter_ip_14_B" value="<% CmoGetCfg("inbound_filter_ip_14_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_15_B" name="inbound_filter_ip_15_B" value="<% CmoGetCfg("inbound_filter_ip_15_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_16_B" name="inbound_filter_ip_16_B" value="<% CmoGetCfg("inbound_filter_ip_16_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_17_B" name="inbound_filter_ip_17_B" value="<% CmoGetCfg("inbound_filter_ip_17_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_18_B" name="inbound_filter_ip_18_B" value="<% CmoGetCfg("inbound_filter_ip_18_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_19_B" name="inbound_filter_ip_19_B" value="<% CmoGetCfg("inbound_filter_ip_19_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_20_B" name="inbound_filter_ip_20_B" value="<% CmoGetCfg("inbound_filter_ip_20_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_21_B" name="inbound_filter_ip_21_B" value="<% CmoGetCfg("inbound_filter_ip_21_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_22_B" name="inbound_filter_ip_22_B" value="<% CmoGetCfg("inbound_filter_ip_22_B","none"); %>">
            <input type="hidden" id="inbound_filter_ip_23_B" name="inbound_filter_ip_23_B" value="<% CmoGetCfg("inbound_filter_ip_23_B","none"); %>">
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_admin.asp">
	<input type="hidden" id="reboot_type" name="reboot_type" value="none">			
				<input type="hidden" id="inbound_filter_name_00" name="inbound_filter_name_00" value="<% CmoGetCfg("inbound_filter_name_00","none"); %>">
        <input type="hidden" id="inbound_filter_name_01" name="inbound_filter_name_01" value="<% CmoGetCfg("inbound_filter_name_01","none"); %>">
        <input type="hidden" id="inbound_filter_name_02" name="inbound_filter_name_02" value="<% CmoGetCfg("inbound_filter_name_02","none"); %>">
        <input type="hidden" id="inbound_filter_name_03" name="inbound_filter_name_03" value="<% CmoGetCfg("inbound_filter_name_03","none"); %>">
        <input type="hidden" id="inbound_filter_name_04" name="inbound_filter_name_04" value="<% CmoGetCfg("inbound_filter_name_04","none"); %>">
        <input type="hidden" id="inbound_filter_name_05" name="inbound_filter_name_05" value="<% CmoGetCfg("inbound_filter_name_05","none"); %>">
        <input type="hidden" id="inbound_filter_name_06" name="inbound_filter_name_06" value="<% CmoGetCfg("inbound_filter_name_06","none"); %>">
        <input type="hidden" id="inbound_filter_name_07" name="inbound_filter_name_07" value="<% CmoGetCfg("inbound_filter_name_07","none"); %>">
        <input type="hidden" id="inbound_filter_name_08" name="inbound_filter_name_08" value="<% CmoGetCfg("inbound_filter_name_08","none"); %>">
        <input type="hidden" id="inbound_filter_name_09" name="inbound_filter_name_09" value="<% CmoGetCfg("inbound_filter_name_09","none"); %>">
        <input type="hidden" id="inbound_filter_name_10" name="inbound_filter_name_10" value="<% CmoGetCfg("inbound_filter_name_10","none"); %>">
        <input type="hidden" id="inbound_filter_name_11" name="inbound_filter_name_11" value="<% CmoGetCfg("inbound_filter_name_11","none"); %>">
        <input type="hidden" id="inbound_filter_name_12" name="inbound_filter_name_12" value="<% CmoGetCfg("inbound_filter_name_12","none"); %>">
        <input type="hidden" id="inbound_filter_name_13" name="inbound_filter_name_13" value="<% CmoGetCfg("inbound_filter_name_13","none"); %>">
        <input type="hidden" id="inbound_filter_name_14" name="inbound_filter_name_14" value="<% CmoGetCfg("inbound_filter_name_14","none"); %>">
        <input type="hidden" id="inbound_filter_name_15" name="inbound_filter_name_15" value="<% CmoGetCfg("inbound_filter_name_15","none"); %>">
        <input type="hidden" id="inbound_filter_name_16" name="inbound_filter_name_16" value="<% CmoGetCfg("inbound_filter_name_16","none"); %>">
        <input type="hidden" id="inbound_filter_name_17" name="inbound_filter_name_17" value="<% CmoGetCfg("inbound_filter_name_17","none"); %>">
        <input type="hidden" id="inbound_filter_name_18" name="inbound_filter_name_18" value="<% CmoGetCfg("inbound_filter_name_18","none"); %>">
        <input type="hidden" id="inbound_filter_name_19" name="inbound_filter_name_19" value="<% CmoGetCfg("inbound_filter_name_19","none"); %>">
        <input type="hidden" id="inbound_filter_name_20" name="inbound_filter_name_20" value="<% CmoGetCfg("inbound_filter_name_20","none"); %>">
        <input type="hidden" id="inbound_filter_name_21" name="inbound_filter_name_21" value="<% CmoGetCfg("inbound_filter_name_21","none"); %>">
        <input type="hidden" id="inbound_filter_name_22" name="inbound_filter_name_22" value="<% CmoGetCfg("inbound_filter_name_22","none"); %>">
        <input type="hidden" id="inbound_filter_name_23" name="inbound_filter_name_23" value="<% CmoGetCfg("inbound_filter_name_23","none"); %>">
				
			<td valign="top" id="maincontent_container">
				<div id="maincontent">	
					
          <div id="box_header"> 
            <h1> 
              <script>show_words(which_lang[ta_AdmSt])</script>
            </h1>
            <p> 
              <script>show_words(which_lang[ta_intro1])</script>
            </p>
						
            <p> 
              <script>show_words(which_lang[ta_intro_Adm2])</script>
            </p>
			<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
            <input name="button2" id="button2" type=button class=button_submit value="" onclick="page_cancel('form1', 'tools_admin.asp');">
            <script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
            <script>get_by_id("button").value = which_lang[_savesettings];</script>
			</div>
					
          <div class="box"> 
            <h2> 
              <script>show_words(which_lang[_password_admin])</script>
            </h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td colspan="2" class="box_msg"><p> 
                    <script>show_words(which_lang[ta_msg_TW])</script>
                  </p></td>
							</tr>
							<tr>
								
                <td class="duple"> 
                  <script>show_words(which_lang[_password])</script>
                  :</td>
									<input type="hidden" id="admin_password" name="admin_password" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type=password id="admin_password1" name="admin_password1" size=20 maxlength=15 value="WDB8WvbXdH" onChange="key_word(this,'admin_password');"></font>
								</td>
							</tr>
							<tr>
								
                <td class="duple"> 
                  <script>show_words(which_lang[_verifypw])</script>
                  :</td>
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type=password id=admPass2 name=admPass2 size=20 maxlength=15 value="WDB8WvbXdH"></font>
								</td>
							</tr>														
					  </table>
					</div>
					<div class="box">
						<h2><script>show_words(which_lang[_password_user])</script></h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td colspan="2" class="box_msg"><p> 
                    <script>show_words(which_lang[ta_msg_TW])</script>
                  </p></td>
							</tr>
							<tr>
								
                <td class="duple">
                  <script>show_words(which_lang[_password])</script>
                  :</td>
									<input type="hidden" id="user_password" name="user_password" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type=password id="user_password1" name="user_password1" size=20 maxlength=15 value="WDB8WvbXdH" onChange="key_word(this,'user_password');"></font>
								</td>
							</tr>
							<tr>
								
                <td class="duple">
                  <script>show_words(which_lang[_verifypw])</script>
                  :</td>
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type="password" id="usrPass2" name="usrPass2" size="20" maxlength="15" value="WDB8WvbXdH"></font>
								</td>
							</tr>														
					  </table>
					</div>
					
          <div class="box"> 
            <h2>
              <script>show_words(which_lang[ta_sn])</script>
            </h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								
                <td class="duple">
                  <script>show_words(which_lang[ta_GWN])</script>
                  :</td>
								<td width="340"><font face=Arial size=2>&nbsp;&nbsp;
                                    <input type="text" id="hostname" name="hostname" maxlength=32 value="<% CmoGetCfg("hostname","none"); %>"></font>
								</td>
							</tr>
					  </table>
					</div>
					
          <div class="box"> 
            <h2>
              <script>show_words(which_lang[ta_A12n])</script>
            </h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
                            <td class="duple">Enable Graphical Authentication :</td>
                            <td width="340"><div align="left">&nbsp;
                                    <input name="graphical_enable" type="checkbox" id="graphical_enable" value="1" checked>
                                    <input type="hidden" id="graph_auth_enable" name="graph_auth_enable" value="<% CmoGetCfg("graph_auth_enable","none"); %>">
                            </div></td>
                          </tr>
                          <tr>
								
                <td class="duple">
                  <script>show_words(which_lang[ta_ERM])</script>
                  :</td>
                            	<td width="340"><div align="left">&nbsp;
								<input name="remote_enable" type="checkbox" id="remote_enable" value="1" onClick="disable_obj();">
								<input type="hidden" id="remote_http_management_enable" name="remote_http_management_enable" value="<% CmoGetCfg("remote_http_management_enable","none"); %>"></div>
     							</td>
                          </tr>
                          <tr>
                            
                <td class="duple">
                  <script>show_words(which_lang[ta_RAP])</script>
                  :</td>
                            <td width="340"><div align="left">&nbsp;&nbsp;
								<input type="text" id="remote_http_management_port" name="remote_http_management_port" value="<% CmoGetCfg("remote_http_management_port","none"); %>">
                            </div></td>
                          </tr>
                          <tr>
                            
                <td class="duple"><script>show_words(which_lang[ta_RAIF])</script>
                   :</td>
                            <td width="340"><div align="left">&nbsp;&nbsp;
                            	<select id="remote_inbound_filter" name="remote_inbound_filter" size="1" onChange="inbound_filter_name_selector(this.value);">
                                	<option value="Allow_All"><script>show_words(which_lang[_allowall])</script></option>
                                    <option value="Deny_All"><script>show_words(which_lang[_denyall])</script></option>
                                    <script>
                                    set_Inbound();
                                    show_option_value();
                                    </script>
                                </select>
								<input type="hidden" id="remote_http_management_inbound_filter" name="remote_http_management_inbound_filter" value="<% CmoGetCfg("remote_http_management_inbound_filter","none"); %>">
                            </div></td>
                          </tr>
                          <tr>
                            
                <td class="duple">
                  <script>show_words(which_lang[_aa_details])</script>
                  :</td>
                            <td width="340"><div align="left">&nbsp;&nbsp;
                              <input type=text id="remote_detail" name="remote_detail" size=48 maxlength=48 disabled>
                            </div></td>
                          </tr>
                      </table>
					</div>
				</div>				
			</td>
			</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  
          <td id="help_text"> <strong> 
            <script>show_words(which_lang[_hints])</script>
            &hellip;</strong> <p>
              <script>show_words(which_lang[hhta_pw])</script>
            </p>
					  	
            <p>
              <script>show_words(which_lang[hhta_en])</script>
            </p>
						
            <p>
              <script>show_words(which_lang[hhta_pt])</script>
            </p>
						
            <p>
              <script>show_words(which_lang[hhta_831])</script>
            </p>
					  	
            <p><a href="support_tools.asp#Admin" onclick="return jump_if();">
              <script>show_words(which_lang[_more])</script>
             &hellip;</a></p>
					  </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
</script>
</html>