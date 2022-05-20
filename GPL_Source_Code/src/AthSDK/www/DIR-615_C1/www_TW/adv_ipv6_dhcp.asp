﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
function onPageLoad(){
		var link_local ;
		var ipv6_advert_lifetime = document.getElementById("ipv6_ra_adv_default_lifetime_l").value;
		get_by_id("ipv6_dhcp_adver_lifetime").value = ipv6_advert_lifetime/60;
		link_local = document.getElementById("link_local_ip_l").value;
	  document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
		set_checked(get_by_id("ipv6_autoconfig").value, get_by_id("ipv6_autoconfig_sel"));
		set_checked("<% CmoGetCfg("ipv6_dhcp_dns_enable","none"); %>", get_by_name("ipv6_dns_dhcp_enable"));
		disable_ipv6_dhcp_auto_dns();
		set_selectIndex("<% CmoGetCfg("ipv6_autoconfig_type","none"); %>", get_by_id("ipv6_autoconfig_type"));
		set_ipv6_autoconfiguration_type();
}
function disable_ipv6_dhcp_auto_dns(){
	    var fixIP = get_by_name("ipv6_dns_dhcp_enable");
	    var is_disabled;
	    if (fixIP[0].checked){
	    	is_disabled = true;
	    }else{
	    	is_disabled = false;
	    }
	    get_by_id("ipv6_dhcp_primary_dns").disabled = is_disabled;
	    get_by_id("ipv6_dhcp_secondary_dns").disabled = is_disabled;
}
function set_ipv6_autoconf_range(){
			var ipv6_lan_ip = get_by_id("ipv6_dhcp_lan_ip").value;
			var prefix_length = 64;
			var correct_ipv6="";
			if(ipv6_lan_ip != ""){
					correct_ipv6 = get_stateful_ipv6(ipv6_lan_ip);
					get_by_id("ipv6_addr_range_start_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
          get_by_id("ipv6_addr_range_end_prefix").value  = get_stateful_prefix(correct_ipv6,prefix_length);
			}
}
function set_ipv6_stateful_range(){
			var prefix_length = 64;
			var ipv6_lan_ip = get_by_id("ipv6_dhcp_lan_ip").value;
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
		case 0:
			get_by_id("show_ipv6_addr_range_start").style.display = "none";
			get_by_id("show_ipv6_addr_range_end").style.display = "none";
			get_by_id("show_ipv6_addr_lifetime").style.display ="none";
			get_by_id("show_router_advert_lifetime").style.display = "";
			break;
		case 1:
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
	var primary_dns = get_by_id("ipv6_dhcp_primary_dns").value;
//		var primary_dns_msg = replace_msg(all_ip_addr_msg,"Primary DNS Address");
	var v6_primary_dns_msg = replace_msg(all_ipv6_addr_msg,"Primary DNS Address");
//	var temp_primary_dns = new addr_obj(primary_dns.split("."), primary_dns_msg, false, false);
	var secondary_dns = get_by_id("ipv6_dhcp_secondary_dns").value;
	var secondary_dns_msg = replace_msg(all_ip_addr_msg,"Secondary DNS Address");
	var v6_secondary_dns_msg = replace_msg(all_ipv6_addr_msg,"Secondary DNS Address");
	var temp_secondary_dns = new addr_obj(secondary_dns.split("."), secondary_dns_msg, false, false);
	var ipv6_lan = get_by_id("ipv6_dhcp_lan_ip").value;
	var ipv6_lan_msg = replace_msg(all_ipv6_addr_msg,"LAN IPv6 Address");
	var temp_ipv6_lan = new ipv6_addr_obj(ipv6_lan.split(":"), ipv6_lan_msg, false, false);
	var check_mode = get_by_id("ipv6_autoconfig_type").selectedIndex;
	var enable_autoconfig = get_by_id("ipv6_autoconfig").value;
	var addr_lifetime_msg = replace_msg(check_num_msg, "Address Lifetime", 0, 9999);
	var addr_lifetime_obj = new varible_obj(get_by_id("ipv6_dhcpd_lifetime").value, addr_lifetime_msg, 0, 9999, false);
	var adver_lifetime_msg = replace_msg(check_num_msg, "Advertisement Lifetime", 0, 9999);
	var adver_lifetime_obj = new varible_obj(get_by_id("ipv6_dhcp_adver_lifetime").value, adver_lifetime_msg , 0, 9999, false);
	var ipv6_addr_s_suffix = get_by_id("ipv6_addr_range_start_suffix").value;
	var ipv6_addr_e_suffix = get_by_id("ipv6_addr_range_end_suffix").value;
	get_by_id("ipv6_autoconfig").value = get_checked_value(get_by_id("ipv6_autoconfig_sel"));
	get_by_id("ipv6_dhcp_dns_enable").value = get_checked_value(get_by_name("ipv6_dns_dhcp_enable"));
	get_by_id("ipv6_wan_specify_dns").value= get_by_id("ipv6_dhcp_dns_enable").value;
	get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;
	//check DNS Address
   /* if(get_by_id("ipv6_dhcp_dns_enable").value == 1){
		if(check_ipv6_symbol(primary_dns,"::")==2){ // find two '::' symbol
			return false;
		}else if(check_ipv6_symbol(primary_dns,"::")==1){    // find one '::' symbol
			temp_ipv6_primary_dns = new ipv6_addr_obj(primary_dns.split("::"), v6_primary_dns_msg, false, false);
		  	if (!check_ipv6_address(temp_ipv6_primary_dns ,"::")){
				return false;
			}
		}else{	//not find '::' symbol
			temp_ipv6_primary_dns  = new ipv6_addr_obj(primary_dns.split(":"), v6_primary_dns_msg, false, false);
			if (!check_ipv6_address(temp_ipv6_primary_dns,":")){
				return false;
			}
		}
		if (secondary_dns != ""){
			if(check_ipv6_symbol(secondary_dns,"::")==2){ // find two '::' symbol
				return false;
			}else if(check_ipv6_symbol(secondary_dns,"::")==1){    // find one '::' symbol
				temp_ipv6_secondary_dns = new ipv6_addr_obj(secondary_dns.split("::"), v6_secondary_dns_msg, false, false);
 				if (!check_ipv6_address(temp_ipv6_secondary_dns ,"::")){
					return false;
				}
			}else{	//not find '::' symbol
				temp_ipv6_secondary_dns  = new ipv6_addr_obj(secondary_dns.split(":"), v6_secondary_dns_msg, false, false);
				if (!check_ipv6_address(temp_ipv6_secondary_dns,":")){
					return false;
				}
			}
		}
     }*/
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
					get_by_id("ipv6_ra_adv_default_lifetime_l").value = get_by_id("ipv6_dhcp_adver_lifetime").value * 60 ;
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
					get_by_id("ipv6_dhcpd_start").value = get_by_id("ipv6_addr_range_start_prefix").value + "::" + get_by_id("ipv6_addr_range_start_suffix").value;
					get_by_id("ipv6_dhcpd_end").value = get_by_id("ipv6_addr_range_end_prefix").value + "::" + get_by_id("ipv6_addr_range_end_suffix").value;
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
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
.style2 {font-size: 12px}
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
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(which_lang[_specappsr])</script></a></div></LI>
							<LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(which_lang[YM48])</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(which_lang[_acccon])</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();"><script>show_words(which_lang[YM63])</script></a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script></a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                          </UL>
                      	</div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
	       <form id="form1" name="form1" method="post" action="apply.cgi">
		    <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
		    <input type="hidden" id="html_response_message" name="html_response_message" value="">
		    <script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
		    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_dhcp.asp">
		    <input type="hidden" id="ipv6_autoconfig" name="ipv6_autoconfig" value="<% CmoGetCfg("ipv6_autoconfig","none"); %>">
		    <input type="hidden" id="ipv6_dhcp_dns_enable" name="ipv6_dhcp_dns_enable" value="<% CmoGetCfg("ipv6_dhcp_dns_enable","none"); %>">
		    <input type="hidden" id="ipv6_dhcpd_start" name="ipv6_dhcpd_start" value="<% CmoGetCfg("ipv6_dhcpd_start","none"); %>">
		    <input type="hidden" id="ipv6_dhcpd_end" name="ipv6_dhcpd_end" value="<% CmoGetCfg("ipv6_dhcpd_end","none"); %>">
		    <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto","none"); %>">
		    <input type="hidden" id="ipv6_ra_adv_default_lifetime_l" name="ipv6_ra_adv_default_lifetime_l" value="<% CmoGetCfg("ipv6_ra_adv_default_lifetime_l","none"); %>">
		    <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<% CmoGetStatus("link_local_ip_l","none"); %>">
		    <input type="hidden" id="page_type" name="page_type" value="IPv6">
				<input type="hidden" id="ipv6_wan_specify_dns" name="ipv6_wan_specify_dns" value="1">
               <td valign="top" id="maincontent_container">
				<div id=maincontent>
		  <div id=box_header>
                    <h1>IPv6</h1>
                     <script>show_words(which_lang[IPV6_TEXT28])</script><br>
                    <br>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
            		<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel_1('form1', 'adv_ipv6_dhcp.asp');">
           			<script>get_by_id("button").value = which_lang[_savesettings];</script>
					<script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
				  </div>
                  <div class=box>
                    <h2 style=" text-transform:none">
                   <script>show_words(which_lang[IPV6_TEXT29])</script></h2>
				   <p class="box_msg"><script>show_words(which_lang[IPV6_TEXT30])</script></p>
                   <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="187" class="duple"><script>show_words(which_lang[IPV6_TEXT31])</script> :</td>
                      <td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
                        <option value="ipv6_static"><script>show_words(which_lang[IPV6_TEXT32])</script></option>
                        <option value="ipv6_dhcp" selected><script>show_words(which_lang[IPV6_TEXT33])</script></option>
                        <option value="ipv6_pppoe"><script>show_words(which_lang[IPV6_TEXT34])</script></option>
                        <option value="ipv6_6in4"><script>show_words(which_lang[IPV6_TEXT35])</script></option>
                        <option value="ipv6_6to4"><script>show_words(which_lang[IPV6_TEXT36])</script></option>
						<!--option value="ipv6_stateless"><script>show_words(which_lang[TEXT001])</script></option-->
                        <option value="link_local"><script>show_words(which_lang[IPV6_TEXT37])</script></option>
                      </select></td>
                    </tr>
                   </table>
                  </div>
	         <div class=box id=wan_ipv6_settings>
	                <h2 style=" text-transform:none"><script>show_words(which_lang[IPV6_TEXT63])</script>  : </h2>
					<p class="box_msg"><script>show_words(which_lang[IPV6_TEXT64])</script> </p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
						<tr>
							<td width="187" align=right><input type="radio" name="ipv6_dns_dhcp_enable" value="0" onClick="disable_ipv6_dhcp_auto_dns()" checked></td>
							<td width="331">&nbsp;<script>show_words(which_lang[IPV6_TEXT65])</script></td>
						</tr>
						<tr>
							<td width="187" align=right><input type="radio" name="ipv6_dns_dhcp_enable" value="1" onClick="disable_ipv6_dhcp_auto_dns()"></td>
							<td width="331">&nbsp;<script>show_words(which_lang[IPV6_TEXT66])</script></td>
						</tr>
	                    <tr>
	                      <td width="187" align=right class="duple"><script>show_words(which_lang[wwa_pdns])</script> :</td>
	                      <td width="331">&nbsp;<input type=text id="ipv6_dhcp_primary_dns" name="ipv6_dhcp_primary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_dhcp_primary_dns","none"); %>"></td>
	                    </tr>
	                    <tr>
	                      <td width="187" align=right class="duple"><script>show_words(which_lang[wwa_sdns])</script> :</td>
	                      <td width="331">&nbsp;<input type=text id="ipv6_dhcp_secondary_dns" name="ipv6_dhcp_secondary_dns" size="30" maxlength="39" value="<% CmoGetCfg("ipv6_dhcp_secondary_dns","none"); %>"></td>
	                    </tr>
	                </table>
                 </div>
		 <div class=box id=lan_ipv6_settings>
	                <h2 style=" text-transform:none"><script>show_words(which_lang[IPV6_TEXT44])</script>  : </h2>
					<p align="justify" class="style1"><script>show_words(which_lang[IPV6_TEXT45])</script> </p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
	                    <tr>
	                      <td width="187" align=right class="duple"><script>show_words(which_lang[IPV6_TEXT46])</script> :</td>
	                      <td width="331">&nbsp;
	                      	<input type=text id="ipv6_dhcp_lan_ip" name="ipv6_dhcp_lan_ip" size="30" maxlength="63" value="<% CmoGetCfg("ipv6_dhcp_lan_ip","none"); %>" onChange="set_ipv6_autoconf_range()">
	                      	<b>/64</b>
	                      </td>
			    </tr>
			    <tr>
			      <td width="187" align=right class="duple"><script>show_words(which_lang[IPV6_TEXT47])</script> :</td>
	                      <td width="331">&nbsp;
	                      	<b><span id="lan_link_local_ip"></span></b>
	                      </td>
                      </tr>
			</table>
                 </div>
		 <div class="box" id=ipv6_autoconfiguration_settings>
			  <h2><script>show_words(which_lang[IPV6_TEXT48])</script></h2>
			   <p align="justify" class="style1"><script>show_words(which_lang[IPV6_TEXT49])</script></p>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td width="187" class="duple"><script>show_words(which_lang[IPV6_TEXT50])</script> :</td>
                                  <td width="331">&nbsp;<input name="ipv6_autoconfig_sel" type=checkbox id="ipv6_autoconfig_sel" value="1"></td>
                                </tr>
                                <tr>
                                <td class="duple"><script>show_words(which_lang[IPV6_TEXT51])</script> :</td>
                                  <td width="331">&nbsp;
				   <select id="ipv6_autoconfig_type" name="ipv6_autoconfig_type" onChange="set_ipv6_autoconfiguration_type()">
				      <option value="stateless"><script>show_words(which_lang[IPV6_TEXT52])</script></option>
				      <option value="stateful"><script>show_words(which_lang[IPV6_TEXT53])</script></option>
				   </select>
				  </td>
                                </tr>
                                <tr id="show_ipv6_addr_range_start" style="display:none">
				     <td class="duple"><script>show_words(which_lang[IPV6_TEXT54])</script> :</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_start_prefix" name="ipv6_addr_range_start_prefix" size="20" maxlength="19">
				     ::<input type=text id="ipv6_addr_range_start_suffix" name="ipv6_addr_range_start_suffix" size="5" maxlength="4">
				     </td>
				</tr>
				<tr id="show_ipv6_addr_range_end" style="display:none">
				     <td class="duple"><script>show_words(which_lang[IPV6_TEXT55])</script> :</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_addr_range_end_prefix" name="ipv6_addr_range_end_prefix" size="20" maxlength="19">
				     ::<input type=text id="ipv6_addr_range_end_suffix" name="ipv6_addr_range_end_suffix" size="5" maxlength="4">
				     </td>
				</tr>
				<tr id="show_ipv6_addr_lifetime" style="display:none">
				     <td class="duple"><script>show_words(which_lang[IPV6_TEXT56])</script> :</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcpd_lifetime" name="ipv6_dhcpd_lifetime" size="20" maxlength="15" value="<% CmoGetCfg("ipv6_dhcpd_lifetime","none"); %>">
				     <script>show_words(which_lang[_minutes])</script></td>
				</tr>
				<tr id="show_router_advert_lifetime">
				     <td class="duple"><script>show_words(which_lang[IPV6_TEXT57])</script> :</td>
				     <td width="331">&nbsp;&nbsp;<input type=text id="ipv6_dhcp_adver_lifetime" name="ipv6_dhcp_adver_lifetime" size="20" maxlength="15" value="">
				     <script>show_words(which_lang[_minutes])</script></td>
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
                      <td id=help_text><b><script>show_words(which_lang[_hints])</script>&hellip;</b>
                      	<p><script>show_words(which_lang[IPV6_TEXT58])</script></p>
              			<p><script>show_words(which_lang[IPV6_TEXT59])</script></p>
						<p><a href="support_adv.asp#ipv6" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
	set_ipv6_stateful_range();
</script>
</html>
