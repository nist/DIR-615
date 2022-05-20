<html>
<head>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script>
var submit_button_flag = 0;
function onPageLoad(){
	set_checked(get_by_id("dhcpc_use_ucast").value, get_by_id("dhcpc_use_ucast_sel"));
	set_form_default_values("form1");
}

function clone_mac_action(){
	get_by_id("wan_mac").value = get_by_id("mac_clone_addr").value;
}

function change_wan(){
    var html_file;
    
    switch(get_by_id("wan_proto").selectedIndex){
		case 0 :
	    	html_file = "wan_static.asp";
	    	break;	   	
		case 1 :
	    	html_file = "wan_dhcp.asp";
	    	break;
		case 2 :
	    	html_file = "wan_poe.asp";
	    	break;
	    case 3 :
	    	html_file = "wan_pptp.asp";
	    	break;
		case 4 :
			html_file = "wan_l2tp.asp";
	    	break;
		case 5 :
			html_file = "wan_bigpond.asp";
	    	break;
	}
	
	location.href = html_file;
}

	function send_dhcp_request(){
		var ipv6_wan_proto = "<% CmoGetCfg("ipv6_wan_proto","none"); %>";
		if (ipv6_wan_proto == "ipv6_pppoe"){
			//alert("Please change IPv6 wan protocol at first!");
			alert(which_lang[IPV6_TEXT1]);
			return false;
		}
		get_by_id("asp_temp_52").value = get_by_id("wan_proto").value;
		var is_modify = is_form_modified("form1");
    	//if (!is_modify && !confirm(msg[FORM_MODIFIED_CHECK])) {
    	if (!is_modify && !confirm(which_lang[_ask_nochange])) {
			return false;
		}
		var dns1 = get_by_id("wan_primary_dns").value;
	    var dns2 = get_by_id("wan_secondary_dns").value;
	    var mtu = get_by_id("wan_mtu").value;	 
	    var c_hostname=get_by_id("hostname").value;
	    
	    var dns1_addr_msg = replace_msg(all_ip_addr_msg,which_lang[wwa_pdns]);
		var dns2_addr_msg = replace_msg(all_ip_addr_msg,which_lang[wwa_sdns]);
		var mtu_msg = replace_msg(check_num_msg, which_lang[bwn_MTU], 600, 1500);
	    
	    var temp_dns1_obj = new addr_obj(dns1.split("."), dns1_addr_msg, false, false);
		var temp_dns2_obj = new addr_obj(dns2.split("."), dns2_addr_msg, true, false);
	    var temp_mtu = new varible_obj(mtu, mtu_msg, 600, 1500, false);
		if(Find_word(c_hostname,"'") || Find_word(c_hostname,'"') || Find_word(c_hostname,"/")){
			//alert("Host name invalid. the legal characters can not enter ',/,''");
			alert(which_lang[GW_DHCP_CLIENT_CLIENT_NAME_INVALID]);
			return false;
		}
		
		/*
		 * Validate MAC and activate cloning if necessary
		 */		
		var clonemac = get_by_id("wan_mac").value; 
		if (!check_mac_00(clonemac)){
			//alert(msg[MAC_ADDRESS_ERROR]);
			alert(which_lang[KR3]);
			return false;
		} 
		 	
		var mac = trim_string(get_by_id("wan_mac").value);
		if(!is_mac_valid(mac, true)) {
			//alert ("Invalid MAC address:" + mac + ".");
			alert (which_lang[KR3]+":" + mac + ".");
			return false;
		}else{
			get_by_id("wan_mac").value = mac;
		}

	    if (dns1 != "" && dns1 != "0.0.0.0"){
    		if (!check_address(temp_dns1_obj)){
    			return false;
    		}
    	}
    	
    	if (dns2 != "" && dns2 != "0.0.0.0"){
    		if (!check_address(temp_dns2_obj)){
    			return false;
    		}
    	}
    	
    	if (!check_varible(temp_mtu)){
    		return false;
    	}
		
		if((get_by_id("wan_primary_dns").value =="" || get_by_id("wan_primary_dns").value =="0.0.0.0")&& ( get_by_id("wan_secondary_dns").value =="" || get_by_id("wan_secondary_dns").value =="0.0.0.0")){
			get_by_id("wan_specify_dns").value = 0;
		}else{
			get_by_id("wan_specify_dns").value = 1;
		}
		
    	get_by_id("wan_mac").value= mac;
    	get_by_id("dhcpc_use_ucast").value = get_checked_value(get_by_id("dhcpc_use_ucast_sel"));
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			/*
			if(is_modify || get_by_id("asp_temp_51").value.length > 0){
				get_by_id("asp_temp_51").value = "wan";
				get_by_id("html_response_page").value = "wan_reboot_need.asp";
			}else{
				window.location.href = get_by_id("html_response_page").value;
			}
			*/
			return true;
		}else{
			return false;
		}
	}
