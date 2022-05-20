<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
-->
</style>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">

function reset_packets(){
	send_submit("form2");
}

var stats_string1, wlan_string;
function show_stats(status){
	var sent, received, tx, rx, collision, error;
	var lan_stats = (get_by_id("lan_stats").value).split("/");
	var wan_stats = (get_by_id("wan_stats").value).split("/");
	var wlan_stats = (get_by_id("wlan_stats").value).split("/");

	if(status == "lan"){
		sent = lan_stats[1];
		received = lan_stats[0];
		tx = lan_stats[3];
		rx = lan_stats[2];
		collision = lan_stats[4];
		error = lan_stats[5];
	}else if(status == "wan"){
		sent = wan_stats[1];
		received = wan_stats[0];
		tx = wan_stats[3];
		rx = wan_stats[2];
		collision = wan_stats[4];
		error = wan_stats[5];
	}else if(status == "wlan"){
		sent = wlan_stats[1];
		received = wlan_stats[0];
		tx = wlan_stats[3];
		rx = wlan_stats[2];
		error = wlan_stats[5];
	}

	stats_string1 = "<tr>";
	stats_string1 += "<td class=duple>Sent :</td>";
	stats_string1 += "<td width=340>&nbsp;" + sent + "</td>";
	stats_string1 += "<td class=duple>Received :</td>";
	stats_string1 += "<td width=340>&nbsp;" + received + "</td>";
	stats_string1 += "</tr>";
	stats_string1 += "<tr>";
	stats_string1 += "<td class=duple>TX Packets Dropped :</td>";
	stats_string1 += "<td width=340>&nbsp;" + tx + "</td>";
	stats_string1 += "<td class=duple>RX Packets Dropped :</td>"
	stats_string1 += "<td width=340>&nbsp;" + rx + "</td>"
	stats_string1 += "</tr>";
	
	stats_string2 = "<tr>";
	stats_string2 += "<td class=duple>Collisions :</td>";
	stats_string2 += "<td width=340>&nbsp;" + collision + "</td>";
	stats_string2 += "<td class=duple>Errors :</td>";
	stats_string2 += "<td width=340>&nbsp;" + error + "</td>";
	stats_string2 += "</tr>";

	wlan_string = "<tr>";
	wlan_string += "<td class=duple>&nbsp;</td>";
	wlan_string += "<td width=340>&nbsp;</td>";
	wlan_string += "<td class=duple>Errors :</td>";
	wlan_string += "<td width=340>&nbsp;" + error + "</td>";
	wlan_string += "</tr>";
}

</script>
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
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp">SETUP</a></td>
			<td id="topnavoff"><a href="adv_virtual.asp">ADVANCED</a></td>
			<td id="topnavoff"><a href="tools_admin.asp">TOOLS</a></td>
			<td id="topnavon"><a href="st_device.asp">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp">SUPPORT</a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="st_device.asp">Device Info</a></div></li>
									<li><div><a href="st_log.asp">Logs</a></div></li>
									<li><div id="sidenavoff">Statistics</div></li>
									<li><div><a href="internet_sessions.asp">Internet Sessions</a></div></li>
									<li><div><a href="st_routing.asp">Routing</a></div></li>
									<li><div><a href="st_wireless.asp">Wireless</a></div></li>
									<li><div style=" text-transform:none"><a href="st_ipv6.asp">IPv6</a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_stats.asp">
			<input type="hidden" id="lan_stats" name="lan_stats" value="<% CmoGetStatus("lan_ifconfig_info"); %>">
			<input type="hidden" id="wan_stats" name="wan_stats" value="<% CmoGetStatus("wan_ifconfig_info"); %>">
			<input type="hidden" id="wlan_stats" name="wlan_stats" value="<% CmoGetStatus("wlan_ifconfig_info"); %>">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1>Traffic Statistics</h1>
						Traffic Statistics display Receive and Transmit packets passing through your router.
						<br><br>
						<input name=refresh type=button id="refresh" onClick="window.location.href='st_stats.asp'" value="Refresh Statistics">
						<input name=reset type=button id="reset" value="Clear Statistics" onClick="reset_packets()">
				  	</div>
					<div class="box"> 
						<h2>LAN Statistics</h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("lan");
								document.write(stats_string1 + stats_string2);
								</script>
							</table>
					</div>
					<div class="box"> 
						<h2>WAN Statistics</h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("wan");
								document.write(stats_string1 + stats_string2);
								</script>
							</table>
					</div>
					<div class="box"> 
						<h2>Wireless Statistics</h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("wlan");
								document.write(stats_string1 + wlan_string);
								</script>
							</table>
					</div>
					<!-- === END MAINCONTENT === -->
                </div>
			</form>
			</td>
			<form id="form2" name="form2" method="post" action="reset_ifconfig_packet_counter.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="st_stats.asp">
			<input type="hidden" id="html_response_return_page" vname="html_response_return_page" value="st_stats.asp">
			</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text">
						<strong>Helpful Hints&hellip;</strong>
						<p>This is a summary of the number of packets that have passed between the WAN and the LAN since the router was last initialized.</p>
						<p><a href="support_status.asp#Statistics">More&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
</body>
</html>