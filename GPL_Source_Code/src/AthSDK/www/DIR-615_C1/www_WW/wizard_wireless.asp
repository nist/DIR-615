<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="public.js"></script>
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
.style2 {font-size: 11px}
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
			<td id="topnavon"><a href="index.asp">SETUP</a></td>
			<td id="topnavoff"><a href="adv_virtual.asp">ADVANCED</a></td>
			<td id="topnavoff"><a href="tools_admin.asp">TOOLS</a></td>
			<td id="topnavoff"><a href="st_device.asp">STATUS</a></td>
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
								<ul>
									<li><div id="sidenavon"><a href="index.asp">INTERNET</a></div></li>
									<li><div id="sidenavoff">WIRELESS SETTINGS</div></li>
									<li><div id="sidenavon"><a href="lan.asp">NETWORK SETTINGS</a></div></li>

								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				 
                  <div id=box_header>
                    <h1>Wireless Settings</h1>
                  	<p>The following Web-based wizards are designed to assist you in your wireless network setup and wireless device connection.</p>
                  	<p>Before launching these wizards, please make sure you have followed all steps outlined in the Quick Installation Guide included in the package.</p>
                  </div>
                  <div class=box>
                    <h2>Wireless Network Setup Wizard</h2>
                    This wizard is designed to assist you in your wireless network setup. It will guide you through step-by-step instructions on how to set up your wireless network and how to make it secure.<br><br>
                    <center><input name="button2" type="button" class="button_submit" value="Wireless Connection Setup Wizard" onClick="window.location.href='wizard_wlan.asp'"></center>
                    <br><br>
					<strong>Note:</strong> Some changes made using this Setup Wizard may require you to change some settings on your wireless client adapters so they can still connect to the D-Link Router.
                  </div>
                  <div class=box>
                    <h2>Add Wireless Device WITH WPS (WI-FI PROTECTED SETUP) Wizard</h2>
                    This wizard is designed to assist you in connecting your wireless device to your router. It will guide you through step-by-step instructions on how to get your wireless device connected. Click the button below to begin.<br><br>
                    <center><input name="wps_wizard" type="button" class="button_submit" value="Add Wireless Device with WPS" onClick="window.location.href='wps_wifi_setup.asp'"></center>
                  </div>
				  <div class=box>
                    <h2>Manual Wireless Network Setup</h2>
                    If your wireless network is already set up with Wi-Fi Protected Setup, manual confguration of the wireless network will destroy the existing wireless network. If you would like to configure the wireless settings of your new D-Link Systems Router manually, then click on the Manual Wireless Network Setup button below.<br><br>
                    <center><input name="wizard" type="button" class="button_submit" value="Manual Wireless Connection Setup" onClick="window.location.href='wireless.asp'"></center>
                    <br>
                    <!--br>                    
                    <span class="style1">Note:</span> Some changes made using this Setup Wizard may require you to change some settings on your wireless client adapters so they can still connect to the D-Link Router.-->
                  </div>
			  </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><strong>Helpful Hints&hellip;</strong>
                          <!--p>If you already have a wireless network setup with Wi-Fi Protected Setup, click on <strong>Add Wireless Device Wizard</strong> to add new device to your wireless network.</p-->
                          <p>If you are new to wireless networking and have never configured a wireless router before, click on <strong>Wireless Connection Setup Wizard</strong> and the router will guide you through a few simple steps to get your wireless network up and running.</p>
						  <p>If you consider yourself an advanced user and have configured a wireless router before, click <strong>Manual Wireless Connection Setup</strong> to input all the settings manually.</p>
						  <p><a href="support_internet.asp#Wireless">More&hellip;</a></p>
                      </td>
                    </tr>
                  </tbody>
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