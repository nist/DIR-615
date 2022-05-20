<html>
<head>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	function send_request(){
		if (get_by_id("file").value === "") {
			//alert("You must enter the name of a firmware file first.");
			alert(which_lang[tf_FWF1]);
			return false;
		}
		//if (!confirm("Note: Some firmware upgrades reset the router's configuration options to the factory defaults.\n Before performing an upgrade, be sure to save the current configuration from the Tools-System screen.\n Do you still want to upgrade?")) {
		if (!confirm(which_lang[tf_USSW])) {
			return false;
		}
		//if (!confirm("Do you really want to reprogram the device using the firmware file \"" +
				//get_by_id("file").value + "\"?")) {
		if (!confirm(which_lang[tf_really_FWF]+" \""+ get_by_id("file").value + " \"?" )) {
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
			//alert(which_lang[_error]+": " + e.message);
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

<title>D-Link公司 | 无线路由器 | 主页</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
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
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
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
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_admin])</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(which_lang[_time])</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(which_lang[_syslog])</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(which_lang[_email])</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(which_lang[_system])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[_firmware])</script></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(which_lang[_dyndns])</script></a></div></li>
                                    <li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(which_lang[_syscheck])</script></a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(which_lang[_scheds])</script></a></div></li>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
				<div id="maincontent">				
					
        <div id="box_header"> 
          <h1>
            <script>show_words(which_lang[_firmware])</script>
          </h1>
						
          <p> 
            <script>show_words(which_lang[tf_intro_FWU1])</script>
            DIR-615 
            <script>show_words(which_lang[tf_intro_FWU2])</script>
          </p>
          <p>
            <script>show_words(which_lang[tf_intro_FWCh])</script>
          </p>
          <p> 
            <script>show_words(which_lang[tf_intro_FWChB])</script>
          </p>
					</div>
					
        <div class="box"> 
          <h2>
            <script>show_words(which_lang[tf_FWInf])</script>
          </h2>
							<table width=525 border=0 cellpadding=2 cellspacing="2">
                              <tr>
                                
              <td width="40%" align=right class="duple">
                <script>show_words(which_lang[tf_CFWV])</script>
                :</td>
                                
              <td width="60%" colspan=2 class="output"> 
                <% CmoGetStatus("version"); %>
              </td>
                              </tr>
                              <tr>
                              	
              <td align=right class="duple">
                <script>show_words(which_lang[tf_CFWD])</script>
                :</td>
                                
              <td colspan=2 class="output"> 
                <% CmoGetStatus("version_date"); %>
              </td>
                              </tr>
                              <!--tr>
                              	<td align=right class="duple">Latest <script>show_words(which_lang[sd_FWV])</script>&nbsp;:</td>
                                <td width="60%" colspan=2 class="output">
                                   <% CmoGetStatus("version"); %>
                                </td>
                              </tr-->
                              <tr>
                                
              <td colspan=3>&nbsp;&nbsp;&nbsp;&nbsp;<strong> 
                <script>show_words(which_lang[tf_COLF])</script>
                : &nbsp;&nbsp;&nbsp;&nbsp; 
                
                <input id="check_now_b" name="check_now_b" type="button" class=button_submit value="" onClick="New_update_button();">
                <script>get_by_id("check_now_b").value = which_lang[tf_CKN];</script>
			    </strong> </td>
                              </tr>
				 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<tr>
				<td colspan=3>
				<strong><div id="check_result"></div></strong>
				</td>
				</tr>
                            </table>
				    </div>
				  	
        <div id="check_now_result" name="check_now_result" class="box" style="display:none"> 
          <h2>
            <script>show_words(which_lang[tf_FWCheckInf])</script>
          </h2>
							<table width=76% height=57 border=0 cellpadding=2 cellspacing="2">
                              <tr>
                                <td width="40%"><div align="right">
                  <script>show_words(which_lang[YM182])</script>
                  &nbsp;</div></td>
                                <td width="60%" height=10 colspan=2>
								<div align="left" id="latest_version"></div>
								</td>
                              </tr>
                              <tr>
                              <td width="40%">
							  	<div align="right">
                  <script>show_words(which_lang[tf_LFWD])</script>
                  &nbsp;</div>
								</td>
                                <td width="60%" height=10 colspan=2>
                                  <div align="left" id="latest_date"></div></td>
                              </tr>
                              <td width="40%"><div align="right">
                  <script>show_words(which_lang[tf_ADS])</script>
                  &nbsp;</div></td>
                                <td width="60%" height=10 colspan=2>
                                 <select id="sel_site" name="sel_site" onChange="">
								 </select>
								 </td>
                              </tr>
                              <tr>
                                <td colspan="3" height="21" align="center">
                                    <input type="button" name="download" id="download" value="" onClick="download_latest_fm();"> 
              						<script>get_by_id("download").value = which_lang[help501];</script>
			  					</td>
                              </tr>
                            </table>
				  	</div>
				    <form id="form1" name="form1" method=POST action="firmware_upgrade.cgi" enctype=multipart/form-data>
					<input type="hidden" id="html_response_page" name="html_response_page" value="ustatus.asp">
					<input type="hidden" name="html_response_return_page" value="tools_firmw.asp">
				    
          <div class="box"> 
            <h2>
              <script>show_words(which_lang[tf_FWUg])</script>
            </h2>
						<table width=525 border=0 cellpadding=2 cellspacing="2">
                          <tr>
                            
                <td colspan=3> <p class="box_alert"> <strong> 
                    <script>show_words(which_lang[_note])</script>
                    :</strong> 
                    <script>show_words(which_lang[tf_msg_FWUgReset])</script>
                  </p>
                                
                  <p class="box_msg"> 
                    <script>show_words(which_lang[tf_msg_wired])</script>
                  </p>
                            </td>
                          </tr>
                          <tr>
                            <td align=right class="duple"></td>
                            <td height="59" colspan=2>
                            	<input type=file id=file name=file size="30"><br>
                                <input type="button" id="upgrade_button" name="upgrade_button" class=button_submit value="" onClick="send_request();">
                            	<script>get_by_id("upgrade_button").value = which_lang[tf_Upload];</script>
							</td>
                          </tr>
                          <tr id="msg_upload" style="display:none" class="msg_inprogress">
                            <td align=right class="duple"></td>
                            
                <td colspan=2> 
                  <script>show_words(which_lang[tf_msg_Upping])</script>
                </td>
                          </tr>
                        </table>
				    </div>
				  </form>
				  
				  
				  <!--div class="box"> 
					<h2><script>show_words(which_lang[tf_FUNO])</script>
          </h2>
					<table width=76% border=0 cellpadding=2 cellspacing="2">
                         <tr>
                           
              <td width="42%" height="21"><strong>
                <script>show_words(which_lang[tf_EmNew])</script>
                : </strong></td>
                           <td width="58%" colspan=2>
                               <a href="http://wrpd.dlink.com.tw/register.asp"><script>show_words(which_lang[tf_ENFA])</script>                           </a> </td>
                         </tr>
                    </table>
				  </div-->
				  
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
					  
          <td id=help_text><strong> 
            <script>show_words(which_lang[_hints])</script>
            &hellip;</strong> 
            <p>
              <script>show_words(which_lang[ZM17])</script>
            </p>
							<p class="more"><a href="support_tools.asp#Firmware" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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