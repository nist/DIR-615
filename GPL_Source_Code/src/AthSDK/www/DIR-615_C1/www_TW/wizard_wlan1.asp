﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<script language="Javascript" src="md5.js"></script>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="Javascript">
	var submit_button_flag = 0;
	function mis_length(){
		var mis_length = 8;
		if(parseInt(get_by_id("asp_temp_35").value) < 2){
			mis_length = 13;
		}
		return mis_length;
	}
	function max_length(){
		var max_length = 63;
		if(parseInt(get_by_id("asp_temp_35").value) < 2){
			max_length = 26;
		}
		return max_length;
	}
	function send_request(){
		var security = "<% CmoGetCfg("asp_temp_35","none"); %>";
		var key = get_by_id("key").value;
		var temp_key = key;
		var mis = mis_length();
		var max = max_length();
		if(parseInt(get_by_id("asp_temp_35").value) == 1){
			if(key.length != mis && key.length != max && key.length != 5 && key.length != 10){
	        	//alert("The Wireless Security Password must be at least 13 characters or 26 hex digits. You entered "+ key.length);
	             //alert(which_lang[wwl_alert_pv5_1]+ key.length);
	             alert(which_lang[IPV6_TEXT2]);        	
                       
	            return false;
			}else{
				if(key.length == 5){
					mis = key.length;
					max = 10;
					get_by_id("asp_temp_50").value = 0;
				}else if(key.length == 10){
					mis = 5;
					max = key.length;
					get_by_id("asp_temp_50").value = 0;
				}
				if(key.length == max){
					for (var j = 0; j < key.length; j++){
		        		if (!check_hex(key.substring(j, j+1))){
		        			//alert("Passphrase is invalid. The legal characters are 0~9, A~F, or a~f");
		        			//alert("Exactly 10 or 26 characters using 0-9 and A-F");	///wwl_s4_intro_z3
                              alert(which_lang[IPV6_TEXT2]);  
		        			return false;
		        		}
					}
				}else{
		        	get_by_id("asp_temp_36").value = "ascii";
		        	temp_key = a_to_hex(get_by_id("key").value);
		        }
	        }
		}else if(parseInt(get_by_id("asp_temp_35").value) > 1){
			if (key.length < mis){                   
	        	//alert("The length of the Passphrase must be at least "+ mis +" characters");
                //alert(which_lang[wwl_alert_pv5_4]);
                alert(which_lang[IPV6_TEXT2]);  
				return false;
	        }else if (key.length > max){
        		if(!isHex(key)){
        			alert(which_lang[IPV6_TEXT2]);  
        			//alert(which_lang[GW_WLAN_WPA_PSK_HEX_STRING_INVALID]);
        			return false;
        		}
			}
			temp_key = get_by_id("key").value;
		}
		get_by_id("passpharse").value = temp_key;
		
		get_by_id("asp_temp_37").value = get_by_id("passpharse").value;
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
	
	function onPageLoad(){
		if(parseInt(get_by_id("asp_temp_35").value) < 2){
			get_by_id("show_wep").style.display = "";
		}else{
			get_by_id("show_psk").style.display = "";
		}
		get_by_id("key").maxLength = max_length();
		if(parseInt(get_by_id("asp_temp_35").value) > 1){
			get_by_id("key").maxLength = 64;
		}
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
<style type="text/css">
<!--
.style5 {font-size: 10px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wlan2.asp">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wlan1.asp">
<input type="hidden" id="reboot_type" name="reboot_type" value="none">
<input type="hidden" id="asp_temp_35" name="asp_temp_35" value="<% CmoGetCfg("asp_temp_35","none"); %>">
<input type="hidden" id="asp_temp_37" name="asp_temp_37">
<input type="hidden" id="asp_temp_36" name="asp_temp_36" value="hex">
<input type="hidden" id="asp_temp_50" name="asp_temp_50" value="1"><!--64, 128 bits-->

<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td>
<div align=left>
<table width=75% border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF">
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
      <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
      <td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle">
  </div>  
</td>
</tr>
</table>
</td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>    
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box> 
                <h2 align="left">
                  <script>show_words(which_lang[wwl_title_s4_2])</script>
                </h2>
            <table align="center" class="formarea" summary="wizard wep">
			  <tr>
			  	<td class="box_msg" colspan="2">
				<br>
                      <script>show_words(which_lang[wwl_s4_intro])</script>
                      <br>
                      <br>
				</td>
			  </tr>
              <tr id="show_psk" style="display:none">
                    <td class="box_msg" colspan="2"> <span class="itemhelp" id="wlan_passwd_wpa">
                      <script>show_words(which_lang[wwl_s4_intro_za1])</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wpa">
                      <script>show_words(which_lang[wwl_s4_intro_za2])</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wpa">
                      <script>show_words(which_lang[wwl_s4_intro_za3])</script>
                      </span><br>
                      <br>
				</td>
              </tr>
              <tr id="show_wep" style="display:none">
                    <td class="box_msg" colspan="2"> <span class="itemhelp" id="wlan_passwd_wep"> 
                      <script>show_words(which_lang[wwl_s4_intro_z1])</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wep">
                      <script>show_words(which_lang[wwl_s4_intro_z2])</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wep">
                      <script>show_words(which_lang[wwl_s4_intro_z3])</script>
                      </span><br>
                      <br>
                      <span class="itemhelp" id="wlan_passwd_wep">
                      <script>show_words(which_lang[wwl_s4_intro_z4])</script>
                      </span><br>
                      <br>
				</td>
              </tr>
              <tr>
                    <td class="duple">
                      <script>show_words(which_lang[wwl_WSP])</script>
                      &nbsp;:&nbsp;</td>
				<td width="465">
                	<input id="key" name="key" type="text" size="20" maxlength="20">
                    <input type="hidden" id="passpharse" name="passpharse" maxlength="64">
				</td>
              </tr>
			  <tr>
				  <td class="box_msg" colspan="2">
				  <br>
                      <script>show_words(which_lang[wwl_s4_note])</script>
                      <br>
                      <br>
				  </td>
			  </tr>
			  <tr>
			  	    <td colspan="2"> <p align="center"> 
                        <input type="button" class="button_submit" id="prev_b" name="prev_b" value="" onclick="window.location.href='wizard_wlan.asp'">
                        <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="send_request()">
                        <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onclick="wizard_cancel();">
                       	<script>get_by_id("prev_b").value = which_lang[_prev];</script>
						<script>get_by_id("next_b").value = which_lang[_next];</script>
						<script>get_by_id("cancel_b").value = which_lang[_cancel];</script>
                      </p>
			  	</td>
			  </tr>
            </table>
      </div></td>
    </tr>
  </table>
    <p>&nbsp;</p></td>
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
</form>   
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
<script>
onPageLoad();
</script>
</body>
</html>
