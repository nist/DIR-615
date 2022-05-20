<html>
<head>
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
var submit_button_flag = 0;	
var rule_max_num = 25;
var resert_rule = rule_max_num;
var DataArray = new Array();
var DHCPL_DataArray = new Array();
//var DHCPList_word = "";

//1/dddd/192.168.55.55/112255448877
function Data(enable, name, ip, mac, onList) 
{
	this.Enable = enable;
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.OnList = onList;
}

function DHCP_Data(name, ip, mac, Exp_time, onList) 
{
	this.Name = name;
	this.IP = ip;
	this.MAC = mac;
	this.EXP_T = Exp_time;
	this.OnList = onList;
}

function set_reservation(){
	var index = 1;
	for (var i = 0; i < rule_max_num; i++){
		var temp_dhcp;
		var k = i;
		if(parseInt(i) < 10){
			k = "0" + i;
		}
		temp_dhcp = (get_by_id("dhcpd_reserve_" + k).value).split("/");
		if (temp_dhcp.length > 1){
			if(temp_dhcp[1].length > 0){
				DataArray[index] = new Data(temp_dhcp[0],temp_dhcp[1], temp_dhcp[2], temp_dhcp[3], index);
				index++;
			}
		}
	}
	get_by_id("max_row").value = index - 1;
}

function set_lan_dhcp_list(){
	var index = 0;
	var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
	for (var i = 0; i < temp_dhcp_list.length; i++){	
		var temp_data = temp_dhcp_list[i].split("/");
		if(temp_data.length > 1){
			DHCPL_DataArray[DHCPL_DataArray.length++] = new DHCP_Data(temp_data[0], temp_data[1], temp_data[2], temp_data[3], index);
			//DHCPList_word = DHCPList_word+ "<option value=\""+ index +"\">" + temp_data[0] + "</option>";
			index++;
		}
	}
	get_by_id("dhcp_num").innerHTML = DHCPL_DataArray.length;
	//set_reservation();
}

function onPageLoad(){
	set_checked("<% CmoGetCfg("dhcpd_enable","none"); %>", get_by_id("dhcpsvr"));
	set_checked("<% CmoGetCfg("dns_relay","none"); %>", get_by_id("DNSrelay"));
	set_checked("<% CmoGetCfg("dhcpd_always_bcast","none"); %>", get_by_id("always_broadcast"));
	set_checked("<% CmoGetCfg("dhcpd_netbios_enable","none"); %>", get_by_id("netbios_announcement"));
	set_checked("<% CmoGetCfg("dhcpd_netbios_learn","none"); %>", get_by_id("netbios_learn"));
	set_checked("<% CmoGetCfg("dhcpd_static_node_type","none"); %>", get_by_name("netbios_node"));
		
	var dhcpd_static_wins_server = "<% CmoGetCfg("dhcpd_static_wins_server","none"); %>";
	var wins_server = dhcpd_static_wins_server.split("/");
	if(wins_server.length != "")
		get_by_id("wins_ip1").value = wins_server[0];
	if(wins_server.length > 1)
		get_by_id("wins_ip2").value = wins_server[1];
	
	//get_by_id("show_resert").innerHTML = "<font color=\"red\">"+ resert_rule +"</font>";
	
	disable_ip();
	disable_netbios();
}

function clone_mac_action(){
	get_by_id("reserved_mac").value = get_by_id("mac_clone_addr").value;
}

function set_reserved(){
	var idx = parseInt(get_by_id("reserved_list").selectedIndex);

	get_by_id("reserved_enable").checked = true;
	get_by_id("reserved_name").value = DHCPL_DataArray[idx - 1].Name;
	get_by_id("reserved_ip").value = DHCPL_DataArray[idx - 1].IP;
	get_by_id("reserved_mac").value = DHCPL_DataArray[idx - 1].MAC;
}

function set_reserved_enable(idx){
	if(get_by_id("r_enable" + idx).checked){
		//if(confirm("Do you want enable the DHCP Reservation entry for IP Address " + DataArray[idx].IP)){
		if(confirm(which_lang[YM92] + DataArray[idx].IP)){
			DataArray[idx].Enable = 1;
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
		}else{
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
		}
	}else{
		//if(confirm("Do you want disable the DHCP Reservation entry for IP Address " + DataArray[idx].IP)){
		if(confirm(which_lang[YM93] + DataArray[idx].IP)){
			DataArray[idx].Enable = 0;
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")'></center>"
		}else{
			get_by_id("table1").rows[idx].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + idx + " name=r_enable" + idx + " onClick='set_reserved_enable(" + idx + ")' checked></center>"
		}
	}
}

function edit_dhcp_client(idx){
	get_by_id("reserved_enable").checked = true;
	get_by_id("reserved_name").value = DHCPL_DataArray[idx].Name;
	get_by_id("reserved_ip").value = DHCPL_DataArray[idx].IP;
	get_by_id("reserved_mac").value = DHCPL_DataArray[idx].MAC;
}

function edit_row(idx){
	if(DataArray[idx].Enable == 1)
		get_by_id("reserved_enable").checked = true;
	else
		get_by_id("reserved_enable").checked = false;
		
	get_by_id("reserved_name").value = DataArray[idx].Name;
	get_by_id("reserved_ip").value = DataArray[idx].IP;
	get_by_id("reserved_mac").value = DataArray[idx].MAC;
	get_by_id("edit").value = idx;
}

function delete_data(){
	var num = parseInt(get_by_id("del").value);
	var DataArray_length = parseInt(DataArray.length) - 1;

	for(var i = num ; i < DataArray_length; i++){
		DataArray[i].Enable = DataArray[i+1].Enable;
		DataArray[i].Name = DataArray[i+1].Name;
		DataArray[i].IP = DataArray[i+1].IP;
		DataArray[i].MAC = DataArray[i+1].MAC;
		DataArray[i].OnList = DataArray[i+1].OnList;
	}
	
	DataArray[DataArray_length].Name = "";
	--DataArray_length;
	get_by_id("max_row").value = parseInt(DataArray_length);
	clear_reserved();
}

