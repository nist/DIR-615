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
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
	function loadSettings(){
		get_by_id("tzone").selectedIndex = get_by_id("asp_temp_41").value;
		set_form_default_values("form1");
	}
	
	function send_request(){
		get_by_id("asp_temp_01").value = get_by_id("tzone").value;
		get_by_id("asp_temp_41").value = get_by_id("tzone").selectedIndex;
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
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>

<tr>
<td>

  <table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
  <td bgcolor="#FFFFFF">    <div align="center">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
        <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="wlan_masthead.gif" width="836" height="92" align="middle">
      <br>
  </div>
    <table width="650" border="0" align="center"><br>
    <tr>
      <td><div class=box>
        <h2 align="left">Step 2: Select your Time Zone</h2>
        <p class="box_msg">Select the appropriate time zone for your location. This information is required to configure the time-based options for the router.</p>
          <form id="form1" name="form1" method="post" action="apply.cgi">
          	<input type="hidden" id="html_response_page" name="html_response_page" value="wizard_wan3.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wizard_wan3.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			
			<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<% CmoGetCfg("asp_temp_01","none"); %>">
			<input type="hidden" id="asp_temp_41" name="asp_temp_41" value="<% CmoGetCfg("asp_temp_41","none"); %>">
			<input type="hidden" id="asp_temp_43" name="asp_temp_43" value="<% CmoGetCfg("asp_temp_43","none"); %>">
            <P align="center">
                <select size=1 id="tzone" name="tzone">
                  <option value="-192">(GMT-12:00) International Date Line West</option>
                  <option value="-176">(GMT-11:00) Midway Island, Samoa</option>
                  <option value="-160">(GMT-10:00) Hawaii</option>
                  <option value="-144">(GMT-09:00) Alaska</option>
                  <option value="-128">(GMT-08:00) Pacific Time (US &amp; Canada); Tijuana</option>
                  <option value="-112">(GMT-07:00) Arizona</option>
                  <option value="-112">(GMT-07:00) Chihuahua, La Paz, Mazatlan</option>
                  <option value="-113">(GMT-07:00) Mountain Time (US &amp; Canada)</option>
                  <option value="-96">(GMT-06:00) Central America</option>
                  <option value="-96">(GMT-06:00) Central Time (US &amp; Canada)</option>
                  <option value="-97">(GMT-06:00) Guadalajara, Mexico City, Monterrey</option>
                  <option value="-97">(GMT-06:00) Saskatchewan</option>                  
                  <option value="-80">(GMT-05:00) Bogota, Lima, Quito</option>
                  <option value="-81">(GMT-05:00) Eastern Time (US &amp; Canada)</option>
                  <option value="-82">(GMT-05:00) Indiana (East)</option>
                  <option value="-64">(GMT-04:00) Atlantic Time (Canada)</option>
                  <option value="-65">(GMT-04:00) Caracas, La Paz</option>
                  <option value="-65">(GMT-04:00) Santiage</option>
                  <option value="-56">(GMT-03:30) Newfoundland</option>
                  <option value="-48">(GMT-03:00) Brasilia</option>
                  <option value="-49">(GMT-03:00) Buenos Aires, Georgetown</option>
                  <option value="-49">(GMT-03:00) Greenland</option>
                  <option value="-32">(GMT-02:00) Mid-Atlantic</option>
                  <option value="-16">(GMT-01:00) Azores</option>
                  <option value="-16">(GMT-01:00) Cape Verde Is.</option>
                  <option value="0">(GMT) Casablanca, Monrovia</option>
                  <option value="1">(GMT) Greenwich Mean Time : Dublin, Edinburgh, Lisbon, London</option>
                  <option value="16">(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna</option>
                  <option value="17">(GMT+01:00) Belgrade, Bratislave, Budapest, Ljubljana, Prague</option>
                  <option value="18">(GMT+01:00) Brussels, Copenhagen, Madrid, Paris</option>
                  <option value="19">(GMT+01:00) Sarajevo, Skopje, Warsaw, Zagreb</option>
                  <option value="20">(GMT+01:00) West Central Africa</option>
                  <option value="32">(GMT+02:00) Athens, Istanbul, Minsk</option>
                  <option value="32">(GMT+02:00) Bucharest</option>
                  <option value="32">(GMT+02:00) Cairo</option>
                  <option value="33">(GMT+02:00) Harare, Pretoria</option>
                  <option value="33">(GMT+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius</option>
                  <option value="33">(GMT+02:00) Jerusalem</option>
                  <option value="48">(GMT+03:00) Baghdad</option>
                  <option value="48">(GMT+03:00) Kuwait, Riyadh</option>
                  <option value="49">(GMT+03:00) Moscow, St.Petersburg, Volgograd</option>
                  <option value="49">(GMT+03:00) Nairobi</option>
                  <option value="56">(GMT+03:30) Tehran</option>
                  <option value="64">(GMT+04:00) Abu Dhabi, Muscat</option>
                  <option value="64">(GMT+04:00) Baku, Tbilist, Yerevan</option>
                  <option value="72">(GMT+04:30) Kabul</option>
                  <option value="90">(GMT+05:00) EKaterinburg</option>
                  <option value="90">(GMT+05:00) Islamabad, Karachi, Tashikent</option>
                  <option value="88">(GMT+05:30) Chennai, Kolkata, Mumbai, New Delhi</option>
                  <option value="92">(GMT+05:45) Kathmandu</option>
                  <option value="96">(GMT+06:00) Almaty, Novosibirsk</option>
                  <option value="96">(GMT+06:00) Astana, Dhaka</option>
                  <option value="96">(GMT+06:00) Sri Jayawardenepura</option>
                  <option value="104">(GMT+06:30) Rangoon</option>
                  <option value="112">(GMT+07:00) Bangkok, Hanoi, Jakarta</option>
                  <option value="112">(GMT+07:00) Krasnoyarsk</option>
                  <option value="128">(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi</option>
                  <option value="128">(GMT+08:00) Irkutsk, Ulaan Bataar</option>
                  <option value="128">(GMT+08:00) Kuala Lumpur, Singapore</option>
                  <option value="128">(GMT+08:00) Perth</option>
                  <option value="128">(GMT+08:00) Taipei</option>
                  <option value="144">(GMT+09:00) Osaka, Sapporo, Tokyo</option>
                  <option value="145">(GMT+09:00) Yakutsk</option>
                  <option value="152">(GMT+09:30) Adelaide</option>
                  <option value="152">(GMT+09:30) Darwin</option>
                  <option value="160">(GMT+10:00) Brishane</option>
                  <option value="160">(GMT+10:00) Canberra, Melbourne, Sydney</option>
                  <option value="160">(GMT+10:00) Guam, Port Moresby</option>
                  <option value="160">(GMT+10:00) Hobart</option>
                  <option value="160">(GMT+10:00) Vladivostok</option>
                  <option value="176">(GMT+11:00) Magadan, Solomon Is., New Caledonia</option>
                  <option value="192">(GMT+12:00) Auckland, Wellington</option>
                  <option value="192">(GMT+12:00) Fiji, Kamchatka, Marshall Is.</option>
                  <option value="208">(GMT+13:00) Nuku'alofa</option>
                </select>
              </p>
          <br>
          <table align="center" class="formarea">
            <tr>
              <td>
                <input type="button" class="button_submit" id="prev_b" name="prev_b" value="Prev" onClick="window.location.href='wizard_wan1.asp'">
                <input type="submit" class="button_submit" id="next_b" name="next_b" value="Next" onClick="return send_request()">
                <input type="button" class="button_submit" id="cancel_b" name="cancel_b" value="Cancel" onclick="wizard_cancel();">
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
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  
  </td>
</tr>
</table>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc. </div>
</body>
<script>
	loadSettings();
</script>
</html>
