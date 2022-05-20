<html>
<head>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script>
var submit_button_flag = 0;
function onPageLoad(){
	set_checked("<% CmoGetCfg("wan_pppoe_dynamic_00","none"); %>", get_by_name("wan_pppoe_dynamic_00"));
	set_checked("<% CmoGetCfg("wan_pppoe_connect_mode_00","none"); %>", get_by_name("wan_pppoe_connect_mode_00"));
//	set_mac(get_by_id("wan_mac").value);
	check_connectmode();
	disable_poe_ip();
	set_form_default_values("form1");	
}

function clone_mac_action(){
	get_by_id("wan_mac").value = get_by_id("mac_clone_addr").value;
}

function disable_poe_ip(){
		var fixIP = get_by_name("wan_pppoe_dynamic_00");
		var is_disabled;
				  
	  	if (fixIP[0].checked){
	    	is_disabled = true;
	  	}else{
	    	is_disabled = false;
	    }
	  	get_by_id("wan_pppoe_ipaddr_00").disabled = is_disabled;
	  	//get_by_id("wan_primary_dns").disabled = is_disabled;
	  	//get_by_id("wan_secondary_dns").disabled = is_disabled;
	}
		
    function set_poe_dynamic(type){
    	var fixIP = get_by_name("wan_pppoe_dynamic_00");
        if (type == 0){
            fixIP[0].checked = true;
            get_by_id("wan_pppoe_ipaddr_00").value = "0.0.0.0";	           
        }
    }
    
function check_connectmode(){
	var conn_mode = get_by_name("wan_pppoe_connect_mode_00");
	var idle_time = get_by_id("wan_pppoe_max_idle_time_00");
	idle_time.disabled = !conn_mode[1].checked;
}
    
function send_pppoe_request(){
    	get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;
    	var is_modify = is_form_modified("form1");
    	if (!is_modify && !confirm(msg[FORM_MODIFIED_CHECK])) {
			return false;
		}
    	var fixIP = get_by_name("wan_pppoe_dynamic_00");
    	var ip = get_by_id("wan_pppoe_ipaddr_00").value;
    	var dns1 = get_by_id("wan_primary_dns").value;
    	var dns2 = get_by_id("wan_secondary_dns").value;
    	var idle = get_by_id("wan_pppoe_max_idle_time_00").value;	    	
        var mtu = get_by_id("wan_pppoe_mtu").value;
        var user_name = get_by_id("wan_pppoe_username_00").value;
        
        var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
		var primary_dns_msg = replace_msg(all_ip_addr_msg,"Primary DNS");
		var second_dns_msg = replace_msg(all_ip_addr_msg,"Secondary DNS");
		var max_idle_msg = replace_msg(check_num_msg, "Idle Time", 0, 9999);
		var mtu_msg = replace_msg(check_num_msg, "MTU", 200, 1492);
        
        var temp_ip = new addr_obj(ip.split("."), ip_addr_msg, false, false);
        var temp_dns1 = new addr_obj(dns1.split("."), primary_dns_msg, true, false);
	    var temp_dns2 = new addr_obj(dns2.split("."), second_dns_msg, true, false);
        var temp_idle = new varible_obj(idle, max_idle_msg, 0, 9999, false);
        var temp_mtu = new varible_obj(mtu, mtu_msg, 200, 1492, false);
        if (fixIP[1].checked){
        	if (!check_address(temp_ip)){
        		return false;
        	}
        }
        
    	if (dns2 != "" && dns2 != "0.0.0.0"){
    		if (!check_address(temp_dns2)){
    			return false;
    		}
    	}
    	
    	 if(user_name == ""){
    		alert("A PPPoE user name MUST be specified");	//GW_WAN_PPPOE_USERNAME_INVALID
    		return false;
	     }
	     
	     if (get_by_id("poe_pass_s").value == "" || get_by_id("poe_pass_v").value == ""){
		 	alert("A PPPoE password MUST be specified");	//GW_WAN_PPPOE_PASSWORD_INVALID
			return false;
		}
		
    	if (!check_pwd("poe_pass_s", "poe_pass_v")){
       		return false;
       	}
        	
       	if (!check_varible(temp_idle)){
    		return false;
    	}
    	
    	if (!check_varible(temp_mtu)){
    		return false;
    	}
    	
    	/*
		 * Validate MAC and activate cloning if necessary
		 */			
		var clonemac = get_by_id("wan_mac").value; 
		if (!check_mac(clonemac)){
			alert(msg[MAC_ADDRESS_ERROR]);
			return false;
		} 
		 
		var mac = trim_string(get_by_id("wan_mac").value);
		if(!is_mac_valid(mac, true)) {
			alert ("Invalid MAC address:" + mac + ".");
			return false;
		}else{
			get_by_id("wan_mac").value = mac;
		}
				
        if (dns1 != "" && dns1 != "0.0.0.0"){
    		if (!check_address(temp_dns1)){
    			return false;
    		}
    	}
    	
    	
		if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
			get_by_id("wan_specify_dns").value = 0;
		}else{
			get_by_id("wan_specify_dns").value = 1;
		}
		get_by_id("wan_pppoe_russia_enable").value ="0";
		if(submit_button_flag == 0){
			if(get_by_id("poe_pass_s").value !="WDB8WvbXdH"){
				get_by_id("wan_pppoe_password_00").value = get_by_id("poe_pass_s").value;
			}
			/*
			if(is_modify || get_by_id("asp_temp_51").value.length > 0){
				get_by_id("asp_temp_51").value = "wan";
				get_by_id("html_response_page").value = "wan_reboot_need.asp";
			}else{
				window.location.href = get_by_id("html_response_page").value;
			}
			*/
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
}