function delete_row(){
	var del_index = parseInt(get_by_id("del").value);
	var tb1 = get_by_id("table1");
	var DataArray_length = parseInt(DataArray.length) - 1;
	if (del_index >= DataArray_length){
		var oTr = tb1.deleteRow(del_index);
	}else{
		for(var i = del_index; i < DataArray_length; i++){
			var is_checked = "";
			if(parseInt(DataArray[i+1].Enable)){
				is_checked = " checked";
			}
			var edit = i + 1;
			get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + edit + ")' " + is_enable + "></center>"
			get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[edit].Name +"</center>"
			get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[edit].MAC +"</center>"
			get_by_id("table1").rows[i].cells[3].innerHTML = "<center>" + DataArray[edit].IP +"</center>"
			get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"'+which_lang[_edit]+'\"></a></center>";
			get_by_id("table1").rows[i].cells[5].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"'+which_lang[_delete]+'\"></a></center>";
		}
		var oTr = tb1.deleteRow(DataArray_length);
	}
	delete_data();
}

function del_row(idx){
	edit_row(idx);
	//if(confirm(msg[DEL_MSG] + DataArray[idx].IP)){
	if(confirm(which_lang[YM25] + DataArray[idx].IP)){
		get_by_id("del").value = idx;
		delete_row();
	}
}

function update_DataArray(){
	var index = parseInt(get_by_id("edit").value);
	var insert = false;
	var is_enable = "0";

	if(index == "-1"){      //save
		if(get_by_id("max_row").value == rule_max_num){
			//alert("Schedule rules is Full! Please Delete an Entry.");
			alert(which_lang[TEXT015]);
			
		}else{
			index = parseInt(get_by_id("max_row").value) + 1;
			get_by_id("max_row").value = index;
			insert = true;
		}
	}

	if(get_by_id("reserved_enable").checked){
		is_enable = "1";
	}else{
		is_enable = "0";
	}
	
	if(insert){
		DataArray[index] = new Data(is_enable, get_by_id("reserved_name").value, get_by_id("reserved_ip").value, get_by_id("reserved_mac").value, index, index+1);			
	}else if (index != -1){
		DataArray[index].Enable = is_enable;
		DataArray[index].Name = get_by_id("reserved_name").value;
		DataArray[index].IP = get_by_id("reserved_ip").value;
		DataArray[index].MAC = get_by_id("reserved_mac").value;
		DataArray[index].OnList = index;
	}
}

function save_reserved(){
	var index = 0;
    var ip = get_by_id("lan_ipaddr").value;
	var mask = get_by_id("lan_netmask").value;
	var reserved_name = get_by_id("reserved_name").value;
	var reserved_ip = get_by_id("reserved_ip").value;
	var reserved_mac = get_by_id("reserved_mac").value;
	var start_ip = get_by_id("dhcpd_start").value;
	var end_ip = get_by_id("dhcpd_end").value;

	var ip_addr_msg = replace_msg(all_ip_addr_msg,which_lang[_ipaddr]);
	var Res_ip_addr_msg = replace_msg(all_ip_addr_msg,"Reservation IP");
	var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP address");
	var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP address");

	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var temp_res_ip_obj = new addr_obj(reserved_ip.split("."), Res_ip_addr_msg, false, false);
	var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
	var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);

	if(reserved_name == ""){
		//alert(msg[STATIC_DHCP_NAME]);
		alert(which_lang[GW_INET_ACL_NAME_INVALID]);
		return false;
	}else if(!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, which_lang[TEXT033])){
		return false;
	}else if(!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
		return false;
	}else if (!check_domain(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
		//alert(msg[SER_NOT_SAME_DOMAIN]);
		alert("預留IP 位址 " + reserved_ip + " 應該在已設定的DHCP 發放範圍之內。");//GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID
		return false;
	}else if (!check_mac(reserved_mac)){
		//alert(msg[MAC_ADDRESS_ERROR]);
		alert(which_lang[KR3]);
		return false;
	}
	
        if (check_resip_order(temp_res_ip_obj,start_obj, end_obj)){
			//alert(msg[BD_ALERT_8]);
			//alert("Reserved IP address " + reserved_ip + " should be within the configured DHCP range.");	//GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID
			alert("預留IP 位址 " + reserved_ip + " 應該在已設定的DHCP 發放範圍之內。");
			return false;
		}
	//check same ip/mac start	
		var index = parseInt(get_by_id("edit").value);
		var edit_tmp = get_by_id("edit").value;
		for(m = 1; m < DataArray.length; m++){
				if (m==index){
				 continue;
				}else{
				
				if(get_by_id("reserved_name").value.length > 0){
					if((get_by_id("reserved_name").value == DataArray[m].Name)){
						//alert("Reserved name '"+ reserved_name +"' is already used.");//
						alert("電腦名稱("+ get_by_id("reserved_name").value +")已經保留");	

						return false;
					}
				}
				if(reserved_ip.length > 0){
					if((reserved_ip == DataArray[m].IP)){
						//alert("Reserved IP Address '"+ reserved_ip +"' is already used.");//bd_alert_7
						alert("電腦名稱("+ reserved_ip +")的IP位址已經保留");	
						return false;
					}
				}
				if(reserved_mac.length > 0){
					if((reserved_mac == DataArray[m].MAC)){
						//alert("Reserved IP address for this MAC address '"+ reserved_mac +"' is already set.");	//GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID
						alert("對應這個MAC 位址 "+ reserved_mac +" 的預留IP 位址已經被設定。");

						return false;
					}
				}
			}	
		}
	//check same ip/mac end

	update_DataArray();

	var is_enable = "";
	if(get_by_id("edit").value == "-1"){     //add
		var i = get_by_id("max_row").value;
		var tb1 = get_by_id("table1"); 
		var oTr = tb1.insertRow(-1);
		var oTd1 = oTr.insertCell(-1);
		var oTd2 = oTr.insertCell(-1);
		var oTd3 = oTr.insertCell(-1);
		var oTd4 = oTr.insertCell(-1);
		var oTd5 = oTr.insertCell(-1);
		var oTd6 = oTr.insertCell(-1);

		if(parseInt(DataArray[i].Enable)){
			is_enable = "checked";
		}else{
			is_enable = "";
		}
		oTd1.innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
		oTd2.innerHTML = "<center>" + DataArray[i].Name +"</center>"
		oTd3.innerHTML = "<center>" + DataArray[i].MAC +"</center>"
		oTd4.innerHTML = "<center>" + DataArray[i].IP +"</center>"
		oTd5.innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"'+which_lang[_edit]+'\"></a></center>";
		oTd6.innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"'+which_lang[_delete]+'\"></a></center>";
	}else{                                      //update		
		var i = parseInt(get_by_id("edit").value);
		if(parseInt(DataArray[i].Enable)){
			is_enable = "checked";
		}else{
			is_enable = "";
		}
		get_by_id("table1").rows[i].cells[0].innerHTML = "<center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center>"
		get_by_id("table1").rows[i].cells[1].innerHTML = "<center>" + DataArray[i].Name +"</center>"
		get_by_id("table1").rows[i].cells[2].innerHTML = "<center>" + DataArray[i].MAC +"</center>"
		get_by_id("table1").rows[i].cells[3].innerHTML = "<center>" + DataArray[i].IP +"</center>"
		get_by_id("table1").rows[i].cells[4].innerHTML = "<center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"'+which_lang[_edit]+'\"></a></center>";
		get_by_id("table1").rows[i].cells[5].innerHTML = "<center><a href=\"javascript:del_row("+ i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"'+which_lang[_delete]+'\"></a></center>";
	}
	clear_reserved();
}

