<html>
<head>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
	<script language="JavaScript">
	var submit_button_flag = 0;

	function onPageLoad(){
		set_checked(get_by_id("spi_enable").value, get_by_id("spiEnable"));
		set_checked("<% CmoGetCfg("udp_nat_type","none"); %>", get_by_name("udp_nat_type"));
		set_checked("<% CmoGetCfg("tcp_nat_type","none"); %>", get_by_name("tcp_nat_type"));
		set_checked(get_by_id("anti_spoof_check").value, get_by_id("anti_spoof_check_sel"));
		set_checked(get_by_id("dmz_enable").value, get_by_id("dmz_host"));
		disable_obj();
		set_form_default_values("form1");
	}

	function clone_mac(){
		if (get_by_id("dhcp").selectedIndex > 0){
			get_by_id("dmz_ipaddr").value = get_by_id("dhcp").options[get_by_id("dhcp").selectedIndex].value;
		}else{
			//alert(msg[SELECT_COMPUTER_ERROR]);
			alert(which_lang[GW_NAT_DMZ_CONFLICT_WITH_LAN_IP_INVALID]);
			
		}
	}

	function send_request(){
		//if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
		if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
			return false;
		}
		get_by_id("spi_enable").value = get_checked_value(get_by_id("spiEnable"));
		var dmz_ip = get_by_id("dmz_ipaddr").value;
		var lan_ip = "<% CmoGetCfg("lan_ipaddr","none"); %>";
		var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var ip_obj = new addr_obj(dmz_ip.split("."), ip_addr_msg, false, false);
		var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
		
		if(!check_LAN_ip(temp_lan_ip_obj.addr, ip_obj.addr, "IP address")){
			return false;
		}
		
		if (get_by_id("dmz_host").checked){
			if (!check_address(ip_obj)){				
				return false;
	   		}
	   	}
	   	
		get_by_id("dmz_enable").value = get_checked_value(get_by_id("dmz_host"));
		get_by_id("anti_spoof_check").value = get_checked_value(get_by_id("anti_spoof_check_sel"));
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
	
	function disable_obj(){
		var is_disable = true;
		if (get_by_id("dmz_host").checked){
			is_disable = false;
		}
		
		get_by_id("dmz_ipaddr").disabled = is_disable;
		get_by_id("button22").disabled = is_disable;
		get_by_id("dhcp").disabled = is_disable;
	}
</script>

