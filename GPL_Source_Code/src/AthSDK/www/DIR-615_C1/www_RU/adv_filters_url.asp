<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;
var rule_max_num = 40;
	function onPageLoad(){
		set_selectIndex("<% CmoGetCfg("url_domain_filter_type","none"); %>", get_by_id("url_domain_filter_type"));
	
	}

	function set_virtual_server(){
		for (var i = 0; i < rule_max_num; i++){
			var temp_mf;
			
			if (i > 9){
				temp_mf = get_by_id("url_domain_filter_" + i).value;
			}else{
				temp_mf = get_by_id("url_domain_filter_0" + i).value;
			}
			
			if (temp_mf.length > 1){
				get_by_id("url_" + i).value = temp_mf;
			}
		}
	}
	
	function send_request(){
		if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
			return false;
		}
		for (var i = 0; i < rule_max_num; i++){
			var temp_url = get_by_id("url_" + i).value;			
			if (temp_url != ""){
				for (var j = i+1; j < rule_max_num; j++){
					if (temp_url == get_by_id("url_" + j).value){
						alert(msg[DUPLICATE_URL_ERROR]);
						return false;
					}
				}
			}
		}
		var count = 0;		
		for (var i = 0; i < rule_max_num; i++){
			if (i > 9){
				get_by_id("url_domain_filter_" + i).value = "";	
			}else{
				get_by_id("url_domain_filter_0" + i).value = "";
			}
			
//			if (get_by_id("url_" + i).value != "" ){
				var kk=i;
				if(count<10){
					kk="0"+count;
				}
				get_by_id("url_domain_filter_" + kk).value = get_by_id("url_" + i).value;
				count++;			
//			}		
		}
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
	
	function check_date(){
		var is_change = false;
		var check_domain_type = "<% CmoGetCfg("url_domain_filter_type","none"); %>";
		if (get_by_id("url_domain_filter_type").value != check_domain_type){
			is_change = true;
		}else if(!is_change){
			for(i=0;i<rule_max_num;i++){
				var kk = i;
				if(i<10){
					kk = "0"+i;
				}
				if(get_by_id("url_domain_filter_"+ kk).value != get_by_id("url_"+ i).value){
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
	function clear_list_URL(){
		for (var i = 0; i < rule_max_num; i++) {
			get_by_id("url_"+ i).value = "";
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
                          	<ul>
				    <LI><div><a href="adv_virtual.asp">VIRTUAL SERVER</a></div></LI>
	                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();">PORT FORWARDING</a></div></LI>
	                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();">APPLICATION RULES</a></div></LI>
	                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();">QOS Engine</a></div></LI>
	                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();">NETWORK FILTER</a></div></LI>
	                            <LI><div><a href="adv_access_control.asp" onclick="return jump_if();">ACCESS CONTROL</a></div></LI>
								<li><div id="sidenavoff">WEBSITE FILTER</div></li>
				    <LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();">INBOUND FILTER</a></div></LI>
                            	    <LI><div><a href="adv_dmz.asp" onclick="return jump_if();">FIREWALL SETTINGS</a></div></LI>
									<LI><div><a href="adv_routing.asp" onclick="return jump_if();">Routing</a></div></LI>
                            	    <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();">ADVANCED WIRELESS</a></div></LI>
															<@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
				    <LI><div><a href="adv_network.asp" onclick="return jump_if();">ADVANCED NETWORK</a></div></LI>
				    <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
				</ul>
			</div>
		     </td>
                    </tr>
                </table></td>
                <form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_filters_url.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
                <input type="hidden" id="url_domain_filter_00" name="url_domain_filter_00" value="<% CmoGetCfg("url_domain_filter_00","none"); %>">
                <input type="hidden" id="url_domain_filter_01" name="url_domain_filter_01" value="<% CmoGetCfg("url_domain_filter_01","none"); %>">
                <input type="hidden" id="url_domain_filter_02" name="url_domain_filter_02" value="<% CmoGetCfg("url_domain_filter_02","none"); %>">
                <input type="hidden" id="url_domain_filter_03" name="url_domain_filter_03" value="<% CmoGetCfg("url_domain_filter_03","none"); %>">
                <input type="hidden" id="url_domain_filter_04" name="url_domain_filter_04" value="<% CmoGetCfg("url_domain_filter_04","none"); %>">
                <input type="hidden" id="url_domain_filter_05" name="url_domain_filter_05" value="<% CmoGetCfg("url_domain_filter_05","none"); %>">
                <input type="hidden" id="url_domain_filter_06" name="url_domain_filter_06" value="<% CmoGetCfg("url_domain_filter_06","none"); %>">
                <input type="hidden" id="url_domain_filter_07" name="url_domain_filter_07" value="<% CmoGetCfg("url_domain_filter_07","none"); %>">
                <input type="hidden" id="url_domain_filter_08" name="url_domain_filter_08" value="<% CmoGetCfg("url_domain_filter_08","none"); %>">
                <input type="hidden" id="url_domain_filter_09" name="url_domain_filter_09" value="<% CmoGetCfg("url_domain_filter_09","none"); %>">
                <input type="hidden" id="url_domain_filter_10" name="url_domain_filter_10" value="<% CmoGetCfg("url_domain_filter_10","none"); %>">
                <input type="hidden" id="url_domain_filter_11" name="url_domain_filter_11" value="<% CmoGetCfg("url_domain_filter_11","none"); %>">
                <input type="hidden" id="url_domain_filter_12" name="url_domain_filter_12" value="<% CmoGetCfg("url_domain_filter_12","none"); %>">
                <input type="hidden" id="url_domain_filter_13" name="url_domain_filter_13" value="<% CmoGetCfg("url_domain_filter_13","none"); %>">
                <input type="hidden" id="url_domain_filter_14" name="url_domain_filter_14" value="<% CmoGetCfg("url_domain_filter_14","none"); %>">
                <input type="hidden" id="url_domain_filter_15" name="url_domain_filter_15" value="<% CmoGetCfg("url_domain_filter_15","none"); %>">
                <input type="hidden" id="url_domain_filter_16" name="url_domain_filter_16" value="<% CmoGetCfg("url_domain_filter_16","none"); %>">
                <input type="hidden" id="url_domain_filter_17" name="url_domain_filter_17" value="<% CmoGetCfg("url_domain_filter_17","none"); %>">
                <input type="hidden" id="url_domain_filter_18" name="url_domain_filter_18" value="<% CmoGetCfg("url_domain_filter_18","none"); %>">
                <input type="hidden" id="url_domain_filter_19" name="url_domain_filter_19" value="<% CmoGetCfg("url_domain_filter_19","none"); %>">
				<input type="hidden" id="url_domain_filter_20" name="url_domain_filter_20" value="<% CmoGetCfg("url_domain_filter_20","none"); %>">
                <input type="hidden" id="url_domain_filter_21" name="url_domain_filter_21" value="<% CmoGetCfg("url_domain_filter_21","none"); %>">
                <input type="hidden" id="url_domain_filter_22" name="url_domain_filter_22" value="<% CmoGetCfg("url_domain_filter_22","none"); %>">
                <input type="hidden" id="url_domain_filter_23" name="url_domain_filter_23" value="<% CmoGetCfg("url_domain_filter_23","none"); %>">
                <input type="hidden" id="url_domain_filter_24" name="url_domain_filter_24" value="<% CmoGetCfg("url_domain_filter_24","none"); %>">
                <input type="hidden" id="url_domain_filter_25" name="url_domain_filter_25" value="<% CmoGetCfg("url_domain_filter_25","none"); %>">
                <input type="hidden" id="url_domain_filter_26" name="url_domain_filter_26" value="<% CmoGetCfg("url_domain_filter_26","none"); %>">
                <input type="hidden" id="url_domain_filter_27" name="url_domain_filter_27" value="<% CmoGetCfg("url_domain_filter_27","none"); %>">
                <input type="hidden" id="url_domain_filter_28" name="url_domain_filter_28" value="<% CmoGetCfg("url_domain_filter_28","none"); %>">
                <input type="hidden" id="url_domain_filter_29" name="url_domain_filter_29" value="<% CmoGetCfg("url_domain_filter_29","none"); %>">
                <input type="hidden" id="url_domain_filter_30" name="url_domain_filter_30" value="<% CmoGetCfg("url_domain_filter_30","none"); %>">
                <input type="hidden" id="url_domain_filter_31" name="url_domain_filter_31" value="<% CmoGetCfg("url_domain_filter_31","none"); %>">
                <input type="hidden" id="url_domain_filter_32" name="url_domain_filter_32" value="<% CmoGetCfg("url_domain_filter_32","none"); %>">
                <input type="hidden" id="url_domain_filter_33" name="url_domain_filter_33" value="<% CmoGetCfg("url_domain_filter_33","none"); %>">
                <input type="hidden" id="url_domain_filter_34" name="url_domain_filter_34" value="<% CmoGetCfg("url_domain_filter_34","none"); %>">
                <input type="hidden" id="url_domain_filter_35" name="url_domain_filter_35" value="<% CmoGetCfg("url_domain_filter_35","none"); %>">
                <input type="hidden" id="url_domain_filter_36" name="url_domain_filter_36" value="<% CmoGetCfg("url_domain_filter_36","none"); %>">
                <input type="hidden" id="url_domain_filter_37" name="url_domain_filter_37" value="<% CmoGetCfg("url_domain_filter_37","none"); %>">
                <input type="hidden" id="url_domain_filter_38" name="url_domain_filter_38" value="<% CmoGetCfg("url_domain_filter_38","none"); %>">
                <input type="hidden" id="url_domain_filter_39" name="url_domain_filter_39" value="<% CmoGetCfg("url_domain_filter_39","none"); %>">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  <div id=box_header>
                    <h1>Website Filter</h1>
                    <p>The Website Filter option allows you to set up a list of Web sites you would like to allow or deny through your network. To us this feature, you must also select the "Apply Web Filter" checkbox in the Access Control section.<p>
                    <input name="apply" type="button" class=button_submit value="Save Settings" onClick="send_request()">
                    <input name="cancel" type=button class=button_submit value="Don't Save Settings" onclick="page_cancel('form1', 'adv_filters_url.asp');">
                  </div>
                  <div class=box>
                    <h2>40 &ndash; WEBSITE FILTERING RULES</h2>
                    <table cellSpacing=1 cellPadding=2 width=500 border=0>
                        <tr>
                          <td>Configure Website Filter below:</td>
                        </tr>
                        <tr>
                          <td>
						  <select id="url_domain_filter_type" name="url_domain_filter_type">
                              <!--option value="disable">Turn Parental Control OFF</option-->
                              <option value="list_deny">DENY computers access to ONLY these sites</option>
                              <option value="list_allow">ALLOW computers access to ONLY these sites</option>
                            </select>
                          </td>
                        </tr>
                        <tr>
                          <td>
                          	<br>
                          	<input class="button_submit" type="button" value="Clear the list below..." onclick="clear_list_URL();">
                          </td>
                        </tr>
                    </table>
                    <br>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=0>
                        <tr align=center>
                          <td width="100%" colspan="2"><b>Website URL/Domain</b></td>
                        </tr>
                        <tr align=center>
                          <td colspan="2"></td>
                        </tr>
                        <script>
						for(var i=0 ; i<rule_max_num ; i++){
							document.write("<tr align=center>")
							document.write("<td><input id=\"url_" + i + "\" name=\"url_" + i + "\" maxlength=40 size=41></td>")
							document.write("<td><input id=\"url_" + ++i + "\" name=\"url_" + i + "\" maxlength=40 size=41></td>")
							document.write("</tr>")
						}
					  </script>
                    </table>
                  </div>
			  </div>
			</td>
		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table width="125" border=0 cellPadding=2 cellSpacing=0 borderColor=#ffffff borderColorLight=#ffffff borderColorDark=#ffffff bgColor=#ffffff>
                    <tr>
                      <td id=help_text><strong>Helpful Hints&hellip;</strong>
                        <p>Create a list of Web Sites to which you would like to deny or allow through the network.</p>
                      	<p>Use with <a href="adv_access_control.asp" onclick="return jump_if();">Advanced &rarr; Access&nbsp;Control</a>.</p>
                      	<p class="more"><a href="support_adv.asp#Web_Filter" onclick="return jump_if();">More&hellip;</a></p>
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
	set_virtual_server();
	set_form_default_values("form1");
</script>
</html>