function clear_reserved(){
	get_by_id("reserved_enable").checked = false;
	get_by_id("reserved_name").value = "";
	get_by_id("reserved_ip").value = "";
	get_by_id("reserved_mac").value = "";
	get_by_id("edit").value = -1;
}

/*
function change_ip(){
		var ip = get_by_id("lan_ipaddr").value;
		var start_ip = get_by_id("dhcpd_start");
		var end_ip = get_by_id("dhcpd_end");		
		var start_ip_4 = get_by_id("start_ip4").value;
		var end_ip4 = get_by_id("end_ip4").value;
		start_ip.value = ip.substring(0, ip.lastIndexOf(".")) +"." + start_ip_4;
		end_ip.value = ip.substring(0, ip.lastIndexOf(".")) + "." + end_ip4;		
}


function print_dhcp_sel(obj_value){
	var print_sel = get_by_id("d_dhcp"+ obj_value).value;
	if(print_sel > -1){
		get_by_id("d_host"+ obj_value).value = DHCPL_DataArray[print_sel].Name;
		get_by_id("d_ip"+ obj_value).value = DHCPL_DataArray[print_sel].IP;
		get_by_id("d_mac"+ obj_value).value = DHCPL_DataArray[print_sel].MAC;
	}
}
*/

function disable_ip(){
	var dhcpsvr = get_by_id("dhcpsvr");
	var is_hidden = "";
	
	if(dhcpsvr.checked)
		is_hidden = "";
	else
		is_hidden = "none";
	
	get_by_id("dhcpd_start").disabled = !dhcpsvr.checked;
	get_by_id("dhcpd_end").disabled = !dhcpsvr.checked;
	get_by_id("dhcpd_lease_time").disabled = !dhcpsvr.checked;
	get_by_id("always_broadcast").disabled = !dhcpsvr.checked;
	get_by_id("netbios_announcement").disabled = !dhcpsvr.checked;
	get_by_id("add_reserved").style.display = is_hidden;
	get_by_id("reservation_list").style.display = is_hidden;
	get_by_id("dhcpd_list").style.display = is_hidden;
}

function disable_netbios(){
	if(get_by_id("dhcpsvr").checked){
		get_by_id("netbios_learn").disabled = !get_by_id("netbios_announcement").checked;
		disable_netbios_option(get_by_id("netbios_learn").disabled);
		if(get_by_id("netbios_announcement").checked){
			disable_netbios_option(get_by_id("netbios_learn").checked);
		}
	}else{
		get_by_id("netbios_learn").disabled = true;
		disable_netbios_option(get_by_id("netbios_learn").disabled);
	}
}

function disable_netbios_option(flag){
	get_by_id("dhcpd_static_scope").disabled = flag;
	for(var i = 0; i < 4; i++){
		get_by_name("netbios_node")[i].disabled = flag;
	}
	get_by_id("wins_ip1").disabled = flag;
	get_by_id("wins_ip2").disabled = flag;
}

function update_data(){
	var max_row = parseInt(get_by_id("max_row").value) + 1;
	for(var ii = 0; ii < rule_max_num; ii++){
		if (ii < 10){
			get_by_id("dhcpd_reserve_0" + ii).value = "";
		}else{
			get_by_id("dhcpd_reserve_" + ii).value = "";
		}
	}
	
	for(var ii = 1; ii < max_row; ii++){
		if(DataArray[ii].Name != ""){
			var dat = DataArray[ii].Enable +"/"+ DataArray[ii].Name +"/"+ DataArray[ii].IP +"/"+ DataArray[ii].MAC;
			if ((ii-1) < 10){
				get_by_id("dhcpd_reserve_0" + (ii-1)).value = dat;
			}else{
				get_by_id("dhcpd_reserve_" + (ii-1)).value = dat;
			}
		}
	}
}
function check_dhcp_range(){
		var lan_ip = get_by_id("lan_ipaddr").value.split(".");
		var start_ip3 = get_by_id("dhcpd_start").value.split(".");
		var end_ip3 = get_by_id("dhcpd_end").value.split(".");
		var enrty_IP = lan_ip[2];		
		get_by_id("dhcpd_start").value = lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + start_ip3[3];
		get_by_id("dhcpd_end").value = lan_ip[0] +"."+lan_ip[1]+"." + enrty_IP +"." + end_ip3[3];
		//alert(get_by_id("dhcpd_start").value);alert(get_by_id("dhcpd_end").value);
}

