﻿<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		if(get_by_id("asp_temp_12").value == "yes"){
			get_by_name("log")[1].checked = true;
		}else{
			get_by_name("log")[0].checked = true;
		}
	}
	
	function save_info(){
		if(get_by_name("log")[0].checked){
			get_by_id("asp_temp_12").value = "no";
		}else{
			get_by_id("asp_temp_12").value = "yes";
		}
	}

	function  send_previous(){
		save_info();
		get_by_id("html_response_page").value = get_by_id("asp_temp_15").value;
		get_by_id("html_response_return_page").value = get_by_id("asp_temp_15").value;
		return true;
	}

	function send_next(){
		save_info();
		return true;
	}
		
</script>
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
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
			<td height="29"><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(which_lang[_support])</script></a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table cellSpacing=0 cellPadding=0 border=0>
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <LI><div><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_virtserv])</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(which_lang[_pf])</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(which_lang[_specappsr])</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(which_lang[YM48])</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(which_lang[_acccon])</script></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script></a></div></LI>
						</UL>
                      	</div>
					  </td>
                    </tr>
                  </tbody>
                </table>
			</td>
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_save.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_save.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">

			<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<% CmoGetCfg("asp_temp_12","none"); %>">	<!-- logging -->
			<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<% CmoGetCfg("asp_temp_15","none"); %>">	<!-- prev_page -->
			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            
          <div class=box> 
            <h2>
              <script>show_words(which_lang[_aa_wiz_s8_title])</script>
            </h2>
				<table width="670" class=formarea>
				  <tbody>
					  <tr>
						
                  <td class="duple">
                    <script>show_words(which_lang[_aa_logging])</script>
                    :</td>
						<td width="485">&nbsp;
							<input type="radio" id="log" name="log" checked>
                    <script>show_words(which_lang[_disabled])</script>
                  </td>
					  </tr>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						<td width="485">&nbsp;
							<input type="radio" id="log" name="log">
                    <script>show_words(which_lang[_enabled])</script>
                  </td>
					  </tr>
				  </tbody>
				</table><hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
					<input name="prev" type="submit" id="prev" value="" onClick="return send_previous();">
                    &nbsp; 
                    <input name="next" type="submit" id="next" value="" disabled>
                    &nbsp; 
                   <input name="save" type="submit" id="save" value="" onClick="return send_next();">
                    &nbsp; 
                    <input name="cancel" type="button" id="cancel" value="" onClick="exit_access();">
                 	<script>get_by_id("prev").value = which_lang[_prev];</script>
          			<script>get_by_id("next").value = which_lang[_next];</script>
					<script>get_by_id("save").value = which_lang[_save];</script>
          			<script>get_by_id("cancel").value = which_lang[_cancel];</script>
				  </div>
				  </td>
				</table>
            </div>
			</div>
	  		</td>
	  		</form>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table>
<br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script>onPageLoad();</script>
</html>