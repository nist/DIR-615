<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
var rule_max_num = 24;
var resert_rule = rule_max_num;
var DHCPL_DataArray = new Array();
function onPageLoad(){
	set_selectIndex("<% CmoGetCfg("mac_filter_type","none"); %>", get_by_id("mac_filter_type"));
	disable_mac_filter();
}
function DHCP_Data(name, ip, mac, Exp_time, onList) 
{
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.EXP_T = Exp_time;
	this.OnList = onList;
}

function set_mac_filter(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_mf;
			
			if (i > 9){
				temp_mf = (get_by_id("mac_filter_" + i).value).split("/");
			}else{
				temp_mf = (get_by_id("mac_filter_0" + i).value).split("/");		
			}
			
			if (temp_mf.length > 1){
				//set_checked(temp_mf[0],get_by_id("entry_enable_"+i));
				get_by_id("mac" + i).value = temp_mf[2];
				//set_selectIndex(temp_mf[3], get_by_id("schedule" + i));
				if(temp_mf[2].length > 0 && temp_mf[2] !="00:00:00:00:00:00"){
					resert_rule--;
				}
			}
		}
		//get_by_id("show_resert").innerHTML = "<font color=\"red\">"+ resert_rule +"</font>";
}

	function disable_mac_filter(){
		var mac_filter_type = get_by_id("mac_filter_type").selectedIndex;
		for (var i = 0; i < rule_max_num; i++){
			get_by_id("mac" + i).disabled = !(mac_filter_type != 0);
			get_by_id("copy" + i).disabled = !(mac_filter_type != 0);
			get_by_id("dhcp_list" + i).disabled = !(mac_filter_type != 0);
			get_by_id("clear" + i).disabled = !(mac_filter_type != 0);
		}
	}

	function copy_mac(index){
		if (get_by_id("dhcp_list" + index).selectedIndex > 0){
			get_by_id("mac" + index).value = get_by_id("dhcp_list" + index).options[get_by_id("dhcp_list" + index).selectedIndex].value;
		}else{
			alert(msg[SELECT_MACHINE_ERROR]);
		}
	}

	function clear_mac(index){
		get_by_id("mac" + index).value = "00:00:00:00:00:00";
	}
	
	function check_dhcp_ip(index){
		var index = 0;
		var mac = get_by_id("dhcp_list" + index).options[get_by_id("dhcp_list" + index).selectedIndex].value;
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		for (var i = 0; i < temp_dhcp_list.length; i++){	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length > 1){
				DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
				//check selected mac equal to mac or not?
				index++;
					if(mac == temp_data[2]){
						var lan_ip = "<% CmoGetCfg("lan_ipaddr","none"); %>";
						var lan_ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
						var temp_lan_ip_obj = new addr_obj(lan_ip.split("."), lan_ip_addr_msg, false, false);
						var ip = temp_data[1];
						var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
						var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
							if(!check_LAN_ip(temp_lan_ip_obj.addr, temp_ip_obj.addr, "IP address")){
			return false;
		}
						return true;
					}
			}					  
			
			}
			return true;
	}
			
	function send_request(){
		if (!is_form_modified("form1") && !confirm("Nothing has changed, save anyway?")) {
					return false;
				}
		var lan_mac = "<% CmoGetCfg("lan_mac","none"); %>";
		var i=0;
		var mac = 0;
		var flag = 0;		
		for (var i = 0; i < rule_max_num; i++){
			var mac = get_by_id("mac" + i).value;
			if (get_by_id("mac" + i).value != ""){			
				if (mac != "00:00:00:00:00:00" && mac !=""){
					if (!check_mac(get_by_id("mac" + i).value)){
						alert(msg[MAC_ADDRESS_ERROR]);
						return false;
					}
					if (get_by_id("mac" + i).value == lan_mac ){
						alert(msg[MAC_ADDRESS_ERROR]);
						return false;
					}
					if(	!check_dhcp_ip()){
					return false;
					}
				     flag = 1;
					 continue;
				}
				for (var j = i+1; j < rule_max_num; j++){
					if (mac != "00:00:00:00:00:00" && mac !="" && mac == get_by_id("mac" + j).value){
						alert("The Access Control mac address is already in the list");
						return false;
						flag = 1;
					 	continue;
					}
					}
				}
			}
		if(flag == 0){ // Graceyang (2009.3.27) :when set mac is 00:00:00:00:00:00 should be saved  
				for(k=0; k < rule_max_num; k++){
				get_by_id("mac" + k).value = "00:00:00:00:00:00";
			}
		}		
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			if (i > 9){
				get_by_id("mac_filter_" + i).value = "0/Name/00:00:00:00:00:00/Always";
			}else{
				get_by_id("mac_filter_0" + i).value = "0/Name/00:00:00:00:00:00/Always";
			}
			
			if (get_by_id("mac" + i).value != "" && get_by_id("mac" + i).value != "00:00:00:00:00:00"){
				var dat = "1/Name/"+ get_by_id("mac" + i).value + "/Always";
				if (count > 9){
					get_by_id("mac_filter_" + count).value = dat;
				}else{
					get_by_id("mac_filter_0" + count).value = dat;
				}
				count++;			
			}		
		}
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
/*	
	function check_date(){
		var is_change = false;
		var check_mac_filter_type = "<% CmoGetCfg("mac_filter_type","none"); %>";
		if (get_by_id("mac_filter_type").value != check_mac_filter_type){
			is_change = true;
		}else if(!is_change){
			for(i=0;i<rule_max_num;i++){
				var temp_mac = "Name/00:00:00:00:00:00/Always";
				var kk = i;
				if(i<10){
					kk = "0"+i;
				}
				if (get_by_id("mac" + i).value != "" && get_by_id("mac" + i).value != "00:00:00:00:00:00"){
					temp_mac = get_checked_value(get_by_id("entry_enable_"+i)) +"/Name/"+ get_by_id("mac" + i).value + "/" + get_by_id("schedule" + i).value;
				}
				if(get_by_id("mac_filter_"+ kk).value != temp_mac){
					is_change = true;
					break;
				}
			}
		}
		if(is_change){
			if (!confirm(msg[IS_CHANGE_DATA])){
				return false;
			}
		}
		location.href="tools_schedules.asp";
	}
*/
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
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();">QOS Engine</a></div></LI>
                            <LI><div id=sidenavoff>Network Filter</div></LI>
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
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_filters_mac.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="all">
                <input type="hidden" id="mac_filter_00" name="mac_filter_00" value="<% CmoGetCfg("mac_filter_00","none"); %>">
                <input type="hidden" id="mac_filter_01" name="mac_filter_01" value="<% CmoGetCfg("mac_filter_01","none"); %>">
                <input type="hidden" id="mac_filter_02" name="mac_filter_02" value="<% CmoGetCfg("mac_filter_02","none"); %>">
                <input type="hidden" id="mac_filter_03" name="mac_filter_03" value="<% CmoGetCfg("mac_filter_03","none"); %>">
                <input type="hidden" id="mac_filter_04" name="mac_filter_04" value="<% CmoGetCfg("mac_filter_04","none"); %>">
                <input type="hidden" id="mac_filter_05" name="mac_filter_05" value="<% CmoGetCfg("mac_filter_05","none"); %>">
                <input type="hidden" id="mac_filter_06" name="mac_filter_06" value="<% CmoGetCfg("mac_filter_06","none"); %>">
                <input type="hidden" id="mac_filter_07" name="mac_filter_07" value="<% CmoGetCfg("mac_filter_07","none"); %>">
                <input type="hidden" id="mac_filter_08" name="mac_filter_08" value="<% CmoGetCfg("mac_filter_08","none"); %>">
                <input type="hidden" id="mac_filter_09" name="mac_filter_09" value="<% CmoGetCfg("mac_filter_09","none"); %>">
                <input type="hidden" id="mac_filter_10" name="mac_filter_10" value="<% CmoGetCfg("mac_filter_10","none"); %>">
                <input type="hidden" id="mac_filter_11" name="mac_filter_11" value="<% CmoGetCfg("mac_filter_11","none"); %>">
                <input type="hidden" id="mac_filter_12" name="mac_filter_12" value="<% CmoGetCfg("mac_filter_12","none"); %>">
                <input type="hidden" id="mac_filter_13" name="mac_filter_13" value="<% CmoGetCfg("mac_filter_13","none"); %>">
                <input type="hidden" id="mac_filter_14" name="mac_filter_14" value="<% CmoGetCfg("mac_filter_14","none"); %>">
                <input type="hidden" id="mac_filter_15" name="mac_filter_15" value="<% CmoGetCfg("mac_filter_15","none"); %>">
                <input type="hidden" id="mac_filter_16" name="mac_filter_16" value="<% CmoGetCfg("mac_filter_16","none"); %>">
                <input type="hidden" id="mac_filter_17" name="mac_filter_17" value="<% CmoGetCfg("mac_filter_17","none"); %>">
                <input type="hidden" id="mac_filter_18" name="mac_filter_18" value="<% CmoGetCfg("mac_filter_18","none"); %>">
                <input type="hidden" id="mac_filter_19" name="mac_filter_19" value="<% CmoGetCfg("mac_filter_19","none"); %>">
                <input type="hidden" id="mac_filter_20" name="mac_filter_20" value="<% CmoGetCfg("mac_filter_20","none"); %>">
                <input type="hidden" id="mac_filter_21" name="mac_filter_21" value="<% CmoGetCfg("mac_filter_21","none"); %>">
                <input type="hidden" id="mac_filter_22" name="mac_filter_22" value="<% CmoGetCfg("mac_filter_22","none"); %>">
                <input type="hidden" id="mac_filter_23" name="mac_filter_23" value="<% CmoGetCfg("mac_filter_23","none"); %>">
                <input type="hidden" id="mac_filter_24" name="mac_filter_24" value="<% CmoGetCfg("mac_filter_24","none"); %>">
                
				<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
				
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  <div id=box_header>
                    <h1>MAC Address Filter</h1>
                    The MAC (Media Access Controller) Address filter option is used to control network access based on the MAC Address of the network adapter. A MAC address is a unique ID assigned by the manufacturer of the network adapter. This feature can be configured to ALLOW or DENY network/Internet access.
                    <br><br>
                    <input name="button" type="button" class=button_submit value="Save Settings" onClick="send_request()">
                    <input name="button2" type=button class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'adv_filters_mac.asp');">
                  </div>
                  <div class=box>
                    <h2><script>document.write(rule_max_num)</script> &ndash;&ndash; MAC Filtering Rules</h2>
                    <table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tbody>
                        <tr>
                          <td>Configure MAC Filtering below:</td>
                        </tr>
                        <tr>
                          <td>
						  <select id="mac_filter_type" name="mac_filter_type" onChange="disable_mac_filter();">
                              <option value="disable">Turn MAC Filtering OFF</option>
                              <option value="list_allow">Turn MAC Filtering ON and ALLOW computers listed to access the network</option>
                              <option value="list_deny">Turn MAC Filtering ON and DENY computers listed to access the network</option>
                            </select>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td width="100" align=left><strong>MAC Address</strong></td>
                          <td>&nbsp;</td>
                          <td width="250" align=left><strong>DHCP Client List</strong></td>
                          <td>&nbsp;</td>
                        </tr>
                        <script>
							//var Schedule_list = set_schedule_option(Schedule_list);
							for(var i=0 ; i<rule_max_num ; i++){
								document.write("<tr>")
								//document.write("<td align=\"middle\"><INPUT type=\"checkbox\" id=\"entry_enable_"+ i +"\" id=\"entry_enable_"+ i +"\" value=\"1\"></td>")
								document.write("<td><input type=text class=flatL id=mac" + i + " name=mac" + i + " size=20 maxlength=17><input type=hidden id=name" + i + " name=name" + i + " maxlength=31></td>")
								document.write("<td><input type=button id=copy" + i + " name=copy" + i + " value=<< class=btnForCopy onClick='copy_mac(" + i + ")'></td>");
                        	
								document.write("<td width=155> <select class=wordstyle width=140 id=dhcp_list" + i + " name=dhcp_list" + i + " modified=\"ignore\">")
								document.write("<option value=-1>Computer Name</option>")
								document.write(set_mac_list("mac"))
								document.write("</select></td>")
								document.write("<td align=center>");
								document.write("<input type=button id=clear" + i + " name=clear" + i + " value=Clear onClick='clear_mac(" + i + ")'>");
								document.write("</td>");
								document.write("</tr>")
							}
						  </script> 
                      </tbody>
                    </table>
                  </div>             
			  </div></td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b>Helpful Hints&hellip;</b>
                        <p>Create a list of MAC addresses that you would either like to allow or deny access to your network.</p>
                        <p>Computers that have obtained an IP address from the router's DHCP server will be in the DHCP Client List. Select a device from the drop down menu, then click the arrow to add that device's MAC address to the list.</p>
                        <p>Click the <strong>Clear</strong> button to remove the MAC address from the MAC Filtering list.</p>
						<p><a href="support_adv.asp#MAC_Address_Filter" onclick="return jump_if();">More&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
</body>
<script>
 onPageLoad();
 set_mac_filter();
 set_form_default_values("form1");
</script>
</html>