function send_request(){
	//if (!is_form_modified("form1") && !confirm("Nothing has changed, save anyway?")) {
	if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
		return false;
	}
	var dhcpsvr = get_by_id("dhcpsvr");
	//var start_ip4 = get_by_id("start_ip4").value;
	//var end_ip4 = get_by_id("end_ip4").value;
	var start_obj, end_obj;
	var temp_mac = "";
    var ip = get_by_id("lan_ipaddr").value;
	var mask = get_by_id("lan_netmask").value;
	var winsip1 = get_by_id("wins_ip1").value;
	var winsip2 = get_by_id("wins_ip2").value;
	
    var ip_addr_msg = replace_msg(all_ip_addr_msg,which_lang[_ipaddr]);
	var wan_ip_addr_msg = replace_msg(all_ip_addr_msg,which_lang[_ipaddr]);	
	
	var temp_ip_obj = new addr_obj(ip.split("."), ip_addr_msg, false, false);
	var temp_mask_obj = new addr_obj(mask.split("."), subnet_mask_msg, false, false);
	var dhcp_les = get_by_id("dhcpd_lease_time").value;		
	var dhcpd_domain_name = get_by_id("dhcpd_domain_name").value;

    var wan_proto = "<% CmoGetCfg("wan_proto","none"); %>";
    var wan_port_status = "<% CmoGetStatus("wan_port_status"); %>";
	
    var wan_ip_addr_msg = replace_msg(all_ip_addr_msg,which_lang[_ipaddr]);
	var wan_proto = "<% CmoGetCfg("wan_proto","none"); %>";
	var wan_ip_addr;
	
	var temp_wins_ip1_obj = new addr_obj(winsip1.split("."), all_ip_addr_msg, false, false);
	var temp_wins_ip2_obj = new addr_obj(winsip2.split("."), all_ip_addr_msg, false, false);
	
	if (!check_address(temp_ip_obj, temp_mask_obj) || !check_mask(temp_mask_obj)){		
		return false;
	}
	
	//check lan and wan is same subnet    	  
	
	//get from nvram
	if(wan_proto == "static"){
		wan_ip_addr= "<% CmoGetCfg("wan_static_ipaddr"); %>";
	}else if(wan_proto == "pppoe"){
		wan_ip_addr= "<% CmoGetCfg("wan_pppoe_ipaddr_00"); %>";
	}else if(wan_proto == "pptp"){
		wan_ip_addr= "<% CmoGetCfg("wan_pptp_ipaddr"); %>";
	}else if(wan_proto == "l2tp"){
		wan_ip_addr= "<% CmoGetCfg("wan_l2tp_ipaddr"); %>";
	}else{
		var wan_ip_addr1 = get_by_id("wan_current_ipaddr").value.split("/");
		wan_ip_addr = wan_ip_addr1[0];
	}	        
	var wan_ip_addr_obj = new addr_obj(wan_ip_addr.split("."), wan_ip_addr_msg, false, false); 
	     
   if(wan_proto == "static" && wan_ip_addr != "0.0.0.0"){ // when wan static ip doesn't empty
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(which_lang[bln_alert_3]);
			return false;
		}
		
	}else if(wan_proto != "static" & get_by_id("wan_current_ipaddr").value != "0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0/0.0.0.0"){ // /PPTP/L2TP/PPPoE plug in WAN port
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(which_lang[bln_alert_3]);
			return false;
		}
    }else if(wan_proto == "pppoe" && wan_ip_addr != "0.0.0.0"){ // when wan pppoe ip doesn't empty
		if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(which_lang[bln_alert_3]);
			return false;
		}
    }else if(wan_proto == "pptp" && wan_ip_addr != "0.0.0.0"){ // when wan pptp ip doesn't empty
    	if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(which_lang[bln_alert_3]);
			
			return false;
		}
    }else if(wan_proto == "l2tp" && wan_ip_addr != "0.0.0.0"){ // when wan l2tp ip doesn't empty
    	if (check_domain(temp_ip_obj, temp_mask_obj, wan_ip_addr_obj)){
			//alert("LAN and WAN IP Address cann't be set to the same subnet.");
			alert(which_lang[bln_alert_3]);
			return false;
		}
    } 
    
    
	if(Find_word(dhcpd_domain_name,"'") || Find_word(dhcpd_domain_name,'"') || Find_word(dhcpd_domain_name,"/")){
		//alert("Local domain name invalid. The legal characters can not enter ',/,''");
		alert(which_lang[GW_LAN_DOMAIN_NAME_INVALID]);
		return false;
	}
	
	if (dhcpsvr.checked){
		var start_ip = get_by_id("dhcpd_start").value;
		var end_ip = get_by_id("dhcpd_end").value;
		
		var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP address");
		var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP address");

		var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
		var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);

		//check dhcp ip range equal to lan-ip or not?
		if(!check_LAN_ip(temp_ip_obj.addr, start_obj.addr, "Start IP address")){
			return false;
		}		
		if(!check_LAN_ip(temp_ip_obj.addr, end_obj.addr, "End IP Address")){
			return false;
		}
		
		if(!check_LAN_ip(temp_ip_obj.addr, temp_wins_ip1_obj.addr, "Primary WINS IP address")){
			return false;
		}
		
		if(!check_LAN_ip(temp_ip_obj.addr, temp_wins_ip2_obj.addr, "Secondary WINS IP address")){
			return false;
		}
		
		//check dhcp ip range and lan ip the same mask or not?
		if (!check_address(start_obj, temp_mask_obj, temp_ip_obj) || !check_address(end_obj, temp_mask_obj, temp_ip_obj)){
			return false;
		}
		
		if (!check_domain(temp_ip_obj, temp_mask_obj, start_obj)){
			//alert(msg[START_INVALID_DOMAIN]);
			alert(which_lang[TEXT037]);
			return false;
		}
			
		if (!check_domain(temp_ip_obj, temp_mask_obj, end_obj)){
			//alert(msg[END_INVALID_DOMAIN]);
			alert(which_lang[TEXT038]);
			return false;
		}
			
		if (!check_ip_order(start_obj, end_obj)){
			//alert(msg[IP_RANGE_ERROR]);
			alert(which_lang[TEXT039]);
			return false;
		}
		
        if (check_lanip_order(temp_ip_obj,start_obj, end_obj)){
			alert(msg[NETWORK_DHCP_IP_IN_SERVER]);
			return false;
		}

		var less_msg = replace_msg(check_num_msg, which_lang[bd_DLT], 1, 999999);
		var temp_less = new varible_obj(dhcp_les, less_msg, 1, 999999, false);
		if (!check_varible(temp_less)){
    		return false;
    	}

		if(get_by_id("netbios_announcement").checked && !get_by_id("netbios_learn").checked){
			var wins_ip1 = get_by_id("wins_ip1").value;
			var wins_ip2 = get_by_id("wins_ip2").value;
			var wins_ip1_addr_msg = replace_msg(all_ip_addr_msg,which_lang[bd_NETBIOS_PRI_WINS]);
			var wins_ip2_addr_msg = replace_msg(all_ip_addr_msg,which_lang[bd_NETBIOS_SEC_WINS]);
			var wins_ip1_obj = new addr_obj(wins_ip1.split("."), wins_ip1_addr_msg, false, false);
			var wins_ip2_obj = new addr_obj(wins_ip2.split("."), wins_ip2_addr_msg, false, false);

			for(i=0; i<4 ; i++){
				if(!get_by_name("netbios_node")[i].checked && (!check_address(wins_ip1_obj))){
				return false;
				}else{
				if(wins_ip1 !="" && !check_address(wins_ip1_obj)){
					return false;
				}
				if(wins_ip2 !="" && !check_address(wins_ip2_obj)){
					return false;
				}
			}
		}
	}
	}

