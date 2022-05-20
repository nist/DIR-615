<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var rule_max_num = 8;
	function onPageLoad(){
		var idx = 1;
		for(var i = 4; i < 12; i++){
			if(i < 10){
				var temp_firewall = (get_by_id("asp_temp_0" + i).value).split("/");
			}else{
				var temp_firewall = (get_by_id("asp_temp_" + i).value).split("/");
			}
			if (temp_firewall.length > 1){
				set_checked(temp_firewall[0], get_by_id("enable" + idx));
				get_by_id("name" + idx).value = temp_firewall[1];
				get_by_id("start_ip" + idx).value = temp_firewall[7];
				get_by_id("end_ip" + idx).value = temp_firewall[8];
				get_by_id("protocol" + idx).value = temp_firewall[3];
				get_by_id("start_port" + idx).value = temp_firewall[9];
				get_by_id("end_port" + idx).value = temp_firewall[10];
				click_protocol(idx);
				idx++;
			}
		}
	}
	
	function show_save_button(){
		get_by_id("save").disabled = !((get_by_id("asp_temp_14").value != "-1") || (get_by_id("asp_temp_03").value == "firewall_rule"));
		get_by_id("next").disabled = !(get_by_id("asp_temp_03").value == "url_firewall");
	}
	
	function click_protocol(idx){
		var protocol = get_by_id("protocol" + idx).selectedIndex;
		get_by_id("start_port" + idx).disabled = (protocol < 2);
		get_by_id("end_port" + idx).disabled = (protocol < 2);
	}

	function check_info(){
		var temp_ip_obj = new addr_obj(get_by_id("lan_ipaddr").value.split("."), all_ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(get_by_id("lan_netmask").value.split("."), subnet_mask_msg, false, false);
		for(var i = 1; i <= rule_max_num; i++){
			var enable = get_by_id("enable" + i);
			var name = get_by_id("name" + i).value;
			var start_ip = get_by_id("start_ip" + i).value;
			var end_ip = get_by_id("end_ip" + i).value;
			var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start Dest IP address");
			var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End Dest IP address");
			var temp_start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, true, false);
			var temp_end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, true, false);
			
			if(enable.checked && name == ""){
				alert(msg[NAME_ERROR]);
				return false;
			}
			
			if(enable.checked || name != ""){
				if(Find_word(name,"'") || Find_word(name,'"') || Find_word(name,"/")){
					alert(" Port Filter name "+ i +" is invalid. The legal characters can not enter ',/,''");
					return false
				}
				
				if(start_ip != "255.255.255.255"){
					if(!check_address(temp_start_obj)){
						return false;
					}else if (check_domain(temp_start_obj, temp_mask_obj, temp_ip_obj)){
						alert("The Start Dest IP address and the LAN IP Address are in the same subnet.");
						return false;
					}
				}

				if(end_ip != "255.255.255.255"){
					if(!check_address(temp_end_obj)){
						return false;
					}else if (check_domain(temp_end_obj, temp_mask_obj, temp_ip_obj)){
						alert("The End Dest IP address and the LAN IP Address are in the same subnet.");
						return false;
					}
				}
				
				if (!check_ip_order(temp_start_obj, temp_end_obj)){
					alert(msg[IP_RANGE_ERROR]);
					return false;
				}
				
				if(get_by_id("protocol" + i).selectedIndex > 1){
					var start_port = get_by_id("start_port" + i).value;
					var end_port = get_by_id("end_port" + i).value;
					if(!check_pf_port(start_port)){
						alert(msg[PORT_ERROR]);
						return false;
					}else if(end_port != ""){
						if(!check_pf_port(end_port)){
							alert(msg[PORT_ERROR]);
							return false;
						}else if(parseInt(end_port) < parseInt(start_port)){
							alert(msg[PORT_RANGE_ERROR]);
							return false;
						}
					}else{
						get_by_id("end_port" + i).value = get_by_id("start_port" + i).value;
					}
				}
			}
		}
		return true;
	}
	
	function save_info(){
		var idx, enable, firewall_rull = "";
		for(var i = 1; i <= rule_max_num; i++){
			idx = i + 3;
			if(parseInt(idx) < 10){
				get_by_id("asp_temp_0" + idx).value = "";
			}else{
				get_by_id("asp_temp_" + idx).value = "";
			}
			
			if(get_by_id("enable" + i).checked || get_by_id("name" + i).value != ""){
				if(get_by_id("enable" + i).checked){
					enable = "1";
				}else{
					enable = "0";
				}
				
				firewall_rull = enable + "/" + get_by_id("name" + i).value + "/0/" + get_by_id("protocol" + i).value + "/0/0/0/" 
							  + get_by_id("start_ip" + i).value + "/" + get_by_id("end_ip" + i).value + "/" 
							  + get_by_id("start_port" + i).value + "/" + get_by_id("end_port" + i).value + "/0/deny" 
				
				if(parseInt(idx) < 10){
					get_by_id("asp_temp_0" + idx).value = firewall_rull;
				}else{
					get_by_id("asp_temp_" + idx).value = firewall_rull;
				}
			}
		}
	}

	function send_previous(){
		save_info();
		get_by_id("html_response_page").value = "adv_access_add4.asp";
		get_by_id("html_response_return_page").value = "adv_access_add4.asp";
		return true;
	}
		
	function send_next(){
		if(!check_info())
			return false;

		save_info();
		get_by_id("asp_temp_15").value = "adv_access_add5.asp";
		return true;
	}

	function send_request(){
		if(!check_info())
			return false;

		save_info();
		get_by_id("html_response_page").value = "adv_access_save.asp";
		get_by_id("html_response_return_page").value = "adv_access_save.asp";
		return true;
	}
