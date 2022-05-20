<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link公司 | 无线路由器 | 主页</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
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
			<td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(which_lang[_support])</script></a></td>
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
									<li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[sa_Internet])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[_wirelesst])</script></div></li>
									<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();"><script>show_words(which_lang[bln_title])</script></a></div></li>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				 
                  
        <div id=box_header> 
          <h1>
            <script>show_words(which_lang[LW38])</script>
          </h1>
                  	
          <p>
            <script>show_words(which_lang[LW39])</script>
          </p>
                  	
          <p>
            <script>show_words(which_lang[LW39c])</script>
          </p>
                  </div>
                  
        <div class=box> 
          <h2>
            <script>show_words(which_lang[wwl_wl_wiz])</script>
          </h2>
          <script>show_words(which_lang[LW41])</script>
          <br>
          <br>
          <center>
		  <input type="button" class="button_submit" id="button2" name="button2" value="" onClick=window.location.href="wizard_wlan.asp">
          <script>get_by_id("button2").value = which_lang[wwl_wl_wiz];</script>
		  </center>
                    <br><br>
          <strong> 
          <script>show_words(which_lang[_note])</script>
          :</strong> 
          <script>show_words(which_lang[bwz_note_WlsWz])</script>
        </div>
                  
        <div class=box> 
          <h2>
            <script>show_words(which_lang[wps_LW13])</script>
          </h2>
          <script>show_words(which_lang[LW40])</script>
          <br>
          <br>
          <center>
		  <input type="button" class="button_submit" id="wps_wizard" name="wps_wizard" value="" onClick=window.location.href="wps_wifi_setup.asp">
          <script>get_by_id("wps_wizard").value = which_lang[LW13];</script>
		  </center>
                  </div>
				  
        <div class=box> 
          <h2> 
            <script>show_words(which_lang[LW42])</script>
          </h2>
          <script>show_words(which_lang[LW43])</script>
          <script>show_words(which_lang[LW44])</script>
          <br>
          <br>
          <center>
		  <input type="button" class="button_submit" id="wizard" name="wizard" value="" onClick=window.location.href="wireless.asp">
          <script>get_by_id("wizard").value = which_lang[LW42];</script>
		  </center>
                    <br>
                    <!--br>                    
                    <span class="style1">Note:</span> Some changes made using this Setup Wizard may require you to change some settings on your wireless client adapters so they can still connect to the D-Link Router.-->
                  </div>
			  </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                  <tbody>
                    <tr>
                      
            <td id=help_text><strong> 
              <script>show_words(which_lang[_hints])</script>
              &hellip;</strong> 
              <!--p>If you already have a wireless network setup with Wi-Fi Protected Setup, click on <strong>Add Wireless Device Wizard</strong> to add new device to your wireless network.</p-->
              <p>
                <script>show_words(which_lang[LW46])</script>
              </p>
						  
              <p>
                <script>show_words(which_lang[LW47])</script>
              </p>
						  <p><a href="support_internet.asp#Wireless"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
</html>