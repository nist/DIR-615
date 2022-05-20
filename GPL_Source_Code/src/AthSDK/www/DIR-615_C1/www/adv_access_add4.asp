<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function onPageLoad(){
		if(get_by_id("asp_temp_14").value != "-1" || get_by_id("asp_temp_03").value != ""){
			var temp_method = get_by_id("asp_temp_03").value;
			if(temp_method == "log_only"){
				get_by_name("method")[0].checked = true;
			}else if(temp_method == "block_all"){
				get_by_name("method")[1].checked = true;
			}else{
				get_by_name("method")[2].checked = true;
				if(temp_method == "url_filter"){
					get_by_id("url_filter").checked = true;
				}else if(temp_method == "firewall_rule"){
					get_by_id("firewall_rule").checked = true;
				}else{
					get_by_id("url_filter").checked = true;
					get_by_id("firewall_rule").checked = true;
				}
			}
		}
		click_method();
	}
	
	function click_method(){
		get_by_id("show_filter").style.display = "none";
		get_by_id("next").disabled = !get_by_name("method")[2].checked;
		get_by_id("save").disabled = get_by_name("method")[2].checked;
		if(get_by_name("method")[2].checked){
			get_by_id("show_filter").style.display = "";
		}
	}

	function save_info(){
		var method = get_by_name("method");
		if(method[0].checked){
			get_by_id("asp_temp_03").value = "log_only";
			get_by_id("asp_temp_12").value = "yes";
		}else if(method[1].checked){
			get_by_id("asp_temp_03").value = "block_all";
			get_by_id("asp_temp_12").value = "yes";
		}else if(method[2].checked){
			if(get_by_id("url_filter").checked && get_by_id("firewall_rule").checked){
				get_by_id("asp_temp_03").value = "url_firewall";
			}else if(get_by_id("url_filter").checked){
				get_by_id("asp_temp_03").value = "url_filter";
			}else if(get_by_id("firewall_rule").checked){
				get_by_id("asp_temp_03").value = "firewall_rule";
				get_by_id("asp_temp_12").value = "no";
			}
		}
	}

	function send_previous(){
		save_info();
		get_by_id("html_response_page").value = "adv_access_add3.asp";
		get_by_id("html_response_return_page").value = "adv_access_add3.asp";
		return true;
	}

	function send_next(){
		if(get_by_name("method")[2].checked && !get_by_id("url_filter").checked && !get_by_id("firewall_rule").checked){
			alert("Please select a filter.");
			return false;
		}
		if(get_by_name("method")[2].checked){
			if(get_by_id("firewall_rule").checked){
				get_by_id("html_response_page").value = "adv_access_add5.asp";
				get_by_id("html_response_return_page").value = "adv_access_add5.asp";
			}else if(get_by_id("url_filter").checked){
				get_by_id("html_response_page").value = "adv_access_add6.asp";
				get_by_id("html_response_return_page").value = "adv_access_add6.asp";
			}
		}
		save_info();
		get_by_id("asp_temp_15").value = "adv_access_add4.asp";
		return true;
	}

	function send_request(){
		save_info();
		get_by_id("html_response_page").value = "adv_access_save.asp";
		get_by_id("html_response_return_page").value = "adv_access_save.asp";
		return true;
	}

</script>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
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
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_control.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_control.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">

			<input type="hidden" id="asp_temp_03" name="asp_temp_03" value="<% CmoGetCfg("asp_temp_03","none"); %>">	<!-- filter method -->
			<input type="hidden" id="asp_temp_12" name="asp_temp_12" value="<% CmoGetCfg("asp_temp_12","none"); %>">	<!-- logging -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<% CmoGetCfg("asp_temp_14","none"); %>">	<!-- edit_row -->
			<input type="hidden" id="asp_temp_15" name="asp_temp_15" value="<% CmoGetCfg("asp_temp_15","none"); %>">	<!-- prev_page -->
			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            <div class=box>
			 <h2>Step 4: Select Filtering Method</h2>
		 	 <P class="box_msg">Select the method for filtering.</P>
				<table width="670" class=formarea>
				  <tbody>
					  <tr>
						<td class="duple">Method :</td>
						<td width="485">&nbsp;
							<input type="radio" id="method" name="method" onClick="click_method()"> Log Web Access Only
							<input type="radio" id="method" name="method" onClick="click_method()"> Block All Access
							<input type="radio" id="method" name="method" onClick="click_method()" checked> Block Some Access
						</td>
					  </tr>
				  </tbody>
				</table>
				<table width="670" id="show_filter" style="display:none">
				  <tbody>
					  <tr>
						<td class="duple">Apply Web Filter :</td>
						<td width="485">&nbsp;
							<input type="checkbox" id="url_filter" name="url_filter">
						</td>
					  </tr>
					  <tr>
						<td class="duple">Apply Advanced Port Filters :</td>
						<td width="485">&nbsp;
							<input type="checkbox" id="firewall_rule" name="firewall_rule">
						</td>
					  </tr>
				  </tbody>
				</table>
				
				<hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
						<input name="prev" type="submit" id="prev" value="Prev" onClick="send_previous();">
						&nbsp; 
						<input name="next" type="submit" id="next" value="Next" onClick="return send_next();">
						&nbsp;
						<input name="save" type="submit" id="save" value="Save" onClick="return send_request();">                  
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
</script>
</html>