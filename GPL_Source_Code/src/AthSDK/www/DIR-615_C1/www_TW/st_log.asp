﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
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
		//if (!is_form_modified("form8") && !confirm("Nothing has changed, save anyway?")) {
		if (!is_form_modified("form8") && !confirm(which_lang[_ask_nochange])) {
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
			//alert("Email address is not configured.");
			alert(which_lang[YM169]);
		}else{
			var add = "<% CmoGetCfg("log_email_recipien","none"); %>";
			//alert("The log will be sent to email address " + add);
			alert("這個紀錄檔已寄出至電子郵件地址 " + add);	//sl_alert_2
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
			<td id="topnavoff"><a href="index.asp"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavon"><a href="st_device.asp"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp"><script>show_words(which_lang[_support])</script></a></td>
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
									<li><div><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_devinfo])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[_logs])</script></div></li>
									<li><div><a href="st_stats.asp" onclick="return jump_if();"><script>show_words(which_lang[_stats])</script></a></div></li>
									<li><div><a href="internet_sessions.asp" onclick="return jump_if();"><script>show_words(which_lang[YM157])</script></a></div></li>
									<li><div><a href="st_wireless.asp" onclick="return jump_if();"><script>show_words(which_lang[_wireless])</script></a></div></li>
                                     <!--@ ipv6 <li><div style=" text-transform:none"><a href="st_ipv6.asp">IPv6</a></div></li>	@-->								    		
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
						<h1><script>show_words(which_lang[_logs])</script></h1>
						<p><script>show_words(which_lang[sl_intro])</script></p>
			  		</div>
					<form id="form8" name="form8" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value="">
					<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp">
					<div class="box">
                    <h2><script>show_words(which_lang[sl_LogOps])</script></h2>
					<table cellpadding="1" cellspacing="1" border="0" width="525">
						<tr>
							<td class="duple"><script>show_words(which_lang[sl_LogOps])</script> :</td>
							<td width="340">
							<input type="hidden" id="log_system_activity" name="log_system_activity" value="<% CmoGetCfg("log_system_activity","none"); %>">
							<input type=checkbox id=type1 name=type1 value="1"><script>show_words(which_lang[TEXT019])</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_debug_information" name="log_debug_information" value="<% CmoGetCfg("log_debug_information","none"); %>">
							<input type=checkbox id=type2 name=type2 value="1"><script>show_words(which_lang[TEXT020])</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_attacks" name="log_attacks" value="<% CmoGetCfg("log_attacks","none"); %>">
							<input type=checkbox id=type3 name=type3 value="1"><script>show_words(which_lang[TEXT021])</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_dropped_packets" name="log_dropped_packets" value="<% CmoGetCfg("log_dropped_packets","none"); %>">
							<input type=checkbox id=type4 name=type4 value="1"><script>show_words(which_lang[TEXT022])</script>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td width="340">
							<input type="hidden" id="log_notice" name="log_notice" value="<% CmoGetCfg("log_notice","none"); %>">
							<input type=checkbox id=type5 name=type5 value="1"><script>show_words(which_lang[TEXT023])</script>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
							<input name="button3" id="button3" type="button" class=button_submit value="" onClick="send_request()">
							<script>get_by_id("button3").value = which_lang[sl_ApplySt];</script>
							</td>
						</tr>
					</table>
					</div>
					</form>
					<div class="box">
                    <h2><script>show_words(which_lang[sl_LogDet])</script></h2>
					<form id="form1" name="form1" method="post" action="apply.cgi">
					<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
					<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
					<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
					<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp">

					<input type="hidden" name="total_log" id="total_log" value="<% CmoGetLog(); %>">
					<input type=hidden id="current_page" name="current_page" value="<% CmoGetStatus("log_current_page"); %>">
					<input type=hidden id="total_page" name="total_page" value="<% CmoGetStatus("log_total_page"); %>">
                    <table cellpadding="1" cellspacing="1" border="0" width="525">
                      <tr>
                        <td><div align="center">
                          	<input id="Fp1" name="Fp1" type="button" class=button_submit value="" onclick="to_first_page()">
                			<input id="Lp1" name="Lp1" type="button" class=button_submit value="" onclick="to_last_page()">
							<input id="Pp1" name="Pp1" type="button" class=button_submit value="" onclick="to_pre_page()">
							<input id="Np1" name="Np1" type="button" class=button_submit value="" onclick="to_next_page()">
							<script>get_by_id("Fp1").value = which_lang[TEXT016];</script>
							<script>get_by_id("Lp1").value = which_lang[TEXT017];</script>
							<script>get_by_id("Pp1").value = which_lang[TEXT018];</script>
							<script>get_by_id("Np1").value = which_lang[TEXT074];</script>
						
						</div>
						</td>
                      </tr>
                      <tr>
                        <td><div align="center">
							<input id="refresh" name="refresh" type="button" class=button_submit value="" onClick='window.location.href="st_log.asp"'>
			                <input id="clear" name="clear" type="button" class=button_submit value="" onclick="clear_log()">
                			<input id="email" name="email" type="button" class=button_submit value="" onclick="email_now()">
							<input id="backup" name="backup" type="button" class=button_submit value="" onclick="save_log_fun()">
							<script>get_by_id("refresh").value = which_lang[sl_reload];</script>
							<script>get_by_id("clear").value = which_lang[_clear];</script>
							<script>get_by_id("email").value = which_lang[sl_emailLog];</script>
							<script>get_by_id("backup").value = which_lang[sl_saveLog];</script>
						
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
                          <td width="120"><script>show_words(which_lang[_time])</script></td>
                          <td ><script>show_words(which_lang[KR110])</script></td>
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
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = which_lang[_success];</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp">
				</form>
				<form id="form9" name="form9" method="post" action="send_log_email.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_log.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log.asp"></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                  <tr>
                    <td id="help_text">
                      <strong><script>show_words(which_lang[_hints])</script>&hellip;</strong>
                      <p><script>show_words(which_lang[hhsl_intro])</script></p>
					  <p><script>show_words(which_lang[hhsl_lmail])</script></a></p>
					  <p><a href="support_status.asp#Logs" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
<script>
var curr_page = <% CmoGetStatus("log_current_page"); %>;
var last_page = <% CmoGetStatus("log_total_page"); %>;
start_button();
onPageLoad();
</script>
</body>
</html>
