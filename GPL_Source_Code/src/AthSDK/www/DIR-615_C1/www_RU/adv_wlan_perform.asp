<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	function onPageLoad(){
		set_selectIndex("<% CmoGetCfg("wlan0_txpower","none"); %>", get_by_id("wlan0_txpower"));
		//set_checked("<% CmoGetCfg("wlan0_11d_enable","none"); %>", get_by_id("wlan0_11d_enable_sel"));
		set_checked("<% CmoGetCfg("wlan0_partition","none"); %>", get_by_id("wlan0_partition_sel"));
		set_checked("<% CmoGetCfg("wlan0_wmm_enable","none"); %>", get_by_id("wlan0_wmm_enable_sel"));
		set_checked("<% CmoGetCfg("wlan0_short_gi","none"); %>", get_by_id("wlan0_short_gi_sel"));
	}

	function check_perform(which_one){		
    	var obj;
    	var temp_obj;
   
    	switch(which_one){
    		case 0 :
    			temp_obj = get_by_id("wlan0_beacon_interval");
    			var beacon_msg = replace_msg(check_num_msg, "Beacon interval", 20, 1000);
    			obj = new varible_obj(temp_obj.value, beacon_msg, 20, 1000, false);
    			break;
    		case 1 :
    			temp_obj = get_by_id("wlan0_rts_threshold");
    			var rts_msg = replace_msg(check_num_msg, "RTS Threshold", 0, 2347);
    			obj = new varible_obj(temp_obj.value, rts_msg, 0, 2347, false);
    			break;
    		case 2 :
    			temp_obj = get_by_id("wlan0_fragmentation");
    			var dtim_msg = replace_msg(check_num_msg, "Fragmentation",256 ,2346);
    			obj = new varible_obj(temp_obj.value, dtim_msg, 256, 2346, true);
    			break;
    		case 3 :
    			temp_obj = get_by_id("wlan0_dtim");
    			var dtim_msg = replace_msg(check_num_msg, "DTIM Interval",1 ,255);
    			obj = new varible_obj(temp_obj.value, dtim_msg, 1, 255, false);
    			break;
    			
    			
    	}
    	
    	if (check_varible(obj)){
    		return true;
    	}else {
        	temp_obj.value = temp_obj.defaultValue;
        	return false;
    	}         
    }
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
			return false;
		}
		var is_submit = false;
		for (var i = 0; i < 4; i++){
			is_submit = check_perform(i);
			if (!is_submit){			
				break;
    		} 
		}
		
		//get_by_id("wlan0_11d_enable").value = get_checked_value(get_by_id("wlan0_11d_enable_sel"));
		get_by_id("wlan0_partition").value = get_checked_value(get_by_id("wlan0_partition_sel"));
		get_by_id("wlan0_wmm_enable").value = get_checked_value(get_by_id("wlan0_wmm_enable_sel"));
		get_by_id("wlan0_short_gi").value = get_checked_value(get_by_id("wlan0_short_gi_sel"));

		if (is_submit){
			if(submit_button_flag == 0){
				submit_button_flag = 1;
				return true;
			}else{
				return false;
			}
		}
		return false;
	}
