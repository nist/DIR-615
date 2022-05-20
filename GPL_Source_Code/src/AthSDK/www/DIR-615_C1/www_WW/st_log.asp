<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		set_checked(get_by_id("log_system_activity").value, get_by_id("type1"));
		set_checked(get_by_id("log_debug_information").value, get_by_id("type2"));
		set_checked(get_by_id("log_attacks").value, get_by_id("type3"));
		set_checked(get_by_id("log_dropped_packets").value, get_by_id("type4"));
		set_checked(get_by_id("log_notice").value, get_by_id("type5"));
		set_form_default_values("form8");
	}
	
	function send_request(){
		if (!is_form_modified("form8") && !confirm("Nothing has changed, save anyway?")) {
			return false;
		}
		var log_res_type ="";
		var type1 = get_by_id("type1");	
		if (type1.checked==true){						
				get_by_id("log_system_activity").value = "1";
				log_res_type = "system";
		}else{		
				get_by_id("log_system_activity").value = "0";
		}
		
		var type2 = get_by_id("type2");	
		if (type2.checked==true){						
				get_by_id("log_debug_information").value = "1";
				log_res_type = log_res_type +"| debug" ;
		}else{		
				get_by_id("log_debug_information").value = "0";
		}
		
		var type3 = get_by_id("type3");	
		if (type3.checked==true){						
				get_by_id("log_attacks").value = "1";
				log_res_type = log_res_type +"| attack";
		}else{		
				get_by_id("log_attacks").value = "0";
		}
		
		var type4 = get_by_id("type4");	
		if (type4.checked==true){						
				get_by_id("log_dropped_packets").value = "1";
				log_res_type = log_res_type +"| dropped";
		}else{		
				get_by_id("log_dropped_packets").value = "0";
		}
		
		var type5 = get_by_id("type5");	
		if (type5.checked==true){						
				get_by_id("log_notice").value = "1";
				log_res_type = log_res_type +"| notice";
		}else{		
				get_by_id("log_notice").value = "0";
		}
		send_submit("form8");
	}
	
	
	function switch_page(which_page){	
		if (which_page >= 0 && which_page <= last_page){
			get_by_id("current_page").value = which_page;
			send_submit("form1");
		}
	}

	function start_button(){
		get_by_id("Pp1").disabled = true;
		get_by_id("Np1").disabled = true;
		get_by_id("Fp1").disabled = true;
		get_by_id("Lp1").disabled = true;
		
		setTimeout('disable_button()',1000);
	}

	function disable_button(){
		get_by_id("Pp1").disabled = false;
		get_by_id("Np1").disabled = false;
		get_by_id("Fp1").disabled = false;
		get_by_id("Lp1").disabled = false;
		
		if (curr_page == "1"){
			get_by_id("Pp1").disabled = true;
		}
		
		if (curr_page == last_page){
			get_by_id("Np1").disabled = true;
		}
	}

	function to_first_page(){
		send_submit("form2");
	}

	function to_last_page(){
		send_submit("form3");
	}
	
	function to_next_page(){
		send_submit("form4");
	}
	
	function to_pre_page(){
		send_submit("form5");
	}

	function clear_log(){
		send_submit("form6");
	}
	
	function save_log_fun(){
		send_submit("form7");
	}

	function email_now(){
		if("<% CmoGetCfg("log_email_enable","none"); %>" == 0){
			alert("Email address is not configured.");
		}else{
			var add = "<% CmoGetCfg("log_email_recipien","none"); %>";
			alert("The log will be sent to email address " + add)
			send_submit("form9");
		}
	}
</script>

