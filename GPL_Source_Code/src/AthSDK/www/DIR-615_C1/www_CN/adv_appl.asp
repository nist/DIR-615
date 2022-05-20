﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 24;
	var resert_rule = rule_max_num;
	function onPageLoad(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_appl;
			if (i > 9){
				temp_appl = get_by_id("application_" + i).value;
			}else{
				temp_appl = get_by_id("application_0" + i).value;				
			}
			
			if(temp_appl ==""){
				if (i > 9){
					 get_by_id("application_" + i).value = "0//TCP/0/TCP/0/Always";
				}else{
					get_by_id("application_0" + i).value = "0//TCP/0/TCP/0/Always";				
				}
			}
			
		}
	}
	
	
	function set_application(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_appl;
			
			if (i > 9){
				temp_appl = (get_by_id("application_" + i).value).split("/");
			}else{
				temp_appl = (get_by_id("application_0" + i).value).split("/");				
			}
			
			if (temp_appl.length > 1){
				
				if (temp_appl[0] == "1"){
					get_by_id("enable" + i).checked = true;
				}
				
				get_by_id("name" + i).value = temp_appl[1];								
				set_protocol(temp_appl[2], get_by_id("trigger" + i));	
				get_by_id("trigger_port" + i).value = temp_appl[3];
				set_protocol(temp_appl[4], get_by_id("public" + i));
				get_by_id("public_port" + i).value = temp_appl[5];

			  	//2009/4/20 Tina modify:Fixed schedule can't selected.
 				if((temp_appl[6] == "Always") || (temp_appl[6] == "Never") || (temp_appl[6] == "")){
					set_selectIndex(temp_appl[6], get_by_id("schedule" + i));
   				}else{
				  	var temp_index = get_schedule_index(temp_appl[6]);
		   		    get_by_id("schedule" + i).selectedIndex=temp_index+2;
     			}
			}
		}
		//get_by_id("show_resert").innerHTML = "<font color=\"red\">"+ resert_rule +"</font>";
	}
	
	function check_vistual_port(potocol,chk_port, obj_word){
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
				
				for(j=0;j<rule_max_num;j++){  // get VS rule value
					  var rule_value;
						if (j > 9){
								rule_value = (get_by_id("vs_rule_" + j).value);
						}else{
								rule_value = (get_by_id("vs_rule_0" + j).value);				
						}					  
						
						if (rule_value == ""){
							continue;
						}
						
						temp_vs = rule_value.split("/");
						if(temp_vs[0]== "1"){
					  	if(proto_type == temp_vs[2] || temp_vs[2]==256){
					  			if (port2 == ""){			  	
							  		if(port1 == temp_vs[3]){
							  				alert(obj_word + "与虚拟服务器端口相冲突。");
							  				//alert(obj_word + which_lang[tool_vs_pf_conflict] + which_lang[_vs_title]+ which_lang[_vs_port]);
												return false;	
										}
									}
									else{//range
										if(parseInt(port1) <= parseInt(temp_vs[3]) && parseInt(port2) >= parseInt(temp_vs[3])){
									 	    alert(obj_word + "与虚拟服务器端口相冲突。");
									 	    //alert(obj_word + which_lang[tool_vs_pf_conflict] + which_lang[_vs_title]+ which_lang[_vs_port]);
											return false;								
										}	
								}
							}	
						}
				}
		}	
		return true;
	}	
	
	function check_portforward_port(potocol,chk_port, obj_word){
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
					  			if (port2 == "" || Aport2 == ""){	//當PF為單一port or APP為單一port		  	
							  		if(port1 == Aport1){
							  				alert(obj_word + "与端口转发端口相冲突。");
							  				return false;	
										}else if (port2 == ""){ //當PF為單一 APP為range										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
												alert(obj_word + "与端口转发端口相冲突。");
												return false;							
												}											
										}else if (Aport2 == ""){ //當APP為單一 PF為range										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
												alert(obj_word + "与端口转发端口相冲突。");
												return false;							
												}											
										}
										
									}else{//PF為range 對APP單一
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
									 	    alert(obj_word + "与运用防火墙端口相冲突。");
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
					  	if(proto_type == "6" || proto_type == "256"){
					  			if (port2 == "" || Aport2 == ""){	//當PF為單一port or APP為單一port		  	
							  		if(port1 == Aport1){
							  				alert(obj_word + "与端口转发端口相冲突。");
							  				return false;	
										}else if (port2 == ""){ //當PF為單一 APP為range										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
												alert(obj_word + "与端口转发端口相冲突。");
												return false;	
												}											
										}else if (Aport2 == ""){ //當APP為單一 PF為range										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
												alert(obj_word + "与端口转发端口相冲突。");
												return false;								
												}											
										}
										
									}else{//PF為range 對APP單一
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
									 	    alert(obj_word + "与运用防火墙端口相冲突。");
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
	    	
	function send_request(){
		//if (!is_form_modified("form1") && !confirm("Nothing has changed, save anyway?")) {
		if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var name = get_by_id("name" + i);
			var proto_type = get_by_id("public" + i).selectedIndex;
			var trigger_port = (get_by_id("trigger_port" + i).value).split("-");
			var public_port = (get_by_id("public_port" + i).value).split(",");			
			var is_enable = 0;
			var temp_appl;
			
			if (i > 9){
				get_by_id("application_" + i).value = "";
			}else{
				get_by_id("application_0" + i).value = "";
			}
			
			if (name.value != ""){
				if (get_by_id("trigger_port" + i).value == ""){
		     		alert(msg[TRIGGER_PORT_ERROR]);
		     		return false;
		     	}else if (get_by_id("public_port" + i).value == ""){
		     		alert(msg[PUBLIC_PORT_ERROR]);
		     		return false;
		     	}
		     	
		     	if (!check_port(trigger_port[0])){
	 				alert(msg[PUBLIC_PORT_ERROR]);
	 				return false;
	 			}		  
	 			   	
		     	if (trigger_port.length > 1){
		     		if (!check_port(trigger_port[1])){
		 				alert(msg[PUBLIC_PORT_ERROR]);
		 				return false;
		 			}	
		     	}
		     	
		     	if(get_by_id("enable" + i).checked == true){		     				     	
		     	for (var j = 0; j < public_port.length; j++){
	  				var port = public_port[j].split("-");
	  				var temp_port1 = "";
	  				var temp_port2 = "";
	  				
	  				
	  				temp_port1 = port[0];
	  				
	  				if (port.length > 1){
	  					temp_port2 = port[1];
	  				}
	  				
	 				if (temp_port1 != ""){
	 					if (!check_port(temp_port1)){
			 				alert(msg[PUBLIC_PORT_ERROR]);
			 				return false;
			 			}
	 				}
 				
	 				if (temp_port2 != ""){
	 					if (!check_port(temp_port2)){
			 				alert(msg[PUBLIC_PORT_ERROR]);
			 				return false;
			 			}
	 				}		
	 								
				}

                //check application firewall port and remote management port conflict problem
				var remote_port = "<% CmoGetCfg("remote_http_management_port","none"); %>";
				var remote_port_enable = "<% CmoGetCfg("remote_http_management_enable","none"); %>";
				if(get_by_id("enable" + i).checked == true){
					if(remote_port_enable == "1"){
						if (get_by_id("public_port" + i).value == remote_port && proto_type != 1){
							//alert("Firewall port conflict with Remote Management HTTP port.");
							alert(which_lang[tool_admin_portconflict]+"与运用防火墙端口相冲突。.");	
							return false;
						}
					}
				}
					if(!check_vistual_port(proto_type,get_by_id("public_port" + i).value, which_lang[_vs_port])){
					return false;
					}
					if(!check_portforward_port(proto_type,get_by_id("public_port" + i).value, which_lang[_vs_port])){
					return false;
					}
			}
				
				
				for(jj=i+1;jj<rule_max_num;jj++){
					if(get_by_id("name" + jj).value==get_by_id("name" + i).value){
						//alert("The Application table has the same rules.\n");
						alert(which_lang[ag_inuse]);
						return false;
						break;
					}
					if(get_by_id("trigger" + jj).value == get_by_id("trigger" + i).value){
						if(get_by_id("trigger_port" + jj).value==get_by_id("trigger_port" + i).value){
							alert("端口冲突。");	
							return false;
						}
					}
					if(get_by_id("public" + jj).value == get_by_id("public" + i).value){
						if(get_by_id("public_port" + jj).value == get_by_id("public_port" + i).value){
							alert("端口冲突。");	
							return false;
						}
					}
				}
				
				if (get_by_id("enable" + i).checked){
		        	is_enable = 1;
		        }
		        
		    if (count > 9){
					temp_appl = get_by_id("application_" + count);
				}else{
					temp_appl = get_by_id("application_0" + count);
				}
				
	  			//2009/4/10 Tina modify:Fixed can't save space char.
				var tmp_schedule = get_schedule_value(i);
				temp_appl.value = is_enable + "/" + get_by_id("name" + i).value + "/" + get_by_id("trigger" + i).value 
					+ "/" + get_by_id("trigger_port" + i).value + "/" + get_by_id("public" + i).value 
					+ "/" + get_by_id("public_port" + i).value + "/" + tmp_schedule;
				
				//temp_appl.value = is_enable + "/" + get_by_id("name" + i).value + "/" + get_by_id("trigger" + i).value 
				//	+ "/" + get_by_id("trigger_port" + i).value + "/" + get_by_id("public" + i).value 
				//	+ "/" + get_by_id("public_port" + i).value + "/" + get_by_id("schedule" + i).value;
		        count++;		     	
			} 			
		}
		
		
		if(submit_button_flag == 0){
		submit_button_flag = 1;
		return true;
		}else{
		return false;
		}
		//return true;
	}
    
