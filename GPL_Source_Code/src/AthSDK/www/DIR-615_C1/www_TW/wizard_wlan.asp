﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="Javascript">
	var submit_button_flag = 0;
	var auto_length = 13;
	function onPageLoad(){
		get_by_id("show_ssid").value = get_by_id("asp_temp_34").value;
		set_form_default_values("form1");
	}
				
	function send_request(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			//window.location.href ="index.asp";
			window.location.href ="user_page.asp";
			return false;
		}else{
			var c_ssid = get_by_id("show_ssid").value;
			if (check_ssid("show_ssid")){
				get_by_id("asp_temp_34").value = get_by_id("show_ssid").value;
				get_by_id("asp_temp_35").value = 1;
				if(get_by_id("is_WPA").checked){
					get_by_id("asp_temp_35").value = 2;
					auto_length = 32;
				}
				if(get_by_name("auto_next_page")[0].checked){
					get_by_id("asp_temp_37").value = get_auto_wepkey(auto_length);
				}
				get_by_id("html_response_page").value = get_checked_value(get_by_name("auto_next_page"));
				if(submit_button_flag == 0){
					submit_button_flag = 1;
					send_submit("form1");
				}
			}
		}
	}
	
	function get_auto_wepkey(length){
		var pass_word=""
		var seed = parseInt(Math.random() * 100,10);
		for (i=0; i<length ;i++ ){
			seed = (214013 * seed) & 0xffffffff;
		    if(seed & 0x80000000)
		        seed = (seed & 0x7fffffff) + 0x80000000 + 0x269ec3;
		    else
		        seed = (seed & 0x7fffffff) + 0x269ec3;
		    temp = ((seed >> 16) & 0xff);
		    if(temp < 0x10){
		        pass_word += "0" + temp.toString(16).toLowerCase();
			}else{
		        pass_word += temp.toString(16).toLowerCase();
		    }
		}
		return pass_word;
	}
	function wizard_cancel(){
		if (!is_form_modified("mainform")) {
			//if (!confirm ("Do you want to abandon all changes you made to this wizard?")) {
			if(!confirm(which_lang[_wizquit])) {
				return false;
			}
		}
		window.location.href="wizard_wireless.asp";
	}
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">

<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF">
<div align=center>
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
      <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
      <td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
      <td>&nbsp;</td>
    </tr>
  </table>
 <img src="wlan_masthead.gif" width="836" height="92" align="middle"> </div></td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  <p>&nbsp;</p>
  <table width="650" border="0" align="center">
    <tr>
      <td>
	  <div class="box"> 
              <h2 align="left"> 
                <script>show_words(which_lang[wwz_wwl_title_s3])</script>
              </h2>
              <div align="center"> 
                <p class="box_msg" align="left">
                  <script>show_words(which_lang[wwz_wwl_intro_s3_1])</script>
                </p>
            </div>
				<form id="form1" name="form1" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wlan1.asp">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wlan.asp">
					<input type="hidden" id="reboot_type" name="reboot_type" value="none">
					
					<input type="hidden" id="asp_temp_34" name="asp_temp_34" value="<% CmoGetCfg("wlan0_ssid","none"); %>">
					<input type="hidden" id="asp_temp_35" name="asp_temp_35" value="">
					<input type="hidden" id="asp_temp_37" name="asp_temp_37" value="">
					<input type="hidden" id="asp_temp_36" name="asp_temp_36" value="hex">
					<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="1"><!--64, 128 bits-->
					
					<table align="center" class=formarea>
	                <tr align="left">
	                  <td width="20">&nbsp;</td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1">
                        <script>show_words(which_lang[wwz_wwl_wnn])</script>
                        : 
                        <input type="text" id="show_ssid" name="show_ssid" size="20" maxlength="32" value="">
	                    </div>
	                  </TD>
	                </tr>
	                <tr align="left">
	                  <td width="20"><INPUT type="radio" id="auto_next_page" name="auto_next_page" value="wizard_wlan2.asp" checked></td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1">
                        <script>show_words(which_lang[wwz_auto_assign_key])</script>
                      </div>
	                  </TD>
	                </tr>
	                <tr align="left">
	                  <td width="20">&nbsp;</td>
	                  
                    <td colspan="2" class=form_label> <p>
                        <script>show_words(which_lang[wwz_auto_assign_key2])</script>
                      </p>
	                  </TD>
	                </tr>
	                <tr align="left">
	                  <td width="20"><INPUT type="radio" id="auto_next_page" name="auto_next_page" value="wizard_wlan1.asp"></td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1">
                        <script>show_words(which_lang[wwz_manual_key])</script>
                      </div>
	                  </TD>
	                </tr>
	                <tr align="left">
	                  <td width="20">&nbsp;</td>
	                  
                    <td colspan="2" class=form_label> <p>
                        <script>show_words(which_lang[wwz_manual_key2])</script>
                      </p>
	                  </TD>
	                </tr>
	                <tr align="left">
	                  <td width="20"><INPUT type="checkbox" id="is_WPA" name="is_WPA"></td>
	                  <td colspan="2" class=form_label>
	                  	<div class="style1"> 
                        <script>show_words(which_lang[wwz_wpa_support])</script>
                      </div>
	                  </TD>
	                </tr>
					<tr>
					<td class="box_msg" colspan="3"><br>
                      <script>show_words(which_lang[wwl_s3_note_2])</script>
                      <br></td>
					</tr>
	                <tr align="center">
	                  <td colspan="3">
                          <input type="button" class="button_submit" id="prev_b" name="prev_b" value="" onclick=window.location.href="wizard_wireless.asp"> 
                          <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="send_request()">
                          <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onclick="wizard_cancel();"> 
                          <input type="button" class="button_submit" id="save_b" name="save_b" value="" onClick="return send_request()"> 
                        <script>get_by_id("prev_b").value = which_lang[_prev];</script>
						<script>get_by_id("next_b").value = which_lang[_next];</script>
						<script>get_by_id("cancel_b").value = which_lang[_cancel];</script>
						<script>get_by_id("save_b").value = which_lang[_save];</script>
						
	                  </TD>
	                </tr>
	              </table>
            	</form>
      </div>
	  </td>
    </tr>
  </table>
  <p>&nbsp;</p>
 </td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
      <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
      <td width="10">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table></td>
</tr>
</table>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
<script>onPageLoad();</script>
</body>
</html>
