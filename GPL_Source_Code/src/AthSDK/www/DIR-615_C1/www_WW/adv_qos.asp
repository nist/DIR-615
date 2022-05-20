<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
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
				alert("Uplink Speed is over wire Speed");
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
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--    
.style1 {font-size: 11px}
-->     
</style>
</head> 
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;Product Page: <a href="http://support.dlink.com.tw/" onclick="return jump_if();">DIR-615</a></td>
        <td align="right" nowrap>Hardware Version: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
        <td align="right" nowrap>Firmware Version: <% CmoGetStatus("version"); %></td>
				<td>&nbsp;</td>
      </tr>
    </table>
	<table id="topnav_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr><td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td></tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();">SETUP</a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();">ADVANCED</a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();">TOOLS</a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();">SUPPORT</a></td>
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
                    <LI><div><a href="adv_virtual.asp" onclick="return jump_if();">Virtual Server</a></div></LI>
                    <LI><div><a href="adv_portforward.asp" onclick="return jump_if();">Port Forwarding</a></div></LI>
                    <LI><div><a href="adv_appl.asp" onclick="return jump_if();">Application Rules</a></div></LI>
                    <LI><div id=sidenavoff>QOS Engine</div></LI>
                    <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();">Network Filter</a></div></LI>
                    <LI><div><a href="adv_access_control.asp" onclick="return jump_if();">Access control</a></div></LI>
										<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();">Website Filter</a></div></LI>
										<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();">Inbound Filter</a></div></LI>
										<LI><div><a href="adv_dmz.asp" onclick="return jump_if();">Firewall Settings</a></div></LI>
							<LI><div><a href="adv_routing.asp" onclick="return jump_if();">Routing</a></div></LI>
                    <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();">Advanced Wireless </a></div></LI>
                    <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                    <LI><div><a href="adv_network.asp" onclick="return jump_if();">Advanced Network </a></div></LI>
                    <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                  </UL>
              	</div>
              </td>
            </tr>
        </table></td>
				
                <form id="form1" name="form1" method="post" action="apply.cgi">
		              <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
									<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
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
                    <h1>QoS Engine</h1>
                     Use this section to configure D-Link's QoS Engine. The QoS 
            Engine improves your online gaming experience by ensuring that your 
            game traffic is prioritized over other network traffic, such as FTP 
            or Web.<br>
            <br>
                    <input name="button" id="button" type="submit" class=button_submit value="Save Settings" onClick="return send_request()">
                    <input name="button2" type=button class=button_submit value="Don't Save Settings"  onClick="window.location.href='adv_qos.asp'">
                  </div>
                  <div class=box>
                    <h2>WAN Traffic Shaping</h2>
                  	<table width=525>
					
					<tr>
						<!--td width="185" align=right class="duple">Enable Traffic Shaping :</td-->
						<td width="185" align=right class="duple">Enable Traffic Shaping:</td>
                        <td width="333">&nbsp;
						<input type="checkbox" id="qos_traffic_shaping" name="qos_traffic_shaping" value="1" onClick="qos_traffic_shaping_click(this.checked);">
						<input type="hidden" id="traffic_shaping" name="traffic_shaping" value="<% CmoGetCfg("traffic_shaping","none"); %>">
						</td>
					</tr>
											<tr>
											  <td align=right class="duple">Automatic Uplink Speed :</td>
                        <td>&nbsp;
					  							<input type="checkbox" id="qos_auto_uplink" name="qos_auto_uplink" value="1" onClick="qos_auto_uplink_click(this.checked);">
													<input type="hidden" id="auto_uplink" name="auto_uplink" value="<% CmoGetCfg("auto_uplink","none"); %>">
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple">Measured Uplink Speed :</td>
                        <td>&nbsp;
					  							<% CmoGetStatus("measured_uplink_speed"); %>
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple">Manual Uplink Speed :</td>
                        <td>&nbsp;
					  							<input type="text" id="qos_uplink" name="qos_uplink" maxlength="6" size="6"  value="<% CmoGetCfg("qos_uplink","none"); %>">&nbsp;kbps
					  							<span>&nbsp;&lt;&lt;&nbsp;</span>
													<select id="qos_max_trans_rate_select" name="qos_max_trans_rate_select" onchange="qos_max_trans_rate_selector(this.value);">
														<option value="0">Select Transmission Rate</option>
														<option value="128">128 kbps</option>
														<option value="256">256 kbps</option>
														<option value="384">384 kbps</option>
														<option value="512">512 kbps</option>
														<option value="1024">1024 kbps</option>
														<option value="2048">2048 kbps</option>
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
                  <div class=box id="qos_engine" style="display:none">
                    <h2>QoS Engine Setup</h2>
                  	<table width=525>
								<tr>
					<td width="185" align=right class="duple">Enable QoS Engine :</td>
					<td width="333">&nbsp;
						<input type="checkbox" id="qos_engine_enabled" name="qos_engine_enabled" value="1" onClick="qos_enable_click(this.checked)">
						<input type="hidden" id="qos_enable" name="qos_enable" value="<% CmoGetCfg("qos_enable","none"); %>">
					</td>
					</tr>  
											<tr>
											  <td align=right class="duple">Automatic Classification :</td>
                        <td>&nbsp;
					  							<input type="checkbox" id="qos_auto_classification" name="qos_auto_classification" value="1">
													<input type="hidden" id="auto_classification" name="auto_classification" value="<% CmoGetCfg("auto_classification","none"); %>">
					  						</td>
											</tr>
											<tr>
											  <td align=right class="duple">Dynamic Fragmentation :</td>
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
	                   <td id=help_text><strong>Helpful Hints&hellip;</strong>
	                   <p>If the <strong>Measured Uplink Speed</strong> is known to be incorrect (that is, it produces suboptimal performance), disable <strong>Automatic Uplink Speed</strong> and enter the <strong>Manual Uplink Speed</strong>. Some experimentation and performance measurement may be required to converge on the optimal value.</p>
	                   <p class="more"><a href="support_adv.asp#Traffic_Shaping" onclick="return jump_if();">More&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
</script>
</html>