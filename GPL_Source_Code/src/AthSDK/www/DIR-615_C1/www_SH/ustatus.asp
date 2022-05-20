<html lang=en-US xml:lang="en-US" xmlns="http://www.w3.org/1999/xhtml">
<head><title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<script language="JavaScript">
	function ReplaceAll(strOrg,strFind,strReplace){
		var index = 0;
		while(strOrg.indexOf(strFind,index) != -1){
				strOrg = strOrg.replace(strFind,strReplace);
				index = strOrg.indexOf(strFind,index);
		}
		return strOrg
	}

	function onPageLoad(){
		document.getElementById("html_response_page").value = document.getElementById("html_response_return_page").value;
		var message = ReplaceAll(document.getElementById("html_response_message").value," ","").split(",");
		if(message.length>1){
			var obj_name = message[0].toLowerCase();
			document.getElementById(obj_name +"_1").style.display = "";
			if(obj_name == "success"){
				do_count_down();
			}
		}
	}
	
	function do_count_down(){
		document.getElementById("show_sec").innerHTML = count;
		
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
			window.location.href = document.getElementById("html_response_page").value;
		}
		
	}
</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<style type="text/css">
<!--
.style1 {color: #FF6600}
-->
</style>
<title></title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<div >
<form id="form1" name="form1" method="post">
<input type="hidden" id="html_response_page" name="html_response_page" value="index.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="<% CmoGetCfg("html_response_message","none"); %>">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="<% CmoGetCfg("html_response_return_page","none"); %>">
<input type="hidden" name="reboot_type" value="none">
  <table width="838" height="100" border=0 align="center" cellPadding=0 cellSpacing=0 id=table_shell>
  <tr>
    <td bgcolor="#FFFFFF">
      <div align="center">
        <table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
          <tr>
            <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
            <!--td align="right" nowrap>Hardware Version: C1 &nbsp;</td-->
            <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
			<td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
			<td>&nbsp;</td>
          </tr>
        </table>
        <img src="wlan_masthead.gif" width="836" height="92"></div></td>
    </tr>
  <tr>
    <td>
      <table width="838" border=0 align="center" cellPadding=0 cellSpacing=0 >
        <tr>
          <td bgcolor="#FFFFFF"></td></tr>
        <tr>
          <td bgcolor="#FFFFFF"></td>
        </tr>
        <tr id="success_1" style="display:none">
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>
           <table width="650" border="0" align="center">
            <tr>
              <td height="15"><div id=box_header>
                  <h1>Upload Succeeded</h1>
                  <p>
                  	The router will now be reprogrammed using the uploaded firmware file.
                  	Please wait <span id="show_sec"></span>&nbsp;seconds for this process to complete, after which you may
                  	access these web pages again.  Pressing reload or back on your browser
                  	may cause this operation to fail.
                  </p>
                  <br>
              </div></td>
            </tr>
          </table>
          <p>&nbsp;</p>
          </td>
        </tr>
        <tr id="fail_1" style="display:none">
          <td bgcolor="#FFFFFF"><p>&nbsp;</p>
           <table width="650" border="0" align="center">
            <tr>
              <td height="15"><div id=box_header>
                  <h1>Upload Failed</h1>
                  <p>
                  	The uploaded firmware file may not be correct.
                  	You may have uploaded a file that is not intended for
                  	this device, or the uploaded file may be corrupted.
                  </p>
                  <p>
                  	If the uploaded file is correct, it is possible that
					the device may be too busy to properly receive it right now.
					In this case, please try the upload again. It is also possible that
					you are logged in as a 'user' instead of an 'admin' - only administrators
					can upload new firmware.
                  </p>
                  <p>
                  	The Gateway will not be reprogrammed.
                  </p>
                  <p>
                  	<input type="button" class="button_submit" value="continue" id="Continue" name="Continue" onclick="back();">
                  </p>
                  <br>
              </div></td>
            </tr>
          </table>
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
        </table>     </td>
    </tr>
  </table></form>
  <div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc. </div>
</div>


</BODY>
<script>
	var count = 15;
	var temp_count= "<% CmoGetCfg("countdown_time","none"); %>";
	if(temp_count != ""){
		count = parseInt(temp_count);
	}
	onPageLoad();
</script>
</html>
