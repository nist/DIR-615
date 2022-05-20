<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
	function set_static_ip(){
		var l2tp_type = get_by_name("l2tp_type");	
		
		if (get_by_id("asp_temp_23").value == "1"){
			l2tp_type[0].checked = true;
		}else{
			l2tp_type[1].checked = true;
		}
	}
	
	function show_static_ip(){
		var l2tp_type = get_by_name("l2tp_type");
		
		get_by_id("ip").disabled = l2tp_type[0].checked;
		get_by_id("mask").disabled = l2tp_type[0].checked;
		get_by_id("gateway").disabled = l2tp_type[0].checked;
	}
	
	function send_request(){
		var l2tp_type = get_by_name("l2tp_type");
    	var ip = get_by_id("ip").value;
    	var mask = get_by_id("mask").value;  
    	var gateway = get_by_id("gateway").value;    	
		var server_ip = get_by_id("server_ip").value;
    	
    	var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var gateway_msg = replace_msg(all_ip_addr_msg,"Gateway address");
    	
    	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
		var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
		var temp_gateway_obj = new addr_obj(gateway.split("."), gateway_msg, false, false);
    	
    	if (l2tp_type[1].checked){        
	        if (!check_lan_setting(temp_ip_obj, temp_mask_obj, temp_gateway_obj)){
	    		return false;
	    	}
       	}
       	
    	if(server_ip == ""){
    		alert(msg[ZERO_SERVER_IP]);
    		return false;
       	}
       	if(get_by_id("l2tpuserid").value == ""){
    		alert(msg[PPP_USERNAME_EMPTY]);
    		return false;
	     }
	     
	      if (get_by_id("l2tppwd").value == "" || get_by_id("l2tppwd2").value == ""){
		 	alert("A L2TP password MUST be specified");	//GW_WAN_L2TP_PASSWORD_INVALID
			return false;
		}
       	
       	if (!check_pwd("l2tppwd", "l2tppwd2")){
       		return false;
       	}
       	
       	if (l2tp_type[1].checked){
       		get_by_id("asp_temp_23").value = "0";
       		get_by_id("asp_temp_26").value = ip;
       		get_by_id("asp_temp_27").value = mask;
       		get_by_id("asp_temp_28").value = gateway;
       	}else{
       		get_by_id("asp_temp_23").value = "1";
       	}
       	
       	get_by_id("asp_temp_24").value = get_by_id("l2tpuserid").value;
       	if(get_by_id("l2tppwd").value!="WDB8WvbXdH"){
       		get_by_id("asp_temp_25").value = get_by_id("l2tppwd").value;
       	}
       	get_by_id("asp_temp_29").value = get_by_id("server_ip").value;
       	       
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
			if(!confirm("Do you want to abandon all changes you made to this wizard?")) {
				return false;
			}
		}
		window.location.href="index.asp";
	}
</script>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
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
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=75% border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
<td bgcolor="#FFFFFF"><div align=center>
  <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
      <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
      <td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
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
      <td><div class=box>
        <h2 align="left">Set Username and Password Connection (L2TP)</h2>
        <div align="left">
          <p class="box_msg">To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need L2TP IP adress. If you do not have this information, please contact your ISP.</p>
          <div>
            <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan5.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan4e.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="asp_temp_23" name="asp_temp_23" value="<% CmoGetCfg("asp_temp_23","none"); %>">
			<input type="hidden" id="asp_temp_24" name="asp_temp_24">
			<input type="hidden" id="asp_temp_25" name="asp_temp_25" value="<% CmoGetCfg("asp_temp_25","none"); %>">								
			<input type="hidden" id="asp_temp_26" name="asp_temp_26">
			<input type="hidden" id="asp_temp_27" name="asp_temp_27">
			<input type="hidden" id="asp_temp_28" name="asp_temp_28">
			<input type="hidden" id="asp_temp_29" name="asp_temp_29">
			<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
              <table width="536" align="center" class=formarea>
                <tr>
                  <td width="235" align=right class="duple">Address Mode&nbsp;:</td>
                  <td width="468">
                    <input name="l2tp_type" type="radio" value="1" onClick="show_static_ip()">
              		Dynamic IP&nbsp;&nbsp;
              		<input name="l2tp_type" type="radio" value="0" onClick="show_static_ip()">
              		Static IP
              	  </td>
                </tr>
                <tr>
                  <td align=right class="duple"><strong>L2TP IP Address&nbsp;:</td>
                  <td>
                    <input type=text id=ip name=ip size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_26","none"); %>">
                  </td>
                </tr>
                <tr>
                  <td align=right class="duple">L2TP Subnet Mask&nbsp;:</td>
                  <td>
                    <input type=text id=mask name=mask size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_27","none"); %>">
                  </td>
                </tr>
                <tr>
                  <td align=right class="duple">L2TP Gateway IP Address&nbsp;:</td>
                  <td>
                    <input type=text id=gateway name=gateway size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_28","none"); %>">
                  </td>
                </tr>
                <tr>
                  <td align=right class="duple">L2TP Server IP Address <br>(may be same as gateway)&nbsp;:</td>
                  <td>
                    <input type=text id=server_ip name=server_ip size="20" maxlength="15" value="<% CmoGetCfg("asp_temp_29","none"); %>">
                  </td>
                </tr>
                <tr>
                  <td align=right class="duple">User Name&nbsp;:</td>
                  <td>
                    <input type=text id=l2tpuserid name=l2tpuserid size="20" maxlength="63" value="<% CmoGetCfg("asp_temp_24","none"); %>">
                  </td>
                </tr>
                <tr>
                  <td align=right class="duple">Password&nbsp;:</td>
                  <td>
                    <input type=password id=l2tppwd name=l2tppwd size="20" maxlength="63" value="WDB8WvbXdH">
                  </td>
                </tr>
                <tr>
                  <td align=right class="duple">Verify Password&nbsp;:</td>
                  <td>
                    <input type=password id=l2tppwd2 name=l2tppwd2 size="20" maxlength="63" value="WDB8WvbXdH">
                  </td>
                </tr>
                <tr>
                  <td></td>
                  <td><input type="button" class="button_submit" id="prev" name="prev" value="Prev" onclick="window.location.href='wizard_wan3.asp'">
                  	  <input type="submit" class="button_submit" id="next" name="next" value="Next" onClick="return send_request()">
                      <input type="button" class="button_submit" id="cancel" name="cancel" value="Cancel" onclick="wizard_cancel();">
                      <input type="button" class="button_submit" id="wz_save_b" name="wz_save_b" value="Connect" disabled>
                  </td>
                </tr>
              </table>
            </form>
          </div>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc. </div>
</body>
<script>
	set_static_ip();
	show_static_ip();
	set_form_default_values("form1");
</script>
</html>
