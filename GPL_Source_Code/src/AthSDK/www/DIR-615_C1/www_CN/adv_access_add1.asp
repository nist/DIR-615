﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	function show_save_button(){
		get_by_id("save").disabled = !(get_by_id("asp_temp_14").value != "-1");
	}

	function check_info(){
		var name = get_by_id("name").value;
		var name_list = (get_by_id("asp_temp_13").value).split(",");

		if(name == ""){
			//alert(msg[NAME_ERROR]);
			alert(which_lang[aa_alert_9]);
			return false;
		}

		for(var i = 0; i < name_list.length; i++){
			if(name == name_list[i] && i != get_by_id("asp_temp_14").value){
				//alert("The Policy Name is already used.");
				alert(which_lang[aa_alert_8]);
				return false;
			}
		}
		return true;	
	}
	
	function save_info(){
		get_by_id("asp_temp_00").value = get_by_id("name").value;
	}

	function send_previous(){
		save_info();
		get_by_id("html_response_page").value = "adv_access_add.asp";
		get_by_id("html_response_return_page").value = "adv_access_add.asp";
		send_submit("form1");
	}
		
	function send_next(){
		if(!check_info())
			return false;
			
		save_info();
		send_submit("form1");
	}
	
	function send_request(){
		if(!check_info())
			return false;
			
		save_info();
		get_by_id("html_response_page").value = "adv_access_save.asp";
		get_by_id("html_response_return_page").value = "adv_access_save.asp";
		send_submit("form1");
	}
	
	
	function showword(){ 	//check the button event,when key press in textbox
         
        	get_by_id("asp_temp_00").value = get_by_id("name").value;
    
     }
   
	
</script>



</script>
<title>D-Link公司 | 无线路由器 | 主页</title>
</head>
<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
      <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-615</a></td>
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
			<td  height="29"><img src="short_modnum.gif" width="125" height="25"></td>
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
                  <tbody>
                    <tr>
                      <td id=sidenav_container>
                        <div id=sidenav>
                          <UL>
                            <LI><div><a href="adv_virtual.asp" onclick="return jump_if();"><script>show_words(which_lang[_virtserv])</script></a></div></LI>
                            <LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(which_lang[_pf])</script></a></div></LI>
                            <LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(which_lang[_specappsr])</script></a></div></LI>
                            <LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(which_lang[YM48])</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
                            <LI><div id=sidenavoff><script>show_words(which_lang[_acccon])</script></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div><a href="Inbound_Filter.asp" onclick="return jump_if();"><script>show_words(which_lang[_inboundfilter])</script></a></div></LI>
							<LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
                            <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
                            <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
                            <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script></a></div></LI>
						</UL>
                      	</div>
					  </td>
                    </tr>
                  </tbody>
                </table>
			</td>
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_add2.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_add2.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">

			<input type="hidden" id="asp_temp_00" name="asp_temp_00">	<!-- policy name -->
			<input type="hidden" id="asp_temp_13" name="asp_temp_13" value="<% CmoGetCfg("asp_temp_13","none"); %>">	<!-- policy name list -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<% CmoGetCfg("asp_temp_14","none"); %>">	<!-- edit_row -->

			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            
          <div class=box> 
            <h2><script>show_words(which_lang[_aa_wiz_s2_title])</script></h2>
            <P class="box_msg">
              <script>show_words(which_lang[_aa_wiz_s2_msg])</script>
            </P>
				<table width="670" class=formarea>
				  <tbody>
					  <tr>
						
                  <td class="duple">
                    <script>show_words(which_lang[aa_PolName])</script>
                    :</td>
						<td width="485">&nbsp;&nbsp;<input type="text" id="name" name="name" onKeypress="showword()" maxlength="16" value="<% CmoGetCfg("asp_temp_00","none"); %>"></td>
					  </tr>
				  </tbody>
				</table><hr>
				<table width="362" align="center">
				  <td> <div align="center">
                    <input name="prev" type="button" id="prev" value="" onClick="return send_previous();">
                    &nbsp; 
                    <input name="next" type="button" id="next" value="" onClick="return send_next();">
                    &nbsp; 
                   <input name="save" type="button" id="save" value="" onClick="return send_request();">
                    &nbsp; 
                    <input name="cancel" type="button" id="cancel" value="" onClick="page_cancel_1('form1', 'adv_access_control.asp');">
					<script>get_by_id("prev").value = which_lang[_prev];</script>
          			<script>get_by_id("next").value = which_lang[_next];</script>
					<script>get_by_id("save").value = which_lang[_save];</script>
          			<script>get_by_id("cancel").value = which_lang[_cancel];</script>
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
	show_save_button();
</script>
</html>