<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
#wrap {word-break:break-all;width:450px;}
-->
</style>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
        <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
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
			<td id="topnavoff"><a href="index.asp">SETUP</a></td>
			<td id="topnavoff"><a href="adv_virtual.asp">ADVANCED</a></td>
			<td id="topnavoff"><a href="tools_admin.asp">TOOLS</a></td>
			<td id="topnavon"><a href="st_device.asp">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp">SUPPORT</a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="st_device.asp" onclick="return jump_if();">Device Info</a></div></li>
									<li><div id="sidenavoff">Logs</div></li>
									<li><div><a href="st_stats.asp" onclick="return jump_if();">Statistics</a></div></li>
									<li><div><a href="internet_sessions.asp" onclick="return jump_if();">Internet Sessions</a></div></li>
									<li><div><a href="st_routing.asp">Routing</a></div></li>
									<li><div><a href="st_wireless.asp" onclick="return jump_if();">Wireless</a></div></li>
									<li><div style=" text-transform:none"><a href="st_ipv6.asp">IPv6</a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
                  </tbody>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">			  
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1>Logs</h1>
						<p>Use this option to view the router logs. You can define what types of events you want to view and the event levels to view. This router also has internal syslog server support so you can send the log files to a computer on your network that is running a syslog utility.</p>
			  		</div>
					<form id="form8" name="form8" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp">
					<div class="box">
                    <h2>Log Options</h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
						<tr>
							<td class="duple">Log Type :</td>
							<td width="340">
							<input type="hidden" id="log_system_activity" name="log_system_activity" value="<% CmoGetCfg("log_system_activity","none"); %>">
							<input type=checkbox id=type1 name=type1 value="1">System Activity
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_debug_information" name="log_debug_information" value="<% CmoGetCfg("log_debug_information","none"); %>">
							<input type=checkbox id=type2 name=type2 value="1">Debug Information
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_attacks" name="log_attacks" value="<% CmoGetCfg("log_attacks","none"); %>">
							<input type=checkbox id=type3 name=type3 value="1">Attacks
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_dropped_packets" name="log_dropped_packets" value="<% CmoGetCfg("log_dropped_packets","none"); %>">
							<input type=checkbox id=type4 name=type4 value="1">Dropped Packets
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_notice" name="log_notice" value="<% CmoGetCfg("log_notice","none"); %>">
							<input type=checkbox id=type5 name=type5 value="1">Notice
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
							<input name="button3" type="button" class=button_submit value="Apply Log Settings Now" onClick="send_request()">
							</td>
						</tr>
					</table>
					</div>
					</form>
					<div class="box">
                    <h2>Log Details</h2>
					<form id="form1" name="form1" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp">

					<input type="hidden" name="total_log" id="total_log" value="<% CmoGetLog(); %>">
					<input type=hidden id="current_page" name="current_page" value="<% CmoGetStatus("log_current_page"); %>">
					<input type=hidden id="total_page" name="total_page" value="<% CmoGetStatus("log_total_page"); %>">
                    <table cellpadding="1" cellspacing="1" border="0" width="525">
                      <tr>
                        <td><div align="center">
                           <input type=button class=button_submit  value="First Page" id="Fp1" name="Fp1" onClick="to_first_page()">
							<input type=button class=button_submit  value="Last Page" id="Lp1" name="Lp1" onClick="to_last_page()">
							<input type=button class=button_submit  value="Previous" id="Pp1" name="Pp1" onClick="to_pre_page()">
							<input type=button class=button_submit  value="Next" id="Np1" name="Np1" onClick="to_next_page()">
						</div>
						</td>
                      </tr>
                      <tr>
                        <td><div align="center">
							<input type=button class=button_submit value="Refresh" name=refresh id=refresh onClick="window.location.href='st_log.asp'">
							<input type=button class=button_submit  value="Clear" name=clear id=clear onClick="clear_log()">
	                    	<input type="button" class=button_submit name="email" value="Email Now" onClick="email_now()">
	                    	<input type="button" class=button_submit name="backup" value="Save Log" onClick="save_log_fun()">
						</div>
						</td>
                      </tr>
                      <tr> 
                  		<td><font face="Tahoma" size="2"><% CmoGetStatus("log_current_page"); %>
                  		/<% CmoGetStatus("log_total_page"); %><!-- insert name="pageNum" --></font></td>
                	  </tr>
                    </table>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td width="120">Time</td>
                          <td >Message</td>
                        </tr>
                        <script>
							var temp_entry = get_by_id("total_log").value.split("|syslog|");
							for (var i = 0; i < temp_entry.length; i++){
								var entry = temp_entry[i].split("|");
								if(entry.length > 1){
									document.write("<tr><td width=\"120\">" + entry[0] + "</td><td><div id=\"wrap\">" + entry[2] + "</div></td></tr>");
								}
							}
						</script>
                      </tbody>
                    </table>
					</form>
					</div>
					<!-- === END MAINCONTENT === -->
              <p>&nbsp;</p>
			</div>
			</td>
				<form id="form2" name="form2" method="post" action="log_first_page.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form3" name="form3" method="post" action="log_last_page.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form4" name="form4" method="post" action="log_next_page.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form5" name="form5" method="post" action="log_previous_page.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form6" name="form6" method="post" action="log_clear_page.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
				<form id="form7" name="form7" method=POST action="save_log.cgi" enctype=multipart/form-data>
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="Success.">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp">
				</form>
				<form id="form9" name="form9" method="post" action="send_log_email.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                  <tr>
                    <td id="help_text">
                      <strong>Helpful Hints&hellip;</strong>
                      <p>Check the log frequently to detect unauthorized network usage.</p>
					  <p>You can also have the log mailed to you periodically. Refer to <a href="tools_email.asp" onclick="return jump_if();">Tools &rarr; EMail.</a></p>
					  <p><a href="support_status.asp#Logs" onclick="return jump_if();">More&hellip;</a></p>
                    </td>
                  </tr>
                </table></td>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
<script>
var curr_page = <% CmoGetStatus("log_current_page"); %>;
var last_page = <% CmoGetStatus("log_total_page"); %>;
start_button();
onPageLoad();
</script>
</body>
</html>
