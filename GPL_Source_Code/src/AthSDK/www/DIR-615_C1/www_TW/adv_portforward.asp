<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 24;
	var DHCPList_word = "";
	var is_chk_public_port = 0;
	var is_chk_private_port = 0;
	var inbound_used = 1;
		
	function onPageLoad(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_pf;
			if (i > 9){
				temp_pf = get_by_id("port_forward_both_" + i).value;
			}else{
				temp_pf = get_by_id("port_forward_both_0" + i).value;				
			}
			
			if(temp_pf ==""){
				if (i > 9){
					 get_by_id("port_forward_both_" + i).value = "0//0.0.0.0/0/0/Always/Allow_All";
				}else{
					get_by_id("port_forward_both_0" + i).value = "0//0.0.0.0/0/0/Always/Allow_All";				
				}
			}
		}
	
		set_port_forwarding();
		set_form_default_values("form1");
	}

	function set_port_forwarding(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_pf;
			
			if (i > 9){
				temp_pf = (get_by_id("port_forward_both_" + i).value).split("/");
			}else{
				temp_pf = (get_by_id("port_forward_both_0" + i).value).split("/");				
			}
			
			if (temp_pf.length > 1){
				set_checked(temp_pf[0], get_by_id("enable" + i));
				get_by_id("name" + i).value = temp_pf[1];
				get_by_id("ip" + i).value = temp_pf[2];
				get_by_id("tcp_ports" + i).value = temp_pf[3];
				get_by_id("udp_ports" + i).value = temp_pf[4];

			  	//2009/4/20 Tina modify:Fixed schedule can't selected.
				if((temp_pf[5] == "Always") || (temp_pf[5] == "Never") || (temp_pf[5] == "")){
					set_selectIndex(temp_pf[5], get_by_id("schedule" + i));
   				}else{
				  	var temp_index = get_schedule_index(temp_pf[5]);
		   		    get_by_id("schedule" + i).selectedIndex=temp_index+2;
     			}			  	
				set_selectIndex(temp_pf[6], get_by_id("inbound_filter" + i));
			}
		}
	}

	function check_vistual_port(potocol,chk_port, obj_word){
	
			var chk_port_arry = chk_port.split(",");				 
			var checkTimes = chk_port_arry.length;	
			  
		for (var i = 0; i < checkTimes; i++){  // get chk_port_arry data
				var port = chk_port_arry[i].split("-");
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
					  	if(potocol == temp_vs[2] || temp_vs[2]==256){
					  			if (port2 == ""){			  	
							  		if(port1 == temp_vs[3]){
							  				//alert(obj_word + " conflict with Virtual Server Port.");
							  				alert(obj_word + "和虛擬伺服器的服務埠衝突");//TEXT056
												return false;	
										}
									}
									else{//range
										if(parseInt(port1) <= parseInt(temp_vs[3]) && parseInt(port2) >= parseInt(temp_vs[3])){
									 	    //alert(obj_word + " conflict with Virtual Server Port.");
									 	    alert(obj_word + "和虛擬伺服器的服務埠衝突");
									 	    return false;							
										}	
								}
							}	
						}
				}
		}	
		return true;
	}
	
	function check_app_port(potocol,chk_port, obj_word){
			var chk_port_arry = chk_port.split(",");				 
			var checkTimes = chk_port_arry.length;	
			  
		for (var i = 0; i < checkTimes; i++){  // get chk_port_arry data
				var port = chk_port_arry[i].split("-");
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
						var chk_appport_arry = temp_app[5].split(",");
						var checkAppTimes = chk_appport_arry.length;	
						for (var m = 0; m < checkAppTimes; m++){ // split the application port range
							var Aport = chk_appport_arry[m].split("-");
							var Aport1 = "";
							var Aport2 = "";	
							Aport1 = Aport[0];
											
							if (Aport.length > 1){
							Aport2 = Aport[1];
							}
						if(temp_app[0]== "1"){
					  	if(potocol == 6 && temp_app[4]== "TCP" || potocol == 17 && temp_app[4]== "UDP" ||temp_app[4]== "Any"){
					  		
					  			if (port2 == "" || Aport2 == ""){	//when PF is sigle port or APP is sigle port		  	
							  		if(port1 == Aport1){
							  				//alert(obj_word + " conflict with Application Firewall Port.");
							  				alert(obj_word + "和應用程式防火牆的服務埠衝突");
									 	    return false;	
										}else if (port2 == ""){ //when PF is sigle port, APP is range port										
												if(parseInt(port1) >= parseInt(Aport1) && parseInt(port1) <= parseInt(Aport2)||parseInt(port2) >= parseInt(Aport1) && parseInt(port2) <= parseInt(Aport2)){
												//alert(obj_word + " conflict with Application Firewall Port.");
												alert(obj_word +  "和應用程式防火牆的服務埠衝突");
									 	    	return false;								
												}											
										}else if (Aport2 == ""){ //when APP is sigle port, PF is range port										
												if(parseInt(Aport1) >= parseInt(port1) && parseInt(Aport1) <= parseInt(port2)||parseInt(Aport2) >= parseInt(port1) && parseInt(Aport2) <= parseInt(port2)){
												//alert(obj_word + " conflict with Application Firewall Port.");
												alert(obj_word + "和應用程式防火牆的服務埠衝突");
									 	   		return false;								
												}											
										}
										
									}else{//PF is range port, APP is sigle port
										if(parseInt(port1) <= parseInt(Aport1) && parseInt(port2) >= parseInt(Aport1)){
									 	    //alert(obj_word + " conflict with Application Firewall Port.");
									 	    alert(obj_word + "和應用程式防火牆的服務埠衝突");
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
	
	function check_forward_port(index, chk_port, obj_word){
		for(ii=(index+1); ii<rule_max_num; ii++){
		
			if(chk_port != 0){
				if(get_by_id("tcp_ports" + ii).value == chk_port){
					alert("TCP埠衝突.");		
					return false;
				}
			
				if(get_by_id("udp_ports" + ii).value == chk_port){
					alert("UDP埠衝突.");		
					return false;
				}
		}
						
		}
						
		return true;
	}

	function send_request(){
		//if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
		if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_port_name = get_by_id("name" + i).value;			
			if (temp_port_name != ""){
				for (var j = i+1; j < rule_max_num; j++){
					if (temp_port_name == get_by_id("name" + j).value){
						alert("此服務埠轉傳的名稱已經在清單內");
						//alert("Name " + temp_port_name + " is already used.");
						return false;
					}
				}
			}
		}
		
		for (var i = 0; i < rule_max_num; i++){		
			var ip = get_by_id("ip" + i).value;
			
			var lan_ip = "<% CmoGetCfg("lan_ipaddr","none"); %>";
			var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
			var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
			
			var temp_pf;
			
			if (parseInt(i,10) >= 10){
				get_by_id("port_forward_both_" + i).value = "";
			}else{
				get_by_id("port_forward_both_0" + i).value = "";
			}
			
			if (get_by_id("name" + i).value != ""){
					check_name = get_by_id("name" + i).value;
					//if(Find_word(check_name,"'") || Find_word(check_name,'"') || Find_word(check_name,"/")){
					if(Find_word(check_name,'"') || Find_word(check_name,"/")){
					alert("服務埠轉傳名稱 "+ i +"無效，不正確的字元',/,''");
					return false;
					}
				
					if (!check_address(temp_ip_obj)){
		            return false;
		      }
        		        
					if (get_by_id("tcp_ports" + i).value == "0" && get_by_id("udp_ports" + i).value == "0"){
						alert("請輸入一個TCP埠數字或一個UDP埠數字.");
						//alert(which_lang[ag_alert2]);
		        		return false;
		      		        }
                                        //if (get_by_id("tcp_ports" + i).value == "" && get_by_id("udp_ports" + i).value == ""){
						//alert("Please enter a TCP port number or a UDP port number.");
						//alert(which_lang[GW_NAT_PORT_FORWARD_RANGE_BOTH_EMPTY_INVALID]);
		        		//return false;
		      		//}
        		        
                                 //check dhcp ip range equal to lan-ip or not?
					if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_ip_obj.addr, which_lang[help256])){
						return false;
					}
		      		
					//check port forwarding tcp port and remote management port conflict problem
					var remote_port = "<% CmoGetCfg("remote_http_management_port","none"); %>";
					var remote_port_enable = "<% CmoGetCfg("remote_http_management_enable","none"); %>";
										
					if(get_by_id("tcp_ports" + i).value != ""){
							if(get_by_id("enable" + i).checked == true){
								if(remote_port_enable == "1"){
							if(!check_multi_port(remote_port, get_by_id("tcp_ports" + i).value)){
								//alert("TCP port conflict with Remote Management HTTP port.");
								alert("TCP 通訊埠[" + get_by_id("tcp_ports" + i).value+ "]和遠端管理的通訊埠衝突");	//ag_conflict4
								return false;
							}
								}
							}
								
							if(get_by_id("enable" + i).checked == true){
							  	if(!check_vistual_port(6,get_by_id("tcp_ports" + i).value, which_lang[_vs_port])){
									return false;
								  }
								  if(!check_app_port(6,get_by_id("tcp_ports" + i).value, which_lang[_vs_port])){
									return false;
								  }
								
								  if(!check_forward_port(6, get_by_id("tcp_ports" + i).value, which_lang[_vs_port])){
									return false;
								}
							}
					}else{
						get_by_id("tcp_ports" + i).value = "0";
					}
				
				if(get_by_id("udp_ports" + i).value != ""){
					if(get_by_id("enable" + i).checked == true){
						if(!check_vistual_port(17,get_by_id("udp_ports" + i).value, which_lang[_vs_port])){
							return false;
						}
						if(!check_app_port(17,get_by_id("udp_ports" + i).value, which_lang[_vs_port])){
									return false;
						}
						if(!check_forward_port(17, get_by_id("udp_ports" + i).value, which_lang[_vs_port])){
							return false;
						}
					}
				}else{
					get_by_id("udp_ports" + i).value = "0";
				}
				//if port value have blank, replace to ""
				get_by_id("tcp_ports" + i).value = get_by_id("tcp_ports" + i).value.replace(/ /,"");
				get_by_id("udp_ports" + i).value = get_by_id("udp_ports" + i).value.replace(/ /,"");
			

		    var is_enable = get_checked_value(get_by_id("enable" + i));
		    if (count > 9){
					temp_pf = get_by_id("port_forward_both_" + count);
				}else{
					temp_pf = get_by_id("port_forward_both_0" + count);
				}
				
	  			//2009/4/10 Tina modify:Fixed can't save space char.
				var tmp_schedule = get_schedule_value(i);
				temp_pf.value = is_enable + "/" + get_by_id("name" + i).value + "/" + get_by_id("ip" + i).value
					+ "/" + get_by_id("tcp_ports" + i).value  + "/"+ get_by_id("udp_ports" + i).value 
					+ "/" + tmp_schedule + "/" + get_by_id("inbound_filter" + i).value;
				
				//temp_pf.value = is_enable + "/" + get_by_id("name" + i).value + "/" + get_by_id("ip" + i).value
				//	+ "/" + get_by_id("tcp_ports" + i).value  + "/"+ get_by_id("udp_ports" + i).value 
				//	+ "/" + get_by_id("schedule" + i).value + "/" + get_by_id("inbound_filter" + i).value;
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

<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
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
                            <LI><div id=sidenavoff><script>show_words(which_lang[_pf])</script></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(which_lang[_specappsr])</script></a></div></LI>
							<LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(which_lang[YM48])</script></a></div></LI>
							<LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
							<LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(which_lang[_acccon])</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
							<@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script> </a></div></LI>
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
										<input type="hidden" id="html_response_message" name="html_response_message" value="">
										<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
										<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_portforward.asp">
										<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
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
            <h1> 
              <script>show_words(which_lang[_pf])</script>
            </h1>
            <script>show_words(which_lang[ag_intro])</script>
            <br>
            <br>
           	<input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
			<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel('form1', 'adv_portforward.asp');">
			<script>get_by_id("button").value = which_lang[_savesettings];</script>
			<script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
		  </div>
          <div class=box> 
            <h2>
              <script>document.write(rule_max_num)</script>
              &ndash;&ndash; 
              <script>show_words(which_lang[ag_title_4])</script>
            </h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=middle width=20>&nbsp;</td>
                          <td width="36">&nbsp;</td>
                          <td width="200">&nbsp;</td>
                          <td width="120" align=middle><div align="center"><script>show_words(which_lang[sps_ports])</script></div></td>
                          <td width="120">&nbsp;</td>
                        </tr>
                        <script>
							var Application_list = set_application_option(Application_list, default_rule);
							var Inbound_list = set_inbound_option(Inbound_list, inbound_used);
							for(var i=0 ; i<rule_max_num ; i++){
								document.write("<tr>");
								document.write("<td align=center valign=middle rowspan=2><input type=checkbox id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>");
								document.write('<td valign=bottom>'+which_lang[_name]+'<br><input type=text class=flatL id=\"name' + i + '\" name=\"name' + i +'\" size=16 maxlength=31></td>');
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_app" + i + " name=copy_app" + i + " type=button value=<< onClick='copy_portforward(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:140' id=application" + i +" name=application" + i +" modified=\"ignore\">");
								document.write('<option>'+which_lang[gw_SelVS]+'</option>');
								document.write(Application_list);
								document.write("</select></td>");
								document.write('<td align=center valign=bottom>'+which_lang[_TCP]+'<br>');
								document.write("<input type=text class=flatL id=tcp_ports" + i + " name=tcp_ports" + i +" size=16></td>");
								document.write('<td align=center>'+which_lang[_sched]+'<br>');
								document.write("<select width=30 id=schedule" + i + " name=schedule" + i + " style='width:70'>");
								document.write('<option value=\"Always\" selected>'+which_lang[_always]+'</option>');
								document.write('<option value=\"Never\" selected>'+which_lang[_never]+'</option>');
								document.write(set_schedule_option());
								document.write("</select>");
								document.write("</td>");
								document.write("</tr>");
								
								document.write("<tr>");
								document.write('<td valign=bottom>'+which_lang[_ipaddr]+'<br><input type=text class=flatL  id=ip' + i + ' name=ip' + i +' size=16 maxlength=15></td>');
								document.write("<td align=left valign=bottom>");
								document.write("<input id=copy_ip" + i + " name=copy_ip" + i + " type=button value=<< onClick='copy_ip(" + i + ")' style=\"width: 23;\">");
								document.write("<select style='width:140' id=ip_list" + i +" name=ip_list" + i +" modified=\"ignore\">");
								document.write('<option value=-1>'+which_lang[bd_CName]+'</option>');
								document.write(set_mac_list("ip"));			
								document.write("</select></td>");
								document.write('<td align=center valign=bottom>'+which_lang[_UDP]+'<br>');
								document.write("<input type=text class=flatL id=udp_ports" + i + " name=udp_ports" + i +" size=16></td>");
								document.write('<td align=center>'+which_lang[INBOUND_FILTER]+'<br>');
								document.write("<select width=30 id=inbound_filter" + i + " name=inbound_filter" + i + " style='width:70'>");
								document.write('<option value=\"Allow_All\" selected>'+which_lang[_allowall]+'</option>');
								document.write('<option value=\"Deny_All\">'+which_lang[_denyall]+'</option>');
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
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      
            <td id=help_text><b><strong> 
              <script>show_words(which_lang[_hints])</script>
              </strong>&hellip;</b> <p>
                <script>show_words(which_lang[hhag_10])</script>
              </p>
                        
              <p>
                <script>show_words(which_lang[hhag_20])</script>
              </p>
                        
              <p>
                <script>show_words(which_lang[hhag_30])</script>
              </p>
                        
              <p>
                <script>show_words(which_lang[hhag_40])</script>
              </p>
                      	
              <p> 
                <script>show_words(which_lang[help58])</script>
                <script>show_words(which_lang[help59])</script>
                <script>show_words(which_lang[help60])</script>
              </p>
						<p><a href="support_adv.asp#Gaming" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
</script>
</html>
