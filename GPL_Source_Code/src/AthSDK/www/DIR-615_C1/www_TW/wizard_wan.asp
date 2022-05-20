﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<style type="text/css">
/*
 * Styles used only on this page.
 * WAN mode radio buttons
 */
#wan_modes p {
	margin-bottom: 1px;
}
#wan_modes input {
	float: left;
	margin-right: 1em;
}
#wan_modes label.duple {
	float: none;
	width: auto;
	text-align: left;
}
#wan_modes .itemhelp {
	margin: 0 0 1em 2em;
}

/*
 * Wizard buttons at bottom wizard "page".
 */
#wz_buttons {
	margin-top: 1em;
	border: none;
}
</style>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="Javascript">
var submit_button_flag = 0;
	function send_request(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			//window.location.href ="index.asp";
			window.location.href ="user_page.asp";
			return false;
		}else{
			
			if(submit_button_flag == 0){
				submit_button_flag = 1;
				return true;
			}else{
				return false;
			}
		}
		
		
	}
</script>

<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td bgcolor="#FFFFFF">
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
  <img src="wlan_masthead.gif" width="836" height="92" align="middle"> 
     </div>
   </div></td>
</tr>
</table>
</div></td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  <p>&nbsp;</p>
  <table width="650" border="0" align="center">
    <tr>
      <td>
      	<div class=box> 
              <h2 align="left">
                <script>show_words(which_lang[wwa_title_wel])</script>
              </h2>
              <p class="box_msg">
                <script>show_words(which_lang[wwa_intro_wel])</script>
              </p>
        	<form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan1.asp">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan1.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="none">
				<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="false">
				<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="<% CmoGetCfg("admin_password","none"); %>">
				<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<% CmoGetCfg("time_zone","none"); %>">
				<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<% CmoGetCfg("wan_proto","none"); %>">
				<input type="hidden" id="asp_temp_41" name="asp_temp_41" value="<% CmoGetCfg("time_zone_area","none"); %>">
				
				<!-- dhcp -->
				<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<% CmoGetCfg("wan_mac","none"); %>">
				<input type="hidden" id="asp_temp_04" name="asp_temp_04" value="<% CmoGetCfg("hostname","none"); %>">
												
				<!-- static ip -->
				<input type="hidden" id="asp_temp_05" name="asp_temp_05" value="<% CmoGetCfg("wan_static_ipaddr","none"); %>">
				<input type="hidden" id="asp_temp_06" name="asp_temp_06" value="<% CmoGetCfg("wan_static_netmask","none"); %>">
				<input type="hidden" id="asp_temp_07" name="asp_temp_07" value="<% CmoGetCfg("wan_static_gateway","none"); %>">
				<input type="hidden" id="asp_temp_08" name="asp_temp_08" value="<% CmoGetCfg("wan_specify_dns","none"); %>">
				<input type="hidden" id="asp_temp_09" name="asp_temp_09" value="<% CmoGetCfg("wan_primary_dns","none"); %>">
				<input type="hidden" id="asp_temp_10" name="asp_temp_10" value="<% CmoGetCfg("wan_secondary_dns","none"); %>">
				
				<!-- pppoe -->
				<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="<% CmoGetCfg("wan_pppoe_dynamic_00","none"); %>">
				<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<% CmoGetCfg("wan_pppoe_username_00","none"); %>">
				<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="<% CmoGetCfg("wan_pppoe_password_00","none"); %>">
				<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<% CmoGetCfg("wan_pppoe_service_00","none"); %>">				
				<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<% CmoGetCfg("wan_pppoe_ipaddr_00","none"); %>">
				
				<!-- pptp -->
				<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="<% CmoGetCfg("wan_pptp_dynamic","none"); %>">
				<input type="hidden" id="asp_temp_17" name="asp_temp_17" value="<% CmoGetCfg("wan_pptp_username","none"); %>">
				<input type="hidden" id="asp_temp_18" name="asp_temp_18" value="<% CmoGetCfg("wan_pptp_password","none"); %>">				
				<input type="hidden" id="asp_temp_19" name="asp_temp_19" value="<% CmoGetCfg("wan_pptp_ipaddr","none"); %>">
				<input type="hidden" id="asp_temp_20" name="asp_temp_20" value="<% CmoGetCfg("wan_pptp_netmask","none"); %>">
				<input type="hidden" id="asp_temp_21" name="asp_temp_21" value="<% CmoGetCfg("wan_pptp_gateway","none"); %>">
				<input type="hidden" id="asp_temp_22" name="asp_temp_22" value="<% CmoGetCfg("wan_pptp_server_ip","none"); %>">
				
				<!-- l2tp -->
				<input type="hidden" id="asp_temp_23" name="asp_temp_23" value="<% CmoGetCfg("wan_l2tp_dynamic","none"); %>">
				<input type="hidden" id="asp_temp_24" name="asp_temp_24" value="<% CmoGetCfg("wan_l2tp_username","none"); %>">
				<input type="hidden" id="asp_temp_25" name="asp_temp_25" value="<% CmoGetCfg("wan_l2tp_password","none"); %>">								
				<input type="hidden" id="asp_temp_26" name="asp_temp_26" value="<% CmoGetCfg("wan_l2tp_ipaddr","none"); %>">
				<input type="hidden" id="asp_temp_27" name="asp_temp_27" value="<% CmoGetCfg("wan_l2tp_netmask","none"); %>">
				<input type="hidden" id="asp_temp_28" name="asp_temp_28" value="<% CmoGetCfg("wan_l2tp_gateway","none"); %>">
				<input type="hidden" id="asp_temp_29" name="asp_temp_29" value="<% CmoGetCfg("wan_l2tp_server_ip","none"); %>">
				
				<!-- bigpond -->				
				<input type="hidden" id="asp_temp_30" name="asp_temp_30" value="<% CmoGetCfg("wan_bigpond_username","none"); %>">
				<input type="hidden" id="asp_temp_31" name="asp_temp_31" value="<% CmoGetCfg("wan_bigpond_password","none"); %>">
				<input type="hidden" id="asp_temp_32" name="asp_temp_32" value="<% CmoGetCfg("wan_bigpond_auth","none"); %>">				
				<input type="hidden" id="asp_temp_33" name="asp_temp_33" value="<% CmoGetCfg("wan_bigpond_server","none"); %>">
				
				<!-- static routing -->
				<input type="hidden" id="asp_temp_45" name="asp_temp_45" value="<% CmoGetCfg("static_routing_00","none"); %>">
				<input type="hidden" id="asp_temp_46" name="asp_temp_46" value="<% CmoGetCfg("static_routing_01","none"); %>">
				<input type="hidden" id="asp_temp_47" name="asp_temp_47" value="<% CmoGetCfg("static_routing_02","none"); %>">				
				<input type="hidden" id="asp_temp_48" name="asp_temp_48" value="<% CmoGetCfg("static_routing_03","none"); %>">
				<input type="hidden" id="asp_temp_49" name="asp_temp_49" value="<% CmoGetCfg("static_routing_04","none"); %>">
				
                <table class=formarea>
                    <tr>
                      <td width="334" height="81">
                        <UL>
                        <LI><script>show_words(which_lang[wwa_title_s1])</script>
                        <LI><script>show_words(which_lang[wwa_title_s2])</script>
                        <LI><script>show_words(which_lang[wwa_title_s3])</script>
                        <LI><script>show_words(which_lang[wwa_title_s4])</script>
                        </LI>
                      	</UL>
                      </TD>
                    </tr>
                </table>
                <table align="center" class="formarea">
                  <tr>
                    <td>
                    <fieldset id="wz_buttons">
					<input type="button" class="button_submit" id="wz_prev_b" name="wz_prev_b" value="" disabled>
					<input type="submit" class="button_submit" id="next_b2" name="next_b2" value="" onClick="return send_request();">
					<input type="button" class="button_submit" id="cancel_b2" name="cancel_b2" value="" onClick=window.location.href="index.asp">
					<input type="button" class="button_submit" id="wz_save_b" name="wz_save_b" value="" disabled>
					<script>get_by_id("wz_prev_b").value = which_lang[_prev];</script>
					<script>get_by_id("next_b2").value = which_lang[_next];</script>
					<script>get_by_id("cancel_b2").value = which_lang[_cancel];</script>
					<script>get_by_id("wz_save_b").value = which_lang[_connect];</script>
					  </fieldset>
                    </td>
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
</body>
</html>
