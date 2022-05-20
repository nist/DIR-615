﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link 회사 | 무선 라우터 | 홈</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
-->
</style>
<script type="text/javascript" src="ko.js"></script>
<script type="text/javascript" src="text.js"></script>
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
	stats_string1 += '<td class=duple>'+which_lang[ss_Sent]+' :</td>';
	stats_string1 += "<td width=340>&nbsp;" + sent + "</td>";
	stats_string1 += '<td class=duple>'+which_lang[ss_Received]+' :</td>';
	stats_string1 += "<td width=340>&nbsp;" + received + "</td>";
	stats_string1 += "</tr>";
	stats_string1 += "<tr>";
	stats_string1 += '<td class=duple>'+which_lang[ss_TXPD]+' :</td>';
	stats_string1 += "<td width=340>&nbsp;" + tx + "</td>";
	stats_string1 += '<td class=duple>'+which_lang[ss_RXPD]+' :</td>';
	stats_string1 += "<td width=340>&nbsp;" + rx + "</td>"
	stats_string1 += "</tr>";
	
	stats_string2 = "<tr>";
	stats_string2 += '<td class=duple>'+which_lang[ss_Collisions]+' :</td>';
	stats_string2 += "<td width=340>&nbsp;" + collision + "</td>";
	stats_string2 += '<td class=duple>'+which_lang[ss_Errors]+' :</td>';
	stats_string2 += "<td width=340>&nbsp;" + error + "</td>";
	stats_string2 += "</tr>";

	wlan_string = "<tr>";
	wlan_string += "<td class=duple>&nbsp;</td>";
	wlan_string += "<td width=340>&nbsp;</td>";
	wlan_string += '<td class=duple>'+which_lang[ss_Errors]+' :</td>';
	wlan_string += "<td width=340>&nbsp;" + error + "</td>";
	wlan_string += "</tr>";
}

</script>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
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
			<td id="topnavoff"><a href="index.asp"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavon"><a href="st_device.asp"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp"><script>show_words(which_lang[_support])</script></a></td>
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
									<li><div><a href="st_device.asp"><script>show_words(which_lang[_devinfo])</script></a></div></li>
									<li><div><a href="st_log.asp"><script>show_words(which_lang[_logs])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[_stats])</script></div></li>
									<li><div><a href="internet_sessions.asp"><script>show_words(which_lang[YM157])</script></a></div></li>
									<li><div><a href="st_wireless.asp"><script>show_words(which_lang[_wireless])</script></a></div></li>	
                                                                        <!--@ ipv6 <li><div style=" text-transform:none"><a href="st_ipv6.asp">IPv6</a></div></li>	@-->								    
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
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_stats.asp">
			<input type="hidden" id="lan_stats" name="lan_stats" value="<% CmoGetStatus("lan_ifconfig_info"); %>">
			<input type="hidden" id="wan_stats" name="wan_stats" value="<% CmoGetStatus("wan_ifconfig_info"); %>">
			<input type="hidden" id="wlan_stats" name="wlan_stats" value="<% CmoGetStatus("wlan_ifconfig_info"); %>">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1><script>show_words(which_lang[_tstats])</script></h1>
						<script>show_words(which_lang[ss_intro])</script>
						<br><br>
						<input name="refresh" type="button" id="refresh" value="" onClick=window.location.href="st_stats.asp">
						<input name="reset" type="button" id="reset" value="" onclick="reset_packets()">
						<script>get_by_id("refresh").value = which_lang[ss_reload];</script>
						<script>get_by_id("reset").value = which_lang[ss_clear_stats];</script>
				  	</div>
					<div class="box"> 
						<h2><script>show_words(which_lang[ss_LANStats])</script></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("lan");
								document.write(stats_string1 + stats_string2);
								</script>
							</table>
					</div>
					<div class="box"> 
						<h2><script>show_words(which_lang[ss_WANStats])</script></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=1 width=525>
								<script>
								show_stats("wan");
								document.write(stats_string1 + stats_string2);
								</script>
							</table>
					</div>
					<div class="box"> 
						<h2><script>show_words(which_lang[ss_WStats])</script></h2>
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
						<strong><script>show_words(which_lang[_hints])</script>&hellip;</strong>
						<p><script>show_words(which_lang[hhss_intro])</script></p>
						<p><a href="support_status.asp#Statistics"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
</html>