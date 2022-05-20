<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<script language="Javascript" src="md5.js"></script>
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
	        	alert("Invalid Network Key!");
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
		        			alert("Invalid Network Key!");
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
	        	alert("Invalid Network Key!");
				return false;
	        }else if (key.length > max){
        		if(!isHex(key)){
        			alert("Invalid Network Key!");
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
		if (confirm ("Do you want to abandon all changes you made to this wizard?")) {
			window.location.href="wizard_wireless.asp";
		}
	}
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
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
      <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
      <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
      <td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
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
        <h2 align="left">Step 2: Set your Wireless Security Password</h2>
            <table align="center" class="formarea" summary="wizard wep">
			  <tr>
			  	<td class="box_msg" colspan="2">
				<br>You have selected your security level - you will need to set a wireless security password.<br><br>
				</td>
			  </tr>
              <tr id="show_psk" style="display:none">
                <td class="box_msg" colspan="2">
				The WPA (Wi-Fi Protected Access) key must meet one of following guildelines:<br><br>
				- Between 8 and 63 characters (A longer WPA key is more secure than a short one)<br><br>
				- Exactly 64 characters using 0-9 and A-F<br><br>
				</td>
              </tr>
              <tr id="show_wep" style="display:none">
                <td class="box_msg" colspan="2">
				The WEP (or Wired Equivalent Privacy) key must meet one of following guildelines:<br><br>
				- Exactly 5 or 13 characters<br><br>
				- Exactly 10 or 26 characters using 0-9 and A-F<br><br>
				A longer WEP key is more secure than a short one<br><br>
				</td>
              </tr>
              <tr>
                <td class="duple">Wireless Security Password&nbsp;:&nbsp;</td>
				<td width="465">
                	<input id="key" name="key" type="text" size="20" maxlength="20">
                    <input type="hidden" id="passpharse" name="passpharse" maxlength="64">
				</td>
              </tr>
			  <tr>
				  <td class="box_msg" colspan="2">
				  <br>Note: You will need to enter the same password as keys in this step into your wireless clients in order to enable proper wireless communication.<br><br>
				  </td>
			  </tr>
			  <tr>
			  	<td colspan="2">
            	<p align="center">
                <input type="button" class="button_submit" name="prev_b" value="Prev" onClick="window.location.href='wizard_wlan.asp'">
                <input type="button" class="button_submit" name="next_b2" value="Next" onClick="send_request();">
                <input type="button" class="button_submit" name="cancel_b" value="Cancel" onClick="wizard_cancel();">
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc. </div>
<script>
onPageLoad();
</script>
</body>
</html>
