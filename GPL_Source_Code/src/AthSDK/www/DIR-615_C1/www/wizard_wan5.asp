<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	function send_request(){		
		if("<% CmoGetCfg("admin_password","none"); %>" !="<% CmoGetCfg("asp_temp_00","none"); %>"){
			get_by_id("html_response_page").value = "login.asp";
			get_by_id("html_response_return_page").value = "login.asp";
		}
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}
	function wizard_cancel(){
		if (get_by_id("asp_temp_43").value == "true" && confirm("Do you want to abandon all changes you made to this wizard?")) {
			window.location.href="index.asp";
		}
	}
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">

<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td>
<div align=left>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF">
<div align=center>
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
  <tr>
    <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
    <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
	<td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
	<td>&nbsp;</td>
  </tr>
</table>
<div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle"></div>
</td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF"><p>&nbsp;</p><table width="650" border="0" align="center">
  <tr>
    <td><div class=box>
      <h2 align="left">Setup Complete!</h2>
      <div align="left">
        <div>
          <P align="left" class=box_msg>The Setup Wizard has completed. Click the Connect button to save your settings and restart the router.</P>
          <form id="form1" name="form1" method="post" action="apply.cgi">
          		<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="index.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="all">
				
          		<input type="hidden" id="admin_password" name="admin_password" value="<% CmoGetCfg("asp_temp_00","none"); %>">
				<input type="hidden" id="time_zone" name="time_zone" value="<% CmoGetCfg("asp_temp_01","none"); %>">
				<input type="hidden" id="wan_proto" name="wan_proto" value="<% CmoGetCfg("asp_temp_02","none"); %>">
				<input type="hidden" id="time_zone_area" name="time_zone_area" value="<% CmoGetCfg("asp_temp_41","none"); %>">
				<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
				
				<script>
					var wan_type = get_by_id("wan_proto").value;
					var static_routing_rule = false;
					if (wan_type == "dhcpc"){ // dhcp
						document.write("<input type=\"hidden\" id=\"wan_mac\" name=\"wan_mac\" value=\"<% CmoGetCfg("asp_temp_03","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"hostname\" name=\"hostname\" value=\"<% CmoGetCfg("asp_temp_04","none"); %>\">");
					}else if (wan_type == "static"){ //static ip 
						document.write("<input type=\"hidden\" id=\"wan_static_ipaddr\" name=\"wan_static_ipaddr\" value=\"<% CmoGetCfg("asp_temp_05","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_static_netmask\" name=\"wan_static_netmask\" value=\"<% CmoGetCfg("asp_temp_06","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_static_gateway\" name=\"wan_static_gateway\" value=\"<% CmoGetCfg("asp_temp_07","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_specify_dns\" name=\"wan_specify_dns\" value=\"<% CmoGetCfg("asp_temp_08","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_primary_dns\" name=\"wan_primary_dns\" value=\"<% CmoGetCfg("asp_temp_09","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_secondary_dns\" name=\"wan_secondary_dns\" value=\"<% CmoGetCfg("asp_temp_10","none"); %>\">");
						
					}else if (wan_type == "pppoe"){ //pppoe
						document.write("<input type=\"hidden\" id=\"wan_pppoe_dynamic_00\" name=\"wan_pppoe_dynamic_00\" value=\"<% CmoGetCfg("asp_temp_11","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pppoe_username_00\" name=\"wan_pppoe_username_00\" value=\"<% CmoGetCfg("asp_temp_12","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pppoe_password_00\" name=\"wan_pppoe_password_00\" value=\"<% CmoGetCfg("asp_temp_13","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pppoe_service_00\" name=\"wan_pppoe_service_00\" value=\"<% CmoGetCfg("asp_temp_14","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pppoe_ipaddr_00\" name=\"wan_pppoe_ipaddr_00\" value=\"<% CmoGetCfg("asp_temp_15","none"); %>\">");
						static_routing_rule = true;
					}else if (wan_type == "pptp"){	//pptp
						document.write("<input type=\"hidden\" id=\"wan_pptp_dynamic\" name=\"wan_pptp_dynamic\" value=\"<% CmoGetCfg("asp_temp_16","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pptp_username\" name=\"wan_pptp_username\" value=\"<% CmoGetCfg("asp_temp_17","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pptp_password\" name=\"wan_pptp_password\" value=\"<% CmoGetCfg("asp_temp_18","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pptp_ipaddr\" name=\"wan_pptp_ipaddr\" value=\"<% CmoGetCfg("asp_temp_19","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pptp_netmask\" name=\"wan_pptp_netmask\" value=\"<% CmoGetCfg("asp_temp_20","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pptp_gateway\" name=\"wan_pptp_gateway\" value=\"<% CmoGetCfg("asp_temp_21","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_pptp_server_ip\" name=\"wan_pptp_server_ip\" value=\"<% CmoGetCfg("asp_temp_22","none"); %>\">");
						static_routing_rule = true;
					}else if (wan_type == "l2tp"){	//l2tp
						document.write("<input type=\"hidden\" id=\"wan_l2tp_dynamic\" name=\"wan_l2tp_dynamic\" value=\"<% CmoGetCfg("asp_temp_23","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_l2tp_username\" name=\"wan_l2tp_username\" value=\"<% CmoGetCfg("asp_temp_24","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_l2tp_password\" name=\"wan_l2tp_password\" value=\"<% CmoGetCfg("asp_temp_25","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_l2tp_ipaddr\" name=\"wan_l2tp_ipaddr\" value=\"<% CmoGetCfg("asp_temp_26","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_l2tp_netmask\" name=\"wan_l2tp_netmask\" value=\"<% CmoGetCfg("asp_temp_27","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_l2tp_gateway\" name=\"wan_l2tp_gateway\" value=\"<% CmoGetCfg("asp_temp_28","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_l2tp_server_ip\" name=\"wan_l2tp_server_ip\" value=\"<% CmoGetCfg("asp_temp_29","none"); %>\">");
					}else if (wan_type == "bigpond"){	// bigpond
						document.write("<input type=\"hidden\" id=\"wan_bigpond_username\" name=\"wan_bigpond_username\" value=\"<% CmoGetCfg("asp_temp_30","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_bigpond_password\" name=\"wan_bigpond_password\" value=\"<% CmoGetCfg("asp_temp_31","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_bigpond_auth\" name=\"wan_bigpond_auth\" value=\"<% CmoGetCfg("asp_temp_32","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"wan_bigpond_server\" name=\"wan_bigpond_server\" value=\"<% CmoGetCfg("asp_temp_33","none"); %>\">");
					}
					if(static_routing_rule){
						document.write("<input type=\"hidden\" id=\"static_routing_00\" name=\"static_routing_00\" value=\"<% CmoGetCfg("asp_temp_45","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"static_routing_01\" name=\"static_routing_01\" value=\"<% CmoGetCfg("asp_temp_46","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"static_routing_02\" name=\"static_routing_02\" value=\"<% CmoGetCfg("asp_temp_47","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"static_routing_03\" name=\"static_routing_03\" value=\"<% CmoGetCfg("asp_temp_48","none"); %>\">");
						document.write("<input type=\"hidden\" id=\"static_routing_04\" name=\"static_routing_04\" value=\"<% CmoGetCfg("asp_temp_49","none"); %>\">");
					}		
				</script>
            <table align="center" class=formarea >
                <tr>
                  <td></td>
                  <td><input type="button" class="button_submit" id="prev_b" name="prev_b" value="Prev" onclick="window.location.href='<% CmoGetCfg("html_response_return_page","none"); %>';">
                      <input type="submit" class="button_submit" id="next_b" name="next_b" value="Next" disabled>
                      <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="Cancel" onclick="wizard_cancel();">
                      <input type="submit" class="button_submit" id="wz_save_b" name="wz_save_b" value="Connect" onClick="return send_request()">
                  </td>
                </tr>
            </table>
            <div align="center"></div>
          </form>
        </div>
      </div>
    </div></td>
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
