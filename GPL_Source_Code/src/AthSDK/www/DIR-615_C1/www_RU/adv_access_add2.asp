<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		if(get_by_id("asp_temp_14").value != "-1"){
			get_by_id("schedule").value = get_by_id("asp_temp_01").value;
			
		  	//2009/4/20 Tina modify:Fixed schedule can't selected.
			for (var i = 0; i < 13; i++){
				var temp_acc;
			
				if (i > 9){
					temp_acc = (get_by_id("access_control_" + i).value).split("/");
				}else{
					temp_acc = (get_by_id("access_control_0" + i).value).split("/");				
				}
				if (temp_acc.length > 1){
			    	if((temp_acc[5] == "Always") || (temp_acc[5] == "Never") || (temp_acc[5] == "")){
   						set_selectIndex(temp_acc[5], get_by_id("schedule"));
   					}else{
				  		var temp_index = get_schedule_index(temp_acc[5]);
		   		    	get_by_id("schedule").selectedIndex=temp_index+2;
     				}
	   			}					
			}
		}				
	}

	function show_save_button(){
		get_by_id("save").disabled = !(get_by_id("asp_temp_14").value != "-1");
	}
	
	function click_schedule(){
		var schedule = get_by_id("schedule");
		if(schedule.value == "-1"){
			if (confirm(msg[GO_SCHEDULE])){
				window.location.href = "tools_schedules.asp";
			}
		}else if(schedule.selectedIndex < 2){
			get_by_id("detail").value = schedule.value;
		}else if(schedule.selectedIndex > 1){
			var idx = parseInt(schedule.selectedIndex) - 2;
			get_by_id("detail").value = show_schedule_detail(idx);
		}
	}

	function save_info(){
		if(get_by_id("asp_temp_00").value == ""){
			alert(msg[NAME_ERROR]);
			return false;
		}
		
		//2009/4/20 Tina modify:Fixed can't save space char.
		var tmp_schedule_index = get_by_id("schedule").selectedIndex;
		var schedule;
		if (tmp_schedule_index > 1){
			schedule = get_by_id("schedule_rule_" + (tmp_schedule_index-2)).value;
		}else if (tmp_schedule_index == 0){
			schedule = "Always";
		}else if (tmp_schedule_index == 1){
			schedule = "Never";
		}
		get_by_id("asp_temp_01").value = schedule;
		//get_by_id("asp_temp_01").value = get_by_id("schedule").value;
	}

	function send_previous(){
		save_info();
		get_by_id("html_response_page").value = "adv_access_add1.asp";
		get_by_id("html_response_return_page").value = "adv_access_add1.asp";
		send_submit("form1");
	}
			
	function send_next(){
		save_info();
		send_submit("form1");
	}

	function send_request(){
		save_info();
		get_by_id("html_response_page").value = "adv_access_save.asp";
		get_by_id("html_response_return_page").value = "adv_access_save.asp";
		send_submit("form1");
	}
