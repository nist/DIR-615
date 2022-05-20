<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<script type="text/javascript" src="ko.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-Link 회사 | 무선 라우터 | 홈</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
</head>
<script language="JavaScript">
var submit_button_flag = 0;
function do_reboot(is_true){
	if(is_true && get_by_id("asp_temp_51").value.length > 0){
		get_by_id("form1").action = "reboot.cgi";
		get_by_id("html_response_page").value = "reboot.asp";
		get_by_id("reboot_type").value = get_by_id("asp_temp_51").value;
		get_by_id("asp_temp_51").value = "";
		send_submit("form1");
	}else{
		window.location.href = get_by_id("html_response_return_page").value;
	}
}
</script>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();">DIR-615</a></td>
        <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
		<td>&nbsp;</td>
      </tr>
    </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(which_lang[_support])</script></a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<li><div id="sidenavoff"><script>show_words(which_lang[sa_Internet])</script></div></li>
									<li><div id="sidenavon"><a href="wizard_wireless.asp"><script>show_words(which_lang[_wirelesst])</script></a></div></li>
									<li><div id="sidenavon"><a href="lan.asp"><script>show_words(which_lang[bln_title])</script></a></div></li>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				 
                  <div id=box_header>
                    <h1><script>show_words(which_lang[YM1])</script>
          </h1>
                  	<p><script>show_words(which_lang[YM2])</script>
          </p>
                  	<form id="form1" name="form1" method="post" action="apply.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
						<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
						<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<% CmoGetCfg("asp_temp_51","none"); %>">
						<input type="hidden" id="reboot_type" name="reboot_type" value="none">
						
           <input name="button" id="button" type="button" class=button_submit value="" onClick="do_reboot(true);">
           <input name="button2" id="button2" type=button class=button_submit value="" onclick="do_reboot(false);">
           <script>get_by_id("button").value = which_lang[YM3];</script>
		   <script>get_by_id("button2").value = which_lang[YM4];</script>
		  
		  </form>
                  </div>     
			  </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(which_lang[_hints])</script>&hellip;</strong>
                          <p><script>show_words(which_lang[LW33])</script>
            </p>
                          <p><script>show_words(which_lang[LW34])</script>
            </p>
                          <p class="more"><a href="support_internet.asp#Internet"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
                      </td>
                    </tr>
			  </table></td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			
    <td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright">Copyright &copy; 2004-2007 D-LINK CORPORATION, INC.</div>
<br>
</body>
</html>