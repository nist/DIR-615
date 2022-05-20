﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link 회사 | 무선 라우터 | 홈</title>
<script type="text/javascript" src="ko.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	function send_request(){
    	var ip = get_by_id("ip").value;
    	var mask = get_by_id("mask").value;
    	var gateway = get_by_id("gateway").value;
    	var dns1 = get_by_id("dns1").value;
        var dns2 = get_by_id("dns2").value;       
        
		var ip_addr_msg = replace_msg(all_ip_addr_msg,which_lang[_ipaddr]);
		var gateway_msg = replace_msg(all_ip_addr_msg,which_lang[wwa_gw]);
		var dns1_addr_msg = replace_msg(all_ip_addr_msg,which_lang[wwa_pdns]);
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,which_lang[wwa_sdns]);
        
        var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
		var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
		var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
                
        if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
        	return false;
        }	     
                
		if (!check_address(temp_dns1_obj)){
			return false;
		}
    	
    	if (dns2 != "" && dns2 != "0.0.0.0"){
    		if (!check_address(temp_dns2_obj)){
    			return false;
    		}
    	}
    	 
    	get_by_id("asp_temp_05").value = ip;  
    	get_by_id("asp_temp_06").value = mask;
    	get_by_id("asp_temp_07").value = gateway;
    	get_by_id("asp_temp_08").value = "1";
    	get_by_id("asp_temp_09").value = dns1;
    	get_by_id("asp_temp_10").value = dns2;
        
		if(get_by_id("asp_temp_43").value == "false"){
			get_by_id("asp_temp_43").value = is_form_modified("form1");
		}
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		} 
    }
    function wizard_cancel(){
		if (get_by_id("asp_temp_43").value == "true" || is_form_modified("form1")){
			//if(!confirm("Do you want to abandon all changes you made to this wizard?")) {
			if(!confirm(which_lang[_wizquit])) {
				return false;
			}
		}
		window.location.href="index.asp";
	}
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style1 {
	font-size: 11px;
	font-weight: bold;
}
.style3 {font-size: 11px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table width=838 height="100" border=0 align=center cellpadding=0 cellspacing=0>
<tr>
<td>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=92>
<tr>
<td bgcolor="#FFFFFF"><div align="center">
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
      <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
      <td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
      <td>&nbsp;</td>
    </tr>
  </table>  <img src="wlan_masthead.gif" width="836" height="92" align="middle"></td>
</tr>
</table>
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  <p>&nbsp;</p>
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box> 
              <h2 align="left">
                <script>show_words(which_lang[wwa_set_sipa_title])</script>
              </h2>
              <div align="left"> 
                <p class="box_msg">
                  <script>show_words(which_lang[wwa_set_sipa_msg])</script>
                </p>
            <div>
              <form id="form1" name="form1" method="post" action="apply.cgi">
              	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan5.asp">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan4b.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="none">
				
				<input type="hidden" id="asp_temp_05" name="asp_temp_05">
				<input type="hidden" id="asp_temp_06" name="asp_temp_06">
				<input type="hidden" id="asp_temp_07" name="asp_temp_07">
				<input type="hidden" id="asp_temp_08" name="asp_temp_08">
				<input type="hidden" id="asp_temp_09" name="asp_temp_09">
				<input type="hidden" id="asp_temp_10" name="asp_temp_10">
				<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
                <table width="536" align="center" class=formarea>
                  <tr>
                        <td width="235" align=right class="duple">
                          <script>show_words(which_lang[_ipaddr])</script>
                          &nbsp;:</td>
                    <td width="468">
                      <input type=text id=ip name=ip size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_05","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[_subnet])</script>
                          &nbsp;:</td>
                    <td>
                		<input type=text id=mask name=mask size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_06","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple"> 
                          <script>show_words(which_lang[wwa_gw])</script>
                          &nbsp;:</td>
                    <td>
                		<input type=text id=gateway name=gateway size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_07","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[wwa_pdns])</script>
                          &nbsp;:</td>
                    <td>
                		<input type=text id=dns1 name=dns1 size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_09","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[wwa_sdns])</script>
                          &nbsp;:</td>
                    <td>
                		<input type=text id=dns2 name=dns2 size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_10","none"); %>">
                    </td>
                  </tr>
                  <tr>
                    <td></td>
              		<td>  <input type="button" class="button_submit" id="wz_prev_b" name="wz_prev_b" value="" onclick=window.location="wizard_wan3.asp"> 
                          <input type="submit" class="button_submit" id="next_b" name="next_b" value="" onClick="return send_request();"> 
                          <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="" onclick="wizard_cancel();"> 
                          <input type="button" class="button_submit" id="wz_save_b" name="wz_save_b" value="" disabled> 
							<script>get_by_id("wz_prev_b").value = which_lang[_prev];</script>
							<script>get_by_id("next_b").value = which_lang[_next];</script>
							<script>get_by_id("cancel_b").value = which_lang[_cancel];</script>
							<script>get_by_id("wz_save_b").value = which_lang[_connect];</script>
						
						</td>
                  </tr>
                </table>
              </form>
            </div>
          </div>
      </div></td>
    </tr>
  </table>
  
 <br><br>
 
  <table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="836" align="center">
    <tr>
      <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
      <td width="10">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div align=right></div></td>
</tr>
</table>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
</body>
<script>
	set_form_default_values("form1");
</script>
</html>
