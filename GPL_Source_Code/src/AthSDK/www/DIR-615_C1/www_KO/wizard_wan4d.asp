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
	function set_static_ip(){
		var pptp_type = get_by_name("pptp_type");	
		
		if (get_by_id("asp_temp_16").value == "1"){
			pptp_type[0].checked = true;
		}else{
			pptp_type[1].checked = true;
		}
	}
	
	function show_static_ip(){
		var pptp_type = get_by_name("pptp_type");
		
		get_by_id("ip").disabled = pptp_type[0].checked;
		get_by_id("mask").disabled = pptp_type[0].checked;
		get_by_id("gateway").disabled = pptp_type[0].checked;
	}
	
	function send_request(){
		var pptp_type = get_by_name("pptp_type");
    	var ip = get_by_id("ip").value;
    	var mask = get_by_id("mask").value;  
    	var gateway = get_by_id("gateway").value;
		var server_ip = get_by_id("server_ip").value;
		
		var ip_addr_msg = replace_msg(all_ip_addr_msg,which_lang[_ipaddr]);
		var gateway_msg = replace_msg(all_ip_addr_msg,which_lang[wwa_gw]);
		
		var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
                
		if (pptp_type[1].checked){    	      
        	if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
        		return false;
        	}
        }
    	
    	if(server_ip == ""){
    		//alert(msg[ZERO_SERVER_IP]);
    		alert(which_lang[YM108]);
    		return false;
       	}
       	if(get_by_id("pptpuserid").value == ""){
       		alert(msg[PPP_USERNAME_EMPTY]);
    		return false;
	     }
       	if (get_by_id("pptppwd").value == "" || get_by_id("pptppwd2").value == ""){
		 	//alert("A PPTP password MUST be specified");	//GW_WAN_PPTP_PASSWORD_INVALID
		 	alert(which_lang[GW_WAN_PPTP_PASSWORD_INVALID]);
			return false;
		}
       	if (!check_pwd("pptppwd", "pptppwd2")){
       		return false;
       	}
       	
       	if (pptp_type[1].checked){
       		get_by_id("asp_temp_16").value = "0";
       		get_by_id("asp_temp_19").value = ip;
       		get_by_id("asp_temp_20").value = mask;
       		get_by_id("asp_temp_21").value = gateway;
       	}else{
       		get_by_id("asp_temp_16").value = "1";
       	}
       	
       	get_by_id("asp_temp_17").value = get_by_id("pptpuserid").value;
       	if(get_by_id("pptppwd").value!="WDB8WvbXdH"){
       		get_by_id("asp_temp_18").value = get_by_id("pptppwd").value;
       	}
       	get_by_id("asp_temp_22").value = get_by_id("server_ip").value;
        
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
.style4 {font-size: 10px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>
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
 
  <div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle"></div>
  </td>
</tr>
</table>
</div>
</td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>    <table width="650" border="0" align="center">
    <tr>
      <td><div class=box> 
              <h2 align="left">
                <script>show_words(which_lang[wwa_title_set_pptp])</script>
              </h2>
              <div align="left"> 
                <p class="box_msg">
                  <script>show_words(which_lang[wwa_msg_set_pptp])</script>
                </p>
          <form id="form1" name="form1" method="post" action="apply.cgi">
         	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan5.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan4d.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="asp_temp_16" name="asp_temp_16" value="<% CmoGetCfg("asp_temp_16","none"); %>">
			<input type="hidden" id="asp_temp_17" name="asp_temp_17">
			<input type="hidden" id="asp_temp_18" name="asp_temp_18" value="<% CmoGetCfg("asp_temp_18","none"); %>">				
			<input type="hidden" id="asp_temp_19" name="asp_temp_19">
			<input type="hidden" id="asp_temp_20" name="asp_temp_20">
			<input type="hidden" id="asp_temp_21" name="asp_temp_21">
			<input type="hidden" id="asp_temp_22" name="asp_temp_22">
			<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
            <div>
                <table width="525" align="center" class=formarea >
                  <tr>
                        <td width="220" align=right class="duple">
                          <script>show_words(which_lang[bwn_AM])</script>
                          &nbsp;:</td>
                    <td width="304">
		                <input name="pptp_type" type="radio" value="1" onClick="show_static_ip()">
                          <script>show_words(which_lang[carriertype_ct_0])</script>
                          &nbsp; 
                          <input name="pptp_type" type="radio" value="0" onClick="show_static_ip()">
                          <script>show_words(which_lang[_sdi_staticip])</script>
                        </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[_PPTPip])</script>
                          &nbsp;:</td>
                    <td>
                      <input type=text id=ip name=ip size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_19","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[_PPTPsubnet])</script>
                          &nbsp;:</td>
                    <td>
                      <input type=text id=mask name=mask size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_20","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[_PPTPgw])</script>
                          &nbsp;:</td>
                    <td>
                      <input type=text id=gateway name=gateway size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_21","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[wwa_pptp_svraddr])</script>
                          &nbsp;:</td>
                    <td>
                      <input type=text id=server_ip name=server_ip size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_22","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[_username])</script>
                          &nbsp;:</td>
                    <td>
                      <input type=text id=pptpuserid name=pptpuserid size="20" maxlength="63" value="<% CmoGetCfg("asp_temp_17","none"); %>">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[_password])</script>
                          &nbsp;:</td>
                    <td>
                      <input type=password id=pptppwd name=pptppwd size="20" maxlength="63" value="WDB8WvbXdH">
                    </td>
                  </tr>
                  <tr>
                        <td align=right class="duple">
                          <script>show_words(which_lang[_verifypw])</script>
                          &nbsp;:</td>
                    <td>
                      <input type=password id=pptppwd2 name=pptppwd2 size="20" maxlength="63" value="WDB8WvbXdH">
                    </td>
                  </tr>
                  <tr>
                    <td></td>
              		<td><input type="button" class="button_submit" id="wz_prev_b" name="wz_prev_b" value="" onclick=window.location="wizard_wan3.asp"> 
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
            </div>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
</body>
<script>
	set_static_ip();
	show_static_ip();
	set_form_default_values("form1");
</script>
</html>
