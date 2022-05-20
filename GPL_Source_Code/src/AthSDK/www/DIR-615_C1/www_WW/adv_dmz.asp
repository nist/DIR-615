<html>
<head>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
	<script language="JavaScript">
	var submit_button_flag = 0;

	function onPageLoad(){
		set_checked(get_by_id("spi_enable").value, get_by_id("spiEnable"));
		set_checked("<% CmoGetCfg("udp_nat_type","none"); %>", get_by_name("udp_nat_type"));
		set_checked("<% CmoGetCfg("tcp_nat_type","none"); %>", get_by_name("tcp_nat_type"));
		set_checked(get_by_id("anti_spoof_check").value, get_by_id("anti_spoof_check_sel"));
		set_checked(get_by_id("dmz_enable").value, get_by_id("dmz_host"));
		set_checked("<% CmoGetCfg("pptp_pass_through","none"); %>", get_by_id("pptp"));
		set_checked("<% CmoGetCfg("ipsec_pass_through","none"); %>", get_by_id("ipsec"));
		set_checked("<% CmoGetCfg("alg_rtsp","none"); %>", get_by_id("rtsp"));
		set_checked("<% CmoGetCfg("alg_sip","none"); %>", get_by_id("sip"));
		disable_obj();
		set_form_default_values("form1");
	}

	function clone_mac(){
		if (get_by_id("dhcp").selectedIndex > 0){
			get_by_id("dmz_ipaddr").value = get_by_id("dhcp").options[get_by_id("dhcp").selectedIndex].value;
		}else{
			alert(msg[SELECT_COMPUTER_ERROR]);
		}
	}

	function send_request(){
		if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
			return false;
		}
		get_by_id("spi_enable").value = get_checked_value(get_by_id("spiEnable"));
		get_by_id("pptp_pass_through").value = get_checked_value(get_by_id("pptp"));
		get_by_id("ipsec_pass_through").value = get_checked_value(get_by_id("ipsec"));
		get_by_id("alg_rtsp").value = get_checked_value(get_by_id("rtsp"));
		get_by_id("alg_sip").value = get_checked_value(get_by_id("sip"));
		var dmz_ip = get_by_id("dmz_ipaddr").value;
		var lan_ip = "<% CmoGetCfg("lan_ipaddr","none"); %>";
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var ip_obj = new addr_obj(dmz_ip.split("."), ip_addr_msg, false, false);
		var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
		
		if(!check_LAN_ip(temp_lan_ip_obj.addr, ip_obj.addr, "IP address")){
			return false;
		}
		
		if (get_by_id("dmz_host").checked){
			if (!check_address(ip_obj)){				
				return false;
	   		}
	   	}
	   	
		get_by_id("dmz_enable").value = get_checked_value(get_by_id("dmz_host"));
		get_by_id("anti_spoof_check").value = get_checked_value(get_by_id("anti_spoof_check_sel"));
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
	
	function disable_obj(){
		var is_disable = true;
		if (get_by_id("dmz_host").checked){
			is_disable = false;
		}
		
		get_by_id("dmz_ipaddr").disabled = is_disable;
		get_by_id("button22").disabled = is_disable;
		get_by_id("dhcp").disabled = is_disable;
	}
</script>

