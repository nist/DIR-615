<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script language="JavaScript"> 
	var dDat = new Array();
	var rDat = new Array();
	var resert_rule = 0;
	var DataArray = new Array();
	var DataArray_Sort = new Array();
	var rule_max_num = 40;
	
	function station_list(){
		var wireless_station_list = get_by_id("wireless_station_list").value;
		dDat = wireless_station_list.split(",");
		for (var i = 0; i < dDat.length - 1 ; i++){
			rDat[i] = dDat[i].split("/");
			document.write("<tr bgcolor=\"#FFFFFF\">");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][0] +"</font></td>");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][5] +"</font></td>");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][2] +"</font></td>");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][4] +"</font></td>");
			document.write("<td><font face=\"Arial\" size=\"2\">"+ rDat[i][1] +"</font></td>");
			document.write("</tr>");
			resert_rule++;
		}
		get_by_id("show_resert").innerHTML = resert_rule;
	}

	//  1/name/ip/netmask/gateway/WAN/metric
	function Data(enable, name, ip_addr, net_mask, gateway, show_inter , metric, show_creator, show_type ,onList) 
	{
		this.Enable = enable;
		this.Name = name;
		this.Ip_addr = ip_addr;
		this.Net_mask = net_mask;
		this.Gateway = gateway;
		this.Interface = change_inter(show_inter);
		this.Metric = metric;
		this.Type = change_type(show_type);
		this.Creator = change_creator(show_creator);
		this.OnList = onList ;
	}

	function change_inter(obj_value){
		var return_word = obj_value;
		if(obj_value == "br0"){
			return_word = "LAN";
		}else if((obj_value == "eth1")|| (obj_value == "WAN")){
			return_word = "INTERNET";
		}else if(obj_value == "lo"){
			return_word = "Local Loopback";
		}
		return return_word;
	}

	function change_creator(obj_value){
		var return_word = obj_value;
		if(obj_value == "0"){
			return_word = "System";
		}else if(obj_value == "1"){
			return_word = "ADMIN";
		}
		return return_word;
	}

	function change_type(obj_value){
		var return_word = obj_value;
		if(obj_value == "0"){
			return_word = "INTERNET";
		}else if(obj_value == "1"){
			return_word = "DHCP Option";
		}else if(obj_value == "2"){
			return_word = "STATIC";
		}else if(obj_value == "3"){
			return_word = "INTRANET";
		}else if(obj_value == "4"){
			return_word = "LOCAL";
		}
		return return_word;
	}


	function DataShow(){
		set_routes();
		metric_sort();
		data_sort();
		for (var i=0; i<DataArray_Sort.length;i++){
			document.write("<tr bgcolor=\"#F0F0F0\">");
			document.write("<td>"+ DataArray_Sort[i].Ip_addr +"</td>");
			document.write("<td>"+ DataArray_Sort[i].Net_mask +"</td>");
			document.write("<td>"+ DataArray_Sort[i].Gateway +"</td>");
			document.write("<td>"+ DataArray_Sort[i].Metric +"</td>");
			document.write("<td>"+ DataArray_Sort[i].Interface +"</td>");
			document.write("<td>"+ DataArray_Sort[i].Type +"</td>");
			document.write("<td>"+ DataArray_Sort[i].Creator +"</td>");
			document.write("</tr>\n");
		}
	}
	
	function metric_sort(){
		// sorting ascending first
		var i=0,j=0;
		DataArray_tmp = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
		for (i=0; i<DataArray.length;i++){
			for(j=0; j < DataArray.length-1 ; j++){
				if(DataArray[j].Metric > DataArray[j+1].Metric){
					DataArray_tmp.Ip_addr = DataArray[j].Ip_addr;
					DataArray_tmp.Net_mask = DataArray[j].Net_mask;
					DataArray_tmp.Gateway = DataArray[j].Gateway;
					DataArray_tmp.Metric = DataArray[j].Metric;
					DataArray_tmp.Interface = DataArray[j].Interface;
					DataArray_tmp.Type = DataArray[j].Type;
					DataArray_tmp.Creator = DataArray[j].Creator;
					
					DataArray[j].Ip_addr = DataArray[j+1].Ip_addr;
					DataArray[j].Net_mask = DataArray[j+1].Net_mask;
					DataArray[j].Gateway = DataArray[j+1].Gateway;
					DataArray[j].Metric = DataArray[j+1].Metric;
					DataArray[j].Interface = DataArray[j+1].Interface;
					DataArray[j].Type = DataArray[j+1].Type;
					DataArray[j].Creator = DataArray[j+1].Creator;
					
					DataArray[j+1].Ip_addr = DataArray_tmp.Ip_addr;
					DataArray[j+1].Net_mask = DataArray_tmp.Net_mask;
					DataArray[j+1].Gateway = DataArray_tmp.Gateway;
					DataArray[j+1].Metric = DataArray_tmp.Metric;
					DataArray[j+1].Interface = DataArray_tmp.Interface;
					DataArray[j+1].Type = DataArray_tmp.Type;
					DataArray[j+1].Creator = DataArray_tmp.Creator;
				}
			}
		}
	}
	
	function data_sort(){
		//sorting group
		var j = DataArray_Sort.length;
		// Grouping Type = INTERNET, Creator = System, 
		for (var i=0; i<DataArray.length;i++){
			if((DataArray[i].Type == "INTERNET") && (DataArray[i].Creator == "System")){
				DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
				DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
				DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
				DataArray_Sort[j].Gateway = DataArray[i].Gateway;
				DataArray_Sort[j].Metric = DataArray[i].Metric;
				DataArray_Sort[j].Interface = DataArray[i].Interface;
				DataArray_Sort[j].Type = DataArray[i].Type;
				DataArray_Sort[j].Creator = DataArray[i].Creator;
				j++;
			}
		}
		// Grouping Type = DHCP Option, Creator = System, 
		for (var i=0; i<DataArray.length;i++){
			if((DataArray[i].Type == "DHCP Option") && (DataArray[i].Creator == "System")){
				DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
				DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
				DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
				DataArray_Sort[j].Gateway = DataArray[i].Gateway;
				DataArray_Sort[j].Metric = DataArray[i].Metric;
				DataArray_Sort[j].Interface = DataArray[i].Interface;
				DataArray_Sort[j].Type = DataArray[i].Type;
				DataArray_Sort[j].Creator = DataArray[i].Creator;
				j++;
			}
		}
		// Grouping Type = INTRANET, Creator = System, 
		for (var i=0; i<DataArray.length;i++){
			if((DataArray[i].Type == "INTRANET") && (DataArray[i].Creator == "System")){
				DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
				DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
				DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
				DataArray_Sort[j].Gateway = DataArray[i].Gateway;
				DataArray_Sort[j].Metric = DataArray[i].Metric;
				DataArray_Sort[j].Interface = DataArray[i].Interface;
				DataArray_Sort[j].Type = DataArray[i].Type;
				DataArray_Sort[j].Creator = DataArray[i].Creator;
				j++;
			}
		}
		// Grouping Type = LOCAL, Creator = System, 
		for (var i=0; i<DataArray.length;i++){
			if((DataArray[i].Type == "LOCAL") && (DataArray[i].Creator == "System")){
				DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
				DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
				DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
				DataArray_Sort[j].Gateway = DataArray[i].Gateway;
				DataArray_Sort[j].Metric = DataArray[i].Metric;
				DataArray_Sort[j].Interface = DataArray[i].Interface;
				DataArray_Sort[j].Type = DataArray[i].Type;
				DataArray_Sort[j].Creator = DataArray[i].Creator;
				j++;
			}
		}
		// Grouping Type = STATIC, Creator = ADMIN, 
		for (var i=0; i<DataArray.length;i++){
			if((DataArray[i].Type == "STATIC") && (DataArray[i].Creator == "ADMIN")){
				DataArray_Sort[j] = new Data(0,0, 0, 0, 0, 0,0, 0, 0, 1);
				DataArray_Sort[j].Ip_addr = DataArray[i].Ip_addr;
				DataArray_Sort[j].Net_mask = DataArray[i].Net_mask;
				DataArray_Sort[j].Gateway = DataArray[i].Gateway;
				DataArray_Sort[j].Metric = DataArray[i].Metric;
				DataArray_Sort[j].Interface = DataArray[i].Interface;
				DataArray_Sort[j].Type = DataArray[i].Type;
				DataArray_Sort[j].Creator = DataArray[i].Creator;
				j++;
			}
		}
		
		DataArray_Sort.length = j;
	}

	function set_routes(){
		var index = 1;
		for (var i=0;i<rule_max_num;i++){
			var temp_st;
			var k=i;
			if(parseInt(i,10)<10){
				k="0"+i;
			}
			temp_st = (get_by_id("static_routing_" + k).value).split("/");
			if (temp_st.length > 1){
				if(temp_st[1] != "" && temp_st[0] != "0"){ //only show enabled static routing rules			
					DataArray[DataArray.length++] = new Data(temp_st[0],temp_st[1], temp_st[2], temp_st[3], temp_st[4], temp_st[5], temp_st[6], 1, 2, index);
					index++;
				}
			}
		}
		
		var myData = get_by_id("routing_table").value.split(",");
		var temp_data;
		for (var i=0 ; i<myData.length;i++){
			temp_data = myData[i].split("/");
			if(temp_data.length > 1){				
				var is_not_check= true;
				for(var j=0;j<DataArray.length;j++){
					if(temp_data[0] == DataArray[j].Ip_addr && temp_data[1] == DataArray[j].Net_mask && temp_data[2] == DataArray[j].Gateway){
						is_not_check = false;
						break;
					}
				}
				if(is_not_check){
					DataArray[DataArray.length++] = new Data(0, i , temp_data[0], temp_data[1], temp_data[2], temp_data[3], temp_data[4], temp_data[5], temp_data[6], index);
					index++;
				}
			}	
				
		}
	}	

