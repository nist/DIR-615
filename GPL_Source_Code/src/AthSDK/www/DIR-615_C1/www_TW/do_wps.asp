﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<title></title>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
	function check_pin(){
		var accum = 0;
		var PIN = get_by_id("wps_sta_enrollee_pin").value;
		
		accum += 3 * Math.floor((PIN / 10000000) % 10); 
		accum += 1 * Math.floor((PIN / 1000000) % 10); 
		accum += 3 * Math.floor((PIN / 100000) % 10); 
		accum += 1 * Math.floor((PIN / 10000) % 10); 
		accum += 3 * Math.floor((PIN / 1000) % 10); 
		accum += 1 * Math.floor((PIN / 100) % 10); 
		accum += 3 * Math.floor((PIN / 10) % 10); 
		accum += 1 * Math.floor((PIN / 1) % 10); 	
		
		return (0 == (accum % 10));
	}
	
	function send_request(){
		if(!get_by_name("wps_pin_radio")[0].checked && !get_by_name("wps_pin_radio")[1].checked){
			//alert("Please choose wireless device with wps!");
			alert(which_lang[TEXT012]);
			return false;
		}
		if(get_by_name("wps_pin_radio")[0].checked){
			if((get_by_id("wps_sta_enrollee_pin").value =="") || !_isNumeric(get_by_id("wps_sta_enrollee_pin").value) || (get_by_id("wps_sta_enrollee_pin").value.length != 8) || !check_pin()){
				//alert("Invalid PIN number.");
				alert(which_lang[KR22_ww]);
				return false;
			}
		}
		if(get_by_name("wps_pin_radio")[1].checked){
			get_by_id("html_response_page").value = "wps_back.asp";
			get_by_id("form1").action = "virtual_push_button.cgi";
		}
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
</script>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>

<tr>
<td>

  <table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
  <td bgcolor="#FFFFFF">    <div align="center">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
        <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="wlan_masthead.gif" width="836" height="92" align="middle">
      <br>
  </div>
    <table width="650" border="0" align="center"><br>
    <tr>
      <td><div id=box_header>
        <h1 align="left"><script>show_words(which_lang[wps_LW13])</script>
                    </h1>
        <div align="left">
          <p><script>show_words(which_lang[wps_p3_1])</script> </p>
          <P>-<script>show_words(which_lang[wps_p3_2])</script> </P>
          <P>-<script>show_words(which_lang[wps_p3_3])</script> </P>
          <form id="form1" name="form1" method="post" action="set_sta_enrollee_pin.cgi">
          	<input type="hidden" id="html_response_page" name="html_response_page" value="do_wps_save.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="do_wps.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
          <table align="center" class="formarea">
            <tr>
              <td width="50%" align="right"><input id="wps_pin_radio" name="wps_pin_radio" value="0" type="radio"></td>
              <td width="50%">
              	<b>PIN :&nbsp;</b>
              	<input id="wps_sta_enrollee_pin" name="wps_sta_enrollee_pin" maxlength="8" type="text">
              </td>
            </tr>
            <tr>
            	<td colspan="2">
                <p><script>show_words(which_lang[wps_p3_4])</script></p>
                <p></p>
            </td></tr>
            <tr>
              <td align="right"><INPUT type="radio" id="wps_pin_radio" name="wps_pin_radio" value="1"></td>
              <td><b>PBC&nbsp;</b></td>
            </tr>
            <tr>
              <td colspan="2">
              	<p><script>show_words(which_lang[wps_p3_5])</script>
                              </p>
              	<p></p>
              </td>
            </tr>
            <tr align="center">
                            <td colspan="3"> 
                             <input name="btn_prev" id="btn_prev" type="button" class=button_submit value="" onClick="window.location.href='wps_wifi_setup.asp'"> 
                             <input name="btn_connect" id="btn_connect" type="button" class=button_submit value="" onClick="send_request()">	
                              <script>get_by_id("btn_prev").value = which_lang[_prev];</script>
							  <script>get_by_id("btn_connect").value = which_lang[_connect];</script>
							</td>
            </tr>
          </table>
      </form>
        </div>
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
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  
  </td>
</tr>
</table>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
</body>
</html>
