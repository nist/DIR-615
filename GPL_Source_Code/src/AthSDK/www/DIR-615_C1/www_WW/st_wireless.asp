
<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript"> 
	var dDat = new Array();
	var rDat = new Array();
	var resert_rule = 0;
	function station_list(){
		var wireless_station_list = get_by_id("wireless_station_list").value;
		dDat = wireless_station_list.split(",");
		for (var i = 0; i < dDat.length - 1 ; i++){
			rDat[i] = dDat[i].split("/");
			document.write("<tr bgcolor=\"#FFFFFF\">");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][0] +"</font></td>");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][5] +"</font></td>");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][2] +"</font></td>");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][4] +"</font></td>");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][1] +"</font></td>");
			document.write("</tr>");		
			resert_rule++;
		}
		get_by_id("show_resert").innerHTML = resert_rule;
	}

</script>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
-->
</style>
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
									<li><div><a href="st_device.asp">DEVICE INFO</a></div></li>
									<li><div><a href="st_log.asp">LOGS</a></div></li>
									<li><div><a href="st_stats.asp">STATISTICS</a></div></li>
									<li><div><a href="internet_sessions.asp">INTERNET SESSIONS</a></div></li>
									<li><div><a href="st_routing.asp">Routing</a></div></li>
									<li><div id="sidenavoff">WIRELESS</div></li>
									<li><div style=" text-transform:none"><a href="st_ipv6.asp">IPv6</a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
                <td>
                 <!-- repeat name="extTab" -->
                </td>
				</table>			
			</td>
			<form id="form1" name="form1" method="post" action=apply.cgi>
<input type="hidden" id="html_response_page" name="html_response_page" value="st_wireless.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_wireles.asp">

<input type="hidden" id="wireless_station_list" name="wireless_station_list" value="<% CmoGetList("wireless_station_list"); %>">
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1>Wireless</h1>
						<p>Use this option to view the wireless clients that are connected to your wireless router.</p>
					</div>
					<div class="box"> 
						<h2>Number Of Wireless Clients :&nbsp;<span id="show_resert"></span></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                              <tr id="box_header">
							    <TD><b>MAC Address</b></TD>
							    <TD><b>IP Address</b></TD>
							    <TD><b>Mode</b></TD>
							    <TD><b>Rate</b></TD>
							    <TD><b>Signal(%)</b></TD>
                              </tr>
                              <script>
                              	station_list(); 
							  </script>
                            </table>
					</div>
                </div></td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong>Helpful Hints&hellip;</strong>
                      	<p>This is a list of all wireless clients that are currently connected to your wireless router.</p>
                      	<p class="more"><a href="support_status.asp#Wireless">More&hellip;</a></p>
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