</script>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | Advanced / Access control</title>
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
			<td height="29"><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();">Setup</a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();">Advanced</a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();">Tools</a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();">Status</a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();">Support</a></td>
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
                            <LI><div><a href="adv_virtual.asp" onclick="return jump_if();">Virtual Server</a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();">Port Forwarding</a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();">Application Rules</a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();">QOS Engine</a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();">Network Filter</a></div></LI>
                            <LI><div id=sidenavoff>Access control</div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();">Website Filter</a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();">Inbound Filter</a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();">Firewall Settings</a></div></LI>
							<LI><div><a href="adv_routing.asp" onclick="return jump_if();">Routing</a></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();">Advanced Wireless </a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();">Advanced Network </a></div></LI>
                          </UL>
                      	</div>
					  </td>
                    </tr>
                  </tbody>
                </table>
			</td>
			<input type="hidden" id="schedule_rule_0" name="schedule_rule_0" value="<% CmoGetCfg("schedule_rule_00","none"); %>">				
			<input type="hidden" id="schedule_rule_1" name="schedule_rule_1" value="<% CmoGetCfg("schedule_rule_01","none"); %>">
			<input type="hidden" id="schedule_rule_2" name="schedule_rule_2" value="<% CmoGetCfg("schedule_rule_02","none"); %>">		
			<input type="hidden" id="schedule_rule_3" name="schedule_rule_3" value="<% CmoGetCfg("schedule_rule_03","none"); %>">				
			<input type="hidden" id="schedule_rule_4" name="schedule_rule_4" value="<% CmoGetCfg("schedule_rule_04","none"); %>">
			<input type="hidden" id="schedule_rule_5" name="schedule_rule_5" value="<% CmoGetCfg("schedule_rule_05","none"); %>">
			<input type="hidden" id="schedule_rule_6" name="schedule_rule_6" value="<% CmoGetCfg("schedule_rule_06","none"); %>">				
			<input type="hidden" id="schedule_rule_7" name="schedule_rule_7" value="<% CmoGetCfg("schedule_rule_07","none"); %>">
			<input type="hidden" id="schedule_rule_8" name="schedule_rule_8" value="<% CmoGetCfg("schedule_rule_08","none"); %>">	
			<input type="hidden" id="schedule_rule_9" name="schedule_rule_9" value="<% CmoGetCfg("schedule_rule_09","none"); %>">
			<input type="hidden" id="schedule_rule_10" name="schedule_rule_10" value="<% CmoGetCfg("schedule_rule_10","none"); %>">
			<input type="hidden" id="schedule_rule_11" name="schedule_rule_11" value="<% CmoGetCfg("schedule_rule_11","none"); %>">
			<input type="hidden" id="schedule_rule_12" name="schedule_rule_12" value="<% CmoGetCfg("schedule_rule_12","none"); %>">
			<input type="hidden" id="schedule_rule_13" name="schedule_rule_13" value="<% CmoGetCfg("schedule_rule_13","none"); %>">
			<input type="hidden" id="schedule_rule_14" name="schedule_rule_14" value="<% CmoGetCfg("schedule_rule_14","none"); %>">
			<input type="hidden" id="schedule_rule_15" name="schedule_rule_15" value="<% CmoGetCfg("schedule_rule_15","none"); %>">
			<input type="hidden" id="schedule_rule_16" name="schedule_rule_16" value="<% CmoGetCfg("schedule_rule_16","none"); %>">
			<input type="hidden" id="schedule_rule_17" name="schedule_rule_17" value="<% CmoGetCfg("schedule_rule_17","none"); %>">
			<input type="hidden" id="schedule_rule_18" name="schedule_rule_18" value="<% CmoGetCfg("schedule_rule_18","none"); %>">
			<input type="hidden" id="schedule_rule_19" name="schedule_rule_19" value="<% CmoGetCfg("schedule_rule_19","none"); %>">
			<input type="hidden" id="schedule_rule_20" name="schedule_rule_20" value="<% CmoGetCfg("schedule_rule_20","none"); %>">
			<input type="hidden" id="schedule_rule_21" name="schedule_rule_21" value="<% CmoGetCfg("schedule_rule_21","none"); %>">
			<input type="hidden" id="schedule_rule_22" name="schedule_rule_22" value="<% CmoGetCfg("schedule_rule_22","none"); %>">
			<input type="hidden" id="schedule_rule_23" name="schedule_rule_23" value="<% CmoGetCfg("schedule_rule_23","none"); %>">
			<input type="hidden" id="schedule_rule_24" name="schedule_rule_24" value="<% CmoGetCfg("schedule_rule_24","none"); %>">
			<input type="hidden" id="schedule_rule_25" name="schedule_rule_25" value="<% CmoGetCfg("schedule_rule_25","none"); %>">
			<input type="hidden" id="schedule_rule_26" name="schedule_rule_26" value="<% CmoGetCfg("schedule_rule_26","none"); %>">
			<input type="hidden" id="schedule_rule_27" name="schedule_rule_27" value="<% CmoGetCfg("schedule_rule_27","none"); %>">
			<input type="hidden" id="schedule_rule_28" name="schedule_rule_28" value="<% CmoGetCfg("schedule_rule_28","none"); %>">
			<input type="hidden" id="schedule_rule_29" name="schedule_rule_29" value="<% CmoGetCfg("schedule_rule_29","none"); %>">
			<input type="hidden" id="schedule_rule_30" name="schedule_rule_30" value="<% CmoGetCfg("schedule_rule_30","none"); %>">
			<input type="hidden" id="schedule_rule_31" name="schedule_rule_31" value="<% CmoGetCfg("schedule_rule_31","none"); %>">

			<input type="hidden" id="access_control_00" name="access_control_00" value="<% CmoGetCfg("access_control_00","none"); %>">
			<input type="hidden" id="access_control_01" name="access_control_01" value="<% CmoGetCfg("access_control_01","none"); %>">
			<input type="hidden" id="access_control_02" name="access_control_02" value="<% CmoGetCfg("access_control_02","none"); %>">
			<input type="hidden" id="access_control_03" name="access_control_03" value="<% CmoGetCfg("access_control_03","none"); %>">
			<input type="hidden" id="access_control_04" name="access_control_04" value="<% CmoGetCfg("access_control_04","none"); %>">
			<input type="hidden" id="access_control_05" name="access_control_05" value="<% CmoGetCfg("access_control_05","none"); %>">
			<input type="hidden" id="access_control_06" name="access_control_06" value="<% CmoGetCfg("access_control_06","none"); %>">
			<input type="hidden" id="access_control_07" name="access_control_07" value="<% CmoGetCfg("access_control_07","none"); %>">
			<input type="hidden" id="access_control_08" name="access_control_08" value="<% CmoGetCfg("access_control_08","none"); %>">
			<input type="hidden" id="access_control_09" name="access_control_09" value="<% CmoGetCfg("access_control_09","none"); %>">
			<input type="hidden" id="access_control_10" name="access_control_10" value="<% CmoGetCfg("access_control_10","none"); %>">
			<input type="hidden" id="access_control_11" name="access_control_11" value="<% CmoGetCfg("access_control_11","none"); %>">
			<input type="hidden" id="access_control_12" name="access_control_12" value="<% CmoGetCfg("access_control_12","none"); %>">
			<input type="hidden" id="access_control_13" name="access_control_13" value="<% CmoGetCfg("access_control_13","none"); %>">
			<input type="hidden" id="access_control_14" name="access_control_14" value="<% CmoGetCfg("access_control_14","none"); %>">

			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_add3.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_add3.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">
			<input type="hidden" id="asp_temp_00" name="asp_temp_00" value="<% CmoGetCfg("asp_temp_00","none"); %>">	<!-- policy name -->
			<input type="hidden" id="asp_temp_01" name="asp_temp_01" value="<% CmoGetCfg("asp_temp_01","none"); %>">	<!-- schedule -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<% CmoGetCfg("asp_temp_14","none"); %>">	<!-- edit_row -->

			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            <div class=box>
			 <h2>Step 2: Select Schedule</h2>
		 	 <P class="box_msg">Choose a schedule to apply to this policy.</P>
				<table width="670" class=formarea>
				  <tbody>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						<td width="485">&nbsp;
						<select width="30" id="schedule" name="schedule" onChange="click_schedule();">
							<option value="Always" selected>Always</option>
							<option value="Never">Never</option>
							<script>
							document.write(set_schedule_option());
							</script>
							<option value="-1">Define a new schedule</option>
						</select>
						</td>
					  </tr>
					  <tr>
					  	<td class="duple">Details :</td>
						<td width="485">&nbsp;&nbsp;<input type="text" id="detail" name="detail" disabled size="48" maxlength="48"></td>
					  </tr>
				  </tbody>
				</table><hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
						<input name="prev" type="button" id="prev" value="Prev" onClick="return send_previous();">
						&nbsp; 
						<input name="next" type="button" id="next" value="Next" onClick="return send_next();">
						&nbsp;
						<input name="save" type="button" id="save" value="Save" onClick="return send_request();">                  
						&nbsp; 
						<input name="cancel" type="button" id="cancel" value="Cancel" onClick="exit_access()">
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
	show_save_button();
	click_schedule();
</script>
</html>