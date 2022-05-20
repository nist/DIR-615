
<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link公司 | 无线路由器 | 主页</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="Javascript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language=JavaScript>
function check_ip(){
		if (get_by_id("ping_ipaddr").value == ""){
			//alert(msg[PING_IP_ERROR]);
			alert(which_lang[tsc_pingt_msg2]);
			return false;
		}else{
			return true;
			//send_submit("form5");
		}
	}
function check_ipv6_ip(){
		if (get_by_id("ping6_ipaddr").value == ""){
			//alert(msg[PING_IP_ERROR]);
			alert(which_lang[tsc_pingt_msg2]);
			return false;
		}else{
			return true;
			//send_submit("form5");
		}
	} 
	
</script>
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
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(which_lang[_support])</script></a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_admin])</script></a></div></li>
									<li><div><a href="tools_time.asp" onclick="return jump_if();"><script>show_words(which_lang[_time])</script></a></div></li>
									<li><div><a href="tools_syslog.asp" onclick="return jump_if();"><script>show_words(which_lang[_syslog])</script></a></div></li>
									<li><div><a href="tools_email.asp" onclick="return jump_if();"><script>show_words(which_lang[_email])</script></a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();"><script>show_words(which_lang[_system])</script></a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();"><script>show_words(which_lang[_firmware])</script></a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();"><script>show_words(which_lang[_dyndns])</script></a></div></li>
								  	<li><div id="sidenavoff"><script>show_words(which_lang[_syscheck])</script></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();"><script>show_words(which_lang[_scheds])</script></a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">			  <div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  
        <div id="box_header"> 
          <h1>
            <script>show_words(which_lang[tsc_pingt])</script>
          </h1>
						
          <p>
            <script>show_words(which_lang[tsc_pingt_mesg])</script>
          </p>
				  </div>
				  
        <div class=box> 
          <h2>
            <script>show_words(which_lang[tsc_pingt])</script>
          </h2>
                    <!--P>Ping Test is used to send &quot;Ping&quot; packets to test if a computer is on the Internet.</P-->
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                      
                        <form id="form5" name="form5" method="post" action="ping_response.cgi">
						<input type="hidden" id="html_response_page" name="html_response_page" value="tools_vct.asp">
	   					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_vct.asp">
                          <tr>
                            <td>
                              <div align="right"><strong>
                    <script>show_words(which_lang[tsc_pingt_h])</script>
                    &nbsp;:&nbsp;</strong></div></td>
                            <td height="20" valign="top">&nbsp;
							 <input type="text" id="ping_ipaddr" name="ping_ipaddr" size=30 maxlength=63 value="<% CmoGetStatus("ping_ipaddr"); %>" >
                  <script>document.write('<input name="ping" id="ping" type="submit" value="'+which_lang[_ping]+'" onClick="return check_ip()">')</script></td>
                          </tr> </form>                      
                    </table>
						
				  </div>
<@ ipv6 <div class=box> @>
<@ ipv6             <h2 style=" text-transform:none">IPv6 <script>show_words(which_lang[tsc_pingt])</script></h2> @>
<@ ipv6             <table cellSpacing=1 cellPadding=1 width=525 border=0> @>
<@ ipv6             <form id="form6" name="form6" method="post" action="ping6_response.cgi"> @>
<@ ipv6             <input type="hidden" id="html_response_page" name="html_response_page" value="tools_vct.asp"> @>
<@ ipv6 	    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="tools_vct.asp"> @>
<@ ipv6                 <tr><td> <div align="right" style=" text-transform:none"><strong><script>show_words(which_lang[TEXT075])</script>&nbsp;:&nbsp;</strong></div></td> @>
<@ ipv6                     <td height="20" valign="top">&nbsp;<input type="text" id="ping6_ipaddr" name="ping6_ipaddr" size=30 maxlength=63 value="" ><input type="submit" name="ping2" id="ping2" value="" onClick="return check_ipv6_ip()"><script>get_by_id("ping2").value = which_lang[_ping];</script></td> @>
<@ ipv6                 </tr> @>
<@ ipv6             </form> @>                   
<@ ipv6             </table> @>
<@ ipv6 </div> @>
        <div class=box> 
          <h2>
            <script>show_words(which_lang[tsc_pingr])</script>
          </h2>
                    
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                      <tr>
                            <td><div align="center">
                              <% CmoGetStatus("ping_result"); %>
                              <% CmoGetStatus("ping6_test_result"); %>
                              <!-- repeat name=msg --></div></td>
                          </tr>
                            <td height="20" valign="top">&nbsp;</td>
                          </tr>                    
                    </table>
						
			  </div>
					<!-- === END MAINCONTENT === -->
                </div></td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  
          <td id=help_text><strong> 
            <script>show_words(which_lang[_hints])</script>
            &hellip;</strong> <p> 
              <script>show_words(which_lang[hhtsc_pingt_intro])</script>
              <br>
              <script>show_words(which_lang[htsc_pingt_h])</script>
            </p>
					    <p class="more"><a href="support_tools.asp#System_Check" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
					  </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
</html>