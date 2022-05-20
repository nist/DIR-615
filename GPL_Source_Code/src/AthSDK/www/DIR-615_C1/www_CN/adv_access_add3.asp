﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var rule_max_num = 8;
var DataArray = new Array();

	function onPageLoad(){
		if(get_by_id("max_row").value == rule_max_num){
			get_by_id("add_table").style.display = "none";
			get_by_id("full_msg").style.display = "";
		}else{
			click_type();
		}
	}

	function set_machine_list(){
		if(get_by_id("asp_temp_14").value != "-1" || get_by_id("asp_temp_02").value != ""){
			var temp_machine = (get_by_id("asp_temp_02").value).split(",");
			for (var i = 0; i < temp_machine.length; i++){
				var type;
				var machine = temp_machine[i].split(".");
				var machine_name = temp_machine[i];
				if(machine.length == 4){
					type = "0";
				}else{
					if(temp_machine[i] == "other"){
						type = "2";
						machine_name = "Other Machines";
					}else{
						type = "1";
					}
				}
				DataArray[i+1] = new Data(type, machine_name, i+1);
			}
			get_by_id("max_row").value = temp_machine.length;
		}
	}

	function Data(type, machine, onList){
		this.Type = type;
		this.Machine = machine;
		this.OnList = onList;
	}

	function show_save_button(){
		get_by_id("save").disabled = !(get_by_id("asp_temp_14").value != "-1");
	}

	function clone_mac_action(){
		get_by_id("mac").value = get_by_id("mac_clone_addr").value;
	}
	
	function clear_info(){
		get_by_name("type")[0].checked = true;
		get_by_id("ip").value = "";
		get_by_id("mac").value = "";
		get_by_id("ip_list").selectedIndex = 0;
		get_by_id("mac_list").selectedIndex = 0;
		get_by_id("edit").value = "-1";
		click_type();
	}
	
	function click_type(){
		var type = get_by_name("type");
		get_by_id("ip").disabled = !type[0].checked || type[2].checked;
		get_by_id("ip_list").disabled = !type[0].checked || type[2].checked;
		get_by_id("mac").disabled = !type[1].checked || type[2].checked;
		get_by_id("mac_list").disabled = !type[1].checked || type[2].checked;
		get_by_id("clone").disabled = !type[1].checked || type[2].checked;
	}

	function edit_row(idx){
		if(get_by_id("max_row").value == rule_max_num){
			get_by_id("add_table").style.display = "";
			get_by_id("full_msg").style.display = "none";
		}
		get_by_name("type")[DataArray[idx].Type].checked = true;
		if(DataArray[idx].Type == 0){
			get_by_id("ip").value = DataArray[idx].Machine;
		}else if(DataArray[idx].Type == 1){
			get_by_id("mac").value = DataArray[idx].Machine;
		}
		get_by_id("edit").value = idx;
		click_type();
	}

	function del_row(idx){
		if(get_by_id("max_row").value < rule_max_num)
			edit_row(idx);

		if(confirm(msg[DEL_MSG] + DataArray[idx].Machine)){
			get_by_id("del").value = idx;
			delete_row();
		}
	}

	function delete_row(){
		var del_index = parseInt(get_by_id("del").value);
		var tb1 = get_by_id("table1");
		var DataArray_length = parseInt(DataArray.length) - 1;
		if (del_index >= DataArray_length){
			var oTr = tb1.deleteRow(del_index);
		}else{
			for(var i = del_index; i < DataArray_length; i++){
				var edit = i + 1;
				get_by_id("table1").rows[i].cells[0].innerHTML = DataArray[edit].Machine;
				get_by_id("table1").rows[i].cells[1].innerHTML = "<a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a>";
				get_by_id("table1").rows[i].cells[2].innerHTML = "<a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a>";
			}
			var oTr = tb1.deleteRow(DataArray_length);
		}
		delete_data();
	}

	function delete_data(){
		var num = parseInt(get_by_id("del").value);
		var DataArray_length = parseInt(DataArray.length) - 2;
	
		for(var i = num ; i <= DataArray_length; i++){
			DataArray[i].Type = DataArray[i+1].Type;
			DataArray[i].Machine = DataArray[i+1].Machine;
			DataArray[i].OnList = DataArray[i+1].OnList;
		}
		--DataArray.length;
		get_by_id("max_row").value = parseInt(DataArray.length)- 1;
		
		if(get_by_id("max_row").value < rule_max_num){
			get_by_id("add_table").style.display = "";
			get_by_id("full_msg").style.display = "none";
			clear_info();
		}
		
	}
	
	function check_duplicate(obj){
		for(var i = 1; i < DataArray.length; i++){
			if(obj == DataArray[i].Machine && i != get_by_id("edit").value){
				//alert("The Machine is already used.");
				alert(which_lang[aa_alert_7]);
				return false;
			}
		}
		return true;
	}
			
	function add_row(){
		var temp_dhcp_list = (get_by_id("dhcp_list").value).split(",");
		var type = get_by_name("type");
		if(type[0].checked){
			var ip = get_by_id("ip").value;
			var lan_ip = "<% CmoGetCfg("lan_ipaddr","none"); %>";
			var mask ="<% CmoGetCfg("lan_netmask","none"); %>";

			var ip_addr_msg = replace_msg(all_ip_addr_msg, which_lang[help256]);
			var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
			var temp_lan_obj = new addr_obj(lan_ip.split("."), ip_addr_msg, false, false);
			var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
			
						for (var i = 0; i < temp_dhcp_list.length; i++){	
				var temp_data = temp_dhcp_list[i].split("/");
				if (ip==temp_data[1]){
						for(var j = 1; j < DataArray.length; j++){
							if(temp_data[2] == DataArray[j].Machine){
								alert("Can't select the same PC");
								return false;
							}
						}
				}
			}			
						
			if (!check_address(temp_ip_obj, temp_mask_obj, temp_lan_obj)){
				return;
			}
			//check dhcp ip range equal to lan-ip or not?
				if(!check_LAN_ip(temp_lan_obj.addr, temp_ip_obj.addr, which_lang[help256])){
					return false;
			}
			if(!check_domain(temp_lan_obj, temp_mask_obj, temp_ip_obj)){
				//alert(ip + " -- IP Address should be in LAN subnet.");
				alert(ip + " -- "+which_lang[_ipaddr] +which_lang[aa_alert_12]);
				return;
			}
			if(!check_duplicate(ip)){
				return;
			}
		}else if(type[1].checked){
			var mac = get_by_id("mac").value;
			var lan_mac = "<% CmoGetCfg("lan_mac","none"); %>";
			var lower_mac = mac.toLowerCase();
			
			for (var i = 0; i < temp_dhcp_list.length; i++){	
				var temp_data = temp_dhcp_list[i].split("/");
				if (lower_mac==temp_data[2]){
						for(var j = 1; j < DataArray.length; j++){
							if(temp_data[1] == DataArray[j].Machine){
								alert("Can't select the same PC");
								return false;
							}
						}
				}
			}			
			
			if (!check_mac(mac)){
				//alert(msg[MAC_ADDRESS_ERROR]);
				alert(which_lang[LS47]);
				return;
			}
			if (mac == lan_mac ){
				//alert(msg[MAC_ADDRESS_ERROR]);
				alert(which_lang[LS47]);
				return false;
			}
			if(!check_duplicate(mac)){
				return;
			}
		}else{
			if(!check_duplicate("Other Machines")){
				return;
			}
		}

		update_DataArray();

		var i;
		if(get_by_id("edit").value == "-1"){     //add
			i = get_by_id("max_row").value;
			var tb1 = get_by_id("table1"); 
			var oTr = tb1.insertRow(-1);
			var oTd1 = oTr.insertCell(-1);
			var oTd2 = oTr.insertCell(-1);
			var oTd3 = oTr.insertCell(-1);

			oTd1.innerHTML = DataArray[i].Machine;
			oTd2.innerHTML = "<a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a>";
			oTd3.innerHTML = "<a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a>";
		}else{                                      //update		
			i = parseInt(get_by_id("edit").value);

			get_by_id("table1").rows[i].cells[0].innerHTML = DataArray[i].Machine;
			get_by_id("table1").rows[i].cells[1].innerHTML = "<a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a>";
			get_by_id("table1").rows[i].cells[2].innerHTML = "<a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a>";
		}
		
		if(get_by_id("max_row").value == rule_max_num){
			get_by_id("add_table").style.display = "none";
			get_by_id("full_msg").style.display = "";
		}else{
			clear_info();
		}
	}
	
	function update_DataArray(){
		var index = parseInt(get_by_id("edit").value);
		var insert = false;
		var type, machine;
	
		if(index == "-1"){      //save
			index = parseInt(get_by_id("max_row").value) + 1;
			get_by_id("max_row").value = index;
			insert = true;
		}
	
		if(get_by_name("type")[0].checked){
			type = "0";
			machine = get_by_id("ip").value;
		}else if(get_by_name("type")[1].checked){
			type = "1";
			machine = get_by_id("mac").value;
		}else if(get_by_name("type")[2].checked){
			type = "2";
			machine = "Other Machines";
		}
		
		if(insert){
			DataArray[index] = new Data(type, machine, index);			
		}else if (index != -1){
			DataArray[index].Type = type;
			DataArray[index].Machine = machine;
			DataArray[index].OnList = index;
		}
	}

	function check_info(){
		if(DataArray.length < 2){
			//alert("Please enter one machine.");
			alert(which_lang[aa_alert_10]);
			return false;
		}
		return true;	
	}

	function save_info(){
		var machine_list = "";
		var max_row = get_by_id("max_row").value;
		for(var i = 1; i <= max_row; i++){
			var machine_name = DataArray[i].Machine;
			if(DataArray[i].Machine == "Other Machines"){
				machine_name = "other";
			}
			if(i == 1){
				machine_list = machine_name;
			}else{
				machine_list = machine_list + "," + machine_name;
			}
		}
		get_by_id("asp_temp_02").value = machine_list;
	}

	function send_previous(){
		get_by_id("html_response_page").value = "adv_access_add2.asp";
		get_by_id("html_response_return_page").value = "adv_access_add2.asp";
		return true;
	}
		
	function send_next(){
		if(!check_info())
			return false;
			
		save_info();
		return true;
	}

	function send_request(){
		if(!check_info())
			return false;
			
		save_info();
		get_by_id("html_response_page").value = "adv_access_save.asp";
		get_by_id("html_response_return_page").value = "adv_access_save.asp";
		return true;
	}
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
			<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
			<input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">
		   <input type="hidden" id="del" name="del" value="-1">
		   <input type="hidden" id="edit" name="edit" value="-1">
		   <input type="hidden" id="max_row" name="max_row" value="0">
			
			<form id="form1" name="form1" method="post" action="apply.cgi">
			<input type="hidden" id="html_response_page" name="html_response_page" value="adv_access_add4.asp">
			<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="adv_access_add4.asp">
			<input type="hidden" id="reboot_type" name="reboot_type" value="none">

			<input type="hidden" id="asp_temp_02" name="asp_temp_02" value="<% CmoGetCfg("asp_temp_02","none"); %>">	<!-- machine -->
			<input type="hidden" id="asp_temp_14" name="asp_temp_14" value="<% CmoGetCfg("asp_temp_14","none"); %>">	<!-- edit_row -->
			<td valign="top" id="maincontent_container">
			<div id=maincontent>
            
          <div class=box> 
            <h2>
              <script>show_words(which_lang[_aa_wiz_s4_title])</script>
            </h2>
				<table width="670" id="add_table">
				  <tbody>
				  	  <tr>
					  	<td colspan="2" height="30"><P class="box_msg">
                      <script>show_words(which_lang[_aa_wiz_s4_msg])</script>
                    </P></td>
					  </tr>
				  	  <tr>
					  	<td colspan="2" height="30"><p>
                      <script>show_words(which_lang[_aa_wiz_s4_help])</script>
                    </p></td>
					  </tr>
					  <tr>
						
                  <td class="duple">
                    <script>show_words(which_lang[aa_AT])</script>
                    :</td>
						<td width="485">&nbsp;
							<input type="radio" id="type" name="type" checked onClick="click_type()">
                    <script>show_words(which_lang[aa_AT_0])</script>
                    <input type="radio" id="type" name="type" onClick="click_type()">
                    <script>show_words(which_lang[aa_AT_1])</script>
                    <input type="radio" id="type" name="type" onClick="click_type()">
                    <script>show_words(which_lang[_aa_other_machines])</script>
                  </td>
					  </tr>
					  <tr>
					  	
                  <td class="duple">
                    <script>show_words(which_lang[_ipaddr])</script>
                    :</td>
						<td width="485">&nbsp;
							<input type="text" id="ip" name="ip" maxlength="15" size="20">
							&lt;&lt;
							<select id="ip_list" name="ip_list" onChange="key_word(this,'ip');">
								<option value=-1><script>show_words(which_lang[bd_CName])</script></option>
								<script>
								set_mac_list("ip");
								</script>
							</select>
						</td>
					  </tr>
					  <tr>
					  	
                  <td class="duple">
                    <script>show_words(which_lang[aa_MAC])</script>
                    :</td>
						<td width="485">&nbsp;
							<input type="text" id="mac" name="mac" size="20">
							&lt;&lt;
							<select id="mac_list" name="mac_list" onChange="key_word(this,'mac');">
								<option value=-1><script>show_words(which_lang[bd_CName])</script></option>
								<script>
								set_mac_list("mac");
								</script>
							</select>
						</td>
					  </tr>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						
                  <td width="485">&nbsp; 
                    <input name="clone" type="button" id="clone" value="" onClick="clone_mac_action()">
                    <script>get_by_id("clone").value = which_lang[_clone];</script>
				  </td>
					  </tr>
					  <tr>
					  	<td class="duple">&nbsp;</td>
						<td width="485">
							&nbsp; 
							<input name="ok" type="button" id="ok" value="" onClick="add_row()">
							&nbsp;
							<input name="clear" type="button" id="clear" value="" onClick="clear_info()"> 
                 			<script>get_by_id("ok").value = which_lang[_ok];</script>
							<script>get_by_id("clear").value = which_lang[_cancel];</script>
				  </td>
					  </tr>
				  </tbody>
				</table>
				<table width="670" id="full_msg" style="display:none">
					<tr>
						<td height="30">You cannot add more machines because the table is full.</td>
					</tr>
				</table>
				<table id="table1" width="670" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
					<tr>
					       <td width="70%"><strong><script>show_words(which_lang[aa_Machine])</script></strong></td>
						<td width="15%">&nbsp;</td>
						<td width="15%">&nbsp;</td>
					</tr>
					<script>
						set_machine_list();
						for(i = 1; i < DataArray.length; i++){
							document.write("<tr><td>" + DataArray[i].Machine +"</td><td><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></td><td><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></td></tr>");
						}
						
					</script>
				</table>
				<hr>
				<table width="362" align="center">
				  <td> <div align="center"> 
					<input name="prev" type="submit" id="prev" value="" onClick="return send_previous();">
                    &nbsp; 
                   <input name="next" type="submit" id="next" value="" onClick="return send_next();">
                    &nbsp; 
                    <input name="save" type="submit" id="save" value="" onClick="return send_request();">
                    &nbsp; 
                    <input name="cancel" type="button" id="cancel" value="" onClick="exit_access();">
                   
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
onPageLoad();
</script>
</html>