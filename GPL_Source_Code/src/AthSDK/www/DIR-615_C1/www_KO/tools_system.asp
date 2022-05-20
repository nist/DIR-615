﻿<html>
<head>
<script type="text/javascript" src="ko.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function restoreConfirm(){
			var login_who="<% CmoGetStatus("get_current_user"); %>";
			if(login_who== "user"){
				window.location.href ="back.asp";
			}else{
				//if(confirm(msg[RESTORE_DEFAULT])){	
				if(confirm(which_lang[up_rb_4]+"\n"+which_lang[up_rb_5])){	
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
				//alert ("A restore is already in progress.");
				alert(which_lang[ta_alert_4]);
				return false;
			}
			if (get_by_id("file").value == "") {
				//alert(msg[LOAD_FILE_ERROR]);
				alert(which_lang[ta_alert_5]);
				return false;
			}
			var file_name=get_by_id("file").value;
			var ext_file_name=file_name.substring(file_name.lastIndexOf('.')+1,file_name.length);
			if (ext_file_name!="bin"){
				alert(which_lang[rs_intro_1]);
				return false;
			}
			btn_restore.disabled = true;
			//if(confirm(msg[LOAD_SETTING])){
			var inf = get_by_id("restore_info");
			if(confirm(which_lang[YM38])){
				inf.innerHTML = which_lang[ta_alert_6]+"...";
				//inf.innerHTML = "Please wait, uploading configuration file...";
				try {
					send_submit("form1");
				} catch (e) {
					alert(which_lang[_error]+": " + e.message);
					//alert("Error: " + e.message);
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
			//if(confirm(msg[REBOOT_ROUTER])){
			if(confirm(which_lang[up_rb_1]+"\n"+which_lang[up_rb_2])){	
	    		send_submit("form6");
	   		}
		}
	}

	function save_conf(){
		send_submit("form17");
	}

</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-Link 회사 | 무선 라우터 | 홈</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
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
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_admin])</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(which_lang[_time])</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(which_lang[_syslog])</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(which_lang[_email])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[_system])</script></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(which_lang[_firmware])</script></a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(which_lang[_dyndns])</script></a></div></li>
                                    <li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(which_lang[_syscheck])</script></a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(which_lang[_scheds])</script></a></div></li>
								
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
          <h1>
            <script>show_words(which_lang[tss_SysSt])</script>
          </h1>
					
          <p>
            <script>show_words(which_lang[tss_intro])</script>
          </p>
					
          <p>
            <script>show_words(which_lang[tss_intro2])</script>
          </p>
				  </div>
				  
        <div class="box"> 
          <h2>
            <script>show_words(which_lang[tss_SysSt])</script>
          </h2>
                      <table width="525" border=0 cellpadding=2 cellspacing="2">
                        <form id="form17" name="form17" method=POST action="save_configuration.cgi" enctype=multipart/form-data>
                         <input type="hidden" id="html_response_page" name="html_response_page" value="tools_system.asp">
						 <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_system.asp">
						  <tr valign="top">
                            <td width="183" height="48" align=right class="duple"><script>show_words(which_lang[ts_ss])</script>:</td>
                            <td width="328">&nbsp;
                           		<input name="save" id="save" type="button" value="" onClick="save_conf()">
								<script>get_by_id("save").value = which_lang[ta_SavConf];</script>
                </td>
                          </tr>
                        </form>
                         <form id="form1" name="form1" method=POST action="upload_configuration.cgi" enctype=multipart/form-data>
							<input type="hidden" id="html_response_page" name="html_response_page" value="restore_succeeded.asp">
							<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_system.asp">			
                          <tr>
                            <td height="72" align=right valign="top" class="duple"><script>show_words(which_lang[ts_ls])</script>:</td>
                            <td valign="top">&nbsp;
                            	<input type=file id=file name=file size=20><br>
                  &nbsp; 
                  <input name="load" id="load" type="button" value="" onClick="loadConfirm()">
                  <script>get_by_id("load").value = which_lang[ta_ResConf];</script>
				  <br>
                           		<span class="msg_inprogress" id="restore_info">&nbsp;</span>
                           	</td>
                          </tr>
                         </form>
                         <form id="form2" name="form2" method="post" action="restore_default.cgi">
                         	<input type="hidden" id="html_response_page" name="html_response_page" value="reboot.asp">
			  				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_system.asp">
                          <tr valign="top">
                            <td height="66" align=right class="duple"><script>show_words(which_lang[ts_rfd])</script>:</td>
                            
                <td>&nbsp; 
                  <input name="restore" id="restore" type="button" value="" onClick="restoreConfirm()">
                  <script>get_by_id("restore").value = which_lang[tss_RestAll_b];</script>
				  <br>
                  &nbsp;&nbsp;
                  <script>show_words(which_lang[tss_RestAll])</script>
                </td>
                          </tr>
                        </form>
                        <form id="form6" name="form6" method="post" action="reboot.cgi">
                        	<input type="hidden" name="html_response_page" value="reboot.asp">
                        	<input type="hidden" name="html_response_return_page" value="tools_system.asp">
                          <tr valign="top">
                          	<td height="39" align=right class="duple"><script>show_words(which_lang[ts_rd])</script>:</td>
                          	
                <td>&nbsp; 
                  <input name="restart" id="restart" type="button" value="" onClick="confirm_reboot()"> 
                  <script>get_by_id("restart").value = which_lang[ts_rd];</script>
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
					  
          <td id="help_text"><strong> 
            <script>show_words(which_lang[_hints])</script>
            &hellip;</strong> <p>
              <script>show_words(which_lang[ZM18])</script>
            </p>
					  	
            <p>
              <script>show_words(which_lang[ZM19])</script>
            </p>
					  	
            <p>
              <script>show_words(which_lang[ZM20])</script>
            </p>
						<p class="more"><a href="support_tools.asp#System" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
