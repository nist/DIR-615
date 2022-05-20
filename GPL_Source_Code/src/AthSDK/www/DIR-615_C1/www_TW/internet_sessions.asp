﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript"> 
	var DataArray = new Array();

	function set_session_Data(src_proto, timeout, state, direction, local_ip, local_port, remote_ip, remote_port, public_port, priority, onList) 
	{
		this.Proto = src_proto;
		this.Timeout = timeout;
		this.State = state;
		this.Dir = direction;
		this.Local_IP = local_ip;
		this.Local_port = local_port;
		this.Remote_IP = remote_ip;
		this.Remote_Port = remote_port;
		this.Public_port = public_port;
		this.Priority = priority;
		this.OnList = onList ;
	}
	
	function set_session_table(){
		var index = 0;
		var detail_index = 0;
		var temp_napt_session_table = get_by_id("internet_session_table").value.split(",");
		for (var i = 0; i < temp_napt_session_table.length; i++){	
			var temp_data = temp_napt_session_table[i].split("/");
			if(temp_data.length > 1){
				//DataArray[DataArray.length++] = new set_session_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], temp_data[4], temp_data[5], temp_data[6], temp_data[7], temp_data[8], temp_data[9], detail_index);
				DataArray[DataArray.length++] = new set_session_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], temp_data[4], temp_data[5], temp_data[6], temp_data[7], temp_data[8], detail_index);
				detail_index++;
			}
		}
	}
	
	function session_list(){
		for (var i = 0; i < DataArray.length ; i++){
			document.write("<tr bgcolor=\"#FFFFFF\">");
			document.write("<td>"+ DataArray[i].Local_IP +":"+ DataArray[i].Local_port +"</font></td>");
			document.write("<td>"+ DataArray[i].Public_port +"</font></td>");
			document.write("<td>"+ DataArray[i].Remote_IP +":"+ DataArray[i].Remote_Port +"</font></td>");
			document.write("<td>"+ DataArray[i].Proto +"</font></td>");
			document.write("<td>"+ DataArray[i].State +"</font></td>");
			document.write("<td>"+ DataArray[i].Dir +"</font></td>");
			//document.write("<td>"+ DataArray[i].Priority +"</font></td>");
			document.write("<td>"+ DataArray[i].Timeout +"</font></td>");
			document.write("</tr>");		
		}
	}
	
</script>
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
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
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="st_device.asp"><script>show_words(which_lang[_devinfo])</script></a></div></li>
									<li><div><a href="st_log.asp"><script>show_words(which_lang[_logs])</script></a></div></li>
									<li><div><a href="st_stats.asp"><script>show_words(which_lang[_stats])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[YM157])</script></div></li>
									<li><div><a href="st_wireless.asp"><script>show_words(which_lang[_wireless])</script></a></div></li>
									<!--@ ipv6 <li><div style=" text-transform:none"><a href="st_ipv6.asp">IPv6</a></div></li> @-->
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
                <td>
                 <!-- repeat name="extTab" -->
                </td>
				</table>			
			</td>
			<form id="form1" name="form1" method="post">
			<input type="hidden" id="internet_session_table" name="internet_session_table" value="<% CmoGetList("internet_session_table"); %>">
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1><script>show_words(which_lang[YM157])</script></h1>
						<p><script>show_words(which_lang[sa_intro])</script></p>
					</div>
					<div class="box"> 
						<h2><script>show_words(which_lang[YM157])</script></h2>
							<table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                              <tr id="box_header">
                                <TD><b><script>show_words(which_lang[sa_Local])</script></b></TD>
							    <TD><b><script>show_words(which_lang[sa_NAT])</script></b></TD>
							    <TD><b><script>show_words(which_lang[sa_Internet])</script></b></TD>
							    <TD><b><script>show_words(which_lang[_protocol])</script></b></TD>
							    <TD><b><script>show_words(which_lang[sa_State])</script></b></TD>
							    <TD><b><script>show_words(which_lang[sa_Dir])</script></b></TD>
							    <!--<TD><b>Priority</b></TD>-->
							    <TD><b><script>show_words(which_lang[sa_TimeOut])</script></b></TD>
                              </tr>
                              <script>
                              	set_session_table();
                              	session_list(); 
							  </script>
                            </table>
					</div>
                </div>
             </td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong><script>show_words(which_lang[_hints])</script>&hellip;</strong>
                      	<p><script>show_words(which_lang[hhsa_intro])</script></p>
                      	<p class="more"><a href="support_status.asp#Internet_Sessions"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
