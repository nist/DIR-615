﻿<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="ko.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript">
	var submit_button_flag = 0;
	var rule_max_num = 10;
	var DataArray = new Array();
	var DataArray_detail = new Array(10);
	function onPageLoad(){
		set_form_default_values("form1");
	}
	//name/action/used(vs/port/wan/remote)
	function Data(name, action, used, onList) 
	{
		this.Name = name;
		this.Action = action;
		this.Used = used;
		this.Show_W = "";
		this.OnList = onList;
		var sActionW = "Allow"
		if(action =="deny"){
			sActionW = "Deny";
		}
		this.sAction = sActionW;
	}
	
	function Detail_Data(enable, ip_start, ip_end) 
	{
		this.Enable = enable;
		this.Ip_start = ip_start;
		this.Ip_end = ip_end;
	}
	
	function set_Inbound(){
		var index = 0;
		for (var i = 0; i < rule_max_num; i++){
			var temp_st;
			var temp_A;
			var temp_B;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("inbound_filter_name_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[0] != ""){
					DataArray[DataArray.length++] = new Data(temp_st[0], temp_st[1], temp_st[2], index);
					temp_A = get_by_id("inbound_filter_ip_"+ k +"_A").value.split(",");
					DataArray_detail[index] = new Array();
					var temp_ip_rang = 0;
					for(j=0;j<temp_A.length;j++){
						var temp_A_e = temp_A[j].split("/");
						var temp_A_ip = temp_A_e[1].split("-");
						DataArray_detail[index][temp_ip_rang] = new Detail_Data(temp_A_e[0], temp_A_ip[0], temp_A_ip[1]);
						temp_ip_rang++;
						if(temp_A_e[0] == "1"){
							var T_IP_R = temp_A_e[1];
							if(temp_A_e[1] == "0.0.0.0-255.255.255.255"){
								T_IP_R = "*";
							}
							if(DataArray[index].Show_W !=""){
								DataArray[index].Show_W = DataArray[index].Show_W + ",";
							}
							DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
						}
					}
					temp_B = get_by_id("inbound_filter_ip_"+ k +"_B").value.split(",");
					for(j=0;j<temp_B.length;j++){
						var temp_B_e = temp_B[j].split("/");
						var temp_B_ip = temp_B_e[1].split("-");
						DataArray_detail[index][temp_ip_rang] = new Detail_Data(temp_B_e[0], temp_B_ip[0], temp_B_ip[1]);
						temp_ip_rang++;
						if(temp_B_e[0] == "1"){
							var T_IP_R = temp_B_e[1];
							if(temp_B_e[1] == "0.0.0.0-255.255.255.255"){
								T_IP_R = "*";
							}
							if(DataArray[index].Show_W !=""){
								DataArray[index].Show_W = DataArray[index].Show_W + ",";
							}
							DataArray[index].Show_W = DataArray[index].Show_W + T_IP_R;
						}
					}
					index++;
				}
			}
		}
	}
	
	function edit_row(obj){
		get_by_id("edit").value = obj;
		get_by_id("ingress_filter_name").value = DataArray[obj].Name;
		set_selectIndex(DataArray[obj].Action, get_by_id("action_select"));
		for(j=0;j<DataArray_detail[obj].length;j++){
			set_checked(DataArray_detail[obj][j].Enable, get_by_id("entry_enable_"+j));
			get_by_id("ip_start_"+j).value = DataArray_detail[obj][j].Ip_start;
			get_by_id("ip_end_"+j).value = DataArray_detail[obj][j].Ip_end;
		}
		get_by_id("button1").value = which_lang[YM34];;
	}
	
	function del_row(obj){
		if(DataArray[obj].Used == "0000"){
		//if(confirm("Are you sure you want to delete : " + DataArray[obj].Name)){
		if(confirm(which_lang[YM35]+" : "+ DataArray[obj].Name)){
			delete_data(obj);
		}
		}else{
            if(confirm(which_lang[YM35]+" : "+ DataArray[obj].Name)){
			//alert(DataArray[obj].Name + " is used.");
			alert('이름"'+ DataArray[obj].Name +'" 이 이미 사용중입니다.');//GW_QOS_RULES_NAME_ALREADY_USED
		}
}
	}
	
	function delete_data(num){
		for(i=num ; i<DataArray.length-1 ;i++){
			DataArray[i].Name = DataArray[i+1].Name;
			DataArray[i].Action = DataArray[i+1].Action;
			DataArray[i].Used = DataArray[i+1].Used;
			DataArray[i].Show_W = DataArray[i+1].Show_W;
			DataArray[i].sAction = DataArray[i+1].sAction;
			DataArray[i].OnList = DataArray[i+1].OnList;
			for(j=0;j<DataArray_detail[i].length;j++){
				DataArray_detail[i][j].Enable = DataArray_detail[i+1][j].Enable;
				DataArray_detail[i][j].Ip_start = DataArray_detail[i+1][j].Ip_start;
				DataArray_detail[i][j].Ip_end = DataArray_detail[i+1][j].Ip_end;
			}
		}
		--DataArray.length;
		--DataArray_detail[DataArray.length].length;
		save_date();
	}
	
	function send_request(){
		if(get_by_id("ingress_filter_name").value.length > 0){
			//if (!is_form_modified("form1") && !confirm(msg[FORM_MODIFIED_CHECK])) {
			if (!is_form_modified("form1") && !confirm(which_lang[_ask_nochange])) {
				return false;
			}
			var index = parseInt(get_by_id("edit").value,10);
			if(index > -1){
				//if(!confirm("Are you sure you want to update : " + get_by_id("ingress_filter_name").value)){
				if(!confirm(which_lang[YM38]+" : " + get_by_id("ingress_filter_name").value)){
					return false;
				}else{
						if(DataArray[index].Used != "0000"){
									//alert(DataArray[index].Name +" is used.");
									 alert(DataArray[index].Name +" 이 이미 사용중입니다.");
									return false;
				}
							}
			
				if((index < 0) && (DataArray.length >= rule_max_num)){
					//alert("Inbound filter is must smaller than "+ rule_max_num);//TEXT013
					alert(which_lang[TEXT013]+ rule_max_num);
					return false;
				}
			}
			if(get_by_id("ingress_filter_name").value == "Allow All" || get_by_id("ingress_filter_name").value == "Deny All"){
				//alert("Name can not set to the same as default Inbound filter name 'Allow All' or 'Deny All'.");
				alert(which_lang[TEXT014]);
				return false;
			}
			for(var i = 0; i < DataArray.length; i++){
				if(DataArray[i].Name==get_by_id("ingress_filter_name").value){
					if(DataArray[i].Name != "" && index==(DataArray[i].OnList)){
						continue;
					}else{
						//alert('Name "'+ get_by_id("ingress_filter_name").value +'" is already used!');	//GW_QOS_RULES_NAME_ALREADY_USED
						alert("이름 "+ get_by_id("ingress_filter_name").value +" 이 이미 사용중입니다.");
						return false;
					}			
				}
			}
			var is_checked = false;
			for(i=0;i<8;i++){
				var start_ip = get_by_id("ip_start_"+i).value;
				var end_ip = get_by_id("ip_end_"+i).value;
				
				var start_ip_addr_msg = replace_msg(all_ip_addr_msg,"Start IP address");
				var end_ip_addr_msg = replace_msg(all_ip_addr_msg,"End IP address");
				var start_obj = new addr_obj(start_ip.split("."), start_ip_addr_msg, false, false);
				var end_obj = new addr_obj(end_ip.split("."), end_ip_addr_msg, false, false);
				
				if (!check_ip_order(start_obj, end_obj)){
					alert(msg[IP_RANGE_ERROR]);
					//alert("Start IP address must be less than end IP address");
					return false;
				}
				
				if (!is_ipv4_valid(start_ip)) {
					//alert("Invalid IP address: " + start_ip + ".");
					alert(which_lang[KR2] +" : " + start_ip + ".");
					get_by_id("ip_start_"+i).select();
					get_by_id("ip_start_"+i).focus();
					return false;
				}
				
				if (!is_ipv4_valid(end_ip)) {
					//alert("Invalid IP address: " + end_ip + ".");
					alert(which_lang[KR2] +" : " + end_ip + ".");
					get_by_id("ip_end_"+i).select();
					get_by_id("ip_end_"+i).focus();
					return false;
				}

				if(get_by_id("entry_enable_"+i).checked){
					for(j=i+1;j<8;j++){
						if(get_by_id("entry_enable_"+j).checked && (start_ip == get_by_id("ip_start_"+j).value && end_ip == get_by_id("ip_end_"+j).value)){
							//alert("This IP Rang '"+ start_ip +"-"+ end_ip +"' is duplicated.");
							alert("The inbound filter range '"+ start_ip +"-"+ end_ip +"'  is duplicated."); //ai_alert_7
						 	// alert("流入封包過濾器範圍"+ start_ip +"-"+ end_ip +"重複.");	//ai_alert_7

							
							return false;
						}
					}
					is_checked = true;
				}
			}
			if(!is_checked){
				//alert("Enable at least one Source IP Rang for '"+ get_by_id("ingress_filter_name").value +"'.");
				alert("Enable at least one Source IP Range for '"+ get_by_id("ingress_filter_name").value +"'.");	//ai_alert_5
				//alert("啟用至少一筆來源IP範圍"+ get_by_id("ingress_filter_name").value +"");	//ai_alert_5
				return false;
			}
			if(index > -1){
				DataArray[index].Name = get_by_id("ingress_filter_name").value;
				DataArray[index].Action = get_by_id("action_select").value;
				for(j=0;j<DataArray_detail[index].length;j++){
					DataArray_detail[index][j].Enable = get_checked_value(get_by_id("entry_enable_"+j));
					DataArray_detail[index][j].Ip_start = get_by_id("ip_start_"+j).value;
					DataArray_detail[index][j].Ip_end = get_by_id("ip_end_"+j).value;
				}
			}else{
				var T_num = DataArray.length;
				DataArray[DataArray.length++] = new Data(get_by_id("ingress_filter_name").value, get_by_id("action_select").value, "0000", T_num);
				DataArray_detail[T_num] = new Array();
				for(i=0;i<8;i++){
					DataArray_detail[T_num][i] = new Detail_Data(get_checked_value(get_by_id("entry_enable_"+i)), get_by_id("ip_start_"+i).value, get_by_id("ip_end_"+i).value);
				}
			}
			save_date();
		}else{
			//alert(msg[INBOUND_NAME_ERROR]);
			alert(which_lang[GW_FIREWALL_RULE_NAME_INVALID]);
			return false;
		}
	}
	function save_date(){
		for(var i=0; i<rule_max_num; i++){
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			get_by_id("inbound_filter_name_" + k).value = "";
			get_by_id("inbound_filter_ip_"+ k +"_A").value = "";
			get_by_id("inbound_filter_ip_"+ k +"_B").value = "";
			if(i<DataArray.length){
				var temp_st = DataArray[i].Name +"/"+ DataArray[i].Action +"/"+ DataArray[i].Used;
				var temp_A = "";
				var temp_B = "";
				for(j=0;j<5;j++){
					if(temp_A !=""){
						temp_A = temp_A + ",";
					}
					temp_A = temp_A + DataArray_detail[i][j].Enable +"/"+ DataArray_detail[i][j].Ip_start +"-"+ DataArray_detail[i][j].Ip_end;
				}
				for(j=5;j<DataArray_detail[i].length;j++){
					if(temp_B !=""){
						temp_B = temp_B + ",";
					}
					temp_B = temp_B + DataArray_detail[i][j].Enable +"/"+ DataArray_detail[i][j].Ip_start +"-"+ DataArray_detail[i][j].Ip_end;
				}
				get_by_id("inbound_filter_name_" + k).value = temp_st;
				get_by_id("inbound_filter_ip_"+ k +"_A").value = temp_A;
				get_by_id("inbound_filter_ip_"+ k +"_B").value = temp_B;
			}
		}
		
		if(submit_button_flag == 0){
			submit_button_flag = 1;
			get_by_id("form1").submit();
		}
	}
