<html>
<head>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function restoreConfirm(){
			var login_who="<% CmoGetStatus("get_current_user"); %>";
			if(login_who== "user"){
				window.location.href ="back.asp";
			}else{
				if(confirm(msg[RESTORE_DEFAULT])){		
			    	send_submit("form2");
			   	}
			}
	}
	
	function restore_js(){
		if(confirm(msg[RESET_JUMPSTAR])){		
	    	send_submit("form4");
	   	}
	}
	
	function loadConfirm(){
		var login_who="<% CmoGetStatus("get_current_user"); %>"; 
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			var btn_restore = get_by_id("load");
			if (btn_restore.disabled) {
				alert ("A restore is already in progress.");
				return false;
			}
			if (get_by_id("file").value == "") {
				alert(msg[LOAD_FILE_ERROR]);
				return false;
			}
			
			var file_name=get_by_id("file").value;
			var ext_file_name=file_name.substring(file_name.lastIndexOf('.')+1,file_name.length);
			if (ext_file_name!="bin"){
				alert("The restored configuration file is not correct. You may have restored a file that is not intended for this device, or the restored file may be corrupted.");
				return false;
			}
			btn_restore.disabled = true;
			var inf = get_by_id("restore_info");
			if(confirm(msg[LOAD_SETTING])){
				inf.innerHTML = "Please wait, uploading configuration file...";
				try {
					send_submit("form1");
				} catch (e) {
					alert("Error: " + e.message);
					inf.innerHTML = "&nbsp;";
					btn_restore.disabled = false;
				}
			}else{
				inf.innerHTML = "&nbsp;";
				btn_restore.disabled = false;
			}
		}    
	}
	function confirm_reboot(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			if(confirm(msg[REBOOT_ROUTER])){
	    		send_submit("form6");
	   		}
		}
	}

	function save_conf(){
		send_submit("form17");
	}

</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
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
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();">ADMIN</a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();">TIME</a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();">SYSLOG</a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();">EMAIL SETTINGS</a></div></li>
									<li><div id="sidenavoff">SYSTEM</div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();">FIRMWARE</a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();">DYNAMIC DNS</a></div></li>
								  	<li><div><a href="tools_vct.asp" onclick="return jump_if();">SYSTEM CHECK</a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();">SCHEDULES</a></div></li>
									
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
		  <td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  <div id="box_header"> 
					<h1>System Settings</h1>
					<p>The System Settings section allows you to reboot the device, or restore the router to the factory default settings. Restoring the unit to the factory default settings will erase all settings, including any rules that you have created.</p>
					<p>The current system settings can be saved as a file onto the local hard drive. The saved file or any other saved setting file created by device can be uploaded into the unit.</p>
				  </div>
				  <div class="box">
                      <h2>System Settings</h2>
                      <table width="525" border=0 cellpadding=2 cellspacing="2">
                        <form id="form17" name="form17" method=POST action="save_configuration.cgi" enctype=multipart/form-data>
                         <input type="hidden" id="html_response_page" name="html_response_page" value="tools_system.asp">
						 <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_system.asp">
						  <tr valign="top">
                            <td width="183" height="48" align=right class="duple">Save To Local Hard Drive:</td>
                            <td width="328">&nbsp;
                           		<input type=button value="Save Configuration" id=save name=save onClick="save_conf()">
                           	</td>
                          </tr>
                        </form>
                         <form id="form1" name="form1" method=POST action="upload_configuration.cgi" enctype=multipart/form-data>
							<input type="hidden" id="html_response_page" name="html_response_page" value="restore_succeeded.asp">
							<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_system.asp">			
                          <tr>
                            <td height="72" align=right valign="top" class="duple">Load From Local Hard Driver:</td>
                            <td valign="top">&nbsp;
                            	<input type=file id=file name=file size=20><br>
                            	&nbsp;
                           		<input type="button" value="Restore Configuration from File" id="load" name="load" onclick="loadConfirm()"><br>
                           		<span class="msg_inprogress" id="restore_info">&nbsp;</span>
                           	</td>
                          </tr>
                         </form>
                         <form id="form2" name="form2" method="post" action="restore_default.cgi">
                         	<input type="hidden" id="html_response_page" name="html_response_page" value="reboot.asp">
			  				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_system.asp">
                          <tr valign="top">
                            <td height="66" align=right class="duple">Restore To Factory Default:</td>
                            <td>&nbsp;
						    	<input type="button" value="Restore Factory Defaults" name="restore" onclick="restoreConfirm()"><br>
					    		&nbsp;&nbsp;Restore all settings to the factory defaults.
					    	</td>
                          </tr>
                        </form>
                        <form id="form6" name="form6" method="post" action="reboot.cgi">
                        	<input type="hidden" name="html_response_page" value="reboot.asp">
                        	<input type="hidden" name="html_response_return_page" value="tools_system.asp">
                          <tr valign="top">
                          	<td height="39" align=right class="duple">Reboots the Device:</td>
                          	<td>&nbsp;
                          		<input type="button" value="Reboot the Device" name=restart onclick="confirm_reboot()">
                          	</td>
                          </tr>
                        </form>
                    </table>
				  </div>
<!--
<div class="box">
                      <h2>JumpStart : </h2>
                      <table width="525" height=46 border=0 cellpadding=2 cellspacing="2">
                        
                        <form id=form3 name= form3 method=POST action=enableJS.cgi>
                          <tr>
                            <td width=225><div align="right">Enable JumpStart function :</div></td>
                            <td height=20 width=300>&nbsp;
				            <input name="js_g_enable" type="checkbox" id="js_g_enable" value="1">
                            &nbsp;
                            <input type="button" value=Apply name=SaveJs onclick="send_submit('form3')">                           </td>
                          </tr>
                       </form>
                          <form id=form4 name=form4 method=POST action=restoreJS.cgi>
			<tr>
                <td width=225><div align="right">Reset JumpStart :</div></td>
                            <td height=20 width=300>&nbsp;
				<input type="button" name="restoreJS"  id="restoreJS" onClick="restore_js()" value="Jumpstart">                </td>
                          </tr></form>
			  
                    </table>
					
				  </div>
-->
					<!-- === END MAINCONTENT === -->
          </div>
		  </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text"><strong>Helpful Hints&hellip;</strong>
					  	<p>Once your router is configured the way you want it, you can save the configuration settings to a configuration file.</p>
					  	<p>You might need this file so that you can load your configuration later in the event that the router's default settings are restored.</p>
					  	<p>To save the configuration, click the <strong>Save Configuration</strong> button.</p>
						<p class="more"><a href="support_tools.asp#System" onclick="return jump_if();">More&hellip;</a></p>
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