</script>

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style1 {color: #000000}
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
		<tr>
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
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
                            <LI><div><a href="adv_virtual.asp">VIRTUAL SERVER</a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();">PORT FORWARDING</a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();">APPLICATION RULES</a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();">QOS Engine</a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();">NETWORK FILTER</a></div></LI>
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();">ACCESS CONTROL</a></div></LI>
                            <LI><div><a href="adv_filters_url.asp" onclick="return jump_if();">WEBSITE FILTER</a></div></LI>
                            <LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();">INBOUND FILTER</a></div></LI>
                            <LI><div><a href="adv_dmz.asp" onclick="return jump_if();">FIREWALL SETTINGS</a></div></LI>
							<LI><div><a href="adv_routing.asp" onclick="return jump_if();">Routing</a></div></LI>
                            <LI><div id=sidenavoff>ADVANCED WIRELESS</div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();">ADVANCED NETWORK</a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                          </UL>
                       </div>
                      </td>
                    </tr>
                </table>
			</td>
		<form id="form1" name="form1" method="post" action="apply.cgi">
		<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
		<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_wlan_perform.asp">
		<input type="hidden" id="wlan0_auto_txrate" name="wlan0_auto_txrate" value="<% CmoGetCfg("wlan0_auto_txrate","none"); %>">
		<input type="hidden" id="wlan0_wmm_enable" name="wlan0_wmm_enable" value="<% CmoGetCfg("wlan0_wmm_enable","none"); %>">
		<input type="hidden" id="wlan0_11d_enable" name="wlan0_11d_enable" value="<% CmoGetCfg("wlan0_11d_enable","none"); %>">
		<input type="hidden" id="wlan0_partition" name="wlan0_partition" value="<% CmoGetCfg("wlan0_partition","none"); %>">
		<input type="hidden" id="wlan0_short_gi" name="wlan0_short_gi" value="<% CmoGetCfg("wlan0_short_gi","none"); %>">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
                  <div id=box_header>
                    <h1>Advanced Wireless</h1>
                    <p>If you are not familiar with these Advanced Wireless settings, please read the help section before attempting to modify these settings.</p>
                    <input name="button" type="submit" class=button_submit value="Save Settings" onClick="return send_request()">
                    <input name="button2" type=reset class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'adv_wlan_perform.asp');">
                  </div>
                  <div class=box>
                    <h2>Advanced Wireless Settings</h2>
                  <TABLE width=525>
						<tr> 
							<td width="183" align=right class="duple">Transmit Power :</td>
							<td width="330"> 
								<select id="wlan0_txpower" name="wlan0_txpower" size="1" >
									  <option value="19">High</option>
				                      <option value="15">Medium</option>
				                      <option value="3">Low</option>
								</select>
							</td>
						</tr>
						<TR>
						  <TD align=right class="duple">Beacon Period :</TD>
						  <TD>
							<input maxlength=4 id="wlan0_beacon_interval" name="wlan0_beacon_interval" size=6 value="<% CmoGetCfg("wlan0_beacon_interval","none"); %>">
							(20..1000)
							</TD>
						</TR>
						<tr> 
						   <td align=right class="duple">RTS Threshold :</td>
						   <td><input maxlength=4 id="wlan0_rts_threshold" name="wlan0_rts_threshold" size=6 value="<% CmoGetCfg("wlan0_rts_threshold","none"); %>">
						   	(0..2347)
						   </td>
						</tr>
						<tr> 
						   <td align=right class="duple">Fragmentation :</td>
						   <td><input maxlength=4 id="wlan0_fragmentation" name="wlan0_fragmentation" size=6 value="<% CmoGetCfg("wlan0_fragmentation","none"); %>">
						   	(256..2346)
						   </td>
						</tr>
						<TR>
						  <TD align=right class="duple">DTIM Interval :</TD>
						  <TD><input maxlength=3 id="wlan0_dtim" name="wlan0_dtim" size=6 value="<% CmoGetCfg("wlan0_dtim","none"); %>">
						  	(1..255)
						  </TD>
						</TR>
						<!--TR>
						  <TD align=right class="duple">802.11d Enable :</TD>
						  <TD>
							  <INPUT type="checkbox" id="wlan0_11d_enable_sel" name="wlan0_11d_enable_sel" value="1"> 
						  </TD>
						</TR-->
						<TR>
						  <TD align=right class="duple">WLAN Partition :</TD>
						  <TD>
							  <INPUT type="checkbox" id="wlan0_partition_sel" name="wlan0_partition_sel" value="1"> 
						  </TD>
						</TR>
						<TR>
						  <TD align=right class="duple">WMM Enable :</TD>
						  <TD>
							  <INPUT name="wlan0_wmm_enable_sel" type="checkbox" id="wlan0_wmm_enable_sel" value="1"> 
						  </TD>
						</TR>
						<TR>
						  <TD align=right class="duple">Short GI :</TD>
						  <TD>
							  <INPUT type="checkbox" id="wlan0_short_gi_sel" name="wlan0_short_gi_sel" value="1"> 
						  </TD>
						</TR>
				</TABLE>
			</DIV>
			<!-- ________________________________  Main Content End _______________________________ -->
			</TD>
			</form>
<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                    <tr>
	                   <td id=help_text><strong>Helpful Hints&hellip;</strong>
	                   <p>It is recommended that you leave these parameters at their default values. Adjusting them could limit the performance of your wireless network.</p>
	                   <p>Use <strong>802.11d</strong> only for countries where it is required.</p>
	                   <p>Enabling <strong>WMM</strong> can help control latency and jitter when transmitting multimedia content over a wireless connection.</p>
	                   <p class="more"><a href="support_adv.asp#Advanced_Wireless" onclick="return jump_if();">More&hellip;</a></p>
	                   </TD>
                    </tr>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