</script>
<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style1 {font-size: 11px}
-->
</style>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/" onclick="return jump_if();">DIR-615</a></td>
        <td align="right" nowrap><script>show_words(which_lang[TA3])</script>: <% CmoGetStatus("hw_version"); %> &nbsp;</td>
		<td align="right" nowrap><script>show_words(which_lang[sd_FWV])</script>: <% CmoGetStatus("version"); %></td>
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
			<td id="topnavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(which_lang[_support])</script></a></td>
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
									<li><div id="sidenavoff"><script>show_words(which_lang[sa_Internet])</script></div></li>
									<li><div id="sidenavon"><a href="wizard_wireless.asp"><script>show_words(which_lang[_wirelesst])</script></a></div></li>
									<li><div id="sidenavon"><a href="lan.asp"><script>show_words(which_lang[bln_title])</script></a></div></li>
								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">	
				<form id="form1" name="form1" method="post" action="apply.cgi">		
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="wan_dhcp.asp">
							
				<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">			
				<input type="hidden" id="wan_specify_dns" name="wan_specify_dns" value="<% CmoGetCfg("wan_specify_dns","none"); %>">
				<input type="hidden" id="dhcpc_use_ucast" name="dhcpc_use_ucast" value="<% CmoGetCfg("dhcpc_use_ucast","none"); %>">
				<input type="hidden" id="asp_temp_51" name="asp_temp_51" value="<% CmoGetCfg("asp_temp_51","none"); %>">
				<input type="hidden" id="asp_temp_52" name="asp_temp_52" value="<% CmoGetCfg("wan_proto","none"); %>">
				<input type="hidden" id="reboot_type" name="reboot_type" value="wan">
				<div id=maincontent>
			  <!-- === BEGIN MAINCONTENT === -->
              <div id=box_header>
                <h1><script>show_words(which_lang[_WAN])</script></h1>
                
            <p>
              <script>show_words(which_lang[bwn_intro_ICS])</script>
            </p>
                
            <p><strong><b> 
              <script>show_words(which_lang[_note])</script>
              </b>:&nbsp;</strong>
              <script>show_words(which_lang[bwn_note_clientSW])</script>
            </p>
            <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_dhcp_request()">
            <input name="button2" id="button2" type=reset class=button_submit value="" onclick="page_cancel('form1', 'sel_wan.asp');">
         
            <script>get_by_id("button").value = which_lang[_savesettings];</script>
			<script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
		  
		  </div>
              <div class=box>
                <h2><script>show_words(which_lang[bwn_ict])</script></h2>
                <p class="box_msg"><script>show_words(which_lang[bwn_msg_Modes])</script></p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      <td align=right width="185" class="duple"><script>show_words(which_lang[bwn_mici])</script> :</td>
                      <td width="331">&nbsp; <select name="wan_proto" id="wan_proto" onChange="change_wan()">
                    	<option value="static"><script>show_words(which_lang[_sdi_staticip])</script></option>
                        <option value="dhcpc" selected><script>show_words(which_lang[bwn_Mode_DHCP])</script></option>
                        <option value="pppoe"><script>show_words(which_lang[bwn_Mode_PPPoE])</script></option>
                        <option value="pptp"><script>show_words(which_lang[bwn_Mode_PPTP])</script></option>
                        <option value="l2tp"><script>show_words(which_lang[bwn_Mode_L2TP])</script></option>
                        <!--option value="bigpond">BigPond (Australia)</option-->
                      </select></td>
                    </tr>
                </table>
              </div>
              <div class=box id=show_dhcp>
                <h2><script>show_words(which_lang[bwn_DIAICT])</script></h2>
                <p class="box_msg"><script>show_words(which_lang[bwn_msg_DHCPDesc])</script></p>
                <table cellSpacing=1 cellPadding=1 width=525 border=0>
                    <tr>
                      
                <td width="185" align=right class="duple">
                  <script>show_words(which_lang[_hostname])</script>
                  :</td>
                      <td width="331">&nbsp;
                          <input type=text id="hostname" name="hostname" size="25" maxlength="39" value="<% CmoGetCfg("hostname","none"); %>">
                      </td>
                    </tr>
                    <tr>
                      
                <td align=right class="duple">
                  <script>show_words(which_lang[_use_unicasting])</script>
                  :</td>
                      <td>&nbsp;
                          <input type="checkbox" id="dhcpc_use_ucast_sel" name="dhcpc_use_ucast_sel" value="1">
                  <script>show_words(which_lang[bw_WDUU_note])</script>
                </td>
                    </tr>
                    <tr>
                      
                <td align=right class="duple">
                  <script>show_words(which_lang[_dns1])</script>
                  :</td>
                      <td>&nbsp;
                      	<input type=text id="wan_primary_dns" name="wan_primary_dns" size="20" maxlength="15" value="<% CmoGetCfg("wan_primary_dns","none"); %>">
                      </td>
                    </tr>
                    <tr>
                      
                <td align=right class="duple">
                  <script>show_words(which_lang[_dns2])</script>
                  :</td>
                      <td>&nbsp;
                        <input type=text id="wan_secondary_dns" name="wan_secondary_dns" size="20" maxlength="15" value="<% CmoGetCfg("wan_secondary_dns","none"); %>">
    				  </td>
                    </tr>
                    <tr>
                      
                <td align=right class="duple">
                  <script>show_words(which_lang[bwn_MTU])</script>
                  :</td>
                      <td>&nbsp;
                          <input type=text id="wan_mtu" name="wan_mtu" size="10" maxlength="5" value="<% CmoGetCfg("wan_mtu","none"); %>">
                  <script>show_words(which_lang[bwn_bytes])</script>
                  <script>show_words(which_lang[_308])</script>
                  1500</td>
                    </tr>
                    <tr>
                      
                <td align=right valign=top class="duple">
                  <script>show_words(which_lang[_macaddr])</script>
                  :</td>
                      <td>&nbsp;
                      	<input type="text" id="wan_mac" name="wan_mac" size="20" maxlength="17" value="<% CmoGetCfg("wan_mac","none"); %>"><br>
                 &nbsp;<input name="clone" id="clone" type=button class=button_submit value="" onclick="clone_mac_action()"> 
						<script>get_by_id("clone").value = which_lang[_clone];</script>
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
                      <td id=help_text><strong><script>show_words(which_lang[_hints])</script>
            &hellip;</strong> <p>
              <script>show_words(which_lang[LW35])</script>
            </p>
                          
            <p>
              <script>show_words(which_lang[LW36])</script>
            </p>
                          <p class="more"><a href="support_internet.asp#WAN" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script> 
	onPageLoad();
</script>
</html>