</script>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
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
                  <tbody>
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
                          </UL>
                      	</div>
					  </td>
                    </tr>
                  </tbody>
                </table>
			</td>
			<input type="hidden" id="firewall_rule_0" name="firewall_rule_0" value="<% CmoGetCfg("firewall_rule_00","none"); %>">
			<input type="hidden" id="firewall_rule_1" name="firewall_rule_1" value="<% CmoGetCfg("firewall_rule_01","none"); %>">
			<input type="hidden" id="firewall_rule_2" name="firewall_rule_2" value="<% CmoGetCfg("firewall_rule_02","none"); %>">
			<input type="hidden" id="firewall_rule_3" name="firewall_rule_3" value="<% CmoGetCfg("firewall_rule_03","none"); %>">
			<input type="hidden" id="firewall_rule_4" name="firewall_rule_4" value="<% CmoGetCfg("firewall_rule_04","none"); %>">
			<input type="hidden" id="firewall_rule_5" name="firewall_rule_5" value="<% CmoGetCfg("firewall_rule_05","none"); %>">
			<input type="hidden" id="firewall_rule_6" name="firewall_rule_6" value="<% CmoGetCfg("firewall_rule_06","none"); %>">
			<input type="hidden" id="firewall_rule_7" name="firewall_rule_7" value="<% CmoGetCfg("firewall_rule_07","none"); %>">
			
			<input type="hidden" id="firewall_rule_8" name="firewall_rule_8" value="<% CmoGetCfg("firewall_rule_08","none"); %>">
			<input type="hidden" id="firewall_rule_9" name="firewall_rule_9" value="<% CmoGetCfg("firewall_rule_09","none"); %>">
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

			<input type="hidden" id="lan_ipaddr" name="lan_ipaddr" value="<% CmoGetCfg("lan_ipaddr","none"); %>">
			<input type="hidden" id="lan_netmask" name="lan_netmask" value="<% CmoGetCfg("lan_netmask","none"); %>">
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_add6.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_add6.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			
			<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<% CmoGetCfg("asp_temp_03","none"); %>">	<!-- filter method -->
			<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="<% CmoGetCfg("asp_temp_04","none"); %>">	<!-- firewall rule 1 -->
			<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="<% CmoGetCfg("asp_temp_05","none"); %>">	<!-- firewall rule 2 -->
			<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="<% CmoGetCfg("asp_temp_06","none"); %>">	<!-- firewall rule 3 -->
			<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="<% CmoGetCfg("asp_temp_07","none"); %>">	<!-- firewall rule 4 -->
			<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="<% CmoGetCfg("asp_temp_08","none"); %>">	<!-- firewall rule 5 -->
			<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="<% CmoGetCfg("asp_temp_09","none"); %>">	<!-- firewall rule 6 -->
			<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<% CmoGetCfg("asp_temp_10","none"); %>">	<!-- firewall rule 7 -->
			<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="<% CmoGetCfg("asp_temp_11","none"); %>">	<!-- firewall rule 8 -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<% CmoGetCfg("asp_temp_14","none"); %>">	<!-- edit_row -->
			<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<% CmoGetCfg("asp_temp_15","none"); %>">	<!-- prev_page -->
			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            <div class=box>
			 <h2>Step 5: Port Filter</h2>
		 	 <P class="box_msg">Add Port Filters Rules.</P>
			 <p>Specify rules to prohibit access to specific IP addresses and ports.</p>
				<table width="670" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
				  <tbody>
					  <tr>
						<td>Enable</td>
						<td>Name</td>
						<td>Dest IP<br>Start</td>
						<td>Dest IP<br>End</td>
						<td>Protocol</td>
						<td>Dest Port<br>Start</td>
						<td>Dest Port<br>End</td>
					  </tr>
					  <script>
					  	for(var i = 1; i <= rule_max_num; i++){
							document.write("<tr>");
							document.write("<td><input type=checkbox id=enable" + i + " name=enable" + i + " value=1></td>");
							document.write("<td><input type=text id=name" + i + " name=name" + i + " maxlength=15 size=20></td>");
							document.write("<td><input type=text id=start_ip" + i + " name=start_ip" + i + " maxlength=15 size=20 value='0.0.0.0'></td>");
							document.write("<td><input type=text id=end_ip" + i + " name=end_ip" + i + " maxlength=15 size=20 value='255.255.255.255'></td>");
							document.write("<td><select id=protocol" + i + " name=protocol" + i + " onChange='click_protocol(" + i + ")'>");
							document.write("<option value=Any>Any</option>");
							document.write("<option value=ICMP>ICMP</option>");
							document.write("<option value=TCP>TCP</option>");
							document.write("<option value=UDP>UDP</option>");
							document.write("</select></td>");
							document.write("<td><input type=text id=start_port" + i + " name=start_port" + i + " maxlength=5 size=8 value='0'></td>");
							document.write("<td><input type=text id=end_port" + i + " name=end_port" + i + " maxlength=5 size=8 value='65535'></td>");
							document.write("</tr>");
							click_protocol(i);
						}
					  </script>
				  </tbody>
				</table><hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
						<input name="prev" type="submit" id="prev" value="Prev" onClick="return send_previous();">
						&nbsp; 
						<input name="next" type="submit" id="next" value="Next" onClick="return send_next();">
						&nbsp;
						<input name="save" type="submit" id="save" value="Save" onClick="return send_request();">                  
						&nbsp; 
						<input name="cancel" type="button" id="cancel" value="Cancel" onClick="exit_access()">
					</div>
				  </td>
				</table>
            </div>
			</div>
	  		</td>
	  		</form>
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
	show_save_button();
</script>
</html>