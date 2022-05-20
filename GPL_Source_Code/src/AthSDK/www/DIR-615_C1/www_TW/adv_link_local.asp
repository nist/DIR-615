<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_ipv6.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
function onPageLoad(){
	var link_local ;
	link_local = document.getElementById("link_local_ip_l").value;
	document.getElementById("lan_link_local_ip").innerHTML= link_local.toUpperCase();
}
function send_request(){
	get_by_id("ipv6_wan_proto").value = get_by_id("ipv6_w_proto").value;
	if(submit_button_flag == 0){
		submit_button_flag = 1;
		get_by_id("form1").submit();
	}
}
</script>
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style2 {font-size: 11px}
-->
</style>
</head>
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
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(which_lang[_acccon])</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();"><script>show_words(which_lang[YM63])</script></a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script></a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                          </UL>
                      	</div>
                      </td>
                    </tr>
                  </tbody>
                </table></td>
	       <form id="form1" name="form1" method="post" action="apply.cgi">
	      <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
		    <input type="hidden" id="html_response_message" name="html_response_message" value="">
		    <script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
		    <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_ipv6_linklocal.asp">
		    <input type="hidden" id="ipv6_wan_proto" name="ipv6_wan_proto" value="<% CmoGetCfg("ipv6_wan_proto","none"); %>">
		    <input type="hidden" maxLength=80 size=80 name="link_local_ip_l" id="link_local_ip_l" value="<% CmoGetStatus("link_local_ip_l","none"); %>">
		    <input type="hidden" id="page_type" name="page_type" value="IPv6">
               <td valign="top" id="maincontent_container">
				<div id=maincontent>
		  <div id=box_header>
                    <h1>IPv6</h1>
                     <script>show_words(which_lang[IPV6_TEXT28])</script><br>
                    <br>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
            		<input name="button2" id="button2" type="button" class=button_submit value="" onclick="page_cancel_1('form1', 'adv_link_local.asp');">
           			<script>get_by_id("button").value = which_lang[_savesettings];</script>
					<script>get_by_id("button2").value = which_lang[_dontsavesettings];</script></div>
                  <div class=box>
                    <h2 style=" text-transform:none">
                   <script>show_words(which_lang[IPV6_TEXT29])</script></h2>
				   <p class="box_msg"><script>show_words(which_lang[IPV6_TEXT30])</script></p>
                   <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="187" class="duple"><script>show_words(which_lang[IPV6_TEXT31])</script> :</td>
                      <td width="331">&nbsp; <select name="ipv6_w_proto" id="ipv6_w_proto" onChange=select_ipv6_wan_page(get_by_id("ipv6_w_proto").value);>
                        <option value="ipv6_static"><script>show_words(which_lang[IPV6_TEXT32])</script></option>
                        <option value="ipv6_dhcp"><script>show_words(which_lang[IPV6_TEXT33])</script></option>
                        <option value="ipv6_pppoe"><script>show_words(which_lang[IPV6_TEXT34])</script></option>
                        <option value="ipv6_6in4"><script>show_words(which_lang[IPV6_TEXT35])</script></option>
                        <option value="ipv6_6to4"><script>show_words(which_lang[IPV6_TEXT36])</script></option>
						<!--option value="ipv6_stateless"><script>show_words(which_lang[TEXT001])</script></option-->
                        <option value="link_local" selected><script>show_words(which_lang[IPV6_TEXT37])</script></option>
                      </select></td>
                    </tr>
                   </table>
                  </div>
		 <div class=box id=lan_ipv6_settings>
	                <h2 style=" text-transform:none"><script>show_words(which_lang[IPV6_TEXT44])</script>  : </h2>
					<p class="style2"><script>show_words(which_lang[IPV6_TEXT67])</script></p>
	                <table cellSpacing=1 cellPadding=1 width=525 border=0>
			    <tr>
			      <td width="206" align=right class="duple"><script>show_words(which_lang[IPV6_TEXT47])</script> :</td>
	                      <td width="331">&nbsp;<b><span id="lan_link_local_ip"></span></b>
	                      </td>
                      </tr>
			</table>
                 </div>
               </td>
          </form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b><script>show_words(which_lang[_hints])</script>&hellip;</b>
                      	<p><script>show_words(which_lang[IPV6_TEXT58])</script></p>
              			<p><script>show_words(which_lang[IPV6_TEXT59])</script></p>
						<p><a href="support_adv.asp#ipv6" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
                      </td>
                    </tr>
                  </tbody>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
</script>
</html>
