﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link 회사 | 무선 라우터 | 홈</title>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="ko.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function do_count_down(){
		get_by_id("show_sec").innerHTML = count;
		
		if (count == 0) {	       
	        back();
	        return false;
	    }

		if (count > 0) {
	        count--;
	        setTimeout('do_count_down()',1000);
	    }
	
	}

	function back(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="index.asp";
		}else{
			window.location.href = get_by_id("html_response_page").value;
		}
		
	}
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<table border=0 cellspacing=0 cellpadding=0 align=center width=838>

<tr>
<td>
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="wps_back_result.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<% CmoGetCfg("html_response_message","none"); %>">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
<input type="hidden" name="reboot_type" value="none">
  <table width=836 border=0 cellspacing=0 cellpadding=0 align=center height=100>
<tr>
  <td bgcolor="#FFFFFF">    <div align="center">
    <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
        <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
		<td>&nbsp;</td>
      </tr>
    </table>
    <img src="wlan_masthead.gif" width="836" height="92" align="middle">
      <br>
  </div>
    <table width="650" border="0" align="center"><br>
    <tr>
      <td width="50%"><div id=box_header>
        <h1 align="left"><!--Virtual Push Button--><script>show_words(which_lang[LW13])</script></h1>
        <p>&nbsp;</p>
                      <p align="center">
                        <script>show_words(which_lang[wps_messgae1_2])</script>
                        <font color="#FF0000"><span id="show_sec"></span></font>&nbsp;<script>show_words(which_lang[_seconds])</script> 
                        &hellip;</p>
  		<p>&nbsp;</p>
      </div>
      </td>
    </tr>
  </table>
  <iframe src="wps_autodetect.asp" style="display:none">
  <script>
if(wps_status == "1"){
		window.location.href = "wireless.asp";
}

</script>
 </iframe>
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
</form>
</td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
  
  </td>
</tr>
</table>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc. </div>
</body>
<script>
	var count = 120;
	do_count_down();
</script>
</html>