</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">

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
		<tr>
			<td align="center" valign="middle"><img src="wlan_masthead.gif" width="836" height="92"></td>
		</tr>
	</table>
	<table border="0" cellpadding="2" cellspacing="1" width="838" align="center" bgcolor="#FFFFFF">
		<tr id="topnav_container">
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavon"><a href="index.asp" onclick="return jump_if();">SETUP</a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();">ADVANCED</a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();">TOOLS</a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();">SUPPORT</a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
								<ul>
									<li><div id="sidenavoff">INTERNET</div></li>
									<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();">WIRELESS SETTINGS</a></div></li>
									<li><div id="sidenavon"><a href="lan.asp" onclick="return jump_if();">NETWORK SETTINGS</a></div></li>

								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">			
			<form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_poe.asp">
				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">
				<input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<% CmoGetCfg("wan_specify_dns","none"); %>">  
				<input type="hidden" id="wan_pppoe_password_00" name="wan_pppoe_password_00" value="WDB8WvbXdHtZyM8Ms2RENgHlacJghQyG">
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<% CmoGetCfg("asp_temp_51","none"); %>">
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<% CmoGetCfg("wan_proto","none"); %>">
				<input type="hidden" id="reboot_type" name="reboot_type" value="wan">
				<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<% CmoGetCfg("wan_pppoe_russia_enable","none"); %>">
			<div id=maincontent>
			  <!-- === BEGIN MAINCONTENT === -->
              <div id=box_header>
                <h1>WAN</h1>
                <p>Use this section to configure your Internet Connection type. There are several connection types to choose from: Static IP, DHCP, PPPoE, PPTP, L2TP, Russia PPTP, Russia PPPoE and  Russia L2TP. If you are unsure of your connection method, please contact your Internet Service Provider.</p>
                <p><strong>Note:&nbsp;</strong>If using the PPPoE option, you will need to remove or disable any PPPoE client software on your computers.</p>
                <input name="button" type="submit" class=button_submit value="Save Settings" onClick="return send_pppoe_request()">
                <input name="button2" type=reset class=button_submit value="Don't Save Settings" onClick="page_cancel('form1', 'sel_wan.asp');">
              </div>
              <div class=box>
                <h2>Internet Connection Type</h2>
                <p class="box_msg">Choose the mode to be used by the router to connect to the Internet.</p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="185" class="duple">My Internet Connection is :</td>
                      <td width="331">&nbsp; <select name="wan_proto" id="wan_proto" onChange="change_wan()">
                        <option value="static">Static IP</option>
                        <option value="dhcpc">Dynamic IP (DHCP)</option>
                        <option value="pppoe" selected>PPPoE (Username / Password)</option>
                        <option value="pptp">PPTP (Username / Password)</option>
                        <option value="l2tp">L2TP (Username / Password)</option>
                         <!--option value="bigpond">BigPond (Australia)</option-->
						<option value="pptp">Russia PPTP (Dual Access)</option>
                        <option value="pppoe">Russia PPPoE (Dual Access)</option>
                        <option value="l2tp">Russia L2TP (Dual Access)</option>
                      </select></td>
                    </tr>
                </table>
              </div>
              <div class=box id=show_poe >
                <h2>PPPoE : </h2>
				<p class="box_msg">Enter the information provided by your Internet Service Provider (ISP). </p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td width="185" align=right class="duple">Address Mode</td>
                      <td width="331">&nbsp;
                      	<input type="radio" name="wan_pppoe_dynamic_00" value="1" onClick="disable_poe_ip()" checked>
						    Dynamic IP
						<input type="radio" name="wan_pppoe_dynamic_00" value="0" onClick="disable_poe_ip()">
						    Static IP
					  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">IP Address :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pppoe_ipaddr_00" name="wan_pppoe_ipaddr_00" size="20" maxlength="15" value="<% CmoGetCfg("wan_pppoe_ipaddr_00","none"); %>">
					  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">User Name :</td>
                      <td>&nbsp;
                          <input type=text id="wan_pppoe_username_00" name="wan_pppoe_username_00" size="20" maxlength="63" value="<% CmoGetCfg("wan_pppoe_username_00","none"); %>">
					  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">Password :</td>
                      <td>&nbsp;
                      	<input type=password id="poe_pass_s" name="poe_pass_s" size="20" maxlength="63" value="WDB8WvbXdH">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">Verify Password : </td>
                      <td>&nbsp;
                      	<input type=password id=poe_pass_v name=poe_pass_v size="20" maxlength="63" value="WDB8WvbXdH">
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">Service Name :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pppoe_service_00" name="wan_pppoe_service_00" size="30" maxlength="39" value="<% CmoGetCfg("wan_pppoe_service_00","none"); %>">(optional)
    				  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">Reconnect Mode :</td>
                      <td>&nbsp;
	                      <input type=radio name="wan_pppoe_connect_mode_00" value="always_on" onClick="check_connectmode()">
	    					Always on
	    				  <input type=radio name="wan_pppoe_connect_mode_00" value="on_demand" onClick="check_connectmode()">
	    					On demand
	    				  <input type=radio name="wan_pppoe_connect_mode_00" value="manual" onClick="check_connectmode()">
	    					Manual
	    			   </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">Maximum Idle Time :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pppoe_max_idle_time_00" name="wan_pppoe_max_idle_time_00" size="10" maxlength="5" value="<% CmoGetCfg("wan_pppoe_max_idle_time_00","none"); %>">
    					(minutes, 0=infinite)
    				  </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">Primary DNS Address :</td>
                      <td>&nbsp;
	                      <input type=text id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<% CmoGetCfg("wan_primary_dns","none"); %>">
	                      (optional)
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">Secondary DNS Address :</td>
                      <td>&nbsp;
	                      <input type=text id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<% CmoGetCfg("wan_secondary_dns","none"); %>">
	                      (optional)
                      </td>
                    </tr>
                    <tr>
                      <td align=right class="duple">MTU :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_pppoe_mtu" name="wan_pppoe_mtu" size="10" maxlength="5" value="<% CmoGetCfg("wan_pppoe_mtu","none"); %>">
                  (bytes) MTU default = 1492 </td>
                    </tr>
                    <tr>
                      <td width=150 valign=top class="duple">MAC Address :</td>
                      <td>&nbsp;
                      	<input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value="<% CmoGetCfg("wan_mac","none"); %>"><br>
                      	&nbsp;<input name="clone" type="button" value="Clone Your PC's MAC Address" onClick="clone_mac_action()">
					  </td>
                    </tr>
                </table>
        </div>
		</div>
	</form>
   </td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      <td id=help_text><strong>Helpful Hints&hellip;</strong>
                          <p>When configuring the router to access the Internet, be sure to choose the correct <strong>Internet Connection Type</strong> from the drop down menu. If you are unsure of which option to choose, contact your <strong>Internet Service Provider (ISP)</strong>.</p>
                          <p>If you are having trouble accessing the Internet through the router, double check any settings you have entered on this page and verify them with your ISP if needed.</p>
                          <p class="more"><a href="support_internet.asp#WAN" onclick="return jump_if();">More&hellip;</a></p>
					  </td>
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
</script>
<!-- insert name=restore_wan_type -->
</html>