</script>
<title>D-Link 회사 | 무선 라우터 | 홈</title>
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
                          	<ul>
				    		<LI><div><a href="adv_virtual.asp"><script>show_words(which_lang[_virtserv])</script></a></div></LI>
                         	<LI><div><a href="adv_portforward.asp" onclick="return jump_if();"><script>show_words(which_lang[_pf])</script></a></div></LI>
                    		<LI><div><a href="adv_appl.asp" onclick="return jump_if();"><script>show_words(which_lang[_specappsr])</script></a></div></LI>
							<LI><div><a href="adv_qos.asp" onclick="return jump_if();"><script>show_words(which_lang[YM48])</script></a></div></LI>
                            <LI><div><a href="adv_filters_mac.asp" onclick="return jump_if();"><script>show_words(which_lang[_netfilt])</script></a></div></LI>
							<LI><div><a href="adv_access_control.asp" onclick="return jump_if();"><script>show_words(which_lang[_acccon])</script></a></div></LI>
							<LI><div><a href="adv_filters_url.asp" onclick="return jump_if();"><script>show_words(which_lang[_websfilter])</script></a></div></LI>
							<LI><div id=sidenavoff><script>show_words(which_lang[_inboundfilter])</script></div></LI>
	                        <LI><div><a href="adv_dmz.asp" onclick="return jump_if();"><script>show_words(which_lang[_firewalls])</script></a></div></LI>
	                        <LI><div><a href="adv_wlan_perform.asp" onclick="return jump_if();"><script>show_words(which_lang[_adwwls])</script></a></div></LI>
	                         <@ wish <LI><div><a href="adv_wish.asp" onclick="return jump_if();">WISH</a></div></LI> @>
	                        <LI><div><a href="adv_network.asp" onclick="return jump_if();"><script>show_words(which_lang[_advnetwork])</script></a></div></LI>
	                        <@ ipv6 <LI><div style=" text-transform:none"><a href="adv_ipv6_sel_wan.asp" onclick="return jump_if();">IPv6 </a></div></LI> @>
	      					</ul>
			</div>
		     </td>
                    </tr>
                </table></td>
                <form id="form1" name="form1" method="post" action="apply.cgi">
				<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
				<input type="hidden" id="html_response_message" name="html_response_message" value="">
				<script>get_by_id("html_response_message").value = which_lang[sc_intro_sv];</script>
				<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="Inbound_Filter.asp">
				<input type="hidden" id="reboot_type" name="reboot_type" value="filter">
                <input type="hidden" id="inbound_filter_name_00" name="inbound_filter_name_00" value="<% CmoGetCfg("inbound_filter_name_00","none"); %>">
                <input type="hidden" id="inbound_filter_name_01" name="inbound_filter_name_01" value="<% CmoGetCfg("inbound_filter_name_01","none"); %>">
                <input type="hidden" id="inbound_filter_name_02" name="inbound_filter_name_02" value="<% CmoGetCfg("inbound_filter_name_02","none"); %>">
                <input type="hidden" id="inbound_filter_name_03" name="inbound_filter_name_03" value="<% CmoGetCfg("inbound_filter_name_03","none"); %>">
                <input type="hidden" id="inbound_filter_name_04" name="inbound_filter_name_04" value="<% CmoGetCfg("inbound_filter_name_04","none"); %>">
                <input type="hidden" id="inbound_filter_name_05" name="inbound_filter_name_05" value="<% CmoGetCfg("inbound_filter_name_05","none"); %>">
                <input type="hidden" id="inbound_filter_name_06" name="inbound_filter_name_06" value="<% CmoGetCfg("inbound_filter_name_06","none"); %>">
                <input type="hidden" id="inbound_filter_name_07" name="inbound_filter_name_07" value="<% CmoGetCfg("inbound_filter_name_07","none"); %>">
                <input type="hidden" id="inbound_filter_name_08" name="inbound_filter_name_08" value="<% CmoGetCfg("inbound_filter_name_08","none"); %>">
                <input type="hidden" id="inbound_filter_name_09" name="inbound_filter_name_09" value="<% CmoGetCfg("inbound_filter_name_09","none"); %>">
                <input type="hidden" id="inbound_filter_name_10" name="inbound_filter_name_10" value="<% CmoGetCfg("inbound_filter_name_10","none"); %>">
                <input type="hidden" id="inbound_filter_name_11" name="inbound_filter_name_11" value="<% CmoGetCfg("inbound_filter_name_11","none"); %>">
                <input type="hidden" id="inbound_filter_name_12" name="inbound_filter_name_12" value="<% CmoGetCfg("inbound_filter_name_12","none"); %>">
                <input type="hidden" id="inbound_filter_name_13" name="inbound_filter_name_13" value="<% CmoGetCfg("inbound_filter_name_13","none"); %>">
                <input type="hidden" id="inbound_filter_name_14" name="inbound_filter_name_14" value="<% CmoGetCfg("inbound_filter_name_14","none"); %>">
                <input type="hidden" id="inbound_filter_name_15" name="inbound_filter_name_15" value="<% CmoGetCfg("inbound_filter_name_15","none"); %>">
                <input type="hidden" id="inbound_filter_name_16" name="inbound_filter_name_16" value="<% CmoGetCfg("inbound_filter_name_16","none"); %>">
                <input type="hidden" id="inbound_filter_name_17" name="inbound_filter_name_17" value="<% CmoGetCfg("inbound_filter_name_17","none"); %>">
                <input type="hidden" id="inbound_filter_name_18" name="inbound_filter_name_18" value="<% CmoGetCfg("inbound_filter_name_18","none"); %>">
                <input type="hidden" id="inbound_filter_name_19" name="inbound_filter_name_19" value="<% CmoGetCfg("inbound_filter_name_19","none"); %>">
                <input type="hidden" id="inbound_filter_name_20" name="inbound_filter_name_20" value="<% CmoGetCfg("inbound_filter_name_20","none"); %>">
                <input type="hidden" id="inbound_filter_name_21" name="inbound_filter_name_21" value="<% CmoGetCfg("inbound_filter_name_21","none"); %>">
                <input type="hidden" id="inbound_filter_name_22" name="inbound_filter_name_22" value="<% CmoGetCfg("inbound_filter_name_22","none"); %>">
                <input type="hidden" id="inbound_filter_name_23" name="inbound_filter_name_23" value="<% CmoGetCfg("inbound_filter_name_23","none"); %>">

                <input type="hidden" id="inbound_filter_ip_00_A" name="inbound_filter_ip_00_A" value="<% CmoGetCfg("inbound_filter_ip_00_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_01_A" name="inbound_filter_ip_01_A" value="<% CmoGetCfg("inbound_filter_ip_01_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_02_A" name="inbound_filter_ip_02_A" value="<% CmoGetCfg("inbound_filter_ip_02_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_03_A" name="inbound_filter_ip_03_A" value="<% CmoGetCfg("inbound_filter_ip_03_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_04_A" name="inbound_filter_ip_04_A" value="<% CmoGetCfg("inbound_filter_ip_04_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_05_A" name="inbound_filter_ip_05_A" value="<% CmoGetCfg("inbound_filter_ip_05_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_06_A" name="inbound_filter_ip_06_A" value="<% CmoGetCfg("inbound_filter_ip_06_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_07_A" name="inbound_filter_ip_07_A" value="<% CmoGetCfg("inbound_filter_ip_07_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_08_A" name="inbound_filter_ip_08_A" value="<% CmoGetCfg("inbound_filter_ip_08_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_09_A" name="inbound_filter_ip_09_A" value="<% CmoGetCfg("inbound_filter_ip_09_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_10_A" name="inbound_filter_ip_10_A" value="<% CmoGetCfg("inbound_filter_ip_10_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_11_A" name="inbound_filter_ip_11_A" value="<% CmoGetCfg("inbound_filter_ip_11_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_12_A" name="inbound_filter_ip_12_A" value="<% CmoGetCfg("inbound_filter_ip_12_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_13_A" name="inbound_filter_ip_13_A" value="<% CmoGetCfg("inbound_filter_ip_13_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_14_A" name="inbound_filter_ip_14_A" value="<% CmoGetCfg("inbound_filter_ip_14_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_15_A" name="inbound_filter_ip_15_A" value="<% CmoGetCfg("inbound_filter_ip_15_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_16_A" name="inbound_filter_ip_16_A" value="<% CmoGetCfg("inbound_filter_ip_16_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_17_A" name="inbound_filter_ip_17_A" value="<% CmoGetCfg("inbound_filter_ip_17_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_18_A" name="inbound_filter_ip_18_A" value="<% CmoGetCfg("inbound_filter_ip_18_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_19_A" name="inbound_filter_ip_19_A" value="<% CmoGetCfg("inbound_filter_ip_19_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_20_A" name="inbound_filter_ip_20_A" value="<% CmoGetCfg("inbound_filter_ip_20_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_21_A" name="inbound_filter_ip_21_A" value="<% CmoGetCfg("inbound_filter_ip_21_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_22_A" name="inbound_filter_ip_22_A" value="<% CmoGetCfg("inbound_filter_ip_22_A","none"); %>">
                <input type="hidden" id="inbound_filter_ip_23_A" name="inbound_filter_ip_23_A" value="<% CmoGetCfg("inbound_filter_ip_23_A","none"); %>">
                
                <input type="hidden" id="inbound_filter_ip_00_B" name="inbound_filter_ip_00_B" value="<% CmoGetCfg("inbound_filter_ip_00_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_01_B" name="inbound_filter_ip_01_B" value="<% CmoGetCfg("inbound_filter_ip_01_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_02_B" name="inbound_filter_ip_02_B" value="<% CmoGetCfg("inbound_filter_ip_02_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_03_B" name="inbound_filter_ip_03_B" value="<% CmoGetCfg("inbound_filter_ip_03_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_04_B" name="inbound_filter_ip_04_B" value="<% CmoGetCfg("inbound_filter_ip_04_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_05_B" name="inbound_filter_ip_05_B" value="<% CmoGetCfg("inbound_filter_ip_05_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_06_B" name="inbound_filter_ip_06_B" value="<% CmoGetCfg("inbound_filter_ip_06_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_07_B" name="inbound_filter_ip_07_B" value="<% CmoGetCfg("inbound_filter_ip_07_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_08_B" name="inbound_filter_ip_08_B" value="<% CmoGetCfg("inbound_filter_ip_08_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_09_B" name="inbound_filter_ip_09_B" value="<% CmoGetCfg("inbound_filter_ip_09_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_10_B" name="inbound_filter_ip_10_B" value="<% CmoGetCfg("inbound_filter_ip_10_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_11_B" name="inbound_filter_ip_11_B" value="<% CmoGetCfg("inbound_filter_ip_11_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_12_B" name="inbound_filter_ip_12_B" value="<% CmoGetCfg("inbound_filter_ip_12_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_13_B" name="inbound_filter_ip_13_B" value="<% CmoGetCfg("inbound_filter_ip_13_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_14_B" name="inbound_filter_ip_14_B" value="<% CmoGetCfg("inbound_filter_ip_14_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_15_B" name="inbound_filter_ip_15_B" value="<% CmoGetCfg("inbound_filter_ip_15_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_16_B" name="inbound_filter_ip_16_B" value="<% CmoGetCfg("inbound_filter_ip_16_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_17_B" name="inbound_filter_ip_17_B" value="<% CmoGetCfg("inbound_filter_ip_17_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_18_B" name="inbound_filter_ip_18_B" value="<% CmoGetCfg("inbound_filter_ip_18_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_19_B" name="inbound_filter_ip_19_B" value="<% CmoGetCfg("inbound_filter_ip_19_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_20_B" name="inbound_filter_ip_20_B" value="<% CmoGetCfg("inbound_filter_ip_20_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_21_B" name="inbound_filter_ip_21_B" value="<% CmoGetCfg("inbound_filter_ip_21_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_22_B" name="inbound_filter_ip_22_B" value="<% CmoGetCfg("inbound_filter_ip_22_B","none"); %>">
                <input type="hidden" id="inbound_filter_ip_23_B" name="inbound_filter_ip_23_B" value="<% CmoGetCfg("inbound_filter_ip_23_B","none"); %>">
                <input type="hidden" id="edit" name="edit" value="-1">
			<td valign="top" id="maincontent_container">
				<div id=maincontent>				  
                  
          <div id=box_header> 
            <h1>
              <script>show_words(which_lang[_inboundfilter])</script>
            </h1>
                    
            <p>
              <script>show_words(which_lang[ai_intro_1])</script>
            </p>
                    
            <p> 
              <script>show_words(which_lang[ai_intro_2])</script>
              <script>show_words(which_lang[ai_intro_3])</script>
            </p>
                  </div>
                  <div class=box>
                    <h2><span id="inbound_filter_name_rule_title"><script>show_words(which_lang[_add])</script></span> <script>show_words(which_lang[ai_title_IFR])</script></h2>
                    <table cellSpacing=1 cellPadding=2 width=500 border=0>
                        <tr>
                          
                <td align=right class="duple">
                  <script>show_words(which_lang[_name])</script>
                  :</td>
                          <td>
						  	<input type="text" id="ingress_filter_name" size="20" maxlength="15">
                          </td>
                        </tr>
                        <tr>
                          
                <td align=right class="duple">
                  <script>show_words(which_lang[ai_Action])</script>
                  :</td>
                          <td>
						  	<select id="action_select">
						  		<option value="allow"><script>show_words(which_lang[_allow])</script></option>
						  		<option value="deny"><script>show_words(which_lang[_deny])</script></option>
						  	</select>
                          </td>
                        </tr>
                        <tr>
                          
                <td align=right valign="top" class="duple">
                  <script>show_words(which_lang[at_ReIPR])</script>
                  :</td>
                          <td>
						  	<table cellSpacing=1 cellPadding=2 width=300 border=0>
						  		<tr>
						  			
                      <td>
                        <script>show_words(which_lang[_enable])</script></td>
			<td><script>show_words(which_lang[KR5])</script></td>
			<td><script>show_words(which_lang[KR6])</script></td>
						  		</tr>
						  		<script>
						  			for(i=0;i<8;i++){
						  				document.write("<tr>")
						  				document.write("<td align=\"middle\"><INPUT type=\"checkbox\" id=\"entry_enable_"+ i +"\" id=\"entry_enable_"+ i +"\" value=\"1\"></td>")
						  				document.write("<td><input id=\"ip_start_" + i + "\" name=\"ip_start_" + i + "\" size=\"15\" maxlength=\"15\" value=\"0.0.0.0\"></td>")
						  				document.write("<td><input id=\"ip_end_" + i + "\" name=\"ip_end_" + i + "\" size=\"15\" maxlength=\"15\" value=\"255.255.255.255\"></td>")
										document.write("</tr>")
						  			}
						  		</script>
						  	</table>
                          </td>
                        </tr>
                        <tr>
                          <td></td>
                          
                <td> 
                  <input name="button1" id="button1" type="button" class=button_submit value="" onClick="send_request()"> 
                  <input name="button2" id="button2" type="reset" class=button_submit value="">
				  <script>get_by_id("button1").value = which_lang[_add];</script>
				  <script>get_by_id("button2").value = which_lang[_clear];</script>
                </td>
                        </tr>
                    </table>
                  </div>
                  
          <div class=box> 
            <h2>
              <script>show_words(which_lang[ai_title_IFRL])</script>
            </h2>
                    <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
                        <tr align=center>
                          
                <td align=middle width=20>
                  <script>show_words(which_lang[_name])</script>
                </td>
                          
                <td align=middle width=20>
                  <script>show_words(which_lang[ai_Action])</script>
                </td>
                          
                <td width="255">
                  <script>show_words(which_lang[at_ReIPR])</script>
                </td>
                          <td align=middle width=20><b>&nbsp;</b></td>
                          <td align=middle width=20><b>&nbsp;</b></td>
                        </tr>
                        <script>
						set_Inbound();
						for(var i=0;i<DataArray.length;i++){
							document.write("<tr>")
							document.write("<td>"+ DataArray[i].Name +"</td>")
							document.write("<td>"+ DataArray[i].sAction +"</td>")
							document.write("<td>"+ DataArray[i].Show_W +"</td>")
							document.write("<td><a href=\"javascript:edit_row("+ i +")\"><img src=\"edit.jpg\" border=\"0\" alt=\"edit\"></a></td>")
							document.write("<td><a href=\"javascript:del_row(" + i +")\"><img src=\"delete.jpg\"  border=\"0\" alt=\"delete\"></a></td>")
							document.write("</tr>")
						}
					  </script>
                    </table>
                  </div>
			  </div>
			</td>
		</form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table width="125" border=0 
      cellPadding=2 cellSpacing=0 borderColor=#ffffff borderColorLight=#ffffff borderColorDark=#ffffff bgColor=#ffffff>
                    <tr>
                      
          <td id=help_text><strong> 
            <script>show_words(which_lang[_hints])</script>
            &hellip;</strong> <p>
              <script>show_words(which_lang[hhai_name])</script>
            </p>
						
            <p>
              <script>show_words(which_lang[hhai_action])</script>
            </p>
						
            <p>
              <script>show_words(which_lang[hhai_ipr])</script>
            </p>
						
            <p>
              <script>show_words(which_lang[hhai_ip])</script>
            </p>
						
            <p>
              <script>show_words(which_lang[hhai_save])</script>
            </p>
						
            <p>
              <script>show_words(which_lang[hhai_edit])</script>
            </p>
						
            <p>
              <script>show_words(which_lang[hhai_delete])</script>
            </p>
						<p class="more"><a href="support_adv.asp#Inbound_Filter" onclick="return jump_if();"><script>show_words(which_lang[_more])</script>&hellip;</a></p>
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
