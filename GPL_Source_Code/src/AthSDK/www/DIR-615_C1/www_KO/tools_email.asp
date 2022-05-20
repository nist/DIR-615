﻿<html>
<head>
<script type="text/javascript" src="ko.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">	
	function onPageLoad(){
		//email notification
		set_checked(get_by_id("log_email_enable").value, get_by_id("email_enable"));
		set_checked(get_by_id("log_email_auth").value, get_by_id("email_auth"));
		
		//mail_schedule
		var mail_schedule = get_by_id("log_email_schedule").value.split("/");
		//on log full check
		set_checked(mail_schedule[0], get_by_id("email_sch_enable"));
		//on schedule check
		set_checked(mail_schedule[1], get_by_id("by_email_sch"));
		set_selectIndex(mail_schedule[3], get_by_id("email_schedule"));
		key_word(get_by_id("email_schedule"), "email_detail");
		get_by_id("email_detail").readOnly = true;
		
		disable_schedule()
		disable_notifcation();
	}

	function check_mail(){
		if (get_by_id("log_email_sender").value == ""){
			//alert(msg[SMTP_SERVER_ERROR]);
			alert(which_lang[_blanksmtpmailaddr]);
			return false;
		}else if(get_by_id("log_email_recipien").value == ""){
			//alert(msg[EMAIL_ADDRESS_ERROR]);
			alert(which_lang[_blankfromemailaddr]);
			return false;
		}else if (get_by_id("log_email_server").value == ""){
			//alert(msg[EMAIL_ADDRESS_ERROR]);
			alert(which_lang[_blankfromemailaddr]);
			return false;
		}else if (get_by_id("log_email_password").value != get_by_id("email_pw2").value){
			//alert(msg[MATCH_WIZARD_PWD_ERROR]);
			alert(which_lang[YM102]);
			return false;
		}
		return true;
	}
	
	function get_detail(){
	  	key_word(get_by_id("email_schedule"), "email_detail");
	}
	
	function disable_emai_auth(){
		if(get_by_id("email_enable").checked){
	  	get_by_id("log_email_username").disabled = !get_by_id("email_auth").checked;
	  	get_by_id("log_email_password").disabled = !get_by_id("email_auth").checked;
	  	get_by_id("email_pw2").disabled = !get_by_id("email_auth").checked;
		}		
	}		
	
	function disable_notifcation(){
	  	get_by_id("log_email_sender").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("log_email_recipien").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("log_email_server").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("email_auth").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("log_email_username").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("log_email_password").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("email_pw2").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("email_sch_enable").disabled = !get_by_id("email_enable").checked;
	  	get_by_id("by_email_sch").disabled = !get_by_id("email_enable").checked;
	  	if(!get_by_id("email_enable").checked){
	  		get_by_id("email_schedule").disabled = !get_by_id("email_enable").checked;
	  		get_by_id("email_detail").disabled = !get_by_id("email_enable").checked;
	  	}	
	  	else{
	  		get_by_id("email_schedule").disabled = !get_by_id("by_email_sch").checked;
	  		get_by_id("email_detail").disabled = !get_by_id("by_email_sch").checked;
	  	}		  	
		disable_emai_auth();
	}	

	function disable_schedule(){
	  	get_by_id("email_schedule").disabled = !get_by_id("by_email_sch").checked;
	  	get_by_id("email_detail").disabled = !get_by_id("by_email_sch").checked;
	}		

	function check_date(){
		var is_change = false;
		if(!is_change){
			if(get_by_id("log_email_enable").value != get_checked_value(get_by_id("email_enable"))){
				is_change = true;
			}else if(get_by_id("log_email_sender").value != "<% CmoGetCfg("log_email_sender","none"); %>"){
				is_change = true;
			}else if(get_by_id("log_email_recipien").value != "<% CmoGetCfg("log_email_recipien","none"); %>"){
				is_change = true;
			}else if(get_by_id("log_email_server").value != "<% CmoGetCfg("log_email_server","none"); %>"){
				is_change = true;
			}else if(get_by_id("log_email_auth").value != get_checked_value(get_by_id("email_auth"))){
				is_change = true;
			}else if(get_by_id("log_email_username").value != "<% CmoGetCfg("log_email_username","none"); %>"){
				is_change = true;
			}else if(get_by_id("log_email_password").value != "<% CmoGetCfg("log_email_password","none"); %>"){
				is_change = true;
			}else if(get_by_id("log_email_schedule").value != (get_checked_value(get_by_id("email_sch_enable")) +"/"+get_checked_value(get_by_id("by_email_sch"))+"/"+ get_by_id("email_schedule").value)){
				is_change = true;
			}
		}
		if(is_change){
			//if (!confirm(msg[IS_CHANGE_DATA])){
			if (!confirm(which_lang[up_jt_1]+"\n"+which_lang[up_jt_2]+"\n"+which_lang[up_jt_3])){
				return;
			}
		}
		location.href="tools_schedules.asp";
	}
	
	function send_request(){
		//if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
		if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
			return false;
		}

		if(get_by_id("email_enable").checked){
			if(!check_mail()){
				return false;
			}
		}		
		get_by_id("log_email_enable").value = get_checked_value(get_by_id("email_enable"));
		get_by_id("log_email_auth").value = get_checked_value(get_by_id("email_auth"));
		//save mail_schedule
		get_by_id("log_email_schedule").value = get_checked_value(get_by_id("email_sch_enable")) +"/"+get_checked_value(get_by_id("by_email_sch"))+"/0/"+ get_by_id("email_schedule").value;
		get_by_id("form1").submit();
	}
