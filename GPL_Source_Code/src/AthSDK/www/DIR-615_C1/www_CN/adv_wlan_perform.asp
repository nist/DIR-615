<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
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
    			var beacon_msg = replace_msg(check_num_msg, which_lang[help438], 20, 1000);
    			obj = new varible_obj(temp_obj.value, beacon_msg, 20, 1000, false);
    			break;
    		case 1 :
    			temp_obj = get_by_id("wlan0_rts_threshold");
    			var rts_msg = replace_msg(check_num_msg, which_lang[aw_RT], 0, 2347);
    			obj = new varible_obj(temp_obj.value, rts_msg, 0, 2347, false);
    			break;
    		case 2 :
    			temp_obj = get_by_id("wlan0_fragmentation");
    			var frag_msg = replace_msg(check_num_msg, which_lang[aw_FT],256 ,2346);
    			obj = new varible_obj(temp_obj.value, frag_msg, 256, 2346, true);
    			break;
    		case 3 :
    			temp_obj = get_by_id("wlan0_dtim");
    			var dtim_msg = replace_msg(check_num_msg, which_lang[aw_DI],1 ,255);
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
		//if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
		if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
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

<title>D-Link公司 | 无线路由器 | 主页</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style1 {color: #000000}
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
			<td id="topnavoff"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavon"><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp" onclick="return jump_if();"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavoff"><a href="st_device.asp" onclick="return jump_if();"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp" onclick="return jump_if();"><script>show_words(which_lang[_support])</script></a></td>
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
                            <LI><div><a href="adv_virtual.asp"><script>show_words(which_lang[_virtserv])</script></a></div></LI>
                         	<LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(which_lang[_pf])</script></a></div></LI>
                    		<LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(which_lang[_specappsr])</script></a></div></LI>
							<LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(which_lang[YM48])</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
							<LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(which_lang[_acccon])</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
							<LI><div id=sidenavoff><script>show_words(which_lang[_adwwls])</script></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script></a></div></LI>
                            <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
                          </UL>
                       </div>
                      </td>
                    </tr>
                </table>
			</td>
		<form id="form1" name="form1" method="post" action="apply.cgi">
		<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
		<input type="hidden" id="html_response_message" name="html_response_message" value="">
		<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
		<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_wlan_perform.asp">
		<input type="hidden" id="wlan0_auto_txrate" name="wlan0_auto_txrate" value="<% CmoGetCfg("wlan0_auto_txrate","none"); %>">
		<input type="hidden" id="wlan0_wmm_enable" name="wlan0_wmm_enable" value="<% CmoGetCfg("wlan0_wmm_enable","none"); %>">
		<input type="hidden" id="wlan0_11d_enable" name="wlan0_11d_enable" value="<% CmoGetCfg("wlan0_11d_enable","none"); %>">
		<input type="hidden" id="wlan0_partition" name="wlan0_partition" value="<% CmoGetCfg("wlan0_partition","none"); %>">
		<input type="hidden" id="wlan0_short_gi" name="wlan0_short_gi" value="<% CmoGetCfg("wlan0_short_gi","none"); %>">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>
                  <div id=box_header> 
          <h1>
            <script>show_words(which_lang[_advwls])</script>
          </h1>
                    
          <p>
            <script>show_words(which_lang[aw_intro])</script>
          </p>
        <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
		<input name="button2" id="button2" type="reset" class=button_submit value="" onclick="page_cancel('form1', 'adv_wlan_perform.asp');">
		<script>get_by_id("button").value = which_lang[_savesettings];</script>
		<script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
		
		</div>
                  
        <div class=box> 
          <h2>
            <script>show_words(which_lang[aw_title_2])</script>
          </h2>
                  <TABLE width=525>
						<tr> 
							
              <td width="183" align=right class="duple">
                <script>show_words(which_lang[aw_TP])</script>
                :</td>
							<td width="330"> 
								<select id="wlan0_txpower" name="wlan0_txpower" size="1" >
									  <option value="19"><script>show_words(which_lang[aw_TP_0])</script></option>
				                      <option value="15"><script>show_words(which_lang[aw_TP_1])</script></option>
				                      <option value="3"><script>show_words(which_lang[aw_TP_2])</script></option>
								</select>
							</td>
						</tr>
						<TR>
						  
              <TD align=right class="duple">
                <script>show_words(which_lang[aw_BP])</script>
                :</TD>
						  <TD>
							<input maxlength=4 id="wlan0_beacon_interval" name="wlan0_beacon_interval" size=6 value="<% CmoGetCfg("wlan0_beacon_interval","none"); %>">
							(20..1000)
							</TD>
						</TR>
						<tr> 
						   
              <td align=right class="duple">
                <script>show_words(which_lang[aw_RT])</script>
                :</td>
						   <td><input maxlength=4 id="wlan0_rts_threshold" name="wlan0_rts_threshold" size=6 value="<% CmoGetCfg("wlan0_rts_threshold","none"); %>">
						   	(0..2347)
						   </td>
						</tr>
						<tr> 
						   
              <td align=right class="duple">
                <script>show_words(which_lang[aw_FT])</script>
                :</td>
						   <td><input maxlength=4 id="wlan0_fragmentation" name="wlan0_fragmentation" size=6 value="<% CmoGetCfg("wlan0_fragmentation","none"); %>">
						   	(256..2346)
						   </td>
						</tr>
						<TR>
						  
              <TD align=right class="duple">
                <script>show_words(which_lang[aw_DI])</script>
                :</TD>
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
						  
              <TD align=right class="duple">
                <script>show_words(which_lang[KR4])</script>
                :</TD>
						  <TD>
							  <INPUT type="checkbox" id="wlan0_partition_sel" name="wlan0_partition_sel" value="1"> 
						  </TD>
						</TR>
						<TR>
						  
              <TD align=right class="duple">
                <script>show_words(which_lang[aw_WE])</script>
                :</TD>
						  <TD>
							  <INPUT name="wlan0_wmm_enable_sel" type="checkbox" id="wlan0_wmm_enable_sel" value="1"> 
						  </TD>
						</TR>
						<TR>
						  
              <TD align=right class="duple">
                <script>show_words(which_lang[aw_sgi])</script>
                :</TD>
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
	                   
          <td id=help_text><strong><b><strong>
            <script>show_words(which_lang[_hints])</script>
            </strong></b>&hellip;</strong> <p>
              <script>show_words(which_lang[hhaw_1])</script>
            </p>
	                   
            <p>
              <script>show_words(which_lang[hhaw_11d])</script>
            </p>
	                   
            <p>
              <script>show_words(which_lang[hhaw_wmm])</script>
            </p>
	                   <p class="more"><a href="support_adv.asp#Advanced_Wireless" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
<script>
	onPageLoad();
	set_form_default_values("form1");
</script>
</html>