/*	
	var Res_ip_addr_msg = replace_msg(all_ip_addr_msg,"Reservation IP");
	var check_error = false;
	for(i=0;i<rule_max_num;i++){
		var res_en=(get_by_id("enable"+i).checked?1:0);
		var res_host=get_by_id("d_host"+i).value;
		var res_ip=get_by_id("d_ip"+i).value;
		var res_mac=get_by_id("d_mac"+i).value;
		var temp_res_ip_obj = new addr_obj(res_ip.split("."), Res_ip_addr_msg, false, false);
		if(res_en || res_host != "" || res_ip !="" || res_mac !=""){
			if (res_host == ""){
				get_by_id("d_host"+i).focus();
				alert(msg[STATIC_DHCP_NAME]);
				return false;
			}else if(!check_LAN_ip(temp_ip_obj.addr, temp_res_ip_obj.addr, "Reservation IP address")){
				get_by_id("d_ip"+i).focus();
				return false;
			}else if(!check_address(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
				get_by_id("d_ip"+i).focus();
				return false;
			}else if (!check_domain(temp_res_ip_obj, temp_mask_obj, temp_ip_obj)){
				get_by_id("d_ip"+i).focus();
				alert(msg[SER_NOT_SAME_DOMAIN]);
				return false;
			}else if (!check_mac(res_mac)){
				get_by_id("d_mac"+i).focus();
				//alert(msg[MAC_ADDRESS_ERROR]);
				alert(which_lang[KR3]);
				return false;
			}
			for(jj=0;jj<rule_max_num;jj++){
				if(get_by_id("d_host"+jj).value.length > 0){
					if((get_by_id("d_host"+jj).value == res_host) && (jj != i)){
						alert(msg[STATIC_DHCP_NAME]);
						get_by_id("d_host"+jj).focus();
						check_error = true;
						break;
					}
				}
				if(get_by_id("d_ip"+jj).value.length > 0){
					if((get_by_id("d_ip"+jj).value == res_ip) && (jj != i)){
						get_by_id("d_ip"+jj).focus();
						//alert("IP Address '"+ res_ip +"' is already used.");
						alert("Reserved IP '"+ res_ip +"' conflicts with another reservation");	//GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID
						check_error = true;
						break;
					}
				}
				if(get_by_id("d_mac"+jj).value.length > 0){
					if((get_by_id("d_mac"+jj).value == res_mac) && (jj != i)){
						get_by_id("d_mac"+jj).focus();
						alert("Reserved IP address for this MAC address '"+ res_mac +"' is already set."); //bd_alert_6
						check_error = true;
						break;
					}
				}
			}
			if(check_error){
				return false;
			}
		}
	}
*/

	//decide reboot type
	if((get_by_id("dhcpd_netbios_enable").value == 1) && (get_by_id("dhcpd_netbios_learn").value == 1))//It enables learn NETBIOS from WAN originally.
	{
		if( !(get_checked_value(get_by_id("netbios_announcement")) && get_checked_value(get_by_id("netbios_learn")))) //But, it disables learn NETBIOS from WAN now.
		{	
			//alert("enable->disable");
			get_by_id("reboot_type").value = "all";
		}
	}
	else	//It disables learn NETBIOS from WAN originally.
	{
		if( get_checked_value(get_by_id("netbios_announcement")) && get_checked_value(get_by_id("netbios_learn")) ) //But, it enables learn NETBIOS from WAN now.
		{	
			//alert("disable->enable");
			get_by_id("reboot_type").value = "all";
		}
	}
	
    if (check_address(temp_ip_obj, temp_mask_obj) && check_mask(temp_mask_obj)){
		//change_ip();
		update_data();
		
		get_by_id("dhcpd_enable").value = get_checked_value(get_by_id("dhcpsvr"));
		get_by_id("dns_relay").value = get_checked_value(get_by_id("DNSrelay"));

		get_by_id("dhcpd_always_bcast").value = get_checked_value(get_by_id("always_broadcast"));
		get_by_id("dhcpd_netbios_enable").value = get_checked_value(get_by_id("netbios_announcement"));
		get_by_id("dns_relay").value = get_checked_value(get_by_id("DNSrelay"));
		get_by_id("dhcpd_netbios_learn").value = get_checked_value(get_by_id("netbios_learn"));
		get_by_id("dhcpd_static_node_type").value = get_checked_value(get_by_name("netbios_node"));
		
		get_by_id("dhcpd_static_wins_server").value = get_by_id("wins_ip1").value + "/" + get_by_id("wins_ip2").value;
				
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			return true;
		}else{
			return false;
		}
	}else{
		return false;
	}			
}

