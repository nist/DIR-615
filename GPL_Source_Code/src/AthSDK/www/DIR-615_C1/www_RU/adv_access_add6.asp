<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		if(get_by_id("asp_temp_12").value == "yes"){
			get_by_name("log")[1].checked = true;
		}else{
			get_by_name("log")[0].checked = true;
		}
	}
	
	function save_info(){
		if(get_by_name("log")[0].checked){
			get_by_id("asp_temp_12").value = "no";
		}else{
			get_by_id("asp_temp_12").value = "yes";
		}
	}

	function  send_previous(){
		save_info();
		get_by_id("html_response_page").value = get_by_id("asp_temp_15").value;
		get_by_id("html_response_return_page").value = get_by_id("asp_temp_15").value;
		return true;
	}

	function send_next(){
		save_info();
		return true;
	}
		
</script>
<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
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
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_save.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_save.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">

			<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<% CmoGetCfg("asp_temp_12","none"); %>">	<!-- logging -->
			<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<% CmoGetCfg("asp_temp_15","none"); %>">	<!-- prev_page -->
			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            <div class=box>
			 <h2>Step 6: Configure Web Access Logging</h2>
				<table width="670" class=formarea>
				  <tbody>
					  <tr>
						<td class="duple">Web Access Logging :</td>
						<td width="485">&nbsp;
							<input type="radio" id="log" name="log" checked> Disabled
						</td>
					  </tr>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						<td width="485">&nbsp;
							<input type="radio" id="log" name="log"> Enabled
						</td>
					  </tr>
				  </tbody>
				</table><hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
						<input name="prev" type="submit" id="prev" value="Prev" onClick="return send_previous();">
						&nbsp; 
						<input name="next" type="submit" id="next" value="Next" disabled>
						&nbsp;
						<input name="save" type="submit" id="save" value="Save" onClick="return send_next();">                  
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
<script>onPageLoad();</script>
</html>