<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page"  name="html_response_page" value="back.asp">
<input type="hidden" id="html_response_message"  name="html_response_message" value="The setting is saved.">
<input type="hidden" id="html_response_return_page"  name="html_response_return_page" value="adv_dmz.asp">
<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
<input type="hidden" id="dmz_schedule" name="dmz_schedule" value="<% CmoGetCfg("dmz_schedule","none"); %>">
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
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <!-- === BEGIN SIDENAV === -->
                          <UL>
                            <LI><div><a href="adv_virtual.asp">VIRTUAL SERVER</a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();">PORT FORWARDING</a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();">APPLICATION RULES</a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();">QOS Engine</a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();">NETWORK FILTER</a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();">ACCESS CONTROL</a></div></LI>
                            <LI><div><a href="adv_filters_url.asp" onclick="return jump_if();">WEBSITE FILTER</a></div></LI>
                            <LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();">INBOUND FILTER</a></div></LI>
			    <LI><div id=sidenavoff>FIREWALL SETTINGS</div></LI>
							<LI><div><a href="adv_routing.asp" onclick="return jump_if();">Routing</a></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();">ADVANCED WIRELESS</a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();">ADVANCED NETWORK</a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                          </UL>
                          <!-- === END SIDENAV === -->
                      	</div>
                      </td>
                    </tr>
                </table>
             </td>
             <td valign="top" id="maincontent_container">
				<div id=maincontent>
				  <!-- === BEGIN MAINCONTENT === -->
                  <div id=box_header>
                    <h1>Firewall Settings</h1>
                    <p>The Firewall Settings allow you to set a single computer on your network outside of the router.</p>
                    <input name="button" type="button" class=button_submit value="Save Settings" onClick="send_request()">
                    <input name="button2" type=button class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'adv_dmz.asp');">
                  </div>
                  <div class=box>
                    <h2>Firewall Settings</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width=155 align=right class="duple">Enable SPI:</td>
                          <td width="360">&nbsp;
						  <input type="checkbox" id="spiEnable" name="spiEnable" value="1">
						  <input type="hidden" id="spi_enable" name="spi_enable" value="<% CmoGetCfg("spi_enable","none"); %>">
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2>NAT Endpoint Filtering</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="1">
						  &nbsp;Endpoint Independent
						  </td>
                        </tr>
                        <tr>
                          <td width=155 align=right class="duple">UDP Endpoint Filtering:</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="2">
						  &nbsp;Address Restricted
						  </td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="0">
						  &nbsp;Port And Address Restricted
						  </td>
                        </tr>
                        <tr>
                          <td align=right colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="1">
						  &nbsp;Endpoint Independent
						  </td>
                        </tr>
                        <tr>
                          <td width=155 align=right class="duple">TCP Endpoint Filtering:</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="2">
						  &nbsp;Address Restricted
						  </td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="0">
						  &nbsp;Port And Address Restricted
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2>Anti-Spoof checking</h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width=155 align=right class="duple">Enable anti-spoof checking:</td>
                          <td width="360">&nbsp;
						  <input type="checkbox" id="anti_spoof_check_sel" name="anti_spoof_check_sel" value="1">
						  <input type="hidden" id="anti_spoof_check" name="anti_spoof_check" value="<% CmoGetCfg("anti_spoof_check","none"); %>">
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2>DMZ Host</h2>
                    <p>The DMZ (Demilitarized Zone) option lets you set a single computer on your network outside of the router. If you have a computer that cannot run Internet applications successfully from behind the router, then you can place the computer into the DMZ for unrestricted Internet access.</P>
                    <p><b>Note:</b> Putting a computer in the DMZ may expose that computer to a variety of security risks. Use of this option is only recommended as a last resort.</p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td align=right width=155>
						  <input type="hidden" id="dmz_enable" name="dmz_enable" value="<% CmoGetCfg("dmz_enable","none"); %>">
						  Enable DMZ Host :</td>
                          <td colSpan=3>&nbsp;
						   
						  <input type=checkbox id="dmz_host" name="dmz_host" value="1" onClick="disable_obj();"></td>
                        </tr>
                        <tr>
                          <td width="155" align=right>DMZ IP Address :</td>
                          <td width="96" valign="bottom"><input type=text id="dmz_ipaddr" name="dmz_ipaddr" size=16 maxlength=15 value="<% CmoGetCfg("dmz_ipaddr","none"); %>">
                          </td>
                          <td width="258" valign="bottom"><input id="button22" name="button22" type=button value="<<" style="width: 24; height: 24" onClick="clone_mac()">
                            <select id="dhcp" name="dhcp" size=1>
                              <option value="-1">Computer Name</option>
                              <script>set_mac_list("ip")</script>
                            </select>
						  </td>
                          <td width="3">&nbsp;</td>
                        </tr>
                    </table>
                  </div>
				   <div class=box>
                    <h2>Application Level Gateway (ALG) Configuration</h2>
                 
                    
            <table cellSpacing=1 cellPadding=1 width=525 border=0>
              <tr> 
                <td align=right width=155> <input type="hidden" id="pptp_pass_through" name="pptp_pass_through" value="<% CmoGetCfg("pptp_pass_through","none"); %>">
                  PPTP :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="pptp" name="pptp" value="1"></td>
              </tr>
             <tr> 
                <td align=right width=155> <input type="hidden" id="ipsec_pass_through" name="ipsec_pass_through" value="<% CmoGetCfg("ipsec_pass_through","none"); %>">
                  IPSec (VPN) :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="ipsec" name="ipsec" value="1"></td>
              </tr>
			  <tr> 
                <td align=right width=155> <input type="hidden" id="alg_rtsp" name="alg_rtsp" value="<% CmoGetCfg("alg_rtsp","none"); %>">
                  RTSP :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="rtsp" name="rtsp" value="1"></td>
              </tr>
			  <tr> 
                <td align=right width=155> <input type="hidden" id="alg_sip" name="alg_sip" value="<% CmoGetCfg("alg_sip","none"); %>">
                  SIP :</td>
                <td colSpan=3>&nbsp; <input type=checkbox id="sip" name="sip" value="1"></td>
              </tr>
            </table>
                  </div>				  
             </div>
            </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong>Helpful Hints&hellip;</strong>
                        <p>Enable the DMZ option only as a last resort.  If you are having trouble using an application from a computer behind the router, first try opening ports associated with the application in the <a href="adv_virtual.asp" onclick="return jump_if();">Virtual Server</a> or <a href="adv_portforward.asp" onclick="return jump_if();">Port Forwarding</a> sections.</p>
                        <p class="more"><a href="support_adv.asp#Firewall" onclick="return jump_if();">More&hellip;</a></p>
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
</form>
</body>
<script>
	onPageLoad();
</script>
</html>
