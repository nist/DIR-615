<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var rule_max_num = 15;
var DataArray = new Array();

	function onPageLoad(){
		set_checked("<% CmoGetCfg("access_control_filter_type","none"); %>", get_by_id("access_enable"));
		set_form_default_values("form1");
		set_form_default_values("form2");
		show_policy();
	}   	

	function Data(enable, name, machine, filter, logged, schedule, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Machine = machine;
		this.Filter = filter;
		this.Logged = logged;
		this.Schedule = schedule;
		this.OnList = onList;
	}

	function set_policy(){
		var temp_policy, name_list, count = 0;
		for (var i = 0; i < rule_max_num; i++){
			if(i < 10){
				temp_policy = (get_by_id("access_control_0" + i).value).split("/");
			}else{
				temp_policy = (get_by_id("access_control_" + i).value).split("/");
			}
			if (temp_policy.length > 1){
				DataArray[i] = new Data(temp_policy[0], temp_policy[1], temp_policy[2], temp_policy[3], temp_policy[4], temp_policy[5], i);
				if(i == 0){
					name_list = temp_policy[1];
				}else{
					name_list = name_list + "," + temp_policy[1];
				}
				count++;
			}
		}
		
		get_by_id("asp_temp_13").value = name_list;
		get_by_id("asp_temp_16").value = count;
	}

	function set_policy_enable(idx){
		if(confirm(msg[CHECK_ENABLE])){
			var temp_policy, policy;
			if(parseInt(idx) < 10){
				temp_policy = get_by_id("access_control_0" + idx);
			}else{
				temp_policy = get_by_id("access_control_" + idx);
			}
			var filter_type = (temp_policy.value).substring(0, 1);
			
			if(filter_type == "0"){
				temp_policy.value = "1" + (temp_policy.value).substring(1);
			}else{
				temp_policy.value = "0" + (temp_policy.value).substring(1);
			}
			send_submit("form1");
		}
	}

	function edit_row(idx){
		get_by_id("asp_temp_00").value = DataArray[idx].Name;
		get_by_id("asp_temp_01").value = DataArray[idx].Schedule;
		get_by_id("asp_temp_02").value = DataArray[idx].Machine;
		get_by_id("asp_temp_03").value = DataArray[idx].Filter;
		get_by_id("asp_temp_12").value = DataArray[idx].Logged;
		var start = idx * 8;
		var end = (idx + 1) * 8;
		var index = 4;
		for(var i = start; i < end; i++){
			if(i < 10){
				if(parseInt(index) < 10){
					get_by_id("asp_temp_0" + index).value = get_by_id("firewall_rule_0" + i).value
				}else{
					get_by_id("asp_temp_" + index).value = get_by_id("firewall_rule_0" + i).value
				}
			}else{
				if(parseInt(index) < 10){
					get_by_id("asp_temp_0" + index).value = get_by_id("firewall_rule_" + i).value
				}else{
					get_by_id("asp_temp_" + index).value = get_by_id("firewall_rule_" + i).value
				}
			}
			index++;
		}

		get_by_id("asp_temp_14").value = idx;
		get_by_id("html_response_page").value = "adv_access_add1.asp";
		get_by_id("html_response_return_page").value = "adv_access_add1.asp";
		send_submit("form2");
	}

	function del_row(idx){
		if(confirm(msg[DEL_ENTRY_MSG])){
			delete_data(idx);
			send_submit("form1");
		}
	}

	function delete_data(idx){
		var num_next = parseInt(idx) + 1;

		//delete access_control entry
		for(var i = num_next; i < rule_max_num; i++){
			var pre_name, next_name, pre_firewall, next_firewall;
			
			if (i - 1 < 10){
				pre_name = "access_control_0" + (i-1);
			}else{
				pre_name = "access_control_" +  (i-1);
			}

			if (i < 10){
				next_name = "access_control_0" + i;
			}else{
				next_name = "access_control_" +  i;
			}
			get_by_id(pre_name).value = get_by_id(next_name).value;

			//delete firewall_rule entry
			var start = (i-1) * 8;
			var end = i * 8;
			for (var j = start; j < end; j++){
				if (j < 10){
					pre_firewall = "firewall_rule_0" + j;
				}else{
					pre_firewall = "firewall_rule_" + j;
				}

				if ((j + 8) < 10){
					next_firewall = "firewall_rule_0" + (j + 8);
				}else{
					next_firewall = "firewall_rule_" + (j + 8);
				}
				get_by_id(pre_firewall).value = get_by_id(next_firewall).value;
			}
		}
		get_by_id("access_control_14").value = "";
		for(var j = ((rule_max_num - 1) * 8); j < (rule_max_num * 8); j++){
			get_by_id("firewall_rule_" + j).value = "";
		}
	}
		
	function show_policy(){
		get_by_id("show_policy").style.display = "none";		
		get_by_id("show_table").style.display = "none";	
		if (get_by_id("access_enable").checked){
			get_by_id("show_policy").style.display = "";		
			get_by_id("show_table").style.display = "";	
		}
	}
	
	function send_next(){
		for(var i = 0; i < 13; i++){
			if(i < 10){
				get_by_id("asp_temp_0" + i).value = "";
			}else{
				get_by_id("asp_temp_" + i).value = "";
			}
		}
		get_by_id("asp_temp_14").value = "-1";
		get_by_id("html_response_page").value = "adv_access_add.asp";
		get_by_id("html_response_return_page").value = "adv_access_add.asp";
		send_submit("form2");
	}

	function send_request(){
			if (!is_form_modified("form1") && !is_form_modified("form2") && !confirm(msg[FORM_MODIFIED_CHECK])) {
			return false;
		}
		get_by_id("access_control_filter_type").value = get_checked_value(get_by_id("access_enable"));
			send_submit("form1");
	}
