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
	link_local = document.getElementById("link_local_ip_l").value;
	document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
}
function send_request(){
	get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;
	if(submit_button_flag == 0){
		submit_button_flag = 1;
		get_by_id("form1").submit();
	}
}
</script>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style2 {font-size: 11px}
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
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();">Network Filter</a></div></LI>
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
		    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_link_local.asp">
		    <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto","none"); %>">
		    <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<% CmoGetStatus("link_local_ip_l","none"); %>">
		    <input type="hidden" id="page_type" name="page_type" value="IPv6">
               <td valign="top" id="maincontent_container">
				<div id=maincontent>
		  <div id=box_header>
                    <h1>IPv6</h1>
                    Use this section to configure your IPv6 Connection type. If
          you are unsure of your connection method, please contact your Internet
          Service Provider.<br>
                    <br>
                    <input name="button" type="button" class=button_submit value="Save Settings" onClick="send_request()">
                    <input name="button2" type=button class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'adv_ipv6.asp');">
                 </div>
                  <div class=box>
                    <h2 style=" text-transform:none">
                   IPv6 CONNECTION TYPE</h2>
				   <p class="box_msg">Choose the mode to be used by the router to the IPv6 Internet.</p>
                   <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="187" class="duple">My IPv6 Connection is :</td>
                      <td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
                        <option value="ipv6_static" >Static IPv6</option>
                        <option value="ipv6_dhcp" >DHCPv6</option>
                        <option value="ipv6_pppoe">PPPoE</option>
                        <option value="ipv6_6in4">IPv6 in IPv4 Tunnel</option>
                        <option value="ipv6_6to4" >6 to 4</option>
			<!--option value="ipv6_stateless" selected>Stateless Autoconfiguration</option-->			
                        <option value="link_local" selected>Link-local only</option>												
                      </select></td>
                    </tr>
                   </table>
                  </div>
		 <div class=box id=lan_ipv6_settings>
	                <h2 style=" text-transform:none">LAN IPv6 ADDRESS SETTINGS  : </h2>
					<p class="style2">Use this section to configure the internal network setings of your router.</p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
			    <tr>
			      <td width="206" align=right class="duple">LAN IPv6 Link-Local Address :</td>
	                      <td width="331">&nbsp;<b><span id="lan_link_local_ip"></span></b>
	                      </td>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
</script>
</html>
