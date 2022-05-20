<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 24;
	var inbound_used = 0;
	
	function onPageLoad(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_vs;
			if (i > 9){
				temp_vs = get_by_id("vs_rule_" + i).value;
			}else{
				temp_vs = get_by_id("vs_rule_0" + i).value;				
			}
			
			if(temp_vs ==""){
				if (i > 9){
					 get_by_id("vs_rule_" + i).value = "0//6/0/0/0.0.0.0/Always/Allow_All";
					 									
				}else{
					get_by_id("vs_rule_0" + i).value = "0//6/0/0/0.0.0.0/Always/Allow_All";				
				}
			}
			protocol_change(i);
		}
	
		set_port_forwarding();
		set_form_default_values("form1");
	}

	function set_port_forwarding(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_vs;
			
			if (i > 9){
				temp_vs = (get_by_id("vs_rule_" + i).value).split("/");
			}else{
				temp_vs = (get_by_id("vs_rule_0" + i).value).split("/");				
			}
			
			if (temp_vs.length > 1){
				set_checked(temp_vs[0], get_by_id("enable" + i));
				get_by_id("name" + i).value = temp_vs[1];
				set_vs_protocol(i, temp_vs[2], get_by_id("protocol_select"+i));
				get_by_id("public_portS" + i).value = temp_vs[3];
				get_by_id("private_portS" + i).value = temp_vs[4];
				get_by_id("ip" + i).value = temp_vs[5];

			  	//2009/4/20 Tina modify:Fixed schedule can't selected.
				if((temp_vs[6] == "Always") || (temp_vs[6] == "Never") || (temp_vs[6] == "")){
					set_selectIndex(temp_vs[6], get_by_id("schedule" + i));
   				}else{
				  	var temp_index = get_schedule_index(temp_vs[6]);
		   		    get_by_id("schedule" + i).selectedIndex=temp_index+2;
     			}
				set_selectIndex(temp_vs[7], get_by_id("inbound_filter" + i));
				
				if(get_by_id("enable"+ i).checked){
					 detect_protocol_change_port(get_by_id("protocol_select"+i).selectedIndex,i);
				}
			}
			}
		}
	
	function set_vs_protocol(i, which_value, obj){
		set_selectIndex(which_value,obj);
		get_by_id("protocol"+i).disabled=true;
		if(which_value != obj.options[obj.selectedIndex].value){
			get_by_id("protocol"+i).disabled=false;
			get_by_id("protocol_select"+i).selectedIndex = 3;
			
		}
		
			get_by_id("protocol"+i).value=which_value;
	}
	
    function protocol_change(i){
		var obj_name = get_by_id("protocol_select"+i);
		if(obj_name.selectedIndex < 3){ //TCP, UDP, Both, Other
			get_by_id("protocol"+i).disabled =true;
			get_by_id("public_portS"+i).disabled =false;
			get_by_id("private_portS"+i).disabled =false;
			get_by_id("protocol"+i).value=obj_name.options[obj_name.selectedIndex].value;
		}else if(get_by_id("protocol_select"+i).selectedIndex == 3){ // Other
			get_by_id("public_portS"+i).value = 0;
			get_by_id("private_portS"+i).value = 0;
			get_by_id("protocol"+i).disabled=false;
			get_by_id("protocol"+i).value="";
		}
	}

	function detect_protocol_change_port(proto,i){
		if((proto == 0)||(proto == 1)||(proto == 2)){
			get_by_id("protocol"+i).disabled=true;
			get_by_id("public_portS"+i).disabled =false;
			get_by_id("private_portS"+i).disabled =false;					
		}else{
			get_by_id("public_portS"+i).disabled=true;
			get_by_id("private_portS"+i).disabled=true;
			
		}
	}
		
	function check_forward_port(potocol,chk_port, obj_word){
			var chk_port_array = chk_port.split(",");				 
			var checkTimes = chk_port_array.length;	
			if(potocol == 0){
					 proto_type = "6";
				}else if(potocol == 1){
					 proto_type = "17";
				}else if(potocol == 2){
					 proto_type = "256";
				}
			  			  
		for (var i = 0; i < checkTimes; i++){  // get chk_port_arry data
				var port = chk_port_array[i].split("-");
				var port1 = "";
				var port2 = "";	
				port1 = port[0];
												
				if (port.length > 1){
					port2 = port[1];
				}
				
				for(j=0;j<rule_max_num;j++){  // get application rule value
					  var rule_value;
						if (j > 9){
								rule_value = (get_by_id("port_forward_both_" + j).value);
						}else{
								rule_value = (get_by_id("port_forward_both_0" + j).value);				
						}					  
						
						if (rule_value == ""){
							continue;
						}
						
						temp_pf = rule_value.split("/");
						var chk_tcpport_array = temp_pf[3].split(","); //pf tcp port
						var chk_udpport_array = temp_pf[4].split(","); //pf udp port
						var check_tTimes = chk_tcpport_array.length;
						var check_uTimes = chk_udpport_array.length;	
						for (var m = 0; m < check_tTimes; m++){ // split the port forward TCP port range
							var Aport = chk_tcpport_array[m].split("-");
							var Aport1 = "";
							var Aport2 = "";	
							Aport1 = Aport[0];
											
							if (Aport.length > 1){
							Aport2 = Aport[1];
							}
						if(temp_pf[0]== "1"){	
					  	if(proto_type == "6" || proto_type == "256"){
					  			if (port2 == "" || Aport2 == ""){	//when PF is sigle port or vs is sigle port		  	
							  		if(port1 == Aport1){
							  				alert(obj_word + " conflict with Port Forwarding Port.");
												return false;	
										}else if (port2 == ""){ //when PF is sogle port, vs is range port										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
												alert(obj_word + " conflict with Port Forwarding Port.");
												return false;							
												}											
										}else if (Aport2 == ""){ //when vs is sigle port, PF is range port										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
												alert(obj_word + " conflict with Port Forwarding Port.");
												return false;							
												}											
										}
										
									}else{//PF is range port, vs is sigle port
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
									 	    alert(obj_word + " conflict with Application firewall port.");
									 	    return false;							
										}									
								  }
							}	
						}
					  }
					  
					  for (var n = 0; n < check_uTimes; n++){ // split the port forward UDP port range
							var Aport = chk_udpport_array[n].split("-");
							var Aport1 = "";
							var Aport2 = "";	
							Aport1 = Aport[0];
											
							if (Aport.length > 1){
							Aport2 = Aport[1];
							}
						if(temp_pf[0]== "1"){	
					  	if(proto_type == "17" || proto_type == "256"){
					  			if (port2 == "" || Aport2 == ""){	//when PF is single port or vs is sigle port		  	
							  		if(port1 == Aport1){
							  				alert(obj_word + " conflict with Port Forwarding Port.");
												return false;	
										}else if (port2 == ""){ //when PF is sigle port,  vs is range port										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
												alert(obj_word + " conflict with Port Forwarding Port.");
												return false;							
												}											
										}else if (Aport2 == ""){ //when vs is sigle port, PF is range port										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
												alert(obj_word + " conflict with Port Forwarding Port.");
												return false;							
												}											
										}
										
									}else{//PF is range port, vs is sigle port
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
									 	    alert(obj_word + " conflict with Application firewall port.");
									 	    return false;							
										}									
								  }
							}	
						}
					  }
				}
				
				
				/*if(parseInt(temp_pf[0],10) > 0){
					if(!check_multi_port(chk_port, temp_pf[3])){
						alert(obj_word + " conflict with Port Forward port.");
						return false;
					}
					if(!check_multi_port(chk_port, temp_pf[4])){
						alert(obj_word + " conflict with Port Forward port.");
						return false;
					}
				}*/
		}	
		return true;
		}
	
	function check_app_port(potocol,chk_port, obj_word){
			var chk_port_array = chk_port.split(",");				 
			var checkTimes = chk_port_array.length;	

		for (var i = 0; i < checkTimes; i++){  // get chk_port_arry data
				var port = chk_port_array[i].split("-");
				var port1 = "";
				var port2 = "";	
				port1 = port[0];
												
				if (port.length > 1){
					port2 = port[1];
				}
				for(j=0;j<rule_max_num;j++){  // get application rule value
					  var rule_value;
						if (j > 9){
								rule_value = (get_by_id("application_" + j).value);
						}else{
								rule_value = (get_by_id("application_0" + j).value);				
						}					  
						
						if (rule_value == ""){
							continue;
						}
						
						temp_app = rule_value.split("/");
						var chk_appport_array = temp_app[5].split(",");
						var checkAppTimes = chk_appport_array.length;	
						for (var m = 0; m < checkAppTimes; m++){ // split the application port range
							var Aport = chk_appport_array[m].split("-");
							var Aport1 = "";
							var Aport2 = "";	
							Aport1 = Aport[0];
											
							if (Aport.length > 1){
							Aport2 = Aport[1];
							}

						if(temp_app[0]== "1"){
					  	if(potocol == 0 && temp_app[4]== "TCP" || potocol == 1 && temp_app[4]== "UDP" ||temp_app[4]== "Any"){
					  			if (port2 == "" || Aport2 == ""){	//when vs is sigle port or APP is sigle port		  	
							  		if(port1 == Aport1){
							  				alert(obj_word + " conflict with Application Firewall Port.");
												return false;	
										}else if (port2 == ""){ //when vs sigle port, APP is range port										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
												alert(obj_word + " conflict with Application Firewall Port.");
												return false;							
												}											
										}else if (Aport2 == ""){ //when APPis sigle port, vs is range port										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
												alert(obj_word + " conflict with Application Firewall Port.");
												return false;							
												}											
										}
										
									}else{//vs is range port, APP is sigle port
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
									 	    alert(obj_word + " conflict with Application Firewall Port.");
									 	    return false;							
										}									
								  }
							}	
						}
					}
				}
		}	
		return true;
	}
	
	
	
	function check_virtual_port(index, chk_port, chk_ip, obj_word){
		var protocol = get_by_id("protocol_select" +i).selectedIndex;
		for(ii=(index+1); ii<rule_max_num; ii++){
			if(get_by_id("enable" + ii).checked == true){
				if(get_by_id("public_portS" + ii).value == chk_port){
					alert(obj_word + " conflict with other public port.");
					return false;
				}
				if(get_by_id("ip" + ii).value == chk_ip){	//check IP address is different or not?
				if(get_by_id("private_portS" + ii).value == chk_port){
					alert(obj_word + " conflict with other private port.");
					return false;
				}
			}
		}
		}
		return true;
	}
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_port_name = get_by_id("name" + i).value;			
			if (temp_port_name != ""){
				for (var j = i+1; j < rule_max_num; j++){
					if (temp_port_name == get_by_id("name" + j).value){
						alert("The virtual server name is already in the list");
						return false;
					}
				}
			}
		}
		
		for (var i = 0; i < rule_max_num; i++){		
			var ip = get_by_id("ip" + i).value;
			var protocol = get_by_id("protocol_select" +i).selectedIndex;
			var other = get_by_id("protocol"+i).value;
			var check_name = get_by_id("name" + i).value;
			var lan_ip = "<% CmoGetCfg("lan_ipaddr","none"); %>";
			
			var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
			var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
			var temp_vs;
			
			if (parseInt(i,10) >= 10){
				get_by_id("vs_rule_" + i).value = "";
			}else{
				get_by_id("vs_rule_0" + i).value = "";
			}
			
				
			if (get_by_id("name" + i).value != ""){
				if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
					alert("Port forwarding name "+ i +" invalid. the legal characters can not enter ',/,''");
					return false;
				}
								
								
				//check dhcp ip range equal to lan-ip or not?
				if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_ip_obj.addr, "IP address")){
					return false;
				}
	
				var name_string = get_by_id("name" + i).value.toUpperCase();
				//if (get_by_id("name" + i).value != "Wake-On-LAN"){
				if (name_string != "WAKE-ON-LAN"){
					if (!check_address(temp_ip_obj)){
			            return false;
			        }
		        }
       
				//check virtual server public port and remote management port conflict problem
				var remote_port = "<% CmoGetCfg("remote_http_management_port","none"); %>";
				var remote_port_enable = "<% CmoGetCfg("remote_http_management_enable","none"); %>";
				if(get_by_id("enable" + i).checked == true){
					if(remote_port_enable == "1"){
				if (get_by_id("public_portS" + i).value == remote_port && protocol != 1){
					alert("Public port conflict with Remote Management HTTP port.");
					return false;
				}
					}
				}
				
				if(protocol != 3){
					if(get_by_id("enable" + i).checked == true){
						if(!check_forward_port(protocol, get_by_id("public_portS" + i).value, "Port")){
							return false;
						}
					
						if(!check_app_port(protocol,get_by_id("public_portS" + i).value, "Port")){
							return false;
						}
						
						if(!check_virtual_port(i, get_by_id("public_portS" + i).value, get_by_id("ip" + i).value, "Port")){
							return false;
						}
						if(!check_virtual_port(i, get_by_id("private_portS" + i).value, get_by_id("ip" + i).value,"Port")){
							return false;
						}
					}
						
						if (!check_pf_port(get_by_id("private_portS" + i).value)){
		            alert(msg[PRIVATE_PORT_ERROR]);
		            return false;
				    }
				    
				    if (!check_pf_port(get_by_id("public_portS" + i).value)){
		            alert(msg[PUBLIC_PORT_ERROR]);
		            return false;
			      }
				       
				}else if(protocol == 3){
					if (isNaN(other) || other == "" || (parseInt(other) < 0 || parseInt(other) > 255)){
						alert("The Other Protocol Type is invalid");
				 		return false;
					}
				}
		        
        var is_enable = get_checked_value(get_by_id("enable" + i));
        if (count > 9){
					temp_vs = get_by_id("vs_rule_" + count);
				}else{
					temp_vs = get_by_id("vs_rule_0" + count);
				}
				
	  			//2009/4/10 Tina modify:Fixed can't save space char.
				var tmp_schedule = get_schedule_value(i);
				temp_vs.value = is_enable + "/" + get_by_id("name" + i).value + "/" + get_by_id("protocol" + i).value 
					+ "/" + get_by_id("public_portS" + i).value +"/"+ get_by_id("private_portS" + i).value 
					+ "/" + get_by_id("ip" + i).value + "/" + tmp_schedule + "/" + get_by_id("inbound_filter" + i).value;
				
				//temp_vs.value = is_enable + "/" + get_by_id("name" + i).value + "/" + get_by_id("protocol" + i).value 
				//	+ "/" + get_by_id("public_portS" + i).value +"/"+ get_by_id("private_portS" + i).value 
				//	+ "/" + get_by_id("ip" + i).value + "/" + get_by_id("schedule" + i).value + "/" + get_by_id("inbound_filter" + i).value;
				save_inbound_used(get_by_id("inbound_filter" + i).value, inbound_used);
		        count++;
			}
		}

		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