</script>    
<title>D-Link公司 | 无线路由器 | 主页</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
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
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(which_lang[_support])</script></a></td>
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
                            <LI><div><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_virtserv])</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(which_lang[_pf])</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(which_lang[_specappsr])</script></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(which_lang[YM48])</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(which_lang[_acccon])</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script></a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                          </UL>
                      	</div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
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
				
                <form id="form1" name="form1" method="post" action="apply.cgi">
                <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
								<input type="hidden" id="html_response_message" name="html_response_message" value="">
								<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
								<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_appl.asp">
								<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
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
                
                
                
			<td valign="top" id="maincontent_container">
				<div id=maincontent>			
                  <div id=box_header>
                    <h1><script>show_words(which_lang[_specappsr])</script></h1>                    
                    <script>show_words(which_lang[as_intro_SA])</script>
            <br><br>
          	<input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
            <input name="button2" id="button2" type=button class=button_submit value="" onclick="page_cancel('form1', 'adv_appl.asp');">
            <script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
            <script>get_by_id("button").value = which_lang[_savesettings];</script>
			      </div>
                  <div class=box>
                    <h2><script>document.write(rule_max_num)</script> &ndash;&ndash; <script>show_words(which_lang[_specappsr])</script></h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=middle width=20>&nbsp;</td>
                          <td width="75">&nbsp;</td>
                          <td align=middle><div align="left">&nbsp;</div></td>
                          <td align=middle><div align="left"><strong><script>show_words(which_lang[sps_port])</script></strong></div></td>
                          <td align=middle><div align="left"><strong><script>show_words(which_lang[av_traftype])</script></strong></div></td>
                          <td align=middle><div align="left"><strong><script>show_words(which_lang[_sched])</script></strong></div></td>
                        </tr>
						<script>
							var Application_list = set_application_option(Application_list, default_appl);
							for(var i=0 ; i< rule_max_num ; i++){
							document.write("<tr>");
							document.write("<td align=center rowspan=2><input type=checkbox id=enable" + i + " name=enable" + i + " value=1></td>");
							document.write('<td rowspan=2 align=center valign=middle>'+which_lang[_name]+'<br><input type=text class=flatL id=name' + i + ' name=name' + i + ' size=15 maxlength=31></td>');
							document.write('<td rowspan=2 align=center valign=middle>'+which_lang[_app]+'<br>');
							document.write("<input id=copy_app" + i + " name=copy_app" + i + " type=button value=<< class=btnForCopy onClick='copy_special_appl(" + i + ")'>");
							document.write("<select class=wordstyle style='width:108' id=application" + i +" name=application" + i +" modified=\"ignore\">");
							document.write('<option>'+which_lang[gw_SelVS]+'</option>');
							document.write(Application_list);
							document.write("</select></td>");
							
							document.write('<td align=center valign=bottom>'+which_lang[_trigger]+'<br><input type=text class=flatL id=trigger_port' + i +' name=trigger_port' + i +' maxLength=31 size=5></td>');
							document.write("<td align=center valign=middle>");
							document.write("<select class=wordstyle id=trigger" + i + " name=trigger" + i +" >");
							document.write('<option value=\"TCP\">'+which_lang[_TCP]+'</option>');
							document.write('<option value=\"UDP\">'+which_lang[_UDP]+'</option>');
							document.write('<option value=\"Any\" selected>'+which_lang[at_Any]+'</option>');
							document.write("</select></td>");
							document.write("<td rowspan=2 align=center valign=middle>");
							document.write("<select width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>");
							document.write('<option value=\"Always\" selected>'+which_lang[_always]+'</option>');
							document.write('<option value=\"Never\">'+which_lang[_never]+'</option>');
							document.write(set_schedule_option());
							document.write("</select>");
							document.write("</td>");
							document.write("</tr>");
							
							document.write("<tr>");
							document.write('<td align=center valign=bottom>'+which_lang[_firewall]+'<br><input type=text class=flatL id=public_port' + i + ' name=public_port'+ i +' maxLength=31 size=5></td>');
							document.write("<td align=center valign=middle>");
							document.write("<select class=wordstyle id=public" + i + " name=public" + i +" >");
							document.write('<option value=\"TCP\">'+which_lang[_TCP]+'</option>');
							document.write('<option value=\"UDP\">'+which_lang[_UDP]+'</option>');
							document.write('<option value=\"Any\" selected>'+which_lang[at_Any]+'</option>');
							document.write("</select></td>");			
							document.write("</tr>");
                                                        }
							
						</script>
                      </tbody>
                    </table>
                  </div>                 
			  </div>
			</td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(which_lang[_hints])</script>&hellip;</b>
                      	<p><script>show_words(which_lang[hhpt_intro])</script></p>
						<p><script>show_words(which_lang[hhpt_app])</script></p>
						<p><script>show_words(which_lang[hhpt_sch])</script></p>
						<p><a href="support_adv.asp#Special_Applications" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
	set_application();
	set_form_default_values("form1");
</script>
</html>
