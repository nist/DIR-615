<html>
<head>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">	
	var DHCPList_word = "";
	var DHCPL_DataArray = new Array();
	
	function DHCP_Data(name, ip, mac, Exp_time, onList){
		this.Name = name;
		this.IP = ip;
		this.MAC = mac;
		this.EXP_T = Exp_time;
		this.OnList = onList ;
	}
	
	function set_lan_dhcp_list(){
		var index = 0;
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		for (var i = 0; i < temp_dhcp_list.length; i++){	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length > 1){
				DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3],index);
				DHCPList_word = DHCPList_word+ "<option value=\""+ index +"\">" + temp_data[0] + "</option>";
				index++;
			}
		}
	}
	
	function print_dhcp_sel(){
		var print_sel = get_by_id("sys_dhcp").value;
		if(print_sel > -1){
			get_by_id("sys_server").value = DHCPL_DataArray[print_sel].IP;
		}
	}
	
	function onPageLoad(){
		//Syslog settings
		var syslog_ser = get_by_id("syslog_server").value.split("/");
		set_checked(syslog_ser[0], get_by_id("sel_sys_enable"));
		get_by_id("sys_server").value = syslog_ser[1];

		disable_log();
	}

	function send_request(){
		if (!is_form_modified("form1") && !confirm("Nothing has changed, save anyway?")) {
			return false;
		}
		
		if(get_by_id("sel_sys_enable").checked){
			var sys_ip_addr_msg = replace_msg(all_ip_addr_msg,"Syslog server IP address");
    		var temp_sys_ip_obj = new addr_obj(get_by_id("sys_server").value.split("."), sys_ip_addr_msg, false, false);
    		if(!check_address(temp_sys_ip_obj)){
	            return false;
        	}
        }else{
        	get_by_id("sys_server").value = "0.0.0.0";
        }

		//save Syslog settings
		get_by_id("syslog_server").value = get_checked_value(get_by_id("sel_sys_enable")) +"/"+ get_by_id("sys_server").value;
		
		get_by_id("form1").submit();
	}
	
	function disable_log(){
		get_by_id("show_sysip").style.display = "none";
	  	if (get_by_id("sel_sys_enable").checked){
	    	get_by_id("show_sysip").style.display = "";
	  	}
	}		
</script>	
<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
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
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();">ADVANCED</a></td>
			<td id="topnavon"><a href="tools_admin.asp" onclick="return jump_if();">TOOLS</a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();">HELP</a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
                  <tbody>
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="tools_admin.asp" onclick="return jump_if();">Device Administration</a></div></li>
									<li><div><a href="tools_system.asp" onclick="return jump_if();">Save and Restore</a></div></li>
									<li><div><a href="tools_firmw.asp" onclick="return jump_if();">Firmware Update</a></div></li>
									<li><div><a href="tools_ddns.asp" onclick="return jump_if();">DDNS Setting</a></div></li>
								  	<li><div><a href="tools_vct.asp" onclick="return jump_if();">System Check</a></div></li>
									<li><div><a href="tools_schedules.asp" onclick="return jump_if();">Schedules</a></div></li>
									<li><div id="sidenavoff">Log Settings</div></li>
									
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
                  </tbody>
				</table>			
			</td>
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
			<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_log_settings.asp">
			
			<input type="hidden" id="syslog_server" name="syslog_server" value="<% CmoGetCfg("syslog_server","none"); %>">
			<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
			<td valign="top" id="maincontent_container">			  
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  <div id="box_header"> 
						<h1>SysLog</h1>
						<p>The SysLog options allow you to send log information to a SysLog Server.</p>
						<p>
						  <input name="button3" type="button" class=button_submit value="Save Settings" onClick="send_request()">
                          <input name="button2" type=reset class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'st_log_settings.asp');">
						</p>
				  </div>
			 	  <div class="box">
                    <h2>SYLOG SETTINGS</h2>
            		<table cellSpacing=1 cellPadding=2 width=525 border=0>
                      <tr>
                        <td class="duple">Enable Logging To Syslog Server :</td>
                        <td width=70%><input type="Checkbox" id="sel_sys_enable" name="sel_sys_enable" value="1" onClick="disable_log();"></td>
                      </tr>
                      <tr id="show_sysip" style="display:none">
                        <td class="duple">Syslog Server IP Address :</td>
                        <td width=70%> 
							<input type=text id="sys_server" name="sys_server" size=16 maxlength=15>
							<input id="button22" name="button22" type=button value="<<" style="width: 24; height: 24" onClick="print_dhcp_sel()">
                            <select id="sys_dhcp" name="sys_dhcp" size=1>
                              <option value="-1">Computer Name</option>
                              <script>
                              	set_lan_dhcp_list();
                              	document.write(DHCPList_word);
                              </script>
                            </select>
						</td>
                      </tr>
            		</table>
			 	  </div>
				<p>
				  <input name="button33" type="button" class=button_submit value="Save Settings" onClick="send_request()">
                  <input name="button44" type=reset class=button_submit value="Don't Save Settings"  onClick="window.location.href='st_log_settings.asp'">
				</p>
				</div>
			</td>
			</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
                  <tr>
                    <td id="help_text"><strong>Helpful Hints&hellip;</strong>
                      	<p>A System Logger (syslog) is a server that collects in one place the logs from different sources. If the LAN includes a syslog server, you can use this option to send the router's logs to that server.</p>
					  	<p><a href="support_tools.asp#Syslog">More&hellip;</a></p>
                    </td>
                  </tr>
                </table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td>
			<td>&nbsp;</td>
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