</script>    

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
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
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();">ADVANCED</a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();">TOOLS</a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();">SUPPORT</a></td>
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
                            <LI><div id=sidenavoff>Virtual Server</div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();">Port Forwarding</a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();">Application Rules</a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();">QOS Engine</a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();">WLAN MAC Filter</a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();">Access control</a></div></LI>
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
                  </tbody>
                </table></td>
				<input type="hidden" id="schedule_rule_0" name="schedule_rule_0" value="<% CmoGetCfg("schedule_rule_00","none"); %>">
                <input type="hidden" id="schedule_rule_1" name="schedule_rule_1" value="<% CmoGetCfg("schedule_rule_01","none"); %>">
                <input type="hidden" id="schedule_rule_2" name="schedule_rule_2" value="<% CmoGetCfg("schedule_rule_02","none"); %>">
                <input type="hidden" id="schedule_rule_3" name="schedule_rule_3" value="<% CmoGetCfg("schedule_rule_03","none"); %>">
                <input type="hidden" id="schedule_rule_4" name="schedule_rule_4" value="<% CmoGetCfg("schedule_rule_04","none"); %>">
                <input type="hidden" id="schedule_rule_5" name="schedule_rule_5" value="<% CmoGetCfg("schedule_rule_05","none"); %>">
                <input type="hidden" id="schedule_rule_6" name="schedule_rule_6" value="<% CmoGetCfg("schedule_rule_06","none"); %>">
                <input type="hidden" id="schedule_rule_7" name="schedule_rule_7" value="<% CmoGetCfg("schedule_rule_07","none"); %>">
                <input type="hidden" id="schedule_rule_8" name="schedule_rule_8" value="<% CmoGetCfg("schedule_rule_08","none"); %>">
                <input type="hidden" id="schedule_rule_9" name="schedule_rule_9" value="<% CmoGetCfg("schedule_rule_09","none"); %>">
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
                <form id="form1" name="form1" method="post" action="apply.cgi">
                <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
								<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
								<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_virtual.asp">
								<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
				
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
                                
                <input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
				  
                  <div id=box_header>
                    <h1>Virtual Server</h1>
                    The Virtual Server option allows you to define a single public port on your router for redirection to an internal LAN IP Address and Private LAN port if required. This feature is useful for hosting online services such as FTP or Web Servers.
                    <br><br>
                    <input name="button" type="button" class=button_submit value="Save Settings" onClick="send_request()">
                    <input name="button2" type=button class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'adv_virtual.asp');">
                  </div>
                  <div class=box>
                    <h2><script>document.write(rule_max_num)</script> &ndash;&ndash; VIRTUAL SERVERS LIST</h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=middle width=20>&nbsp;</td>
                          <td width="31">&nbsp;</td>
                          <td width="195">&nbsp;</td>
                          <td width="130" align=middle><div align="left"><strong>Port</strong></div></td>
                          <td width="125" align=middle><div align="left"><strong>Traffic Type</strong></div></td>
                          <td width="100" align=middle><div align="center">&nbsp;</td>
                        </tr>
                        <script>
							var Application_list = set_application_option(Application_list, default_virtual);
							var Inbound_list = set_inbound_option(Inbound_list, inbound_used);
							for(var i=0 ; i<rule_max_num ; i++){
								document.write("<tr>");
								document.write("<td align=center valign=middle rowspan=2><input type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>");
								document.write("<td valign=bottom>Name<br><input type=text class=flatL id=\"name" + i + "\" name=\"name" + i +"\" size=16 maxlength=31></td>");
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_app" + i + " name=copy_app" + i + " type=button value=<< onClick='copy_virtual(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:110' id=application" + i +" name=application" + i +" modified=\"ignore\">");
								document.write("<option>Application Name</option>");
								document.write(Application_list);
								document.write("</select></td>");
								document.write("<td align=center valign=bottom>Public Port<br><input type=text class=flatL id=public_portS" + i + " name=public_portS" + i +" size=5 maxlength=5></td>");
								document.write("<td align=center>Protocol<br>");
								document.write("<select width=80 id=protocol_select" + i + " name=protocol_select" + i +" onChange=\"protocol_change(" + i + ");detect_protocol_change_port(this.selectedIndex,'" + i + "');\">");
								document.write("<option value=6 selected>TCP</option>");
								document.write("<option value=17>UDP</option>");
								document.write("<option value=256>Both</option>");
								document.write("<option value=-1> Other</option>");
								document.write("</select></td>");			
								document.write("<td align=center>Schedule<br>");
								document.write("<select width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>");
								document.write("<option value=\"Always\" selected>Always</option>");
								document.write("<option value=\"Never\">Never</option>");
								document.write(set_schedule_option());
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");
								
								document.write("<tr>");
								document.write("<td valign=bottom>IP Address<br><input type=text class=flatL  id=ip" + i + " name=ip" + i +" size=16 maxlength=15></td>");
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_ip" + i + " name=copy_ip" + i + " type=button value=<< onClick='copy_ip(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:110' id=ip_list" + i +" name=ip_list" + i +" modified=\"ignore\">");
								document.write("<option value=-1>Computer Name</option>");
								document.write(set_mac_list("ip"));			
								document.write("</select></td>");
								document.write("<td align=center valign=bottom>Private Port<br><input type=text class=flatL id=private_portS" + i + " name=private_portS" + i +" size=5 maxlength=5></td>");
								document.write("<td align=center><br>");
								document.write("<input type=text id=protocol" + i + " name=protocol" + i + " size=5 maxlength=3>");
								document.write("</td>");
								document.write("<td align=center>Inbound Filter<br>");
								document.write("<select width=30 id=inbound_filter" + i + " name=inbound_filter" + i + " style='width:70'>");
								document.write("<option value=\"Allow_All\" selected>Allow All</option>");
								document.write("<option value=\"Deny_All\">Deny All</option>");
								document.write(Inbound_list);
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");
							}
						</script>
                      </tbody>
                    </table>
                  </div>
                </div>
             </td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b>Helpful Hints&hellip;</b>
                      	<p>Check the <strong>Application Name</strong> drop down menu for a list of predefined server types. If you select one of the predefined server types, click the arrow button next to the drop down menu to fill out the corresponding field.</p>
                        <p>You can select a computer from the list of DHCP clients in the <strong>Computer Name</strong> drop down menu, or you can manually enter the IP address of the computer at which you would like to open the specified port.</p>
                        <p>Select a schedule for when the virtual server will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href="tools_schedules.asp" onclick="return jump_if();">Tools &rarr; Schedules</a> screen and create a new schedule.</p>
                        <p>Select a filter that restricts the Internet hosts that can access this virtual server to hosts that you trust. If you do not see the filter you need in the list of filters, go to the <a href="Inbound_Filter.asp" onclick="return jump_if();">Advanced &rarr; Inbound Filter</a> screen and create a new filter.</p>
						<p><a href="support_adv.asp#Virtual_Server" onclick="return jump_if();">More&hellip;</a></p>
					   </td>
                    </tr>
                  </tbody>
			  </table></td>
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
