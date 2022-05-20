<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	function onPageLoad(){
	  var link_local ;
	  var ipv6_advert_lifetime = document.getElementById("ipv6_ra_adv_default_lifetime_l").value;
	  get_by_id("ipv6_static_adver_lifetime").value = ipv6_advert_lifetime/60;
		link_local = document.getElementById("link_local_ip_l").value;
	  document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
		set_checked(get_by_id("ipv6_autoconfig").value, get_by_id("ipv6_autoconfig_sel"));
		set_selectIndex("<% CmoGetCfg("ipv6_autoconfig_type","none"); %>", get_by_id("ipv6_autoconfig_type"));
		set_ipv6_autoconfiguration_type();
		set_form_default_values("form1");
	}
	function set_ipv6_autoconf_range(){
			var ipv6_lan_ip = get_by_id("ipv6_static_lan_ip").value;
			var prefix_length = 112;
			var correct_ipv6="";
			if(ipv6_lan_ip != ""){
					correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
					get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
          get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
			}
	}
	function set_ipv6_stateful_range()
	{
			var prefix_length = 112;
			var ipv6_lan_ip = get_by_id("ipv6_static_lan_ip").value;
			var ipv6_dhcpd_start_range = get_by_id("ipv6_dhcpd_start").value;
			var ipv6_dhcpd_end_range = get_by_id("ipv6_dhcpd_end").value;
			var correct_ipv6="";
			if(ipv6_lan_ip != ""){
					correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
					get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
					get_by_id("ipv6_addr_range_start_suffix").value  = get_stateful_suffix(ipv6_dhcpd_start_range);
		    	get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
					get_by_id("ipv6_addr_range_end_suffix").value  = get_stateful_suffix(ipv6_dhcpd_end_range);
      }
	}
	function set_ipv6_autoconfiguration_type(){
 		var mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
		switch(mode){
		case 0:	//Stateless
			get_by_id("show_ipv6_addr_range_start").style.display = "none";
			get_by_id("show_ipv6_addr_range_end").style.display = "none";
			get_by_id("show_ipv6_addr_lifetime").style.display ="none";
			get_by_id("show_router_advert_lifetime").style.display = "";
			break;
		case 1: //Stateful DHCPv6
			set_ipv6_autoconf_range();
			get_by_id("ipv6_addr_range_start_prefix").disabled = true;
			get_by_id("ipv6_addr_range_end_prefix").disabled = true;
			get_by_id("show_ipv6_addr_range_start").style.display = "";
			get_by_id("show_ipv6_addr_range_end").style.display = "";
			get_by_id("show_ipv6_addr_lifetime").style.display ="";
			get_by_id("show_router_advert_lifetime").style.display = "none";
			break;
		default:
			get_by_id("show_ipv6_addr_range_start").style.display = "none";
			get_by_id("show_ipv6_addr_range_end").style.display = "none";
			get_by_id("show_ipv6_addr_lifetime").style.display ="none";
			get_by_id("show_channel_width").style.display = "";
			break;
		}
  }