<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
<form id="form1" name="form1" method="post" action="apply.cgi">
<input type="hidden" id="html_response_page"  name="html_response_page" value="back.asp">
<input type="hidden" id="html_response_message"  name="html_response_message" value="">
<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
<input type="hidden" id="html_response_return_page"  name="html_response_return_page" value="adv_dmz.asp">
<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
<input type="hidden" id="dmz_schedule" name="dmz_schedule" value="<% CmoGetCfg("dmz_schedule","none"); %>">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        
      <td width="100%">&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();">DIR-615</a></td>
        <td align="right" nowrap><script>show_words(which_lang[TA3])</script>:<% CmoGetStatus("hw_version"); %>&nbsp;</td>
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
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <!-- === BEGIN SIDENAV === -->
                            <UL> 
                            <LI><div><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_virtserv])</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(which_lang[_pf])</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(which_lang[_specappsr])</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(which_lang[YM48])</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(which_lang[_acccon])</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
							<LI><div id=sidenavoff><script>show_words(which_lang[_firewalls])</script></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script></a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                          </UL>
                          <!-- === END SIDENAV === -->
                      	</div>
                      </td>                    </tr>
                </table>
             </td>
             <td valign="top" id="maincontent_container">
				<div id=maincontent>
				  <!-- === BEGIN MAINCONTENT === -->
                  <div id=box_header>
                    <h1><script>show_words(which_lang[_firewalls])</script></h1>
                    <p><script>show_words(which_lang[af_intro_x])</script></p>
                    <input name="button" id="button" type="button" class=button_submit value="" onClick="send_request()">
            		<input name="button2" id="button2" type=button class=button_submit value="" onclick="page_cancel('form1', 'adv_dmz.asp');">
           			 <script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
            		<script>get_by_id("button").value = which_lang[_savesettings];</script>
				  </div>
                  <div class=box>
                    <h2><script>show_words(which_lang[_firewalls])</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(which_lang[af_ES])</script>:</td>
                          <td width="360">&nbsp;
						  <input type="checkbox" id="spiEnable" name="spiEnable" value="1">
						  <input type="hidden" id="spi_enable" name="spi_enable" value="<% CmoGetCfg("spi_enable","none"); %>">
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(which_lang[af_ES])</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="1">
						  &nbsp;<script>show_words(which_lang[af_EFT_0])</script>
						  </td>
                        </tr>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(which_lang[af_UEFT])</script>:</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="2">
						  &nbsp;<script>show_words(which_lang[af_EFT_1])</script>
						  </td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="udp_nat_type" name="udp_nat_type" value="0">
						  &nbsp;<script>show_words(which_lang[af_EFT_2])</script>
						  </td>
                        </tr>
                        <tr>
                          <td align=right colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="1">
						  &nbsp;<script>show_words(which_lang[af_EFT_0])</script>
						  </td>
                        </tr>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(which_lang[af_TEFT])</script>:</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="2">
						  &nbsp;<script>show_words(which_lang[af_EFT_1])</script>
						  </td>
                        </tr>
                        <tr>
                          <td align=right width=155>&nbsp;</td>
                          <td width="360">&nbsp;
						  <input type="radio" id="tcp_nat_type" name="tcp_nat_type" value="0">
						  &nbsp;<script>show_words(which_lang[af_EFT_2])</script>
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(which_lang[KR105])</script></h2>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td width=155 align=right class="duple"><script>show_words(which_lang[KR106])</script>:</td>
                          <td width="360">&nbsp;
						  <input type="checkbox" id="anti_spoof_check_sel" name="anti_spoof_check_sel" value="1">
						  <input type="hidden" id="anti_spoof_check" name="anti_spoof_check" value="<% CmoGetCfg("anti_spoof_check","none"); %>">
						  </td>
                        </tr>
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(which_lang[_dmzh])</script></h2>
                    
            <p>
              <script>show_words(which_lang[af_intro_1])</script>
              </P>
                    <p><script>show_words(which_lang[af_intro_2])</script></p>
                    <table cellSpacing=1 cellPadding=1 width=525 border=0>
                        <tr>
                          <td align=right width=155>
						  <input type="hidden" id="dmz_enable" name="dmz_enable" value="<% CmoGetCfg("dmz_enable","none"); %>">
						  <script>show_words(which_lang[af_ED])</script>
                  :</td>
                          <td colSpan=3>&nbsp;
						   
						  <input type=checkbox id="dmz_host" name="dmz_host" value="1" onClick="disable_obj();"></td>
                        </tr>
                        <tr>
                          <td width="155" align=right><script>show_words(which_lang[af_DI])</script> :</td>
                          <td width="96" valign="bottom"><input type=text id="dmz_ipaddr" name="dmz_ipaddr" size=16 maxlength=15 value="<% CmoGetCfg("dmz_ipaddr","none"); %>">
                          </td>
                          <td width="258" valign="bottom"><input id="button22" name="button22" type=button value="<<" style="width: 24; height: 24" onClick="clone_mac()">
                            <select id="dhcp" name="dhcp" size=1>
                              <option value="-1"><script>show_words(which_lang[bd_CName])</script></option>
                              <script>set_mac_list("ip")</script>
                            </select>
						  </td>
                          <td width="3">&nbsp;</td>
                        </tr>
                    </table>
                  </div>
             </div>
            </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong><script>show_words(which_lang[_hints])</script>&hellip;</strong>
                        <p><script>show_words(which_lang[hhaf_dmz])</script></p>
                        <p class="more"><a href="support_adv.asp#Firewall" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
                      </td>
                    </tr>
                </table>
             </td>
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
</form>
</body>
<script>
	onPageLoad();
</script>
</html>