</script>	
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

</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();">DIR-615</a></td>
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
                  <tbody>
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_admin])</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(which_lang[_time])</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(which_lang[_syslog])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[_email])</script></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(which_lang[_system])</script></a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(which_lang[_firmware])</script></a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(which_lang[_dyndns])</script></a></div></li>
                                    <li><div><a href="tools_vct.asp" onclick="return jump_if();"><script>show_words(which_lang[_syscheck])</script></a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(which_lang[_scheds])</script></a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
                  </tbody>
				</table>			
			</td>
			
			<input type="hidden" id="schedule_rule_0" name="schedule_rule_0" value="<% CmoGetCfg("schedule_rule_00","none"); %>">
			<input type="hidden" id="schedule_rule_1" name="schedule_rule_1" value="<% CmoGetCfg("schedule_rule_01","none"); %>">
			<input type="hidden" id="schedule_rule_2" name="schedule_rule_2" value="<% CmoGetCfg("schedule_rule_02","none"); %>">
			<input type="hidden" id="schedule_rule_3" name="schedule_rule_3" value="<% CmoGetCfg("schedule_rule_03","none"); %>">
			<input type="hidden" id="schedule_rule_4" name="schedule_rule_4" value="<% CmoGetCfg("schedule_rule_04","none"); %>">
			<input type="hidden" id="schedule_rule_5" name="schedule_rule_5" value="<% CmoGetCfg("schedule_rule_05","none"); %>">
			<input type="hidden" id="schedule_rule_6" name="schedule_rule_6" value="<% CmoGetCfg("schedule_rule_06","none"); %>">
			<input type="hidden" id="schedule_rule_7" name="schedule_rule_7" value="<% CmoGetCfg("schedule_rule_07","none"); %>">
			<input type="hidden" id="schedule_rule_8" name="schedule_rule_8" value="<% CmoGetCfg("schedule_rule_08","none"); %>">
			<input type="hidden" id="schedule_rule_9" name="schedule_rule_9" value="<% CmoGetCfg("schedule_rule_09","none"); %>">
			<input type="hidden" id="schedule_rule_10" name="schedule_rule_10" value="<% CmoGetCfg("schedule_rule_10","none"); %>">
			<input type="hidden" id="schedule_rule_11" name="schedule_rule_11" value="<% CmoGetCfg("schedule_rule_11","none"); %>">
			<input type="hidden" id="schedule_rule_12" name="schedule_rule_12" value="<% CmoGetCfg("schedule_rule_12","none"); %>">
			<input type="hidden" id="schedule_rule_13" name="schedule_rule_13" value="<% CmoGetCfg("schedule_rule_13","none"); %>">
			<input type="hidden" id="schedule_rule_14" name="schedule_rule_14" value="<% CmoGetCfg("schedule_rule_14","none"); %>">
			<input type="hidden" id="schedule_rule_15" name="schedule_rule_15" value="<% CmoGetCfg("schedule_rule_15","none"); %>">
			<input type="hidden" id="schedule_rule_16" name="schedule_rule_16" value="<% CmoGetCfg("schedule_rule_16","none"); %>">
			<input type="hidden" id="schedule_rule_17" name="schedule_rule_17" value="<% CmoGetCfg("schedule_rule_17","none"); %>">
			<input type="hidden" id="schedule_rule_18" name="schedule_rule_18" value="<% CmoGetCfg("schedule_rule_18","none"); %>">
			<input type="hidden" id="schedule_rule_19" name="schedule_rule_19" value="<% CmoGetCfg("schedule_rule_19","none"); %>">
			<input type="hidden" id="schedule_rule_20" name="schedule_rule_20" value="<% CmoGetCfg("schedule_rule_20","none"); %>">
			<input type="hidden" id="schedule_rule_21" name="schedule_rule_21" value="<% CmoGetCfg("schedule_rule_21","none"); %>">
			<input type="hidden" id="schedule_rule_22" name="schedule_rule_22" value="<% CmoGetCfg("schedule_rule_22","none"); %>">
			<input type="hidden" id="schedule_rule_23" name="schedule_rule_23" value="<% CmoGetCfg("schedule_rule_23","none"); %>">
			<input type="hidden" id="schedule_rule_24" name="schedule_rule_24" value="<% CmoGetCfg("schedule_rule_24","none"); %>">
			<input type="hidden" id="schedule_rule_25" name="schedule_rule_25" value="<% CmoGetCfg("schedule_rule_25","none"); %>">
			<input type="hidden" id="schedule_rule_26" name="schedule_rule_26" value="<% CmoGetCfg("schedule_rule_26","none"); %>">
			<input type="hidden" id="schedule_rule_27" name="schedule_rule_27" value="<% CmoGetCfg("schedule_rule_27","none"); %>">
			<input type="hidden" id="schedule_rule_28" name="schedule_rule_28" value="<% CmoGetCfg("schedule_rule_28","none"); %>">
			<input type="hidden" id="schedule_rule_29" name="schedule_rule_29" value="<% CmoGetCfg("schedule_rule_29","none"); %>">
			<input type="hidden" id="schedule_rule_30" name="schedule_rule_30" value="<% CmoGetCfg("schedule_rule_30","none"); %>">
			<input type="hidden" id="schedule_rule_31" name="schedule_rule_31" value="<% CmoGetCfg("schedule_rule_31","none"); %>">
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_email.asp">
			
			<input type="hidden" id="log_email_schedule" name="log_email_schedule" value="<% CmoGetCfg("log_email_schedule","none"); %>">
			<input type="hidden" id="log_email_enable" name="log_email_enable" value="<% CmoGetCfg("log_email_enable","none"); %>">
			<input type="hidden" id="reboot_type" name="reboot_type" value="application">
			<td valign="top" id="maincontent_container">			  <div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				
          <div id="box_header"> 
            <h1>
              <script>show_words(which_lang[_email])</script>
            </h1>
            <script>show_words(which_lang[te_intro_Em])</script>
            <br>
            <br>
			<input name="button3" id="button3" type="button" class=button_submit value="" onClick="send_request()">
			<input name="button2" id="button2" type=reset class=button_submit value="" onclick="page_cancel('form1', 'tools_email.asp');">
			<script>get_by_id("button3").value = which_lang[_savesettings];</script>
			<script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
		   	</div>
			  	
          <div class="box"> 
            <h2>
              <script>show_words(which_lang[_enable])</script>
            </h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[te_EnEmN])</script>
                  :</td>
                        <td width="340">&nbsp;<input type="Checkbox" id="email_enable" name="email_enable" value="1" onClick="disable_notifcation();"></td>
                      </tr>
					</table>
				</div>
			  	
          <div class="box"> 
            <h2>
              <script>show_words(which_lang[te_EmSt])</script>
            </h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[te_FromEm])</script>
                  :</td>
                        <td width="340">&nbsp;
	                        <input type=text id="log_email_sender" name="log_email_sender" size=30 maxlength=99 value="<% CmoGetCfg("log_email_sender","none"); %>">
						</td>
                      </tr>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[te_ToEm])</script>
                  :</td>
                        <td width="340">&nbsp;
	                        <input type=text id="log_email_recipien" name="log_email_recipien" size=30 maxlength=99 value="<% CmoGetCfg("log_email_recipien","none"); %>">
						</td>
                      </tr>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[te_SMTPSv])</script>
                  :</td>
                        <td width="340">&nbsp;
	                        <input type=text id="log_email_server" name="log_email_server" size=30 maxlength=99 value="<% CmoGetCfg("log_email_server","none"); %>">
						</td>
                      </tr>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[te_EnAuth])</script>
                  :</td>
                        <td width="340">&nbsp;<input type="Checkbox" id="email_auth" name="email_auth" value="1" onClick="disable_emai_auth();"></td>
                        <input type="hidden" id="log_email_auth" name="log_email_auth" value="<% CmoGetCfg("log_email_auth","none"); %>">
                      </tr>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[te_Acct])</script>
                  :</td>
                        <td width="340">&nbsp;
	                        <input type=text id="log_email_username" name="log_email_username" size=30 maxlength=99 value="<% CmoGetCfg("log_email_username","none"); %>">
						</td>
                      </tr>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[_password])</script>
                  :</td>
                        <td width="340">&nbsp;
	                        <input type=password id="log_email_password" name="log_email_password" size=30 maxlength=99 value="<% CmoGetCfg("log_email_password","none"); %>">
						</td>
                      </tr>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[_verifypw])</script>
                  :</td>
                        <td width="340">&nbsp;
	                        <input type=password id="email_pw2" name="email_pw2" size=30 maxlength=99 value="<% CmoGetCfg("log_email_password","none"); %>">
						</td>
                      </tr>
            		</table>
			  	</div>
			  	
          <div class="box"> 
            <h2> 
              <script>show_words(which_lang[te__title_EmLog])</script>
            </h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        
                <td class="duple"> 
                  <script>show_words(which_lang[te_OnFull])</script> :</td>
                        <td width="340">&nbsp;<input type="Checkbox" id="email_sch_enable" name="email_sch_enable" value="1"></td>
                      </tr>

                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[te_OnSch])</script>
                  :</td>
                        <td width="340">&nbsp;<input type="Checkbox" id="by_email_sch" name="by_email_sch" value="25" onClick="disable_schedule();"></td>
                      </tr>
				 
                      <tr>
                        <td class="duple"><a href="javascript:check_date();"><script>show_words(which_lang[_sched])</script></a> :</td>
                        <td width="340">&nbsp;
	                        <select id="email_schedule" name="email_schedule" onClick="get_detail();">
	                        	<option value="Never"><script>show_words(which_lang[_never])</script></option>
	                        	<script>
	                              	document.write(set_schedule_option());
	                            </script>
	                        </select>
						</td>
                      </tr>
                      <tr>
                        
                <td class="duple">
                  <script>show_words(which_lang[_aa_details])</script>
                  :</td>
                        <td width="340">&nbsp;&nbsp;<input type="text" id="email_detail" name="email_detail"></td>
                      </tr>
					</table>
				</div>
			</div>
			</td>
		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                  <tr>
                    
          <td id="help_text"><strong>
            <script>show_words(which_lang[_hints])</script>
            &hellip;</strong> <p>
              <script>show_words(which_lang[hhte_intro])</script>
            </p>
					  <p><a href="support_tools.asp#EMail" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
                    </td>
                  </tr>
                </table></td>
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
<script>
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>