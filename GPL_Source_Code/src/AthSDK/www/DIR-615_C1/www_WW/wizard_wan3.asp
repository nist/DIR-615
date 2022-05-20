<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
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
<script language="Javascript" src="public.js"></script>
<script language="Javascript">
var submit_button_flag = 0;
	function loadSettings(){
		set_checked(get_by_id("select_isp").value, get_by_name("wan_type"));
		set_form_default_values("form1");
	}
	
	function select_wan_type(){
		set_checked(get_by_id("select_isp").value, get_by_name("wan_type"));
	}
	
	function send_request(){
		get_by_id("asp_temp_02").value = get_checked_value(get_by_name("wan_type"));
		
		if (get_by_id("asp_temp_02").value == "static"){
			get_by_id("html_response_page").value = "wizard_wan4b.asp";			
		}else if (get_by_id("asp_temp_02").value == "pppoe"){
			get_by_id("html_response_page").value = "wizard_wan4c.asp";
		}else if (get_by_id("asp_temp_02").value == "pptp"){
			get_by_id("html_response_page").value = "wizard_wan4d.asp";
		}else if (get_by_id("asp_temp_02").value == "l2tp"){
			get_by_id("html_response_page").value = "wizard_wan4e.asp";
		}else if (get_by_id("asp_temp_02").value == "bigpond"){
			get_by_id("html_response_page").value = "wizard_wan4f.asp";
		}
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
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="loadSettings();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=838 border=0 cellspacing=0 cellpadding=0 align=center height=92>
<tr height="92">
<td bgcolor="#FFFFFF">
  <div align="center">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
        <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="wlan_masthead.gif" width="836" height="92" align="middle"></div></td>
</tr>
<tr>
  <td bgcolor="#FFFFFF"><p>&nbsp;</p>
    <table width="650" border="0" align="center">
    <tr>
      <td><div class=box>
          <h2>Step 3: Configure your Internet Connection</h2>
          <div>
            <p class="box_msg">Your Internet Connection could not be detected, please select your Internet Service Provider (ISP) from the list below. If your ISP is not listed; select the "Not Listed or Don't Know" option to manually configure your connection.</p>
              <select id="select_isp" name="select_isp" onChange="select_wan_type()">
                <option value="dhcpc">Not Listed or Don't Know</option>
                <option value="dhcpc">Adelphia Power Link</option>
                <option value="static">ALLTEL DSL</option>
                <option value="static">ATAT DSL Service</option>
                <option value="static">Bell Sympatico</option>
                <option value="static">Bellsouth</option>
                <option value="dhcpc">Charter High-Speed</option>
                <option value="dhcpc">Comcast</option>
                <option value="static">Covad</option>
                <option value="dhcpc">Cox Communications</option>
                <option value="dhcpc">Earthlink Cable</option>
                <option value="static">Earthlink DSL</option>
                <option value="static">FrontierNet</option>
                <option value="dhcpc">Optimum Online</option>
                <option value="dhcpc">RCN</option>
                <option value="dhcpc">Road Runner</option>
                <option value="dhcpc">Rogers Yahoo!</option>
                <option value="static">SBC Yahoo! DSL</option>
                <option value="dhcpc">Shaw</option>
                <option value="static">Speakeasy</option>
                <option value="static">Sprint FastConnect</option>
                <option value="static">Telus</option>
                <option value="dhcpc">Time Warner Cable</option>
                <option value="static">US West / Qwest</option>
                <option value="static">Verizon Online DSL</option>
                <option value="static">XO Communications</option>
              </select>
          </div>
                  <div>
                    <P align="left" class=box_msg>If your Internet Service Provider was not listed or you don't know who it is, please select the Internet connection type below:</P>
                    <form id="form1" name="form1" method="post" action="apply.cgi">
		            <input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan4a.asp">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan4a.asp">
					<input type="hidden" name="reboot_type" value="none">
					
					<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
					<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<% CmoGetCfg("asp_temp_02","none"); %>">
                    <table class=formarea >
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="dhcpc">
                              <STRONG>DHCP Connection (Dynamic IP Address)</STRONG>
                              <div class=itemhelp>Choose this if your Internet connection automatically provides you with an IP Address. Most Cable Modems use this type of connection.</div></td>
                        </tr>
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="pppoe">
                              <STRONG>Username / Password Connection (PPPoE)</STRONG>
                              <div class=itemhelp>Choose this option if your Internet connection requires a username and password to get online. Most DSL modems use this connection type of connection.</div></td>
                        </tr>
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="pptp">
                              <STRONG>Username / Password Connection (PPTP)</STRONG>
                              <div class=itemhelp>Choose this option if your Internet connection requires a username and password to get online. Most DSL modems use this connection type of connection. </div></td>
                        </tr>
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="l2tp">
                              <STRONG>Username / Password Connection (L2TP)</STRONG>
                              <div class=itemhelp>Choose this option if your Internet connection requires a username and password to get online. Most DSL modems use this connection type of connection. </div></td>
                        </tr>
                        <!--tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="bigpond">
                              <STRONG>Username / Password Connection (Bigpond)</STRONG>
                              <div class=itemhelp>Choose this option if your Internet connection requires a username and password to get online. Most DSL modems use this connection type of connection. </div></td>
                        </tr-->
                        <tr>
                          <td class=form_label>&nbsp;</td>
                          <td><input name="wan_type" type="radio" value="static">
                              <STRONG>Static IP Address Connection</STRONG>
                              <div class=itemhelp>Choose this option if your INTERNET Provider provided you with IP Address information that has to be manually configured.</div></td>
                        </tr>
                    </table>
                    <br>
                    <table align="center" class="formarea">
                      <tr>
                        <td>
                          <input type="button" class="button_submit" id="prev_b" name="prev_b" value="Prev" onclick="window.location.href='wizard_wan2.asp'">
                          <input type="submit" class="button_submit" id="next_b" name="next_b" value="Next" onClick="return send_request()">
                          <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="Cancel" onclick="wizard_cancel();">
                          <input type="button" class="button_submit" id="wz_save_b" name="wz_save_b" value="Connect" disabled>
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
</div>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc. </div>
</body>
</html>