</script>
<title>D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
<style type="text/css">
<!--
.style4 {
	font-size: 11px;
	font-weight: bold;
}
-->
</style>
</head>

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<table id="header_container" border="0" cellpadding="5" cellspacing="0" width="838" align="center">
       <tr>
        <td width="100%">&nbsp;&nbsp;<script>show_words(which_lang[TA2])</script>: <a href="http://support.dlink.com.tw/">DIR-825</a></td>
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
			<td id="topnavoff"><a href="index.asp"><script>show_words(which_lang[_setup])</script></a></td>
			<td id="topnavoff"><a href="adv_virtual.asp"><script>show_words(which_lang[_advanced])</script></a></td>
			<td id="topnavoff"><a href="tools_admin.asp"><script>show_words(which_lang[_tools])</script></a></td>
			<td id="topnavon"><a href="st_device.asp"><script>show_words(which_lang[_status])</script></a></td>
			<td id="topnavoff"><a href="support_men.asp"><script>show_words(which_lang[_support])</script></a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
			<td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id="sidenav">
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="st_device.asp"><script>show_words(which_lang[_devinfo])</script></a></div></li>
									<li><div><a href="st_log.asp"><script>show_words(which_lang[_logs])</script></a></div></li>
									<li><div><a href="st_stats.asp"><script>show_words(which_lang[_stats])</script></a></div></li>
									<li><div><a href="internet_sessions.asp"><script>show_words(which_lang[YM157])</script></a></div></li>
									<li><div id="sidenavoff"><script>show_words(which_lang[_routing])</script></div></li>
									<li><div><a href="st_wireless.asp"><script>show_words(which_lang[_wireless])</script></a></div></li>
                                    <@ ipv6 <li><div style=" text-transform:none"><a href="st_ipv6.asp">IPv6</a></div></li> @>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>
					</tr>
                <td>
                 <!-- repeat name="extTab" -->
                </td>
				</table>			
			</td>
			<form id="form1" name="form1" method="post" action=apply.cgi>
