<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 32;
	var resert_rule = rule_max_num;
	var DataArray = new Array();
	
	//0/name/192.168.31.0/255.255.255.0/192.168.31.1/192.168.31.1/20
	function Data(enable, name, ip_addr, net_mask, gateway, interface, metric, onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.Net_mask = net_mask;
		this.Gateway = gateway;
		this.Interface = interface;
		this.Metric = metric;
		this.OnList = onList ;
	}
	
	function set_routes(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_st;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("static_routing_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[1] != "name" && temp_st[0] != ""){
					DataArray[DataArray.length++] = new Data(temp_st[0],temp_st[1], temp_st[2], temp_st[3],temp_st[4],temp_st[5],temp_st[6],temp_st[7], index);
					index++;
				}
			}
		}
		
		
	}

	function send_request(){
		if (!is_form_modified("form1") && !confirm("Nothing has changed, save anyway?")) {
			return false;
		}
		var count = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_mac;
		
			if (i > 9){
				get_by_id("static_routing_" + i).value = "";
			}else{
				get_by_id("static_routing_0" + i).value = "";
			}
			
			if (get_by_id("Destination" + i).value == "" ){
				get_by_id("Destination" + i).value="0.0.0.0";
			}
			
			if (get_by_id("Sub_Mask" + i).value == "" ){
				get_by_id("Sub_Mask" + i).value="0.0.0.0";
			}

			if (get_by_id("Sub_gateway" + i).value == ""){
				get_by_id("Sub_gateway" + i).value="0.0.0.0";
			}
			
			
			if (get_by_id("Destination" + i).value != "" && get_by_id("Sub_Mask" + i).value != "" && get_by_id("Sub_gateway" + i).value != ""){
				var static_ip = get_by_id("Destination" + i).value;
    			var static_mask = get_by_id("Sub_Mask" + i).value;
    			var static_gateway = get_by_id("Sub_gateway" + i).value;
    			var metric = get_by_id("metric"+ i).value;
    			
    			var ip_addr_msg = replace_msg(all_ip_addr_msg,"IP address");
    			var gateway_msg = replace_msg(all_ip_addr_msg,"Gateway address");
    			
    			var static_ip_obj = new addr_obj(static_ip.split("."), ip_addr_msg, false, true);
				var static_mask_obj = new addr_obj(static_mask.split("."), subnet_mask_msg, false, false);
				var static_gateway_obj = new addr_obj(static_gateway.split("."), gateway_msg, false, true);
				var temp_metric = new varible_obj(metric, metric_msg, 1, 15, false);
				
				// Don't check subnet and ip		
				//if(!check_route_mask(static_mask_obj)){
					//return false;   // when subnet mask is not in the subnet mask range
				//}else if(!check_network_address(static_ip_obj, static_mask_obj)){
					//return false;		// when ip is invalid
				//}else if(!check_address(static_gateway_obj)){
					//return false;	// when gateway is invalid
				//}
				if(get_by_id("enable" + i).checked){
					if (!check_address(static_gateway_obj)){
						return false;	// when gateway is invalid
					}
				}
					
				if (!check_varible(temp_metric)){
					return false;
    			}
    			
				for(jj=i+1;jj<rule_max_num;jj++){
					if((get_by_id("Destination" + jj).value==static_ip) && (get_by_id("interface" + jj).value==static_gateway)){
						alert("The static routes table has the same router rule.\n");;
						return false;
						break;
					}
				}
    			
				if (count > 9){
					temp_mac = get_by_id("static_routing_" + count);
				}else{
					temp_mac = get_by_id("static_routing_0" + count);
				}
				
				temp_mac.value = get_checked_value(get_by_id("enable"+i))+"/"+ get_by_id("name" + i).value +"/"
								+ get_by_id("Destination" + i).value + "/"+ get_by_id("Sub_Mask" + i).value +"/"
								+ get_by_id("Sub_gateway" + i).value +"/"+ get_by_id("interface" + i).value + "/"+get_by_id("metric" + i).value;
				count++;			
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
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
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
                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();">Access control</a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();">Website Filter</a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();">Inbound Filter</a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();">Firewall Settings</a></div></LI>
							<LI><div id=sidenavoff>Routing</div></LI>
							<LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();">Advanced Wireless </a></div></LI>
							<@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();">Advanced Network </a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                            
                           
                          </UL>
                      	</div>
                      	<br>
						<div id="wan_online" style="display:none"> </div>
              <div id="wan_offline"> </div>
						<br>
            </td>
                    </tr>
                  </tbody>
                </table></td>

                <form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_routing.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
                
                
                <!-- New Variable -->
				<input type="hidden" id="static_routing_00" name="static_routing_00" value="<% CmoGetCfg("static_routing_00","none"); %>">
				<input type="hidden" id="static_routing_01" name="static_routing_01" value="<% CmoGetCfg("static_routing_01","none"); %>">
				<input type="hidden" id="static_routing_02" name="static_routing_02" value="<% CmoGetCfg("static_routing_02","none"); %>">
				<input type="hidden" id="static_routing_03" name="static_routing_03" value="<% CmoGetCfg("static_routing_03","none"); %>">
				<input type="hidden" id="static_routing_04" name="static_routing_04" value="<% CmoGetCfg("static_routing_04","none"); %>">
				<input type="hidden" id="static_routing_05" name="static_routing_05" value="<% CmoGetCfg("static_routing_05","none"); %>">
				<input type="hidden" id="static_routing_06" name="static_routing_06" value="<% CmoGetCfg("static_routing_06","none"); %>">
				<input type="hidden" id="static_routing_07" name="static_routing_07" value="<% CmoGetCfg("static_routing_07","none"); %>">
				<input type="hidden" id="static_routing_08" name="static_routing_08" value="<% CmoGetCfg("static_routing_08","none"); %>">
				<input type="hidden" id="static_routing_09" name="static_routing_09" value="<% CmoGetCfg("static_routing_09","none"); %>">
				<input type="hidden" id="static_routing_10" name="static_routing_10" value="<% CmoGetCfg("static_routing_10","none"); %>">
				<input type="hidden" id="static_routing_11" name="static_routing_11" value="<% CmoGetCfg("static_routing_11","none"); %>">
				<input type="hidden" id="static_routing_12" name="static_routing_12" value="<% CmoGetCfg("static_routing_12","none"); %>">
				<input type="hidden" id="static_routing_13" name="static_routing_13" value="<% CmoGetCfg("static_routing_13","none"); %>">
				<input type="hidden" id="static_routing_14" name="static_routing_14" value="<% CmoGetCfg("static_routing_14","none"); %>">
				<input type="hidden" id="static_routing_15" name="static_routing_15" value="<% CmoGetCfg("static_routing_15","none"); %>">
				<input type="hidden" id="static_routing_16" name="static_routing_16" value="<% CmoGetCfg("static_routing_16","none"); %>">
				<input type="hidden" id="static_routing_17" name="static_routing_17" value="<% CmoGetCfg("static_routing_17","none"); %>">
				<input type="hidden" id="static_routing_18" name="static_routing_18" value="<% CmoGetCfg("static_routing_18","none"); %>">
				<input type="hidden" id="static_routing_19" name="static_routing_19" value="<% CmoGetCfg("static_routing_19","none"); %>">
				<input type="hidden" id="static_routing_20" name="static_routing_20" value="<% CmoGetCfg("static_routing_20","none"); %>">
				<input type="hidden" id="static_routing_21" name="static_routing_21" value="<% CmoGetCfg("static_routing_21","none"); %>">
				<input type="hidden" id="static_routing_22" name="static_routing_22" value="<% CmoGetCfg("static_routing_22","none"); %>">
				<input type="hidden" id="static_routing_23" name="static_routing_23" value="<% CmoGetCfg("static_routing_23","none"); %>">
				<input type="hidden" id="static_routing_24" name="static_routing_24" value="<% CmoGetCfg("static_routing_24","none"); %>">
				<input type="hidden" id="static_routing_25" name="static_routing_25" value="<% CmoGetCfg("static_routing_25","none"); %>">
				<input type="hidden" id="static_routing_26" name="static_routing_26" value="<% CmoGetCfg("static_routing_26","none"); %>">
				<input type="hidden" id="static_routing_27" name="static_routing_27" value="<% CmoGetCfg("static_routing_27","none"); %>">
				<input type="hidden" id="static_routing_28" name="static_routing_28" value="<% CmoGetCfg("static_routing_28","none"); %>">
				<input type="hidden" id="static_routing_29" name="static_routing_29" value="<% CmoGetCfg("static_routing_29","none"); %>">
				<input type="hidden" id="static_routing_30" name="static_routing_30" value="<% CmoGetCfg("static_routing_30","none"); %>">
				<input type="hidden" id="static_routing_31" name="static_routing_31" value="<% CmoGetCfg("static_routing_31","none"); %>">
				<input type="hidden" id="static_routing_32" name="static_routing_32" value="<% CmoGetCfg("static_routing_32","none"); %>">
				<input type="hidden" id="static_routing_33" name="static_routing_33" value="<% CmoGetCfg("static_routing_33","none"); %>">
				<input type="hidden" id="static_routing_34" name="static_routing_34" value="<% CmoGetCfg("static_routing_34","none"); %>">
				<input type="hidden" id="static_routing_35" name="static_routing_35" value="<% CmoGetCfg("static_routing_35","none"); %>">
				<input type="hidden" id="static_routing_36" name="static_routing_36" value="<% CmoGetCfg("static_routing_36","none"); %>">
				<input type="hidden" id="static_routing_37" name="static_routing_37" value="<% CmoGetCfg("static_routing_37","none"); %>">
				<input type="hidden" id="static_routing_38" name="static_routing_38" value="<% CmoGetCfg("static_routing_38","none"); %>">
				<input type="hidden" id="static_routing_39" name="static_routing_39" value="<% CmoGetCfg("static_routing_39","none"); %>">
				<input type="hidden" id="static_routing_40" name="static_routing_40" value="<% CmoGetCfg("static_routing_40","none"); %>">
				<input type="hidden" id="static_routing_41" name="static_routing_41" value="<% CmoGetCfg("static_routing_41","none"); %>">
				<input type="hidden" id="static_routing_42" name="static_routing_42" value="<% CmoGetCfg("static_routing_42","none"); %>">
				<input type="hidden" id="static_routing_43" name="static_routing_43" value="<% CmoGetCfg("static_routing_43","none"); %>">
				<input type="hidden" id="static_routing_44" name="static_routing_44" value="<% CmoGetCfg("static_routing_44","none"); %>">
				<input type="hidden" id="static_routing_45" name="static_routing_45" value="<% CmoGetCfg("static_routing_45","none"); %>">
				<input type="hidden" id="static_routing_46" name="static_routing_46" value="<% CmoGetCfg("static_routing_46","none"); %>">
				<input type="hidden" id="static_routing_47" name="static_routing_47" value="<% CmoGetCfg("static_routing_47","none"); %>">
				<input type="hidden" id="static_routing_48" name="static_routing_48" value="<% CmoGetCfg("static_routing_48","none"); %>">
				<input type="hidden" id="static_routing_49" name="static_routing_49" value="<% CmoGetCfg("static_routing_49","none"); %>">

                
				<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
				
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  <div id=box_header>
                    <h1><!--#tr tag='.routing' -->ROUTING :</h1>
                    <p><!--#tr tag='av.intro.r' -->This Routing page allows you to specify custom routes that determine how data is moved around your network.<!--#endtr --></p>
                    <br>
                    <input name="button" type="submit" class=button_submit value="Save Settings" onClick="return send_request()">
                    <input name="button2" type=button class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'adv_routing.asp');">
                  </div>
                  <a name="show_list"></a>
                  <div class=box>
                    <h2>32 --<!--#tr tag='r.rlist' -->ROUTE LIST<!--#endtr --></h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                      <tbody>
                        <tr>
                          <td align=center width=20>&nbsp;</td>
                          <td align=center>&nbsp;</td>
                  		  <td align=center>&nbsp;</td>
                          <td align=center><!--#tr tag='.metric' -->Metric<!--#endtr --></td>
						  <td align=center><!--#tr tag='.interface' -->Interface<!--#endtr --></td>
						</tr>
						
                        <script>
							set_routes();
							for(var i=0 ; i<rule_max_num ; i++){
								var is_checked = "";
								var obj_Name = "";
								var obj_IP = "";
								var obj_Mask = "";
								var obj_gateway = "";
								var obj_interface = "WAN";
								var obj_metric = "";
								if(i < DataArray.length){
									obj_Name = DataArray[i].Name;
									obj_IP = DataArray[i].Ip_addr;
									obj_Mask = DataArray[i].Net_mask;
									obj_gateway = DataArray[i].Gateway;
									obj_interface = DataArray[i].Interface;
									obj_metric = DataArray[i].Metric;
								}
								document.write("<tr>")
								document.write("<td align=center rowspan=2><input type=\"checkbox\" id=\"enable" + i + "\" name=\"enable" + i + "\" value=\"1\"></td>")
								document.write("<td>Name<br><input type=\"text\" class=flatL id=\"name" + i + "\" name=\"name" + i + "\" size=16 maxlength=15 value=\""+ obj_Name +"\"></td>")
								document.write("<td>Destination IP<br><input type=\"text\" class=flatL id=\"Destination" + i + "\" name=\"Destination" + i + "\" size=16 maxlength=15 value=\""+ obj_IP +"\"></td>")
								document.write("<td align=center rowspan=2><input type=\"text\" class=flatL id=\"metric" + i + "\" name=\"metric" + i + "\" size=16 maxlength=15 value=\""+ obj_metric +"\"></td>")
								document.write("<td align=center rowspan=2>&nbsp;");
								document.write("<select style='width:90' id=\"interface" + i +"\" name=\"interface" + i +"\">");
								document.write("<option value=\"WAN\">WAN</option>");
								document.write("</select></td>");
								document.write("</tr>")
								
								document.write("<tr>")
								document.write("<td>Netmask<br><input type=\"text\" class=flatL id=\"Sub_Mask" + i + "\" name=\"Sub_Mask" + i + "\" size=16 maxlength=15 value=\""+ obj_Mask +"\"></td>")
								document.write("<td>gateway<br><input type=\"text\" class=flatL id=\"Sub_gateway" + i + "\" name=\"Sub_gateway" + i + "\" size=16 maxlength=15 value=\""+ obj_gateway +"\"></td>")
								
								document.write("</tr>")
								
								
								if(i < DataArray.length){
									set_checked(DataArray[i].Enable, get_by_id("enable"+i));
									set_selectIndex(DataArray[i].Interface, get_by_id("interface"+i));
								}
							}
						  </script> 
                      </tbody>
                    </table>
                  </div>             
			  </div>
			 
      </td>
			  </form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table borderColor=#ffffff cellSpacing=0 borderColorDark=#ffffff 
      cellPadding=2 bgColor=#ffffff borderColorLight=#ffffff border=0>
                  <tbody>
                    <tr>
                      <td id=help_text><b>Helpful Hints..</b><br>
                          <p>
                <!--#tr tag='hhav.enable' -->
                Each route has a check box next to it, check this box if you want 
                the route to be enabled.
                <!--#endtr -->
              </p>
              <p>
                <!--#tr tag='hhav.r_name' -->
                The name field allows you to specify a name for identification 
                of this route, e.g. 'Network 2'
                <!--#endtr -->
              </p>
              <p>
                <!--#tr tag='hhav.r_dest_ip' -->
                The destination IP address is the address of the host or network 
                you wish to reach.
                <!--#endtr -->
              </p>
              <p>
                <!--#tr tag='hhav.r_netmask' -->
                The netmask field identifies the portion of the destination IP 
                in use.
                <!--#endtr -->
              </p>
              <p>
                <!--#tr tag='hhav.r_gateway' -->
                The gateway IP address is the IP address of the router, if any, 
                used to reach the specified destination.
                <!--#endtr -->
              </p>
              <p class="more"><a href="support_adv.asp#Routing" onclick="return jump_if();">More&hellip;</a></p>
              
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
<script>
set_form_default_values("form1");
</script>
</body>
</html>
