<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
function onPageLoad(){
	var wlan0_security= "<% CmoGetCfg("wlan0_security","none"); %>";		
		
		var security = wlan0_security.split("_");

		if(wlan0_security == "disable"){					//Disabled
			get_by_id("secu_mode").innerHTML = which_lang[_none];
			get_by_id("wpa").style.display = "none";
			get_by_id("wep").style.display = "none";
		}else if(security[0] == "wep"){						//WEP
			get_by_id("wep").style.display = "";
			get_by_id("wpa").style.display = "none";
			var default_key = "<% CmoGetCfg("wlan0_wep_default_key","none"); %>";
			var key = new Array();
			key[1] = "<% CmoGetCfg("asp_temp_37","none"); %>";
			key[2] = "<% CmoGetCfg("asp_temp_38","none"); %>";
			key[3] = "<% CmoGetCfg("asp_temp_39","none"); %>";
			key[4] = "<% CmoGetCfg("asp_temp_40","none"); %>";
			get_by_id("show_wep_key").innerHTML = "WEP KEY " + default_key + " : " + key[default_key];
			if(security[1] == "open"){
				//get_by_id("secu_mode").innerHTML = "WEP - Open";
				get_by_id("secu_mode").innerHTML = which_lang[_WEP]+" - "+which_lang[_open];
			}else if(security[1] == "share"){
				//get_by_id("secu_mode").innerHTML = "WEP - Shared Key";
				get_by_id("secu_mode").innerHTML = which_lang[_WEP]+" - "+which_lang[bws_Auth_2];
			}
		}else if(security[0] == "wpa" || security[0] == "wpa2" || security[0] == "wpa2auto"){	//WPA
			get_by_id("wpa").style.display = "";
			get_by_id("wep").style.display = "none";	
			if(security[0] == "wpa" && security[1] == "psk"){		
				//get_by_id("secu_mode").innerHTML = "WPA - PSK";
				get_by_id("secu_mode").innerHTML = which_lang[_WPApersonal];
			}else if(security[0] == "wpa" && security[1] == "eap"){
				//get_by_id("secu_mode").innerHTML = "WPA - EAP";
				get_by_id("secu_mode").innerHTML = which_lang[_WPAenterprise];
			}else if(security[0] == "wpa2" && security[1] == "psk"){
				//get_by_id("secu_mode").innerHTML = "WPA2 - PSK";
				get_by_id("secu_mode").innerHTML = "WPA2 - "+which_lang[LW24];
			}else if(security[0] == "wpa2" && security[1] == "eap"){
				//get_by_id("secu_mode").innerHTML = "WPA2 - EAP";
				get_by_id("secu_mode").innerHTML = "WPA2 - "+which_lang[LW23];
			}else if(security[0] == "wpa2auto" && security[1] == "psk"){
				get_by_id("secu_mode").innerHTML = which_lang[KR48];
			}else if(security[0] == "wpa2auto" && security[1] == "eap"){
				get_by_id("secu_mode").innerHTML = which_lang[bws_WPAM_2]+" - "+which_lang[LW23];
			}
		}
}
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style4 {font-size: 10px}
-->
</style>
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
<td bgcolor="#FFFFFF"><div align=center>
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
      <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
      <td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle"></div></td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>    <table width="650" border="0" align="center">
    <tr>
      <td>
      	<div id=box_header> 
              <h1 align="left">
                <script>show_words(which_lang[LW13])</script>
                (<script>show_words(which_lang[LW65])</script>)</h1>
        	<div align="left">
          		<!--p>Please enter the following settings in the wireless device that you are adding to your wireless network and keep a note of it for future reference.</p-->
          		<p><script>show_words(which_lang[wwl_intro_end])</script></p>
          		
          		<table align="center" class="formarea">
	            <tr>
	              <td>
	              	<script>show_words(which_lang[help699])</script>
                      : <strong>
                      <% CmoGetCfg("wlan0_ssid","none"); %>
                      </strong> <br>
                      <br>
					<script>show_words(which_lang[bws_SM])</script>
                      : <strong><span id="secu_mode"></span><strong> <br>
                      <br>
					
					<div id="wpa" style="display:none">
					<script>show_words(which_lang[bws_CT])</script>
                        : <strong><font style="text-transform:uppercase;">
                        <% CmoGetCfg("wlan0_psk_cipher_type","none"); %>
                        </font><strong> <br>
                        <br>
			        <script>show_words(which_lang[LW25])</script>: <strong><% CmoGetCfg("wlan0_psk_pass_phrase","none"); %><strong><br>
					<br><br>
					</div>
					<div id="wep" style="display:none">
					<span id="show_wep_key"></span>
					</div>
	              </td>
	            </tr>
	            <tr align="center">
	                <td> 
                      <input name="OK_b" id="OK_b" type="button" class=button_submit value="" onClick=window.location.href="wizard_wireless.asp">
					  <script>get_by_id("OK_b").value = which_lang[_ok];</script>
                      &nbsp; </td>
	            </tr>
	          </table>
          		
        	</div>
        </div>
	  </td>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
</body>
<script>
 	onPageLoad();
</script>
</html>