function send_request(){
	var ipv6_static = get_by_id("ipv6_static_wan_ip").value;
	var ipv6_static_msg = replace_msg(all_ipv6_addr_msg,"IPv6 address");
	var temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
	var prefix_length_msg = replace_msg(check_num_msg, "Subnet Prefix Length", 0, 128);
	var prefix_length_obj = new varible_obj(get_by_id("ipv6_static_prefix_length").value, prefix_length_msg, 0, 128, false);
	var ipv6_static_gw = get_by_id("ipv6_static_default_gw").value;
	var ipv6_static_gw_msg = replace_msg(all_ipv6_addr_msg,"Default Gateway");
	var temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
	var primary_dns = get_by_id("ipv6_static_primary_dns").value;	
	var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,"Primary DNS Address");	
	var secondary_dns = get_by_id("ipv6_static_secondary_dns").value;	
	var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,"Secondary DNS Address");	
	var ipv6_lan = get_by_id("ipv6_static_lan_ip").value;
	var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg,"LAN IPv6 Address");
	var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
	var check_mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
	var enable_autoconfig = get_by_id("ipv6_autoconfig").value;
	var addr_lifetime_msg = replace_msg(check_num_msg, "Address Lifetime", 0, 9999);
	var addr_lifetime_obj = new varible_obj(get_by_id("ipv6_dhcpd_lifetime").value, addr_lifetime_msg, 0, 9999, false);
	var adver_lifetime_msg = replace_msg(check_num_msg, "Advertisement Lifetime", 0, 9999);
	var adver_lifetime_obj = new varible_obj(get_by_id("ipv6_static_adver_lifetime").value, adver_lifetime_msg , 0, 9999, false);
	var ipv6_addr_s_suffix = get_by_id("ipv6_addr_range_start_suffix").value;
	var ipv6_addr_e_suffix = get_by_id("ipv6_addr_range_end_suffix").value;
	get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;
	get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
	// check the ipv6 address
	if(check_ipv6_symbol(ipv6_static,"::")==2){ // find two '::' symbol
			return false;
	}else if(check_ipv6_symbol(ipv6_static,"::")==1){    // find one '::' symbol
			temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split("::"), ipv6_static_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_static,"::")){
				return false;
			}
	}else{	//not find '::' symbol
			temp_ipv6_static = new ipv6_addr_obj(ipv6_static.split(":"), ipv6_static_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_static,":")){
				return false;
			}
	}
	//check the Subnet Prefix Length
	if (!check_varible(prefix_length_obj)){
  			return false;
    	}
    //check Default Gateway
    if(check_ipv6_symbol(ipv6_static_gw,"::")==2){ // find two '::' symbol
				return false;
		}else if(check_ipv6_symbol(ipv6_static_gw,"::")==1){    // find one '::' symbol
				temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split("::"), ipv6_static_gw_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_static_gw,"::")){
					return false;
				}
		}else{	//not find '::' symbol
				temp_ipv6_static_gw = new ipv6_addr_obj(ipv6_static_gw.split(":"), ipv6_static_gw_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_static_gw,":")){
					return false;
				}
		}
		//check DNS Address
		
		//check LAN IP Address
		if(check_ipv6_symbol(ipv6_lan,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(ipv6_lan,"::")==1){    // find one '::' symbol
			temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split("::"), ipv6_lan_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_lan ,"::")){
				return false;
			}
		}else{	//not find '::' symbol
			temp_ipv6_lan  = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_lan,":")){
				return false;
			}
		}
    if(check_mode == 0 && enable_autoconfig == 1){
    			//check the Router Advertisement Lifetime
    			if (!check_varible(adver_lifetime_obj)){
    				return false;
    			}
    		 	//set Advertisement Lifetime
					get_by_id("ipv6_ra_adv_default_lifetime_l").value = get_by_id("ipv6_static_adver_lifetime").value * 60 ;
    }else if(check_mode == 1 && enable_autoconfig == 1){
    		  //check the suffix of Address Range(Start)
    		  if(!check_ipv6_address_suffix(ipv6_addr_s_suffix,"Address Range(Start)")){
							return false;
					}
					//check the suffix of Address Range(End)
					if(!check_ipv6_address_suffix(ipv6_addr_e_suffix,"Address Range(End)")){
							return false;
					}
					//compare the suffix of start and the suffix of end
					if(!compare_suffix(ipv6_addr_s_suffix,ipv6_addr_e_suffix)){
    				return false;
    			}
    			//check the IPv6 Address Lifetime
    			if (!check_varible(addr_lifetime_obj)){
    				return false;
    			}
    			//set autoconfiguration range value
					get_by_id("ipv6_dhcpd_start").value = get_by_id("ipv6_addr_range_start_prefix").value + ":" +	get_by_id("ipv6_addr_range_start_suffix").value;
					get_by_id("ipv6_dhcpd_end").value = get_by_id("ipv6_addr_range_end_prefix").value + ":" +	get_by_id("ipv6_addr_range_end_suffix").value;
    }
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
			return true;
		}else{
			return false;
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
                            <LI><div><a href="adv_virtual.asp" onclick="return jump_if();">Virtual Server</a></div></LI>
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
						    <LI><div id=sidenavoff style=" text-transform:none">IPv6</div></LI>
                          </UL>
                      	</div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
	       <form id="form1" name="form1" method="post" action="apply.cgi">
	            <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
		    <input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
		    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_static.asp">
		    <input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="<% CmoGetCfg("ipv6_autoconfig","none"); %>">
		    <input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="<% CmoGetCfg("ipv6_dhcpd_start","none"); %>">
		    <input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="<% CmoGetCfg("ipv6_dhcpd_end","none"); %>">
		    <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto","none"); %>">
		    <input type="hidden" id="ipv6_ra_adv_default_lifetime_l" name="ipv6_ra_adv_default_lifetime_l" value="<% CmoGetCfg("ipv6_ra_adv_default_lifetime_l","none"); %>">
		    <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<% CmoGetStatus("link_local_ip_l","none"); %>">
		    <input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">
		    <input type="hidden" id="page_type" name="page_type" value="IPv6">
               <td valign="top" id="maincontent_container">
				<div id=maincontent>
		  <div id=box_header>
                    <h1>IPv6</h1>
            Use this section to configure your IPv6 Connection type. If you are
          unsure of your connection method, please contact your Internet Service
          Provider.<br>
                    <br>
                    <input name="button" type="button" class=button_submit value="Save Settings" onClick="return send_request()">
                    <input name="button2" type=button class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'adv_ipv6_static.asp');">
                 </div>
                  <div class=box>
                    <h2 style=" text-transform:none">
                   IPv6 CONNECTION TYPE</h2>
				   <p class="box_msg">Choose the mode to be used by the router to the IPv6 Internet.</p>
                   <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="187" class="duple">My IPv6 Connection is :</td>
                      <td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
                        <option value="ipv6_static" selected>Static IPv6</option>
                        <option value="ipv6_dhcp">DHCPv6</option>
                        <option value="ipv6_pppoe">PPPoE</option>
                        <option value="ipv6_6in4">IPv6 in IPv4 Tunnel</option>
                        <option value="ipv6_6to4">6 to 4</option>
			<!--option value="ipv6_stateless" selected>Stateless Autoconfiguration</option-->
                        <option value="link_local">Link-local only</option>
                      </select></td>
                    </tr>
                   </table>
                  </div>
	         <div class=box id=wan_ipv6_settings>
	                <h2 style=" text-transform:none">WAN IPv6 ADDRESS SETTINGS  : </h2>
					<p class="box_msg">Enter the IPv6 address information provided by your Internet Service Provider (ISP). </p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
	                    <tr>
	                      <td width="187" align=right class="duple">IPv6 Address :</td>
	                      <td width="331">&nbsp;
	                      	<input type=text id="ipv6_static_wan_ip" name="ipv6_static_wan_ip" size="30" maxlength="63" value="<% CmoGetCfg("ipv6_static_wan_ip","none"); %>">
	                      </td>
	                    </tr>
	                    <tr>
	                      <td align=right class="duple">Subnet Prefix Length :</td>
	                      <td>&nbsp;
	                      	<input type=text id="ipv6_static_prefix_length" name="ipv6_static_prefix_length" size="5" maxlength="63" value="<% CmoGetCfg("ipv6_static_prefix_length","none"); %>">
	                      </td>
	                    </tr>
	                    <tr>
	                      <td align=right class="duple">Defautl Gateway :</td>
	                      <td>&nbsp;
	                      	<input type=text id="ipv6_static_default_gw" name="ipv6_static_default_gw" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_static_default_gw","none"); %>">
	                      </td>
	                    </tr>
	                    <tr>
	                      <td align=right class="duple">Primary DNS Address :</td>
	                      <td>&nbsp;
		                      <input type=text id="ipv6_static_primary_dns" name="ipv6_static_primary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_static_primary_dns","none"); %>">
	                      </td>
	                    </tr>
	                    <tr>
	                      <td align=right class="duple">Secondary DNS Address :</td>
	                      <td>&nbsp;
		                      <input type=text id="ipv6_static_secondary_dns" name="ipv6_static_secondary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_static_secondary_dns","none"); %>">
	                      </td>
	                    </tr>
	                </table>
                 </div>
		 <div class=box id=lan_ipv6_settings>
	                <h2 style=" text-transform:none">LAN IPv6 ADDRESS SETTINGS  : </h2>
					<p align="justify" class="style1">Use this section to configure the internal network setings of your router. If you change the LAN IPv6 Address here, you may need to adjust your PC's network settings to access the network again. </p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
	                    <tr>
	                      <td width="187" align=right class="duple">LAN IPv6 Address :</td>
	                      <td width="331">&nbsp;
	                      	<input type=text id="ipv6_static_lan_ip" name="ipv6_static_lan_ip" size="30" maxlength="63" value="<% CmoGetCfg("ipv6_static_lan_ip","none"); %>" onChange="set_ipv6_autoconf_range()">
	                      	<b>/64</b>
	                      </td>
			    </tr>
			    <tr>
			      <td width="187" align=right class="duple">LAN IPv6 Link-Local Address :</td>
	                      <td width="331">&nbsp;
	                      	<b><span id="lan_link_local_ip"></span></b>
	                      </td>
                      </tr>
			</table>
                 </div>
		 <div class="box" id=ipv6_autoconfiguration_settings>
			  <h2>ADDRESS AUTOCONFIGURATION SETTINGS</h2>
			  <p align="justify" class="style1">Use this section to setup IPv6 Autoconfiguration to assign IP addresses to the computers on your network.</p>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td width="187" class="duple">Enable Autoconfiguration :</td>
                                  <td width="331">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1"></td>
                                </tr>
                                <tr>
                                <td class="duple">Autoconfiguration Type :</td>
                                  <td width="331">&nbsp;
				   <select id="ipv6_autoconfig_type" name="ipv6_autoconfig_type" onChange="set_ipv6_autoconfiguration_type()">
				      <option value="stateless">Stateless</option>
				      <option value="stateful">Stateful (DHCPv6)</option>
				   </select>
				  </td>
                                </tr>
                                <tr id="show_ipv6_addr_range_start" style="display:none">
				     <td class="duple">IPv6 Address Range(Start):</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_start_prefix" name="ipv6_addr_range_start_prefix" size="35" maxlength="34">
				     :<input type=text id="ipv6_addr_range_start_suffix" name="ipv6_addr_range_start_suffix" size="5" maxlength="4">
				     <b>/64</b>
				     </td>
				</tr>
				<tr id="show_ipv6_addr_range_end" style="display:none">
				     <td class="duple">IPv6 Address Range(End):</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_end_prefix" name="ipv6_addr_range_end_prefix" size="35" maxlength="34">
				     :<input type=text id="ipv6_addr_range_end_suffix" name="ipv6_addr_range_end_suffix" size="5" maxlength="4">
				     <b>/64</b>
				     </td>
				</tr>
				<tr id="show_ipv6_addr_lifetime" style="display:none">
				     <td class="duple">IPv6 Address Lifetime:</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="15" value="<% CmoGetCfg("ipv6_dhcpd_lifetime","none"); %>">
				     (minutes)</td>
				</tr>
				<tr id="show_router_advert_lifetime">
				     <td class="duple">Router Advertisement Lifetime:</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_static_adver_lifetime" name="ipv6_static_adver_lifetime" size="20" maxlength="15" value="">
				     (minutes)</td>
				</tr>
                          </table>
		 </div>
               </td>
               </form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b>Helpful Hints&hellip;</b>
                      	<p>When configuring the router to access the IPv6 Internet,
                be sure to choose the correct IPv6 Connection Type from the drop
                down menu. If you are unsure of which option to choose, contact
                your Internet Service Provider (ISP).</p>
              <p>If you are having trouble accessing the IPv6 Internet through
                the router, double check any settings you have entered on this
                page and verify them with your ISP if needed.</p>
				<p><a href="support_adv.asp#ipv6" onclick="return jump_if();">More&hellip;</a></p>
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
	set_ipv6_stateful_range();
</script>
</html>
