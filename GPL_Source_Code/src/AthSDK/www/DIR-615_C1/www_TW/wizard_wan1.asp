<html>
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
<script language="JavaScript" src="public_msg.js"></script>
<script language="Javascript">
	var submit_button_flag = 0;
	function send_request(){
		if (get_by_id("pwd1").value != get_by_id("pwd2").value){
			//alert(msg[MATCH_WIZARD_PWD_ERROR]);
			alert(which_lang[_pwsame]);
			return false;
		}
		
		get_by_id("asp_temp_00").value = get_by_id("pwd1").value;
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
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>

<tr>
<td bgcolor="#C0C0C0">
<div align=left>
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
<div align="center"><img src="wlan_masthead.gif" width="836" height="92" align="middle">
</div></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>
    <table width="650" border="0" align="center">
    <tr>
      <td><div class=box> 
                      <h2 align="left">
                        <script>show_words(which_lang[wwa_title_s1])</script>
                      </h2>
                      <p class="box_msg">
                        <script>show_words(which_lang[wwa_intro_s1])</script>
                      </p>
            <form id="form1" name="form1" method="post" action="apply.cgi">
            <input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan2.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan2.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			
			<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
			
			<input type="hidden" id="asp_temp_00" name="asp_temp_00">
                <table class=formarea>
                    <tr>
                            <td align=right class="duple">
                              <script>show_words(which_lang[_password])</script>
                              :</td>
                      <td>&nbsp;
                        <input type="password" id=pwd1 name=pwd1 size=20 maxlength=15 value="<% CmoGetCfg("asp_temp_00","none"); %>">
                      </td>
                    </tr>
                    <tr>
                            <td align=right class="duple">
                              <script>show_words(which_lang[_verifypw])</script> :</td>
                      <td>&nbsp;
                        <input type="password" id=pwd2 name=pwd2 size=20 maxlength=15 value="<% CmoGetCfg("asp_temp_00","none"); %>">
                      </td>
                    </tr>
                </table>
                <br>
                <table align="center" class="formarea">
                  <tr>
                    <td>
                      <input type="button" class="button_submit" id="wz_prev_b" name="wz_prev_b" value="" onclick=window.location="wizard_wan.asp"> 
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
      </div></td>
    </tr>
  </table>
    <p>&nbsp;</p></td>
</tr>
</table>
</div></td>
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
  </table>  </td>
</tr>
</table><br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
</body>
<script>
	set_form_default_values("form1");
</script>
</html>