function revoke(idx){
	get_by_id("revoke_ip").value = DHCPL_DataArray[idx].IP;
	get_by_id("revoke_mac").value = DHCPL_DataArray[idx].MAC;
	send_submit("form2");
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
<form id="form2" name="form2" method="post" action="dhcp_revoke.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="lan.asp">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="lan.asp">
<input type="hidden" id="revoke_ip" name="revoke_ip">
<input type="hidden" id="revoke_mac" name="revoke_mac">
</form>
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
									<li><div id="sidenavon"><a href="index.asp" onclick="return jump_if();"><script>show_words(which_lang[sa_Internet])</script></a></div></li>
									<li><div id="sidenavon"><a href="wizard_wireless.asp" onclick="return jump_if();"><script>show_words(which_lang[_wirelesst])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[bln_title])</script></div></li>

								</ul>
							</div>
						</td>			
					</tr>
				</table>			
			</td>
       <form id="form1" name="form1" method="post" action="apply.cgi">
	   <input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
	   <input type="hidden" id="html_response_message" name="html_response_message" value="">
	   <script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
	   <input type="hidden" id="html_response_return_page" name="html_response_return_page" value="lan.asp">
       <input type="hidden" id="reboot_type" name="reboot_type" value="lan">
       <input type="hidden" id="del" name="del" value="-1">
	   <input type="hidden" id="edit" name="edit" value="-1">
	   <input type="hidden" id="max_row" name="max_row" value="-1">
	   <input type="hidden" id="mac_clone_addr" name="mac_clone_addr" value="<% CmoGetStatus("mac_clone_addr"); %>">
		<input type="hidden" id="dhcpd_reserve_00" name="dhcpd_reserve_00" value="<% CmoGetCfg("dhcpd_reserve_00","none"); %>">				
		<input type="hidden" id="dhcpd_reserve_01" name="dhcpd_reserve_01" value="<% CmoGetCfg("dhcpd_reserve_01","none"); %>">
		<input type="hidden" id="dhcpd_reserve_02" name="dhcpd_reserve_02" value="<% CmoGetCfg("dhcpd_reserve_02","none"); %>">		
		<input type="hidden" id="dhcpd_reserve_03" name="dhcpd_reserve_03" value="<% CmoGetCfg("dhcpd_reserve_03","none"); %>">				
		<input type="hidden" id="dhcpd_reserve_04" name="dhcpd_reserve_04" value="<% CmoGetCfg("dhcpd_reserve_04","none"); %>">
		<input type="hidden" id="dhcpd_reserve_05" name="dhcpd_reserve_05" value="<% CmoGetCfg("dhcpd_reserve_05","none"); %>">
		<input type="hidden" id="dhcpd_reserve_06" name="dhcpd_reserve_06" value="<% CmoGetCfg("dhcpd_reserve_06","none"); %>">				
		<input type="hidden" id="dhcpd_reserve_07" name="dhcpd_reserve_07" value="<% CmoGetCfg("dhcpd_reserve_07","none"); %>">
		<input type="hidden" id="dhcpd_reserve_08" name="dhcpd_reserve_08" value="<% CmoGetCfg("dhcpd_reserve_08","none"); %>">	
		<input type="hidden" id="dhcpd_reserve_09" name="dhcpd_reserve_09" value="<% CmoGetCfg("dhcpd_reserve_09","none"); %>">
		<input type="hidden" id="dhcpd_reserve_10" name="dhcpd_reserve_10" value="<% CmoGetCfg("dhcpd_reserve_10","none"); %>">				
		<input type="hidden" id="dhcpd_reserve_11" name="dhcpd_reserve_11" value="<% CmoGetCfg("dhcpd_reserve_11","none"); %>">
		<input type="hidden" id="dhcpd_reserve_12" name="dhcpd_reserve_12" value="<% CmoGetCfg("dhcpd_reserve_12","none"); %>">		
		<input type="hidden" id="dhcpd_reserve_13" name="dhcpd_reserve_13" value="<% CmoGetCfg("dhcpd_reserve_13","none"); %>">				
		<input type="hidden" id="dhcpd_reserve_14" name="dhcpd_reserve_14" value="<% CmoGetCfg("dhcpd_reserve_14","none"); %>">
		<input type="hidden" id="dhcpd_reserve_15" name="dhcpd_reserve_15" value="<% CmoGetCfg("dhcpd_reserve_15","none"); %>">
		<input type="hidden" id="dhcpd_reserve_16" name="dhcpd_reserve_16" value="<% CmoGetCfg("dhcpd_reserve_16","none"); %>">				
		<input type="hidden" id="dhcpd_reserve_17" name="dhcpd_reserve_17" value="<% CmoGetCfg("dhcpd_reserve_17","none"); %>">
		<input type="hidden" id="dhcpd_reserve_18" name="dhcpd_reserve_18" value="<% CmoGetCfg("dhcpd_reserve_18","none"); %>">	
		<input type="hidden" id="dhcpd_reserve_19" name="dhcpd_reserve_19" value="<% CmoGetCfg("dhcpd_reserve_19","none"); %>">
		<input type="hidden" id="dhcpd_reserve_20" name="dhcpd_reserve_20" value="<% CmoGetCfg("dhcpd_reserve_20","none"); %>">
		<input type="hidden" id="dhcpd_reserve_21" name="dhcpd_reserve_21" value="<% CmoGetCfg("dhcpd_reserve_21","none"); %>">				
		<input type="hidden" id="dhcpd_reserve_22" name="dhcpd_reserve_22" value="<% CmoGetCfg("dhcpd_reserve_22","none"); %>">
		<input type="hidden" id="dhcpd_reserve_23" name="dhcpd_reserve_23" value="<% CmoGetCfg("dhcpd_reserve_23","none"); %>">	
		<input type="hidden" id="dhcpd_reserve_24" name="dhcpd_reserve_24" value="<% CmoGetCfg("dhcpd_reserve_24","none"); %>">	
		<input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>">
		<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("dhcpd_leased_table"); %>">
			<td valign="top" id="maincontent_container">			  
				<div id="maincontent">
				  
          <div id="box_header"> 
            <h1>
              <script>show_words(which_lang[bln_title_NetSt])</script>
            </h1>
            <script>show_words(which_lang[ns_intro_])</script>
            <br>
            <br>
             <input name="button" id="button" type="submit" class=button_submit value="" onClick="return send_request()">
			<input name="button2" id="button2" type="reset" class=button_submit value="" onclick="page_cancel('form1', 'lan.asp');">
			<script>get_by_id("button").value = which_lang[_savesettings];</script>
			<script>get_by_id("button2").value = which_lang[_dontsavesettings];</script>
		  </div>
				  
          <div class="box"> 
            <h2>
              <script>show_words(which_lang[bln_title_Rtrset])</script>
            </h2>
							
            <p>
              <script>show_words(which_lang[YM97])</script>
            </p>
                            <table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									
                <td class="duple">
                  <script>show_words(which_lang[_ripaddr])</script>
                  :</td>
								  	<td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_ipaddr" type="text" id="lan_ipaddr" size="20" maxlength="15" onChange="check_dhcp_range()" value='<% CmoGetCfg("lan_ipaddr","none"); %>'></td>
								</tr>
								<tr>
									
                <td class="duple">
                  <script>show_words(which_lang[_subnet])</script>
                  :</td>
									<td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_netmask" type="text" id="lan_netmask" size="20" maxlength="15" value="<% CmoGetCfg("lan_netmask","none"); %>"></td>
								</tr>
								<tr>
									<td class="duple">Device Name :</td>
									<td width="340">&nbsp;&nbsp;&nbsp;<input name="lan_device_name" type="text" id="lan_device_name" size="20" maxlength="15" value="<% CmoGetCfg("lan_device_name","none"); %>"></td>
								</tr>
								<tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[_262])</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;
                                  <input name="dhcpd_domain_name" type="text" id="dhcpd_domain_name" size="40" maxlength="30" value="<% CmoGetCfg("dhcpd_domain_name","none"); %>"></td>
							  	</tr>
								<tr>
									
                <td class="duple">
                  <script>show_words(which_lang[bln_EnDNSRelay])</script>
                  :</td>
									<td width="340">&nbsp;
									<input name="DNSrelay" type=checkbox id="DNSrelay" value="1">
									<input type="hidden" id="dns_relay" name="dns_relay" value="<% CmoGetCfg("dns_relay","none"); %>">
									</td>
								</tr>														
					  </table>
				  </div>
				  
          <div class="box"> 
            <h2> 
              <script>show_words(which_lang[bd_title_DHCPSSt])</script>
            </h2>
							<p>
              <script>show_words(which_lang[bd_intro_])</script>
            </p>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_EDSv])</script>
                  :</td>
								  <input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<% CmoGetCfg("dhcpd_enable","none"); %>">
                                  <td width="340">&nbsp;<input name="dhcpsvr" type=checkbox id="dhcpsvr" onClick="disable_ip()" value="1"></td>
                                </tr>
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_DIPAR])</script>
                  :</td>
                                  <td width="340">&nbsp;
									<input type="text" id="dhcpd_start" name="dhcpd_start" value="<% CmoGetCfg("dhcpd_start","none"); %>" size="20" maxlength="15">
                  &nbsp;
                  <script>show_words(which_lang[_to])</script>
                  <input type="text" id="dhcpd_end" name="dhcpd_end" value="<% CmoGetCfg("dhcpd_end","none"); %>" size="20" maxlength="15">
       						      </td>
                                </tr>
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_DLT])</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="dhcpd_lease_time" name="dhcpd_lease_time" size="6" maxlength="6" value="<% CmoGetCfg("dhcpd_lease_time","none"); %>">
                  &nbsp;&nbsp;
                  <script>show_words(which_lang[_minutes])</script>
                </td>
                                </tr>
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_DAB])</script>
                  :</td>
								  <input type="hidden" id="dhcpd_always_bcast" name="dhcpd_always_bcast" value="<% CmoGetCfg("dhcpd_always_bcast","none"); %>">
                                  <td width="340">&nbsp;<input name="always_broadcast" type=checkbox id="always_broadcast" value="1">
                  <script>show_words(which_lang[bd_DAB_note])</script>
                </td>
                                </tr>
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_NETBIOS_ENABLE])</script>
                  :</td>
								  <input type="hidden" id="dhcpd_netbios_enable" name="dhcpd_netbios_enable" value="<% CmoGetCfg("dhcpd_netbios_enable","none"); %>">
                                  <td width="340">&nbsp;<input type=checkbox id="netbios_announcement" name="netbios_announcement" value="1" onClick="disable_netbios();"></td>
                                </tr>
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_NETBIOS_LEARN_FROM_WAN_ENABLE])</script>
                  :</td>
								  <input type="hidden" id="dhcpd_netbios_learn" name="dhcpd_netbios_learn" value="<% CmoGetCfg("dhcpd_netbios_learn","none"); %>">
                                  <td width="340">&nbsp;<input type=checkbox id="netbios_learn" name="netbios_learn" value="1" onClick="disable_netbios();"></td>
                                </tr>
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_NETBIOS_SCOPE])</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="dhcpd_static_scope"  name="dhcpd_static_scope" maxlength="30" value="<% CmoGetCfg("dhcpd_static_scope","none"); %>">
                  (
                  <script>show_words(which_lang[LT124])</script>
                  )</td>
                                </tr>
                                <tr>
                                  
                <td class="duple" valign="top">
                  <script>show_words(which_lang[bd_NETBIOS_REG_TYPE])</script>
                  :</td>
								  <input type="hidden" id="dhcpd_static_node_type" name="dhcpd_static_node_type" value="<% CmoGetCfg("dhcpd_static_node_type","none"); %>">
                                  <td width="340">
								  &nbsp;<input type="radio" id="netbios_node"  name="netbios_node" value="1">
                  						<script>show_words(which_lang[bd_NETBIOS_REG_TYPE_B])</script>
                 						 <br>
								  &nbsp;<input type="radio" id="netbios_node"  name="netbios_node" value="2">
										  <script>show_words(which_lang[bd_NETBIOS_REG_TYPE_P])</script>
										  <br>
								  &nbsp;<input type="radio" id="netbios_node"  name="netbios_node" value="4">
										  <script>show_words(which_lang[bd_NETBIOS_REG_TYPE_M])</script>
										  <br>
								  &nbsp;<input type="radio" id="netbios_node"  name="netbios_node" value="8">
										  <script>show_words(which_lang[bd_NETBIOS_REG_TYPE_H])</script>
                </td>
                                </tr>
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_NETBIOS_PRI_WINS])</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="wins_ip1"  name="wins_ip1" size="20" maxlength="15"></td>
                                </tr>
                                <tr>
                                  
                <td class="duple">
                  <script>show_words(which_lang[bd_NETBIOS_SEC_WINS])</script>
                  :</td>
                                  <td width="340">&nbsp;&nbsp;<input type="text" id="wins_ip2"  name="wins_ip2" size="20" maxlength="15">
								  <input type="hidden" id="dhcpd_static_wins_server" name="dhcpd_static_wins_server" value="<% CmoGetCfg("dhcpd_static_wins_server","none"); %>">
								  </td>
                                </tr>
                    </table>
				  </div>
				  <div class="box" id="add_reserved"> 
						<h2><script>show_words(which_lang[_add])</script> <script>show_words(which_lang[bd_title_SDC])</script></h2>
                          <table width="525" border=0 cellPadding=1 cellSpacing=1 class=formarea summary="">
                                <tr>
                                  <td class="duple"><script>show_words(which_lang[_enable])</script> :</td>
                                  <td width="340">&nbsp;<input type=checkbox id="reserved_enable" name="reserved_enable"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(which_lang[bd_CName])</script> :</td>
                                  <td width="340">&nbsp;
								  	<input type=text id="reserved_name" name="reserved_name" size="20">
									&lt;&lt;
									<select id="reserved_list" name="reserved_list" onChange="set_reserved()">
										<option value=-1><script>show_words(which_lang[bd_CName])</script></option>
										<script>
										set_mac_list("name");
										</script>
									</select>
								  </td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(which_lang[_ipaddr])</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type=text id="reserved_ip" name="reserved_ip" size="20" maxlength="15"></td>
                                </tr>
                                <tr>
                                  <td class="duple"><script>show_words(which_lang[_macaddr])</script> :</td>
                                  <td width="340">&nbsp;&nbsp;<input type=text id="reserved_mac" name="reserved_mac" size="20" maxlength="17"></td>
                                </tr>
								<tr>
									<td class="duple">&nbsp;</td>
									<td width="340">&nbsp;
									 <script>document.write('<input id="clone" name="clone" type="button" class=button_submit value="'+which_lang[_clone]+'" onClick="clone_mac_action();">')</script> 
                					</td>
								</tr>
								<tr>
									<td class="duple">&nbsp;</td>
									<td width="340">&nbsp;
									<input id="save" name="save" type="button" class=button_submit value="" onClick="save_reserved();">
                  					<input id="clear" name="clear" type="button" class=button_submit value="" onClick="clear_reserved();"> 
               						<script>get_by_id("save").value = which_lang[_save];</script>
									<script>get_by_id("clear").value = which_lang[_clear];</script>
								
									</td>
								</tr>
                          </table>
				  </div>
				  
          <div class=box id="reservation_list"> 
            <h2>
              <script>show_words(which_lang[bd_title_list])</script>
            </h2>
	                  <table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
	                      <tr>
							<td><script>show_words(which_lang[_enable])</script></td>
	                        <td><script>show_words(which_lang[help260])</script></td>
	                        <td><script>show_words(which_lang[_macaddr])</script></td>
	                        <td><script>show_words(which_lang[_ipaddr])</script></td>
	                        <td></td>
	                        <td></td>
	                      </tr>
	                    <script>
							set_reservation();
							var is_enable = "";
							for(i = 1; i < DataArray.length; i++){
								if(parseInt(DataArray[i].Enable)){
									is_enable = "checked";
								}else{
									is_enable = "";
								}
								document.write("<tr><td><center><input type=checkbox id=r_enable" + i + " name=r_enable" + i + " onClick='set_reserved_enable(" + i + ")' " + is_enable + "></center></td><td><center>" + DataArray[i].Name +"</td><td><center>" + DataArray[i].MAC +"</center></td><td><center>"+ DataArray[i].IP +"</center></td><td><center><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"'+which_lang[_edit]+'\"></a></center></td><td><center><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"'+which_lang[_delete]+'\"></a></center></td></tr>");
							}
						</script>
	                  </table>
				  </div>
				  <div class=box id="dhcpd_list">
	                  <h2><script>show_words(which_lang[bd_title_clients])</script> <span id="dhcp_num"></span></h2>
	                  <table id="table1" width="525" border=1 cellPadding=1 cellSpacing=1 bgcolor="#DFDFDF" bordercolor="#FFFFFF">
	                      <tr>
	                        <td><script>show_words(which_lang[LS422])</script></td>
	                        <td><script>show_words(which_lang[LS423])</script></td>
	                        <td><script>show_words(which_lang[LS424])</script></td>
	                        <td><script>show_words(which_lang[LS425])</script></td>
	                        <td></td>
	                        <td></td>
	                      </tr>
	                    <script>
							set_lan_dhcp_list();
							for(i=0;i<DHCPL_DataArray.length;i++){
								document.write("<tr><td><center>"+ DHCPL_DataArray[i].MAC +"</center></td><td><center>"+ DHCPL_DataArray[i].IP +"</center></td><td><center>"+ DHCPL_DataArray[i].Name +"</center></td><td><center>"+ DHCPL_DataArray[i].EXP_T +"</center></td><td><center><a href='javascript:revoke(" + i + ")'>Revoke</a></center></td><td><center><a href='javascript:edit_dhcp_client(" + i + ")'>Reserve</a></center></td></tr>");
							}
						</script>
	                  </table>
				  </div>
			</div>
			</td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellSpacing=0 cellPadding=2 bgColor=#ffffff border=0>
                    <tr>
                      
          <td id=help_text><strong> 
            <script>show_words(which_lang[_hints])</script>
            &hellip;</strong> <p>
              <script>show_words(which_lang[TA7])</script>
            </p>
                         
            <p>
              <script>show_words(which_lang[TA8])</script>
            </p>
						 <p><a href="support_internet.asp#Network" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
	set_form_default_values("form1");
</script>
</html>