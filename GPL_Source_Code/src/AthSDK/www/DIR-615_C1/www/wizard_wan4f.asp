<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	
	function send_request(){		
		if (!check_pwd("bigpond_pwd", "bigpond_pwd2")){
       		return false;
       	}
      
      	get_by_id("asp_temp_30").value = get_by_id("bigpond_userid").value;
      	if(get_by_id("bigpond_pwd").value != "WDB8WvbXdH"){
      		get_by_id("asp_temp_31").value = get_by_id("bigpond_pwd").value;
      	}
      	get_by_id("asp_temp_33").value = get_by_id("srv_name").value;
      	      	
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
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table width=838 height="100" border=0 align=center cellpadding=0 cellspacing=0>
<tr>
<td>
<div align=left>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=100>
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
<td bgcolor="#FFFFFF">
    </td>
</tr>
<tr><br>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>
  <table width="650" border="0" align="center">
    <tr>
      <td><div class=box>
        <h2 align="left">Set Username and Password Connection (BigPond)</h2>
          <p class="box_msg">To set up this connection you will need to have a Username and Password from your Internet Service Provider. You also need BigPond IP adress. If you do not have this information, please contact your ISP.</p>
          <form id="form1" name="form1" method="post" action="apply.cgi">
          	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan5.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan4f.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="asp_temp_30" name="asp_temp_30">
			<input type="hidden" id="asp_temp_31" name="asp_temp_31" value="<% CmoGetCfg("asp_temp_31","none"); %>">
			<input type="hidden" id="asp_temp_32" name="asp_temp_32" value="<% CmoGetCfg("wan_bigpond_auth","none"); %>">				
			<input type="hidden" id="asp_temp_33" name="asp_temp_33">
			<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
            <table width="536" align="center" class=formarea >
              <tr>
                <td width="181" align=right class="duple">Bigpond User Name&nbsp;:</td>
                <td width="339">
                  <input name=bigpond_userid type=text id=bigpond_userid size=32 maxlength=63 value="<% CmoGetCfg("asp_temp_30","none"); %>">
                </td>
              </tr>
              <tr>
                <td align=right class="duple">Bigpond Password&nbsp;:</td>
                <td>
                  <input type=password id=bigpond_pwd name=bigpond_pwd size=32 maxlength=31 value="WDB8WvbXdH">
                </td>
              </tr>
              <tr>
                <td align=right class="duple">Bigpond Verify Password&nbsp;:</td>
                <td>
                  <input type=password id=bigpond_pwd2 name=bigpond_pwd2 size=32 maxlength=31 value="WDB8WvbXdH">
                </td>
              </tr>
              <tr>
                <td align=right class="duple">Bigpond Server IP Address:</td>
                <td>
                  <input type=text id=srv_name name=srv_name size=32 maxlength=15 value="<% CmoGetCfg("asp_temp_33","none"); %>">
                </td>
              </tr>
              <tr>
                <td></td>
                <td><input type="button" class="button_submit" id="prev" name="prev" value="Prev" onclick="window.location.href='wizard_wan3.asp'">
                	<input type="submit" class="button_submit" id="prev" name="prev" value="Next" onClick="return send_request()">
                    <input type="button" class="button_submit" id="cancel" name="cancel" value="Cancel" onclick="wizard_cancel();">
                    <input type="button" class="button_submit" id="wz_save_b" name="wz_save_b" value="Connect" disabled>
                </td>
              </tr>
            </table>
          </form>
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
	set_form_default_values("form1");
</script>
</html>
