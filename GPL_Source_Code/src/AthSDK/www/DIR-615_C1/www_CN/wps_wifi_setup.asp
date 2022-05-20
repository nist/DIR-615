<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link公司 | 无线路由器 | 主页</title>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
#wps_enable {
	BORDER-RIGHT: #ff6f00 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #ff6f00 1px solid; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; BORDER-LEFT: #ff6f00 1px solid; PADDING-TOP: 0px; BORDER-BOTTOM: #ff6f00 1px solid; BACKGROUND-COLOR: #dfdfdf
}
#wps_disable {
	BORDER-RIGHT: #ff6f00 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #ff6f00 1px solid; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; BORDER-LEFT: #ff6f00 1px solid; PADDING-TOP: 0px; BORDER-BOTTOM: #ff6f00 1px solid; BACKGROUND-COLOR: #dfdfdf
}
-->
</style>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		var wps_enable = "<% CmoGetCfg("wps_enable","none"); %>";
		if(wps_enable == "1"){
			get_by_id("wps_enable").style.display = "";
			get_by_id("wps_disable").style.display = "none";
		}else{
			get_by_id("wps_enable").style.display = "none";
			get_by_id("wps_disable").style.display = "";
		}
	}
	function send_request(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="user_page.asp";
			return false;
		}else{
		if(!get_by_name("config_method_radio")[0].checked && !get_by_name("config_method_radio")[1].checked){
			alert("Please choose configuration mode!!");
			return false;
		}
		window.location.href = get_checked_value(get_by_name("config_method_radio"));
	}
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="onPageLoad();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
	<tr>
		<td>
		<form id="form1" name="form1" method="post">
		<input type="hidden" name="reboot_type" value="none">
			<table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
				<tr>
				  <td bgcolor="#FFFFFF">    
				  <div align="center">
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
						  <td>
						  <div id="wps_enable" class="box" style="display:none">
							<h1 align="left"><script>show_words(which_lang[LW13])</script>(<script>show_words(which_lang[LW65])</script>)</h1>
							
                      <p>
                        <script>show_words(which_lang[wps_KR37])</script>
                      </p>
							<p>&nbsp;</p>
							
                      <P> <b> 
                        <script>show_words(which_lang[KR50])</script>
                        </b> 
                        <INPUT type="radio" id="config_method_radio" name="config_method_radio" value="do_wps.asp" checked >
                        <LABEL for=config_method_radio_auto><b> </b></LABEL>
                        <script>show_words(which_lang[wps_KR51])</script>
                      </P>
                      <P> <b> 
                        <script>show_words(which_lang[bwn_RM_2])</script>
                        </b> 
                        <INPUT type="radio" id="config_method_radio" name="config_method_radio" value="wizard_add_wlan_device.asp">
                        <LABEL for=config_method_radio_2><b> </b></LABEL>
                        <script>show_words(which_lang[wps_KR42])</script>
                      </P>
							<p>&nbsp;</p>
							
                      <p align="center"> 
                       <input type="button" class="button_submit" id="next_b" name="next_b" value="" onClick="send_request()">
                      <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onClick=window.location.href="wizard_wireless.asp">
                      <script>get_by_id("next_b").value = which_lang[_next];</script>
					  <script>get_by_id("cancel_b").value = which_lang[_cancel];</script>
					  </p>
						  </div>
						  
                    <div id="wps_disable" class="box" style="display:none"> 
                      <h1 align="left">
                        <script>show_words(which_lang[LW13])</script>
                      </h1>
							<p>&nbsp;</p>
							<!--p>The WPS Function is currently set to disable. Please click "Yes" to enable it or "No" to exit the wizard.</p-->
							 <p><script>show_words(which_lang[add_wireless_device])</script> <script>show_words(which_lang[_wifisc_addfail])</script></p>
							<p>&nbsp;</p>
							<p align="center">
								<!--input type="button" class="button_submit" name="yes" id="yes" value="" onClick="window.location.href='wireless.asp'"-->
								<!--input type="button" class="button_submit" name="no" id="no" value="" onClick="window.location.href='wizard_wireless.asp'"-->
								<input type="button" class="button_submit" name="cancel" id="cancel" value="" onClick=window.location.href="wizard_wireless.asp">
								<script>get_by_id("cancel").value = which_lang[_cancel];</script>
							</p>
						  </div>
						  </td>
						</tr>
					</table>
				  </td>
				</tr>
				<tr>
				  <td bgcolor="#FFFFFF">
					  <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
						<tr>
						  <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
						  <td width="10">&nbsp;</td>
						  <td>&nbsp;</td>
						  <td>&nbsp;</td>
						</tr>
					  </table>
				  </td>
				</tr>
			</table>
		</form>
		</td>
	</tr>
</table>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
</body>
</html>