<input type="hidden" id="html_response_page" name="html_response_page" value="st_wireless.asp">
<input type="hidden" id="html_response_message" name="html_response_message" value="The setting is saved.">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_wireles.asp">
<input type="hidden" id="wireless_station_list" name="wireless_station_list" value="<% CmoGetList("wireless_station_list"); %>">
				<input type="hidden" id="static_routing_00" name="static_routing_00" value="<% CmoGetCfg("static_routing_00","none"); %>">
				<input type="hidden" id="static_routing_01" name="static_routing_01" value="<% CmoGetCfg("static_routing_01","none"); %>">
				<input type="hidden" id="static_routing_02" name="static_routing_02" value="<% CmoGetCfg("static_routing_02","none"); %>">
				<input type="hidden" id="static_routing_03" name="static_routing_03" value="<% CmoGetCfg("static_routing_03","none"); %>">
				<input type="hidden" id="static_routing_04" name="static_routing_04" value="<% CmoGetCfg("static_routing_04","none"); %>">
				<input type="hidden" id="static_routing_05" name="static_routing_05" value="<% CmoGetCfg("static_routing_05","none"); %>">
				<input type="hidden" id="static_routing_06" name="static_routing_06" value="<% CmoGetCfg("static_routing_06","none"); %>">
				<input type="hidden" id="static_routing_07" name="static_routing_07" value="<% CmoGetCfg("static_routing_07","none"); %>">
				<input type="hidden" id="static_routing_08" name="static_routing_08" value="<% CmoGetCfg("static_routing_08","none"); %>">
				<input type="hidden" id="static_routing_09" name="static_routing_09" value="<% CmoGetCfg("static_routing_09","none"); %>">
				<input type="hidden" id="static_routing_10" name="static_routing_10" value="<% CmoGetCfg("static_routing_10","none"); %>">
				<input type="hidden" id="static_routing_11" name="static_routing_11" value="<% CmoGetCfg("static_routing_11","none"); %>">
				<input type="hidden" id="static_routing_12" name="static_routing_12" value="<% CmoGetCfg("static_routing_12","none"); %>">
				<input type="hidden" id="static_routing_13" name="static_routing_13" value="<% CmoGetCfg("static_routing_13","none"); %>">
				<input type="hidden" id="static_routing_14" name="static_routing_14" value="<% CmoGetCfg("static_routing_14","none"); %>">
				<input type="hidden" id="static_routing_15" name="static_routing_15" value="<% CmoGetCfg("static_routing_15","none"); %>">
				<input type="hidden" id="static_routing_16" name="static_routing_16" value="<% CmoGetCfg("static_routing_16","none"); %>">
				<input type="hidden" id="static_routing_17" name="static_routing_17" value="<% CmoGetCfg("static_routing_17","none"); %>">
				<input type="hidden" id="static_routing_18" name="static_routing_18" value="<% CmoGetCfg("static_routing_18","none"); %>">
				<input type="hidden" id="static_routing_19" name="static_routing_19" value="<% CmoGetCfg("static_routing_19","none"); %>">
				<input type="hidden" id="static_routing_20" name="static_routing_20" value="<% CmoGetCfg("static_routing_20","none"); %>">
				<input type="hidden" id="static_routing_21" name="static_routing_21" value="<% CmoGetCfg("static_routing_21","none"); %>">
				<input type="hidden" id="static_routing_22" name="static_routing_22" value="<% CmoGetCfg("static_routing_22","none"); %>">
				<input type="hidden" id="static_routing_23" name="static_routing_23" value="<% CmoGetCfg("static_routing_23","none"); %>">
				<input type="hidden" id="static_routing_24" name="static_routing_24" value="<% CmoGetCfg("static_routing_24","none"); %>">
				<input type="hidden" id="static_routing_25" name="static_routing_25" value="<% CmoGetCfg("static_routing_25","none"); %>">
				<input type="hidden" id="static_routing_26" name="static_routing_26" value="<% CmoGetCfg("static_routing_26","none"); %>">
				<input type="hidden" id="static_routing_27" name="static_routing_27" value="<% CmoGetCfg("static_routing_27","none"); %>">
				<input type="hidden" id="static_routing_28" name="static_routing_28" value="<% CmoGetCfg("static_routing_28","none"); %>">
				<input type="hidden" id="static_routing_29" name="static_routing_29" value="<% CmoGetCfg("static_routing_29","none"); %>">
				<input type="hidden" id="static_routing_30" name="static_routing_30" value="<% CmoGetCfg("static_routing_30","none"); %>">
				<input type="hidden" id="static_routing_31" name="static_routing_31" value="<% CmoGetCfg("static_routing_31","none"); %>">
				<input type="hidden" id="static_routing_32" name="static_routing_32" value="<% CmoGetCfg("static_routing_32","none"); %>">
				<input type="hidden" id="static_routing_33" name="static_routing_33" value="<% CmoGetCfg("static_routing_33","none"); %>">
				<input type="hidden" id="static_routing_34" name="static_routing_34" value="<% CmoGetCfg("static_routing_34","none"); %>">
				<input type="hidden" id="static_routing_35" name="static_routing_35" value="<% CmoGetCfg("static_routing_35","none"); %>">
				<input type="hidden" id="static_routing_36" name="static_routing_36" value="<% CmoGetCfg("static_routing_36","none"); %>">
				<input type="hidden" id="static_routing_37" name="static_routing_37" value="<% CmoGetCfg("static_routing_37","none"); %>">
				<input type="hidden" id="static_routing_38" name="static_routing_38" value="<% CmoGetCfg("static_routing_38","none"); %>">
				<input type="hidden" id="static_routing_39" name="static_routing_39" value="<% CmoGetCfg("static_routing_39","none"); %>">
				<input type="hidden" id="static_routing_40" name="static_routing_40" value="<% CmoGetCfg("static_routing_40","none"); %>">
				<input type="hidden" id="static_routing_41" name="static_routing_41" value="<% CmoGetCfg("static_routing_41","none"); %>">
				<input type="hidden" id="static_routing_42" name="static_routing_42" value="<% CmoGetCfg("static_routing_42","none"); %>">
				<input type="hidden" id="static_routing_43" name="static_routing_43" value="<% CmoGetCfg("static_routing_43","none"); %>">
				<input type="hidden" id="static_routing_44" name="static_routing_44" value="<% CmoGetCfg("static_routing_44","none"); %>">
				<input type="hidden" id="static_routing_45" name="static_routing_45" value="<% CmoGetCfg("static_routing_45","none"); %>">
				<input type="hidden" id="static_routing_46" name="static_routing_46" value="<% CmoGetCfg("static_routing_46","none"); %>">
				<input type="hidden" id="static_routing_47" name="static_routing_47" value="<% CmoGetCfg("static_routing_47","none"); %>">
				<input type="hidden" id="static_routing_48" name="static_routing_48" value="<% CmoGetCfg("static_routing_48","none"); %>">
				<input type="hidden" id="static_routing_49" name="static_routing_49" value="<% CmoGetCfg("static_routing_49","none"); %>">
				<input type="hidden" id="routing_table" name="routing_table" value="<% CmoGetList("routing_table"); %>">
				
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
					<div id="box_header"> 
						<h1><script>show_words(which_lang[_routing])</script></h1>
						<b><p><script>show_words(which_lang[sr_RTable])</script></p></b>
						<p><script>show_words(which_lang[sr_intro])</script></p>
					</div>
					<div class="box"> 
						<h2><script>show_words(which_lang[sr_RTable])</script><span id="show_resert"></span></h2>
							<table cellSpacing=1 cellPadding=2 width=525 bgcolor="#FFFFFF">
                              <tr>
							    <TD><b><script>show_words(which_lang[_destip])</script></b></TD>
							    <TD><b><script>show_words(which_lang[_netmask])</script></b></TD>
							    <TD><b><script>show_words(which_lang[_gateway])</script></b></TD>
							    <TD><b><script>show_words(which_lang[_metric])</script></b></TD>
							    <TD><b><script>show_words(which_lang[_interface])</script></b></TD>
								<TD><b>Type</b></TD>
							    <TD><b><script>show_words(which_lang[_creator])</script></b></TD>
                              </tr>
                              <script>
                              	DataShow(); 
							  </script>
                            </table>
					</div>
                </div></td></form>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id=help_text><strong></strong>
                      	<p></p>
                      	<p class="more"></p>
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
</html>
