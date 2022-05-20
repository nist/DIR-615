<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 10;
	function onPageLoad(){
		set_checked(get_by_id("traffic_shaping").value, get_by_id("qos_traffic_shaping"));
		set_checked(get_by_id("auto_uplink").value, get_by_id("qos_auto_uplink"));
		set_checked(get_by_id("qos_enable").value, get_by_id("qos_engine_enabled"));
		set_checked(get_by_id("auto_classification").value, get_by_id("qos_auto_classification"));
		set_checked(get_by_id("qos_dyn_fragmentation").value, get_by_id("qos_dyn_frag"));

		qos_traffic_shaping_click(get_by_id("qos_traffic_shaping").checked);
	}
	
	function qos_max_trans_rate_selector(value)
	{
		get_by_id("qos_uplink").value = value;
		// Always go back to "Select"
		get_by_id("qos_max_trans_rate_select").value = 0;			
	}
	function qos_traffic_shaping_click(obj_chk){
		var is_disabled = !obj_chk;
		get_by_id("qos_auto_uplink").disabled = is_disabled;
		get_by_id("qos_uplink").disabled = is_disabled;
		get_by_id("qos_max_trans_rate_select").disabled = is_disabled;
		if (is_disabled == false){
			qos_auto_uplink_click(get_by_id("qos_auto_uplink").checked);
		}
		get_by_id("qos_engine_enabled").disabled = is_disabled;
		qos_enable_click(get_by_id("qos_engine_enabled").checked);
	}
	function qos_auto_uplink_click(obj_chk){
		var is_disabled = obj_chk;
		get_by_id("qos_uplink").disabled = is_disabled;
		get_by_id("qos_max_trans_rate_select").disabled = is_disabled;
	}

	function qos_enable_click(obj_chk){
		var is_disabled = !(obj_chk && get_by_id("qos_traffic_shaping").checked);
		get_by_id("qos_auto_classification").disabled = is_disabled;
		get_by_id("qos_dyn_frag").disabled = is_disabled;
	}

	function send_request(){
		get_by_id("traffic_shaping").value = get_checked_value(get_by_id("qos_traffic_shaping"));
		get_by_id("auto_uplink").value = get_checked_value(get_by_id("qos_auto_uplink"));
		get_by_id("qos_enable").value = get_checked_value(get_by_id("qos_engine_enabled"));
		get_by_id("auto_classification").value = get_checked_value(get_by_id("qos_auto_classification"));
		get_by_id("qos_dyn_fragmentation").value = get_checked_value(get_by_id("qos_dyn_frag"));
						
		// check qos_uplink
		if(get_by_id("qos_traffic_shaping").checked){
			var qos_uplink = parseInt(get_by_id("qos_uplink").value);			
			if(qos_uplink > 102400){
				//alert("Uplink Speed is over wire Speed");
				alert(which_lang[at_alert_1]);
				return false;
			}	
		}
		
			
				
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}   
</script>
<title>D-Link公司 | &#26080;&#32447;路由器 | 主&#39029;</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--    
.style1 {font-size: 11px}
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
		<tr><td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td></tr>
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
                  <UL>
                    <LI><div><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_virtserv])</script></a></div></LI>
                    <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(which_lang[_pf])</script></a></div></LI>
                    <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(which_lang[_specappsr])</script></a></div></LI>
					<LI><div id=sidenavoff><script>show_words(which_lang[YM48])</script></div></LI>
                    <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
					<LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(which_lang[_acccon])</script></a></div></LI>
					<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
					<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
					<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
					<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
					<@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
					<LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script> </a></div></LI>
					<@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
				</UL>
              	</div>
              </td>
            </tr>
        </table></td>
				
                <form id="form1" name="form1" method="post" action="apply.cgi">
		              <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
									<input type="hidden" id="html_response_message" name="html_response_message" value="">
									<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
									<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_qos.asp">
									<input type="hidden" id="reboot_type" name="reboot_type" value="qos">
				
                <input type="hidden" id="qos_rule_00" name="qos_rule_00" value="<% CmoGetCfg("qos_rule_00","none"); %>">
                <input type="hidden" id="qos_rule_01" name="qos_rule_01" value="<% CmoGetCfg("qos_rule_01","none"); %>">
                <input type="hidden" id="qos_rule_02" name="qos_rule_02" value="<% CmoGetCfg("qos_rule_02","none"); %>">
                <input type="hidden" id="qos_rule_03" name="qos_rule_03" value="<% CmoGetCfg("qos_rule_03","none"); %>">
                <input type="hidden" id="qos_rule_04" name="qos_rule_04" value="<% CmoGetCfg("qos_rule_04","none"); %>">
                <input type="hidden" id="qos_rule_05" name="qos_rule_05" value="<% CmoGetCfg("qos_rule_05","none"); %>">
                <input type="hidden" id="qos_rule_06" name="qos_rule_06" value="<% CmoGetCfg("qos_rule_06","none"); %>">
                <input type="hidden" id="qos_rule_07" name="qos_rule_07" value="<% CmoGetCfg("qos_rule_07","none"); %>">
                <input type="hidden" id="qos_rule_08" name="qos_rule_08" value="<% CmoGetCfg("qos_rule_08","none"); %>">
                <input type="hidden" id="qos_rule_09" name="qos_rule_09" value="<% CmoGetCfg("qos_rule_09","none"); %>">

			<td valign="top" id="maincontent_container">
				<div id=maincontent>
                  <div id=box_header>
                    <h1><script>show_words(which_lang[YM48])</script></h1>
                     <script>show_words(which_lang[at_intro])</script><script>show_words(which_lang[at_intro_2])</script>
            <br>
            <br>
		    <input name="button" id="button" type="submit" class=button_submit value="" onClick="send_request()">
			<input name="button1" id="button1" type="button" class=button_submit value="" onclick="page_cancel_1('form1', 'adv_qos.asp');">
			<script>get_by_id("button").value = which_lang[_savesettings];</script>
			<script>get_by_id("button1").value = which_lang[_dontsavesettings];</script>
				 </div>
                  <div class=box>
                    <h2><script>show_words(which_lang[at_title_Traff])</script></h2>
                  	<table width=525>

								  		<tr>
												<!--td width="185" align=right class="duple"><script>show_words(which_lang[at_ETS])</script> :</td-->
                                                                                                <td width="185" align=right class="duple"><script>show_words(which_lang[at_ETS])</script> :</td>            
                        <td width="333">&nbsp;
					  							<input type="checkbox" id="qos_traffic_shaping" name="qos_traffic_shaping" value="1" onClick="qos_traffic_shaping_click(this.checked);">
													<input type="hidden" id="traffic_shaping" name="traffic_shaping" value="<% CmoGetCfg("traffic_shaping","none"); %>">
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple"><script>show_words(which_lang[at_AUS])</script> :</td>
                        <td>&nbsp;
					  							<input type="checkbox" id="qos_auto_uplink" name="qos_auto_uplink" value="1" onClick="qos_auto_uplink_click(this.checked);">
													<input type="hidden" id="auto_uplink" name="auto_uplink" value="<% CmoGetCfg("auto_uplink","none"); %>">
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple"><script>show_words(which_lang[at_MUS])</script> :</td>
                        <td>&nbsp;
					  							<% CmoGetStatus("measured_uplink_speed"); %>
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple"><script>show_words(which_lang[at_UpSp])</script> :</td>
                        <td>&nbsp;
					  							<input type="text" id="qos_uplink" name="qos_uplink" maxlength="6" size="6"  value="<% CmoGetCfg("qos_uplink","none"); %>">&nbsp;<script>show_words(which_lang[at_kbps])</script>
					  							<span>&nbsp;&lt;&lt;&nbsp;</span>
													<select id="qos_max_trans_rate_select" name="qos_max_trans_rate_select" onchange="qos_max_trans_rate_selector(this.value);">
														<option value="0"><script>show_words(which_lang[at_STR])</script></option>
														<option value="128">128 <script>show_words(which_lang[at_kbps])</script></option>
														<option value="256">256 <script>show_words(which_lang[at_kbps])</script></option>
														<option value="384">384 <script>show_words(which_lang[at_kbps])</script></option>
														<option value="512">512 <script>show_words(which_lang[at_kbps])</script></option>
														<option value="1024">1024 <script>show_words(which_lang[at_kbps])</script></option>
														<option value="2048">2048 <script>show_words(which_lang[at_kbps])</script></option>
													</select>
					  						</td>
											</tr>
											<!--tr>
											  <td align=right class="duple">Connection Type :</td>
                        <td>&nbsp;
					  							<select id="qos_connection_type_select" onchange="qos_connection_type_selector(this.value);">
														<option value="0">Auto-detect</option>
														<option value="1">xDSL Or Other Frame Relay Network</option>
														<option value="2">Cable Or Other Broadband Network</option>
													</select>
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple">Detected xDSL or Other Frame Relay Network :</td>
                        <td>&nbsp;
					  							<% CmoGetCfg("auto_uplink","none"); %>
					  						</td>
											</tr-->
                    </table>
                  </div>
                  <div class=box>
                    <h2><script>show_words(which_lang[at_title_SESet])</script></h2>
                  	<table width=525>
								  		<tr>
												<td width="185" align=right class="duple"><script>show_words(which_lang[at_ESE])</script> :</td>
                        <td width="333">&nbsp;
					  							<input type="checkbox" id="qos_engine_enabled" name="qos_engine_enabled" value="1" onClick="qos_enable_click(this.checked)">
													<input type="hidden" id="qos_enable" name="qos_enable" value="<% CmoGetCfg("qos_enable","none"); %>">
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple"><script>show_words(which_lang[at_AC])</script> :</td>
                        <td>&nbsp;
					  							<input type="checkbox" id="qos_auto_classification" name="qos_auto_classification" value="1">
													<input type="hidden" id="auto_classification" name="auto_classification" value="<% CmoGetCfg("auto_classification","none"); %>">
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple"><script>show_words(which_lang[at_DF])</script> :</td>
                        <td>&nbsp;
					  							<input type="checkbox" id="qos_dyn_frag" name="qos_dyn_frag" value="1">
													<input type="hidden" id="qos_dyn_fragmentation" name="qos_dyn_fragmentation" value="<% CmoGetCfg("qos_dyn_fragmentation","none"); %>">
					  						</td>
											</tr>
                    </table>
                  </div>
                  </div>
				</div>
			 </td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff  cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tr>
	                   
          <td id=help_text><strong><b><strong>
            <script>show_words(which_lang[_hints])</script>
            </strong></b>&hellip;</strong> 
            <p><script>show_words(which_lang[hhase_intro])</script>
	                   <p class="more"><a href="support_adv.asp#Traffic_Shaping" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
	                   </TD>
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
</body>
<script>
	onPageLoad();
</script>
</html>