<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link公司 | 无线路由器 | LOGIN</title>
<meta http-equiv=Content-Type content="text/html; charset=utf8">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript">
var submit_button_flag = true;
function encode_base64(psstr) {
   		return encode(psstr,psstr.length); 
}

function encode (psstrs, iLen) {
	 var map1="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
   var oDataLen = (iLen*4+2)/3;
   var oLen = ((iLen+2)/3)*4;
   var out='';
   var ip = 0;
   var op = 0;
   while (ip < iLen) {
      var xx = psstrs.charCodeAt(ip++);
      var yy = ip < iLen ? psstrs.charCodeAt(ip++) : 0;
      var zz = ip < iLen ? psstrs.charCodeAt(ip++) : 0;
      var aa = xx >>> 2;
      var bb = ((xx &   3) << 4) | (yy >>> 4);
      var cc = ((yy & 0xf) << 2) | (zz >>> 6);
      var dd = zz & 0x3F;
      out += map1.charAt(aa);
      op++;
      out += map1.charAt(bb);
      op++;
      out += op < oDataLen ? map1.charAt(cc) : '='; 
      op++;
      out += op < oDataLen ? map1.charAt(dd) : '='; 
      op++; 
   }
   return out; 
}

function check()
{
	var pwd=get_by_id("log_pass").value;
	//if(get_by_id("login_n").value == "")
	//{
	//	//alert("Please input the User Name.");
	//	alert(which_lang[_nousername]);
	//	return false;
	//}
	if(submit_button_flag){
		var auth = "<% CmoGetCfg("graph_auth_enable","none"); %>";
		if ((auth == 1) && (get_by_id("graph_code").value=="")){
				//alert("Please enter the graphical authentication code.");
				alert(which_lang[li_alert_4]);
				return false;
		}
	
	get_by_id("login_name").value=encode_base64(get_by_id("login_n").value);
	get_by_id("login_pass").value=encode_base64(pwd);
	
	get_by_id("login_n").value=get_by_id("login_name").value;   //set admin field value encode too..
	get_by_id("log_pass").value=get_by_id("login_pass").value;   //set password field value encode too..

		var auth = "<% CmoGetCfg("graph_auth_enable","none"); %>";
		if (auth == 1){
		get_by_id("graph_id").value=encode_base64(get_by_id("graph_id").value);
		get_by_id("graph_code").value=encode_base64(get_by_id("graph_code").value);
		}
	
		submit_button_flag = false;
	}
	return true;
}

function chk_KeyValue(e){
	var salt = "<% CmoGetStatus("login_salt"); %>"
	if(browserName == "Netscape") { 
		var pKey=e.which; 
	} 
	if(browserName=="Microsoft Internet Explorer") { 
		var pKey=event.keyCode; 
	} 
	if(pKey==13){
		if(check()){
			send_submit("form1");
		}
	}
}

	function AuthShow(){
//		get_by_id("show_graph").style.display = "none";
//		get_by_id("show_login").style.display = "none";
//		var auth = "<% CmoGetCfg("graph_auth_enable","none"); %>";
//		if (auth == 1){
//			get_by_id("show_graph").style.display = "";
//		}else{
//			get_by_id("show_login").style.display = "";
//		}
		
		var auth = "<% CmoGetCfg("graph_auth_enable","none"); %>";
		if (auth == 1){
			get_by_id("show_graph").style.display = "";
/*			document.write("<tr>");
            document.write("<td><strong>Auth Code&nbsp;:</strong></td>");
            document.write("<td><input type=password name=graph_code id=graph_code size=20 maxlength=15>");
            document.write("<td><img src=\"auth.bmp\"></td>");
           document.write("<td><input type=button name=Refresh value=Refresh onClick=\"window.location.reload( true );\"></td>");
           document.write("</tr>");
*/
		}
		
	}

	function onPageLoad(){
		AuthShow();
	}	
	
var browserName = navigator.appName;
document.onkeyup=chk_KeyValue;
</script>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575" onLoad="document.form1.log_pass.focus();">
<table border=0 cellspacing=0 cellpadding=0 align=center width=30>
<tr>
<td></td>
</tr>
<tr>
<td>
<div align=left>
<table width=836 border=0 cellspacing=0 cellpadding=0 align=center>
<tr>
  <td align="center" valign="baseline" bgcolor="#FFFFFF">
  	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
    <tr>
      <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
      <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
      <td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table></td>
</tr>
<tr>
<td align="center" valign="baseline" bgcolor="#FFFFFF">
<div align=center>
  <table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
    <tr>
      <td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
    </tr>
  </table>
  <br><br>
  <table width="650" border="0">
    <tr>
      <td height="10">
		<div id=box_header>
        <H1 align="left"><script>show_words(which_lang[li_Login])</script></H1>
        <div align="left">
          <script>show_words(which_lang[li_intro])</script><p>
			<form name="form1" id="form1" action="login.cgi" method="post" onSubmit="return check();">
				<input type="hidden" id="html_response_page" name="html_response_page" value="login_fail.asp">
				<input type="hidden" id="login_name" name="login_name">
				<input type="hidden" id="login_pass" name="login_pass">
			    <input type="hidden" id="graph_id" name="graph_id" value="<% CmoGetStatus("graph_auth_id"); %>">				
          <table width="300" border="0" align="center">
            <tr>
              <td width="123"><script>show_words(which_lang[_username])</script>&nbsp;:</strong></td>
              <td width="224">
              	<select id="login_n" name="login_n">
					<option value="admin"><script>show_words(which_lang[_admin])</script></option>
					<option value="user"><script>show_words(which_lang[_user])</script></option>
				</select>
              </td>
            </tr>
            <tr>
              <td><strong><script>show_words(which_lang[_password])</script>&nbsp;:</strong></td>
              <td><input type="password" name="log_pass" id="log_pass" size="20" maxlength="15">
              </td>
            </tr>
            	</table>
            	
			<table width="300" border="0" align="center" id="show_graph" style="display:none">
              <tr>
                <td height="60" colspan="2"><strong><script>show_words(which_lang[_authword])</script></strong>
				<span> <input type=password name=graph_code id=graph_code size=20 maxlength=15></span></td>
                <td width="48">&nbsp;</td>
              </tr>
              <tr>
                <td width="33"><img src="auth.bmp">
				<div align="left">                  </div></td>
                <td width="262"><input type=button name=Refresh value="" onClick="window.location.reload( true );" style="width:100 ">
                <script>get_by_id("Refresh").value = which_lang[regenerate];</script></td>
                <td>&nbsp;</td>
              </tr>
	        </table>		
		
			<table width="300" border="0" align="center">
             
              <tr>
                <td width="10"><div align="center">                    
                </div></td>
              <td width="284" align="center"><input type="submit" name="login" id="login" value="" style="width:170 ">
              				   <script>get_by_id("login").value = which_lang[li_Log_In];</script></td>
                <td width="49"><div align="center">                    
                </div></td>
              </tr>
            </table>
          </form>            	
        </div>
      </div></td>
      </tr>
  </table>
  <p>&nbsp;</p>
  </div></td>
</tr>
</table>
</div>
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
<script>
onPageLoad();
</script>    
<br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
</body>
</html>
