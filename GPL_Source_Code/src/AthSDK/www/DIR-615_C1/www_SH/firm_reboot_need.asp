<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script language="JavaScript" src="public.js"></script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
</head>
<script language="JavaScript">
var submit_button_flag = 0;
function do_reboot(is_true){
	if(is_true && get_by_id("asp_temp_51").value.length > 0){
		get_by_id("form1").action = "reboot.cgi";
		get_by_id("html_response_page").value = "reboot.asp";
		get_by_id("reboot_type").value = get_by_id("asp_temp_51").value;
		get_by_id("asp_temp_51").value = "";
		send_submit("form1");
	}else{
		window.location.href = get_by_id("html_response_return_page").value;
	}
}
</script>

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
			<td id="topnavoff"><a href="index.asp">SETUP</a></td>
			<td id="topnavoff"><a href="adv_virtual.asp">ADVANCED</a></td>
			<td id="topnavon"><a href="tools_admin.asp">TOOLS</a></td>
			<td id="topnavoff"><a href="st_device.asp">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp">SUPPORT</a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();">ADMIN</a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();">TIME</a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();">SYSLOG</a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();">EMAIL SETTINGS</a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();">SYSTEM</a></div></li>
									<li><div id="sidenavoff">FIRMWARE</div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();">DYNAMIC DNS</a></div></li>
								  	<li><div><a href="tools_vct.asp" onclick="return jump_if();">SYSTEM CHECK</a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();">SCHEDULES</a></div></li>
									
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="reboot_need">
				<div id=maincontent>
                  <div id=box_header>
                    <h1>Reboot needed</h1>
                  	<p>Your changes have been saved. The router must be rebooted for the changes to take effect. You can reboot now, or you can continue to make other changes and reboot later.</p>
                  	<form id="form1" name="form1" method="post" action="apply.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
						<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<% CmoGetCfg("asp_temp_51","none"); %>">
						<input type="hidden" id="reboot_type" name="reboot_type" value="none">
						<input class="button_submit" type="button" value="Reboot Now" onclick="do_reboot(true);">
						<input class="button_submit" type="button" value="Reboot Later" onclick="do_reboot(false);">
					</form>
                  </div>     
			  </div>
			</td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text">
							<strong>Helpful Hints&hellip;</strong>
							<p>Firmware updates are released periodically to improve the functionality of your router and to add features. If you run into a problem with a specific feature of the router, check if updated firmware is available for your router.</p>
							<p class="more"><a href="support_tools.asp#Firmware" onclick="return jump_if();">More&hellip;</a></p>
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
</body>
</html>