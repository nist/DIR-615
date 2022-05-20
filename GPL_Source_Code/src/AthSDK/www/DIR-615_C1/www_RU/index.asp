<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
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
			<td id="topnavon"><a href="index.asp">SETUP</a></td>
			<td id="topnavoff"><a href="adv_virtual.asp">ADVANCED</a></td>
			<td id="topnavoff"><a href="tools_admin.asp">TOOLS</a></td>
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
									<li><div id="sidenavoff">INTERNET</div></li>
									<li><div id="sidenavon"><a href="wizard_wireless.asp">WIRELESS SETTINGS</a></div></li>
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
                    <h1>Internet Connection</h1>
                  	<p>There are two ways to set up your Internet connection: you can 
		            use the Web-based Internet Connection Setup Wizard, or you can 
		            manually configure the connection.</p>
                  </div>
                  <div class=box>
                    <h2>Internet Connection Wizard</h2>
                    <P>If you would like to utilize our easy to use Web-based Wizards to 
		            assist you in connecting your new D-Link Systems Router to the 
		            Internet, click on the button below.</P>
                    <P class=centered><input name="wizard" type=button class=button_submit value="Internet Connection Setup Wizard" onClick="window.location.href='wizard_wan.asp'"></p>
                    <p><strong>Note:</strong> Before launching the wizard, please make sure you have followed all steps outlined in the Quick Installation Guide included in the package.</p>
                  </div>
                  <div class=box>
                    <h2>Manual Internet Connection options</h2>
                    <P>If you would like to configure the Internet settings of your new 
            		D-Link Systems Router manually, then click on the button below.</P>
                    <P class=centered><input name="button2" type=button class=button_submit value="Manual Internet Connection Setup" onClick="window.location.href='sel_wan.asp'"></p>
                  </div>              
			  </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong>Helpful Hints&hellip;</strong>
                          <p>If you are new to networking and have never configured a router before, click on <strong>Internet Connection Setup Wizard</strong> and the router will guide you through a few simple steps to get your network up and running.</p>
                          <p>If you consider yourself an advanced user and have configured a router before, click <strong>Manual Internet Connection Setup</strong> to input all the settings manually.</p>
                          <p class="more"><a href="support_internet.asp#Internet">More&hellip;</a></p>
                      </td>
                    </tr>
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
</html>