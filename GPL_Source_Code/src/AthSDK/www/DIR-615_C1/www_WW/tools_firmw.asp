<html>
<head>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	function send_request(){
		if (get_by_id("file").value === "") {
			alert("You must enter the name of a firmware file first.");
			return false;
		}
		if (!confirm("Note: Some firmware upgrades reset the router's configuration options to the factory defaults.\n Before performing an upgrade, be sure to save the current configuration from the Tools-System screen.\n Do you still want to upgrade?")) {
			return false;
		}
		if (!confirm("Do you really want to reprogram the device using the firmware file \"" +
				get_by_id("file").value + "\"?")) {
				return false;
		}
		
		try {
			get_by_id("msg_upload").style.display = "";
			get_by_id("upgrade_button").disabled = true;
			if(submit_button_flag == 0){
				submit_button_flag = 1;
				send_submit("form1");
			}
		} catch (e) {
			alert("%[.error:Error]%: " + e.message);
			get_by_id("msg_upload").style.display = "none";
			get_by_id("upgrade_button").disabled = false;
		}
	}
	
	function New_update_button(){
		get_by_id("iframe_scan").src = "tools_firmw_chk.asp";
		//get_by_id("update_new_result").style.display ="";
		get_by_id("check_now_b").disabled = true;
		document.getElementById("check_result").innerHTML = "";
	}
	
	function download_latest_fm(){
		for (var i = 0; i < get_by_id("sel_site").length; i++){
			if(get_by_id("sel_site").options[i].selected == true){
				var html = get_by_id("sel_site").options[i].value;
			}
		}
		window.open(""+html+"");
	}
</script>

<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
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
			<td id="topnavon"><a href="tools_admin.asp">TOOLS</a></td>
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
			<td valign="top" id="maincontent_container">
				<div id="maincontent">				
					<div id="box_header"> 
						<h1>Firmware</h1>
						<p>There may be new firmware for your DIR-615 to improve functionality and performance.</p>
						<p>
							To upgrade the firmware, locate the upgrade file on the local hard drive with the Browse button.
							Once. you have found the file to be used, click the Upload button below to start the firmware upgrade.
						</p>
					</div>
					<div class="box"> 
						<h2>Firmware Information</h2>
							<table width=525 border=0 cellpadding=2 cellspacing="2">
                              <tr>
                                <td width="40%" align=right class="duple">Current Firmware Version&nbsp;:</td>
                                
              <td width="60%" colspan=2 class="output"> 
                <% CmoGetStatus("version"); %>
              </td>
                              </tr>
                              <tr>
                              	<td align=right class="duple">Current Firmware Date&nbsp;:</td>
                                
              <td colspan=2 class="output"> 
                <% CmoGetStatus("version_date"); %>
              </td>
                              </tr>
                              <!--tr>
                              	<td align=right class="duple">Latest Firmware Version&nbsp;:</td>
                                <td width="60%" colspan=2 class="output">
                                   <% CmoGetStatus("version"); %>
                                </td>
                              </tr-->
                              <tr>
                                <td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;<strong>
                                	Check Online Now for Latest Firmware Version&nbsp;:
                                	&nbsp;&nbsp;&nbsp;&nbsp;
                                	<input type="button" id="check_now_b" name="check_now_b" class=button_submit value="Check Now" onClick="New_update_button();">
                                	</strong>
                                </td>
                              </tr>
                              <tr>
                                <td colspan=3>
                                	<strong><div id="check_result"></div></strong>
                                </td>
                              </tr>
                            </table>
				    </div>
				  	<div id="check_now_result" name="check_now_result" class="box" style="display:none"> 
				  	<h2>CHECK LATEST FIRMWARE VERSION</h2>
							<table width=76% height=57 border=0 cellpadding=2 cellspacing="2">
                              <tr>
                                <td width="40%"><div align="right">Latest Firmware Version&nbsp;</div></td>
                                <td width="60%" height=10 colspan=2>
								<div align="left" id="latest_version"></div>
								</td>
                              </tr>
                              <tr>
                              <td width="40%">
							  	<div align="right">Latest Firmware Date &nbsp;</div>
								</td>
                                <td width="60%" height=10 colspan=2>
                                  <div align="left" id="latest_date"></div></td>
                              </tr>
                              <td width="40%"><div align="right">Available Download Site &nbsp;</div></td>
                                <td width="60%" height=10 colspan=2>
                                 <select id="sel_site" name="sel_site" onChange="">
								 </select>
								 </td>
                              </tr>
                              <tr>
                                <td colspan="3" height="21" align="center">
                                    <input type="button" name="download"  id="download" value="Download" onClick="download_latest_fm();">
                                </td>
                              </tr>
                            </table>
				  	</div>
				    <form id="form1" name="form1" method=POST action="firmware_upgrade.cgi" enctype=multipart/form-data>
					<input type="hidden" id="html_response_page" name="html_response_page" value="ustatus.asp">
					<input type="hidden" name="html_response_return_page" value="tools_firmw.asp">
				    <div class="box"> 
						<h2>Firmware Upgrade</h2>
						<table width=525 border=0 cellpadding=2 cellspacing="2">
                          <tr>
                            <td colspan=3>
                                <p class="box_alert">
	                                <strong>Note:</strong> 
	                                Some firmware upgrades reset the configuration options to the factory defaults. Before performing an 
	                                upgrade, be sure to save the current configuration from the 
	                                <a href="tools_system.asp" onclick="return jump_if();">
	                                Tools &rarr; System</a> screen.
                                </p>
                                <p class="box_msg">
                                	To upgrade the firmware, your PC must have a wired connection to the router.
                                	Enter the name of the firmware upgrade file, and click on the Upload button.
                                </p>
                            </td>
                          </tr>
                          <tr>
                            <td align=right class="duple"></td>
                            <td height="59" colspan=2>
                            	<input type=file id=file name=file size="30"><br>
                            	<input type=button id="upgrade_button" name="upgrade_button" class=button_submit value="Upload" onClick="send_request()">
                            </td>
                          </tr>
                          <tr id="msg_upload" style="display:none" class="msg_inprogress">
                            <td align=right class="duple"></td>
                            <td colspan=2>
                            	Note: Now uploading. The upload may take up to 1 minute.
                            </td>
                          </tr>
                        </table>
				    </div>
				  </form>
				  <div id="update_new_result" name="update_new_result"> 
					<table width=90% border=0 cellpadding=2 cellspacing="2">
						<tr>
                          <td height=0 align="center">
				          	<IFRAME id="iframe_scan" name="iframe_scan" align=middle border="0" frameborder="0" marginWidth=0 marginHeight=0 src="" width="100%" height=0 scrolling="no"></IFRAME>
				          </td>
				        </tr>
				    </table>
				  </div>
				</div>
			</td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong>Helpful Hints&hellip;</strong>
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
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
</body>
</html>