</script>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form2" name="form2" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page" name="html_response_page">
<input type="hidden" id="html_response_return_page" name="html_response_return_page">
<input type="hidden" id="reboot_type" name="reboot_type" value="none">

<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="">	<!-- policy name -->
<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="">	<!-- schedule -->
<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="">	<!-- machine -->
<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="">	<!-- filter method -->
<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="">	<!-- firewall rule 1 -->
<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="">	<!-- firewall rule 2 -->
<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="">	<!-- firewall rule 3 -->
<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="">	<!-- firewall rule 4 -->
<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="">	<!-- firewall rule 5 -->
<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="">	<!-- firewall rule 6 -->
<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="">	<!-- firewall rule 7 -->
<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="">	<!-- firewall rule 8 -->
<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="">	<!-- logging -->
<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="">	<!-- policy name list -->
<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="">	<!-- edit_row -->
<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="">	<!-- prev_page -->
<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="">	<!-- max_row -->

</form>
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
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
			<td height="29"><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();">Setup</a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();">Advanced</a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();">Tools</a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();">Status</a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();">Support</a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <LI><div><a href="adv_virtual.asp" onclick="return jump_if();">Virtual Server</a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();">Port Forwarding</a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();">Application Rules</a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();">QOS Engine</a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();">Network Filter</a></div></LI>
                            <LI><div id=sidenavoff>Access control</div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();">Website Filter</a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();">Inbound Filter</a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();">Firewall Settings</a></div></LI>
							<LI><div><a href="adv_routing.asp" onclick="return jump_if();">Routing</a></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();">Advanced Wireless </a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();">Advanced Network </a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @> 
                          </UL>
                      	</div>
					  </td>
                    </tr>
                </table>
			</td>

        <form id="form1" name="form1" method="post" action="apply.cgi">
	    <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
	    <input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
	    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_control.asp">
	    <input type="hidden" id="reboot_type" name="reboot_type" value="filter">
		<input type="hidden" id="access_control_filter_type" name="access_control_filter_type" value="<% CmoGetCfg("access_control_filter_type","none"); %>">

		<input type="hidden" id="access_control_00" name="access_control_00" value="<% CmoGetCfg("access_control_00","none"); %>">
		<input type="hidden" id="access_control_01" name="access_control_01" value="<% CmoGetCfg("access_control_01","none"); %>">
		<input type="hidden" id="access_control_02" name="access_control_02" value="<% CmoGetCfg("access_control_02","none"); %>">
		<input type="hidden" id="access_control_03" name="access_control_03" value="<% CmoGetCfg("access_control_03","none"); %>">
		<input type="hidden" id="access_control_04" name="access_control_04" value="<% CmoGetCfg("access_control_04","none"); %>">
		<input type="hidden" id="access_control_05" name="access_control_05" value="<% CmoGetCfg("access_control_05","none"); %>">
		<input type="hidden" id="access_control_06" name="access_control_06" value="<% CmoGetCfg("access_control_06","none"); %>">
		<input type="hidden" id="access_control_07" name="access_control_07" value="<% CmoGetCfg("access_control_07","none"); %>">
		<input type="hidden" id="access_control_08" name="access_control_08" value="<% CmoGetCfg("access_control_08","none"); %>">
		<input type="hidden" id="access_control_09" name="access_control_09" value="<% CmoGetCfg("access_control_09","none"); %>">
		<input type="hidden" id="access_control_10" name="access_control_10" value="<% CmoGetCfg("access_control_10","none"); %>">
		<input type="hidden" id="access_control_11" name="access_control_11" value="<% CmoGetCfg("access_control_11","none"); %>">
		<input type="hidden" id="access_control_12" name="access_control_12" value="<% CmoGetCfg("access_control_12","none"); %>">
		<input type="hidden" id="access_control_13" name="access_control_13" value="<% CmoGetCfg("access_control_13","none"); %>">
		<input type="hidden" id="access_control_14" name="access_control_14" value="<% CmoGetCfg("access_control_14","none"); %>">

		<input type="hidden" id="firewall_rule_00" name="firewall_rule_00" value="<% CmoGetCfg("firewall_rule_00","none"); %>">
		<input type="hidden" id="firewall_rule_01" name="firewall_rule_01" value="<% CmoGetCfg("firewall_rule_01","none"); %>">
		<input type="hidden" id="firewall_rule_02" name="firewall_rule_02" value="<% CmoGetCfg("firewall_rule_02","none"); %>">
		<input type="hidden" id="firewall_rule_03" name="firewall_rule_03" value="<% CmoGetCfg("firewall_rule_03","none"); %>">
		<input type="hidden" id="firewall_rule_04" name="firewall_rule_04" value="<% CmoGetCfg("firewall_rule_04","none"); %>">
		<input type="hidden" id="firewall_rule_05" name="firewall_rule_05" value="<% CmoGetCfg("firewall_rule_05","none"); %>">
		<input type="hidden" id="firewall_rule_06" name="firewall_rule_06" value="<% CmoGetCfg("firewall_rule_06","none"); %>">
		<input type="hidden" id="firewall_rule_07" name="firewall_rule_07" value="<% CmoGetCfg("firewall_rule_07","none"); %>">
		
		<input type="hidden" id="firewall_rule_08" name="firewall_rule_08" value="<% CmoGetCfg("firewall_rule_08","none"); %>">
		<input type="hidden" id="firewall_rule_09" name="firewall_rule_09" value="<% CmoGetCfg("firewall_rule_09","none"); %>">
		<input type="hidden" id="firewall_rule_10" name="firewall_rule_10" value="<% CmoGetCfg("firewall_rule_10","none"); %>">
		<input type="hidden" id="firewall_rule_11" name="firewall_rule_11" value="<% CmoGetCfg("firewall_rule_11","none"); %>">
		<input type="hidden" id="firewall_rule_12" name="firewall_rule_12" value="<% CmoGetCfg("firewall_rule_12","none"); %>">
		<input type="hidden" id="firewall_rule_13" name="firewall_rule_13" value="<% CmoGetCfg("firewall_rule_13","none"); %>">
		<input type="hidden" id="firewall_rule_14" name="firewall_rule_14" value="<% CmoGetCfg("firewall_rule_14","none"); %>">
		<input type="hidden" id="firewall_rule_15" name="firewall_rule_15" value="<% CmoGetCfg("firewall_rule_15","none"); %>">
		
		<input type="hidden" id="firewall_rule_16" name="firewall_rule_16" value="<% CmoGetCfg("firewall_rule_16","none"); %>">
		<input type="hidden" id="firewall_rule_17" name="firewall_rule_17" value="<% CmoGetCfg("firewall_rule_17","none"); %>">
		<input type="hidden" id="firewall_rule_18" name="firewall_rule_18" value="<% CmoGetCfg("firewall_rule_18","none"); %>">
		<input type="hidden" id="firewall_rule_19" name="firewall_rule_19" value="<% CmoGetCfg("firewall_rule_19","none"); %>">
		<input type="hidden" id="firewall_rule_20" name="firewall_rule_20" value="<% CmoGetCfg("firewall_rule_20","none"); %>">
		<input type="hidden" id="firewall_rule_21" name="firewall_rule_21" value="<% CmoGetCfg("firewall_rule_21","none"); %>">
		<input type="hidden" id="firewall_rule_22" name="firewall_rule_22" value="<% CmoGetCfg("firewall_rule_22","none"); %>">
		<input type="hidden" id="firewall_rule_23" name="firewall_rule_23" value="<% CmoGetCfg("firewall_rule_23","none"); %>">
		
		<input type="hidden" id="firewall_rule_24" name="firewall_rule_24" value="<% CmoGetCfg("firewall_rule_24","none"); %>">
		<input type="hidden" id="firewall_rule_25" name="firewall_rule_25" value="<% CmoGetCfg("firewall_rule_25","none"); %>">
		<input type="hidden" id="firewall_rule_26" name="firewall_rule_26" value="<% CmoGetCfg("firewall_rule_26","none"); %>">
		<input type="hidden" id="firewall_rule_27" name="firewall_rule_27" value="<% CmoGetCfg("firewall_rule_27","none"); %>">
		<input type="hidden" id="firewall_rule_28" name="firewall_rule_28" value="<% CmoGetCfg("firewall_rule_28","none"); %>">
		<input type="hidden" id="firewall_rule_29" name="firewall_rule_29" value="<% CmoGetCfg("firewall_rule_29","none"); %>">
		<input type="hidden" id="firewall_rule_30" name="firewall_rule_30" value="<% CmoGetCfg("firewall_rule_30","none"); %>">
		<input type="hidden" id="firewall_rule_31" name="firewall_rule_31" value="<% CmoGetCfg("firewall_rule_31","none"); %>">
		
		<input type="hidden" id="firewall_rule_32" name="firewall_rule_32" value="<% CmoGetCfg("firewall_rule_32","none"); %>">
		<input type="hidden" id="firewall_rule_33" name="firewall_rule_33" value="<% CmoGetCfg("firewall_rule_33","none"); %>">
		<input type="hidden" id="firewall_rule_34" name="firewall_rule_34" value="<% CmoGetCfg("firewall_rule_34","none"); %>">
		<input type="hidden" id="firewall_rule_35" name="firewall_rule_35" value="<% CmoGetCfg("firewall_rule_35","none"); %>">
		<input type="hidden" id="firewall_rule_36" name="firewall_rule_36" value="<% CmoGetCfg("firewall_rule_36","none"); %>">
		<input type="hidden" id="firewall_rule_37" name="firewall_rule_37" value="<% CmoGetCfg("firewall_rule_37","none"); %>">
		<input type="hidden" id="firewall_rule_38" name="firewall_rule_38" value="<% CmoGetCfg("firewall_rule_38","none"); %>">
		<input type="hidden" id="firewall_rule_39" name="firewall_rule_39" value="<% CmoGetCfg("firewall_rule_39","none"); %>">
		
		<input type="hidden" id="firewall_rule_40" name="firewall_rule_40" value="<% CmoGetCfg("firewall_rule_40","none"); %>">
		<input type="hidden" id="firewall_rule_41" name="firewall_rule_41" value="<% CmoGetCfg("firewall_rule_41","none"); %>">
		<input type="hidden" id="firewall_rule_42" name="firewall_rule_42" value="<% CmoGetCfg("firewall_rule_42","none"); %>">
		<input type="hidden" id="firewall_rule_43" name="firewall_rule_43" value="<% CmoGetCfg("firewall_rule_43","none"); %>">
		<input type="hidden" id="firewall_rule_44" name="firewall_rule_44" value="<% CmoGetCfg("firewall_rule_44","none"); %>">
		<input type="hidden" id="firewall_rule_45" name="firewall_rule_45" value="<% CmoGetCfg("firewall_rule_45","none"); %>">
		<input type="hidden" id="firewall_rule_46" name="firewall_rule_46" value="<% CmoGetCfg("firewall_rule_46","none"); %>">
		<input type="hidden" id="firewall_rule_47" name="firewall_rule_47" value="<% CmoGetCfg("firewall_rule_47","none"); %>">
		
		<input type="hidden" id="firewall_rule_48" name="firewall_rule_48" value="<% CmoGetCfg("firewall_rule_48","none"); %>">
		<input type="hidden" id="firewall_rule_49" name="firewall_rule_49" value="<% CmoGetCfg("firewall_rule_49","none"); %>">
		<input type="hidden" id="firewall_rule_50" name="firewall_rule_50" value="<% CmoGetCfg("firewall_rule_50","none"); %>">
		<input type="hidden" id="firewall_rule_51" name="firewall_rule_51" value="<% CmoGetCfg("firewall_rule_51","none"); %>">
		<input type="hidden" id="firewall_rule_52" name="firewall_rule_52" value="<% CmoGetCfg("firewall_rule_52","none"); %>">
		<input type="hidden" id="firewall_rule_53" name="firewall_rule_53" value="<% CmoGetCfg("firewall_rule_53","none"); %>">
		<input type="hidden" id="firewall_rule_54" name="firewall_rule_54" value="<% CmoGetCfg("firewall_rule_54","none"); %>">
		<input type="hidden" id="firewall_rule_55" name="firewall_rule_55" value="<% CmoGetCfg("firewall_rule_55","none"); %>">
		
		<input type="hidden" id="firewall_rule_56" name="firewall_rule_56" value="<% CmoGetCfg("firewall_rule_56","none"); %>">
		<input type="hidden" id="firewall_rule_57" name="firewall_rule_57" value="<% CmoGetCfg("firewall_rule_57","none"); %>">
		<input type="hidden" id="firewall_rule_58" name="firewall_rule_58" value="<% CmoGetCfg("firewall_rule_58","none"); %>">
		<input type="hidden" id="firewall_rule_59" name="firewall_rule_59" value="<% CmoGetCfg("firewall_rule_59","none"); %>">
		<input type="hidden" id="firewall_rule_60" name="firewall_rule_60" value="<% CmoGetCfg("firewall_rule_60","none"); %>">
		<input type="hidden" id="firewall_rule_61" name="firewall_rule_61" value="<% CmoGetCfg("firewall_rule_61","none"); %>">
		<input type="hidden" id="firewall_rule_62" name="firewall_rule_62" value="<% CmoGetCfg("firewall_rule_62","none"); %>">
		<input type="hidden" id="firewall_rule_63" name="firewall_rule_63" value="<% CmoGetCfg("firewall_rule_63","none"); %>">
		
		<input type="hidden" id="firewall_rule_64" name="firewall_rule_64" value="<% CmoGetCfg("firewall_rule_64","none"); %>">
		<input type="hidden" id="firewall_rule_65" name="firewall_rule_65" value="<% CmoGetCfg("firewall_rule_65","none"); %>">
		<input type="hidden" id="firewall_rule_66" name="firewall_rule_66" value="<% CmoGetCfg("firewall_rule_66","none"); %>">
		<input type="hidden" id="firewall_rule_67" name="firewall_rule_67" value="<% CmoGetCfg("firewall_rule_67","none"); %>">
		<input type="hidden" id="firewall_rule_68" name="firewall_rule_68" value="<% CmoGetCfg("firewall_rule_68","none"); %>">
		<input type="hidden" id="firewall_rule_69" name="firewall_rule_69" value="<% CmoGetCfg("firewall_rule_69","none"); %>">
		<input type="hidden" id="firewall_rule_70" name="firewall_rule_70" value="<% CmoGetCfg("firewall_rule_70","none"); %>">
		<input type="hidden" id="firewall_rule_71" name="firewall_rule_71" value="<% CmoGetCfg("firewall_rule_71","none"); %>">
		
		<input type="hidden" id="firewall_rule_72" name="firewall_rule_72" value="<% CmoGetCfg("firewall_rule_72","none"); %>">
		<input type="hidden" id="firewall_rule_73" name="firewall_rule_73" value="<% CmoGetCfg("firewall_rule_73","none"); %>">
		<input type="hidden" id="firewall_rule_74" name="firewall_rule_74" value="<% CmoGetCfg("firewall_rule_74","none"); %>">
		<input type="hidden" id="firewall_rule_75" name="firewall_rule_75" value="<% CmoGetCfg("firewall_rule_75","none"); %>">
		<input type="hidden" id="firewall_rule_76" name="firewall_rule_76" value="<% CmoGetCfg("firewall_rule_76","none"); %>">
		<input type="hidden" id="firewall_rule_77" name="firewall_rule_77" value="<% CmoGetCfg("firewall_rule_77","none"); %>">
		<input type="hidden" id="firewall_rule_78" name="firewall_rule_78" value="<% CmoGetCfg("firewall_rule_78","none"); %>">
		<input type="hidden" id="firewall_rule_79" name="firewall_rule_79" value="<% CmoGetCfg("firewall_rule_79","none"); %>">
		
		<input type="hidden" id="firewall_rule_80" name="firewall_rule_80" value="<% CmoGetCfg("firewall_rule_80","none"); %>">
		<input type="hidden" id="firewall_rule_81" name="firewall_rule_81" value="<% CmoGetCfg("firewall_rule_81","none"); %>">
		<input type="hidden" id="firewall_rule_82" name="firewall_rule_82" value="<% CmoGetCfg("firewall_rule_82","none"); %>">
		<input type="hidden" id="firewall_rule_83" name="firewall_rule_83" value="<% CmoGetCfg("firewall_rule_83","none"); %>">
		<input type="hidden" id="firewall_rule_84" name="firewall_rule_84" value="<% CmoGetCfg("firewall_rule_84","none"); %>">
		<input type="hidden" id="firewall_rule_85" name="firewall_rule_85" value="<% CmoGetCfg("firewall_rule_85","none"); %>">
		<input type="hidden" id="firewall_rule_86" name="firewall_rule_86" value="<% CmoGetCfg("firewall_rule_86","none"); %>">
		<input type="hidden" id="firewall_rule_87" name="firewall_rule_87" value="<% CmoGetCfg("firewall_rule_87","none"); %>">
		
		<input type="hidden" id="firewall_rule_88" name="firewall_rule_88" value="<% CmoGetCfg("firewall_rule_88","none"); %>">
		<input type="hidden" id="firewall_rule_89" name="firewall_rule_89" value="<% CmoGetCfg("firewall_rule_89","none"); %>">
		<input type="hidden" id="firewall_rule_90" name="firewall_rule_90" value="<% CmoGetCfg("firewall_rule_90","none"); %>">
		<input type="hidden" id="firewall_rule_91" name="firewall_rule_91" value="<% CmoGetCfg("firewall_rule_91","none"); %>">
		<input type="hidden" id="firewall_rule_92" name="firewall_rule_92" value="<% CmoGetCfg("firewall_rule_92","none"); %>">
		<input type="hidden" id="firewall_rule_93" name="firewall_rule_93" value="<% CmoGetCfg("firewall_rule_93","none"); %>">
		<input type="hidden" id="firewall_rule_94" name="firewall_rule_94" value="<% CmoGetCfg("firewall_rule_94","none"); %>">
		<input type="hidden" id="firewall_rule_95" name="firewall_rule_95" value="<% CmoGetCfg("firewall_rule_95","none"); %>">
		
		<input type="hidden" id="firewall_rule_96" name="firewall_rule_96" value="<% CmoGetCfg("firewall_rule_96","none"); %>">
		<input type="hidden" id="firewall_rule_97" name="firewall_rule_97" value="<% CmoGetCfg("firewall_rule_97","none"); %>">
		<input type="hidden" id="firewall_rule_98" name="firewall_rule_98" value="<% CmoGetCfg("firewall_rule_98","none"); %>">
		<input type="hidden" id="firewall_rule_99" name="firewall_rule_99" value="<% CmoGetCfg("firewall_rule_99","none"); %>">
		<input type="hidden" id="firewall_rule_100" name="firewall_rule_100" value="<% CmoGetCfg("firewall_rule_100","none"); %>">
		<input type="hidden" id="firewall_rule_101" name="firewall_rule_101" value="<% CmoGetCfg("firewall_rule_101","none"); %>">
		<input type="hidden" id="firewall_rule_102" name="firewall_rule_102" value="<% CmoGetCfg("firewall_rule_102","none"); %>">
		<input type="hidden" id="firewall_rule_103" name="firewall_rule_103" value="<% CmoGetCfg("firewall_rule_103","none"); %>">
		
		<input type="hidden" id="firewall_rule_104" name="firewall_rule_104" value="<% CmoGetCfg("firewall_rule_104","none"); %>">
		<input type="hidden" id="firewall_rule_105" name="firewall_rule_105" value="<% CmoGetCfg("firewall_rule_105","none"); %>">
		<input type="hidden" id="firewall_rule_106" name="firewall_rule_106" value="<% CmoGetCfg("firewall_rule_106","none"); %>">
		<input type="hidden" id="firewall_rule_107" name="firewall_rule_107" value="<% CmoGetCfg("firewall_rule_107","none"); %>">
		<input type="hidden" id="firewall_rule_108" name="firewall_rule_108" value="<% CmoGetCfg("firewall_rule_108","none"); %>">
		<input type="hidden" id="firewall_rule_109" name="firewall_rule_109" value="<% CmoGetCfg("firewall_rule_109","none"); %>">
		<input type="hidden" id="firewall_rule_110" name="firewall_rule_110" value="<% CmoGetCfg("firewall_rule_110","none"); %>">
		<input type="hidden" id="firewall_rule_111" name="firewall_rule_111" value="<% CmoGetCfg("firewall_rule_111","none"); %>">

		<input type="hidden" id="firewall_rule_112" name="firewall_rule_112" value="<% CmoGetCfg("firewall_rule_112","none"); %>">
		<input type="hidden" id="firewall_rule_113" name="firewall_rule_113" value="<% CmoGetCfg("firewall_rule_113","none"); %>">
		<input type="hidden" id="firewall_rule_114" name="firewall_rule_114" value="<% CmoGetCfg("firewall_rule_114","none"); %>">
		<input type="hidden" id="firewall_rule_115" name="firewall_rule_115" value="<% CmoGetCfg("firewall_rule_115","none"); %>">
		<input type="hidden" id="firewall_rule_116" name="firewall_rule_116" value="<% CmoGetCfg("firewall_rule_116","none"); %>">
		<input type="hidden" id="firewall_rule_117" name="firewall_rule_117" value="<% CmoGetCfg("firewall_rule_117","none"); %>">
		<input type="hidden" id="firewall_rule_118" name="firewall_rule_118" value="<% CmoGetCfg("firewall_rule_118","none"); %>">
		<input type="hidden" id="firewall_rule_119" name="firewall_rule_119" value="<% CmoGetCfg("firewall_rule_119","none"); %>">

			<td valign="top" id="maincontent_container">
			<div id=maincontent>
			  <div id=box_header> 
				<h1>Access Control</h1>
				The Access Control option allows you to control access in and out of your network. Use this feature as Access Controls to only grant access to approved sites, limit web access based on time or dates, and/or block internet access for applications like P2P utilities or games.
				<br><br>
				<input name="button" type="button" class=button_submit value="Save Settings" onClick="send_request()">
				<input name="button2" type=reset class=button_submit value="Don't Save Settings" onClick="window.location.href='adv_access_control.asp'">
			  </div>
			  <div class=box>
			  <h2>Enable</h2>
				<table width="525">
					<tr> 
					  <td class="duple">Enable Access Control :</td>
						<input type=hidden id="edit_row" name="edit_row" value=-1>
						<input type="hidden" id="del_row" name="del_row" value="0">  
						<input type="hidden" id="serial" name="serial" value="0">
					  <td width="340">&nbsp;<input type=checkbox id="access_enable" name="access_enable" value="enable" onClick="show_policy()"></td>
					</tr>
					<tr id="show_policy" style="display:none">
						<td class="duple">&nbsp;</td>
						<td width="340">&nbsp;
						<input type=button id=add_policy name=add_policy value="Add Policy" onClick="send_next();">
						</td>
					</tr>
				</table>
			  </div>
			  <div class=box id="show_table">
			  <h2>Policy Table</h2>
				<table width="525" id="table1" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
					<tr> 
					  <td width="20"><strong>Enable</strong></td> 
					  <td width="80"><strong>Policy</strong></td> 
					  <td width="130"><strong>Machine</strong></td> 
					  <td width="120"><strong>Filtering</strong></td> 
					  <td width="50"><strong>Logged</strong></td> 
					  <td width="80"><strong>Schedule</strong></td> 
					  <td>&nbsp;</td>  
					  <td>&nbsp;</td>   
					</tr>
					<script>
						set_policy();
						var is_enable = "", filter, logged;
						for(i = 0; i < DataArray.length; i++){
							if(parseInt(DataArray[i].Enable)){
								is_enable = "checked";
							}else{
								is_enable = "";
							}
							// machine list
							var machine = (DataArray[i].Machine).split(",");
							var machine_list;
							for(var j = 0; j < machine.length; j++){
								var machine_name = machine[j];
								if(machine_name == "other")
									machine_name = "Other Machines";
								if(j == 0){
									machine_list = machine_name;
								}else{
									machine_list = machine_list + ",<br>" + machine_name;
								}
							}
							//filtering method
							if(DataArray[i].Filter == "log_only"){
								filter = "Log Web Access Only";
							}else if(DataArray[i].Filter == "block_all"){
								filter = "Block All Access";
							}else{
								filter = "Block Some Access";
							}
							//web access logging
							if(DataArray[i].Logged == "yes"){
								logged = "Yes";
							}else{
								logged = "No";
							}
							var dName = DataArray[i].Name;
							trimName = trim_string(dName);
							var str=trimName;
							var rep="<";
							//document.write(str.replace(rep, "\&lt;"));
							document.write("<tr><td><input type=checkbox id=enable" + i + " name=enable" + i + " onClick='set_policy_enable(" + i + ")' " + is_enable + "></td><td>"+str.replace(rep, "\&lt;")+"</td><td>" + machine_list +"</td><td>"+ filter +"</td><td>"+ logged +"</td><td>"+ DataArray[i].Schedule +"</td><td><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></td><td><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></td></tr>");
						}
					</script>
				</table>
			  </div>
		</div>
		</td>
		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><b>Helpful Hints&hellip;</b>
                          <p>Check <strong>Enable Access Control</strong> if you want to enforce rules that limit Internet access from specific LAN computers.</p>
						  <p>Click <strong>Add Policy</strong> to start the processes of creating a rule. You can cancel the process at any time. When you are finished creating a rule it will be added to the <strong>Policy Table</strong> below.</p>
						  <p>Click the <strong>Edit</strong> icon to modify an existing rule using the Policy Wizard.</p>
						  <p>Click the <strong>Delete</strong> icon to permanently remove a rule.</p>
						  <p><a href="support_adv.asp#Access_Control" onclick="return jump_if()">More&hellip;</a></p>
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
	onPageLoad();
</script>
</html>
