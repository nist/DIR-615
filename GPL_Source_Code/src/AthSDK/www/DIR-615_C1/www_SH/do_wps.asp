<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<title></title>
<script language="JavaScript" src="public.js"></script>
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
			alert("Please choose wireless device with wps!");
			return false;
		}
		if(get_by_name("wps_pin_radio")[0].checked){
			if((get_by_id("wps_sta_enrollee_pin").value =="") || !_isNumeric(get_by_id("wps_sta_enrollee_pin").value) || (get_by_id("wps_sta_enrollee_pin").value.length != 8) || !check_pin()){
				alert("Invalid PIN number.");
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
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
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
        <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
        <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="wlan_masthead.gif" width="836" height="92" align="middle">
      <br>
  </div>
    <table width="650" border="0" align="center"><br>
    <tr>
      <td><div id=box_header>
        <h1 align="left">Add Wireless Device with WPS(Wi-Fi Protected Setup)</h1>
        <div align="left">
          <p>There are two ways to add wireless device to your wireless network:</p>
          <P>-PIN (Personal Identification Number) </P>
          <P>-PBC (Push Button Configuration) </P>
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
                <p>Please enter the PIN from your wireless device and click the below "Connect" button</p>
                <p></p>
            </td></tr>
            <tr>
              <td align="right"><INPUT type="radio" id="wps_pin_radio" name="wps_pin_radio" value="1"></td>
              <td><b>PBC&nbsp;</b></td>
            </tr>
            <tr>
              <td colspan="2">
              	<p>Please press the push button on your wireless device and press the "Connect" button <br>below within 120 seconds</p>
              	<p></p>
              </td>
            </tr>
            <tr align="center">
              <td colspan="3">
				<input type="button" class="button_submit" name="btn_prev" value="Prev" onClick="window.location.href='wps_wifi_setup.asp'">
				<input type="button" class="button_submit" name="btn_connect" value="Connect" onClick="send_request()">	
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc. </div>
</body>
</html>
