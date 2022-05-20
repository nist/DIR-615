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
		var pppoe_type = get_by_name("pppoe_type");	
		
		if (get_by_id("asp_temp_11").value == "1"){
			pppoe_type[0].checked = true;
		}else{
			pppoe_type[1].checked = true;
		}
	}
	
	function show_static_ip(){
		var pppoe_type = get_by_name("pppoe_type");				
		get_by_id("ip").disabled = pppoe_type[0].checked;
	}	
				  
	function send_request(){
		var pppoe_type = get_by_name("pppoe_type");
		var ip = get_by_id("ip").value;
		
		if (pppoe_type[1].checked){
			var ip_addr_msg = replace_msg(all_ip_addr_msg,which_lang[_ipaddr]);
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
			
			if (!check_address(temp_ip_obj)){
        		return false;
	    	}
		}
		if(get_by_id("user_name").value == ""){
    		alert(msg[PPP_USERNAME_EMPTY]);
    		return false;
	     }
	     
	      if (get_by_id("pwd1").value == "" || get_by_id("pwd2").value == ""){
		 	//alert("A PPPoE password MUST be specified");	
		 	alert(which_lang[GW_WAN_PPPOE_PASSWORD_INVALID]);
			return false;
		}
		
		if (!check_pwd("pwd1", "pwd2")){
			return false;
        }
        
        if (pppoe_type[1].checked){
        	get_by_id("asp_temp_11").value = "0";
        	get_by_id("asp_temp_15").value = ip;
        }else{
        	get_by_id("asp_temp_11").value = "1";
        }
        
        get_by_id("asp_temp_12").value = get_by_id("user_name").value;
        if(get_by_id("pwd1").value != "WDB8WvbXdH"){
        	get_by_id("asp_temp_13").value = get_by_id("pwd1").value;
        }
        get_by_id("asp_temp_14").value = get_by_id("service").value;
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
.style5 {font-size: 12px}
-->
</style>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
  <tr>
    <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
    <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
    <td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
    <td>&nbsp;</td>
  </tr>
</table>
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>
<tr>
<td></td>
</tr>
<tr>
<td>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF"><div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle"></div>
  </td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box> 
                    <h2 align="left">
                      <script>show_words(which_lang[wwa_title_set_pppoe])</script>
                    </h2>
                    <p class="box_msg">
                      <script>show_words(which_lang[wwa_msg_set_pppoe])</script>
                    </p>
          <div>
            <form id="form1" name="form1" method="post" action="apply.cgi">
            	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan5.asp">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan4c.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="none">
				
            	<input type="hidden" id="asp_temp_11" name="asp_temp_11" value="<% CmoGetCfg("asp_temp_11","none"); %>">
				<input type="hidden" id="asp_temp_12" name="asp_temp_12">
				<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="<% CmoGetCfg("asp_temp_13","none"); %>">
				<input type="hidden" id="asp_temp_14" name="asp_temp_14">				
				<input type="hidden" id="asp_temp_15" name="asp_temp_15">
				<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
              <table class=formarea >
                <tr>
                            <td width="167" align=right class="duple">
                              <script>show_words(which_lang[bwn_AM])</script>
                              &nbsp;:</td>
                  <td width="443">
                	<input name="pppoe_type" type="radio" value="1" onClick="show_static_ip()">
                              <script>show_words(which_lang[Dynamic_PPPoE])</script>
                              &nbsp;&nbsp; 
                              <input name="pppoe_type" type="radio" value="0" onClick="show_static_ip()">
                              <script>show_words(which_lang[static_PPPoE])</script>
                            </td>
                </tr>
                <tr>
                            <td align=right class="duple">
                              <script>show_words(which_lang[_ipaddr])</script>
                              &nbsp;:</td>
                  <td>
                  	<input name="ip" type="text" id="ip" size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_15","none"); %>">
                  </td>
                </tr>
                <tr>
                            <td align=right class="duple">
                              <script>show_words(which_lang[_username])</script>
                              &nbsp;:</td>
                  <td>
                    <input type=text id=user_name name=user_name size="20" maxlength="63" value="<% CmoGetCfg("asp_temp_12","none"); %>">
                  </td>
                </tr>
                <tr>
                            <td align=right class="duple">
                              <script>show_words(which_lang[_password])</script>
                              &nbsp;:</td>
                  <td>
                    <input type=password id=pwd1 name=pwd1 size="20" maxlength="63" value="WDB8WvbXdH">
                  </td>
                </tr>
                <tr>
                            <td align=right class="duple">
                              <script>show_words(which_lang[_verifypw])</script>
                              &nbsp;:</td>
                  <td>
                    <input type=password id=pwd2 name=pwd2 size="20" maxlength="63" value="WDB8WvbXdH">
                  </td>
                </tr>
                <tr>
                            <td align=right class="duple">
                              <script>show_words(which_lang[_srvname])</script>
                              &nbsp;:</td>
                  <td>
                    <input type=text id=service name=service size="20" maxlength="39" value="<% CmoGetCfg("asp_temp_14","none"); %>">
                              <script>show_words(which_lang[_optional])</script>
                            </td>
                </tr>
                <tr>
                            <td colspan="2" class="itemhelp"> 
                              <script>show_words(which_lang[wwa_note_svcn])</script>
                            </td>
                </tr>
                <tr>
                  <td></td>
                  <td>
					<input type="button" class="button_submit" id="wz_prev_b" name="wz_prev_b" value="" onclick=window.location="wizard_wan3.asp"> 
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
      </div></td>
    </tr>
  </table>
  <p>&nbsp;</p></td>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
</body>
<script>
	set_static_ip();
	show_static_ip();
	set_form_default_values("form1");
</script>
</html>
