<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script>
	function set_mac_info(){
		var temp_dhcp_list = get_by_id("dhcp_list").value.split(",");
		
		for (var i = 0; i < temp_dhcp_list.length; i++){	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length != 0){		
				if(temp_data.length > 1){
					document.write("<tr><td>" + temp_data[0] + "</td><td>" + temp_data[1] + "</td><td>" + temp_data[2] + "</td></tr>")
				}
			}
		}
	}
	
	function set_igmp_info(){
		var temp_igmp = get_by_id("igmp_list").value.split(",");
		
		for (var i = 0; i < temp_igmp.length; i++){	
			if(temp_igmp.length > 1){
				document.write("<tr><td>" + temp_igmp[i] + "</td></tr>")
			}
		}
	}
	

	function dhcp_renew(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form2");
		}
	}
	
	function dhcp_release(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form3");
		}
	}
	
	function pppoe_connect(){
		get_by_id("connect").disabled = "true"
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form4");
		}
	}
	
	function pppoe_disconnect(){
		get_by_id("disconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form5");
		}
	}
	
	function pptp_connect(){
		get_by_id("pptpconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form6");
		}
	}
	
	function pptp_disconnect(){
		get_by_id("pptpdisconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form7");
		}
	}
	
	function l2tp_connect(){
		get_by_id("l2tpconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form8");
		}
	}
	
	function l2tp_disconnect(){
		get_by_id("l2tpdisconnect").disabled = "true";
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form9");
		}
	}
	
	function bigpond_connect(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form10");
		}
	}
	
	function bigpond_disconnect(){
		var login_who="<% CmoGetStatus("get_current_user"); %>";
		if(login_who== "user"){
			window.location.href ="back.asp";
		}else{
			send_submit("form11");
		}
	}
	
	var nNow,gTime;
	function get_time(){
		if (gTime){
			return;
		}
		var gTime = "<% CmoGetStatus("system_time"); %>";
		var time = gTime.split("/");
		gTime = month[time[1]-1] + " " + time[2] + ", " + time[0] + " " + time[3] + ":" + time[4] + ":" + time[5];		
		nNow = new Date(gTime);
	}

	function STime(){
		nNow.setTime(nNow.getTime() + 1000);
		get_by_id("show_time").innerHTML = nNow.toLocaleString();
		setTimeout('STime()', 1000);
	}
	function padout(number)
		{
			return (number < 10) ? '0' + number : number;
		}


	var wTimesec, wan_time;
	var temp, days = 0, hours = 0, mins = 0, secs = 0;
	function caculate_time(){
	
		var wTime = wTimesec;
		var days = Math.floor(wTime / 86400);
			wTime %= 86400;
			var hours = Math.floor(wTime / 3600);
			wTime %= 3600;
			var mins = Math.floor(wTime / 60);
			wTime %= 60;

			wan_time = days + " " + 
				((days <= 1) 
					? "Day"
					: "Days")
				+ ", ";
			wan_time += hours + ":" + padout(mins) + ":" + padout(wTime);
		
	}
	
	function get_wan_time(){
		wTimesec = <% CmoGetStatus("wan_uptime"); %>;
		if(wTimesec == 0){
			wan_time = "N/A";
		}else{
			caculate_time();
		}
	}
	
	function WTime(){
		get_by_id("show_uptime").innerHTML = wan_time;
		if(wTimesec != 0){
			wTimesec++;
			caculate_time();
		}
		setTimeout('WTime()', 1000);
	}

function xmldoc(){ 
	var init_status=get_by_id("connection_type").innerHTML;
	var position;
	var fix_or_dynamic_ip ="";
	position = get_by_id("connection_type");

	if (init_status == "")	{
		if(get_by_id("wan_proto").value == "static"){
			position.innerHTML = "Fixed IP";
		}else if(get_by_id("wan_proto").value == "dhcpc"){
			position.innerHTML = "DHCP Client " +  " <input type=\"button\" value=\"DHCP Release\" name=\"release\" onClick=\"dhcp_release()\">&nbsp;<input type=\"button\" value=\"DHCP Renew\" name=\"renew\" id=\"renew\" onClick=\"dhcp_renew()\">";		
		}else if((get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value != "1")){			
			if(get_by_id("wan_pppoe_dynamic_00").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "PPPoE Disconnected " + " <input type=button id=\"connect\" name=\"connect\" value=\"Connect\" onClick=\"pppoe_connect()\">&nbsp;<input type=button name=\"disconnect\" id=\"disconnect\" value=\"Disconnect\" onClick=\"pppoe_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value == "1")){			
			if(get_by_id("wan_pppoe_dynamic_00").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia PPPoE Disconnected " + " <input type=button id=\"connect\" name=\"connect\" value=\"Connect\" onClick=\"pppoe_connect()\">&nbsp;<input type=button name=\"disconnect\" id=\"disconnect\" value=\"Disconnect\" onClick=\"pppoe_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value != "1")){			
			if(get_by_id("wan_pptp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "PPTP Disconnected " + " <input type=button id=\"pptpconnect\" name=\"pptpconnect\" value=\"Connect\" onClick=\"pptp_connect()\">&nbsp;<input type=button name=\"pptpdisconnect\" id=\"pptpdisconnect\" value=\"Disconnect\" onClick=\"pptp_disconnect()\">";
		}else if((get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value != "1")){			
			if(get_by_id("wan_l2tp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "L2TP Disconnected " + " <input type=button id=\"l2tpconnect\" name=\"l2tpconnect\" value=\"Connect\" onClick=\"l2tp_connect()\">&nbsp;<input type=button name=\"l2tpdisconnect\" id=\"l2tpdisconnect\" value=\"Disconnect\" onClick=\"l2tp_disconnect()\">";
		}else if(get_by_id("wan_proto").value == "bigpond"){
			position.innerHTML = "Bigpond Client Disconnected " +  " <input type=\"button\" value=\"Bigpond Login\" name=\"bpalogin\" id=\"bpalogin\" onClick=\"bigpond_connect()\">&nbsp;<input type=\"button\" value=\"Bigpond Logout\" name=\"bpalogout\" id=\"bpalogout\" onClick=\"bigpond_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value == "1")){			
			if(get_by_id("wan_pptp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia PPTP Disconnected " + " <input type=button id=\"pptpconnect\" name=\"pptpconnect\" value=\"Connect\" onClick=\"pptp_connect()\">&nbsp;<input type=button name=\"pptpdisconnect\" id=\"pptpdisconnect\" value=\"Disconnect\" onClick=\"pptp_disconnect()\">";
		}else if((get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value == "1")){			
			if(get_by_id("wan_l2tp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia L2TP Disconnected " + " <input type=button id=\"l2tpconnect\" name=\"l2tpconnect\" value=\"Connect\" onClick=\"l2tp_connect()\">&nbsp;<input type=button name=\"l2tpdisconnect\" id=\"l2tpdisconnect\" value=\"Disconnect\" onClick=\"l2tp_disconnect()\">";
		}else{
			alert("connect type none");
		}
		get_by_id("wan_ip").innerHTML = "0.0.0.0";
		get_by_id("wan_netmask").innerHTML = "0.0.0.0";
		get_by_id("wan_gateway").innerHTML = "0.0.0.0";
		get_by_id("wan_dns1").innerHTML = "0.0.0.0";
		get_by_id("wan_dns2").innerHTML = " ";
		
	}
	
	
	if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
		var dns1; 
		var dns2;
		//wan status		
		con_status = xmlhttp.responseXML.getElementsByTagName("wan_connection_status")[0].firstChild.nodeValue; 
		
		if(get_by_id("wan_proto").value == "static"){
			position.innerHTML = "Fixed IP";
		}else if(get_by_id("wan_proto").value == "dhcpc"){
			position.innerHTML = "DHCP Client " +  con_status + "<br><input type=\"button\" value=\"DHCP Release\" name=\"release\" onClick=\"dhcp_release()\">&nbsp;<input type=\"button\" value=\"DHCP Renew\" name=\"renew\" id=\"renew\" onClick=\"dhcp_renew()\">";		
		}else if((get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value != "1")){			
			if(get_by_id("wan_pppoe_dynamic_00").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "PPPoE "+ fix_or_dynamic_ip + con_status + " <br><input type=button id=\"connect\" name=\"connect\" value=\"Connect\" onClick=\"pppoe_connect()\">&nbsp;<input type=button name=\"disconnect\" id=\"disconnect\" value=\"Disconnect\" onClick=\"pppoe_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value == "1")){			
			if(get_by_id("wan_pppoe_dynamic_00").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia PPPoE "+ fix_or_dynamic_ip + con_status + " <br><input type=button id=\"connect\" name=\"connect\" value=\"Connect\" onClick=\"pppoe_connect()\">&nbsp;<input type=button name=\"disconnect\" id=\"disconnect\" value=\"Disconnect\" onClick=\"pppoe_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value != "1")){			
			if(get_by_id("wan_pptp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "PPTP "+ fix_or_dynamic_ip + con_status + " <br><input type=button id=\"pptpconnect\" name=\"pptpconnect\" value=\"Connect\" onClick=\"pptp_connect()\">&nbsp;<input type=button name=\"pptpdisconnect\" id=\"pptpdisconnect\" value=\"Disconnect\" onClick=\"pptp_disconnect()\">";
		}else if((get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value != "1")){			
			if(get_by_id("wan_l2tp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "L2TP "+ fix_or_dynamic_ip + con_status + " <br><input type=button id=\"l2tpconnect\" name=\"l2tpconnect\" value=\"Connect\" onClick=\"l2tp_connect()\">&nbsp;<input type=button name=\"l2tpdisconnect\" id=\"l2tpdisconnect\" value=\"Disconnect\" onClick=\"l2tp_disconnect()\">";
		}else if(get_by_id("wan_proto").value == "bigpond"){
			position.innerHTML = "Bigpond Client " + con_status + " <br><input type=\"button\" value=\"Bigpond Login\" name=\"bpalogin\" id=\"bpalogin\" onClick=\"bigpond_connect()\">&nbsp;<input type=\"button\" value=\"Bigpond Logout\" name=\"bpalogout\" id=\"bpalogout\" onClick=\"bigpond_disconnect()\">";			
		}else if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value == "1")){			
			if(get_by_id("wan_pptp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia PPTP "+ fix_or_dynamic_ip + con_status + " <br><input type=button id=\"pptpconnect\" name=\"pptpconnect\" value=\"Connect\" onClick=\"pptp_connect()\">&nbsp;<input type=button name=\"pptpdisconnect\" id=\"pptpdisconnect\" value=\"Disconnect\" onClick=\"pptp_disconnect()\">";
		}else if((get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value == "1")){			
			if(get_by_id("wan_l2tp_dynamic").value == "0")
				fix_or_dynamic_ip = "Fixed IP ";
			position.innerHTML = "Russia L2TP "+ fix_or_dynamic_ip + con_status + " <br><input type=button id=\"l2tpconnect\" name=\"l2tpconnect\" value=\"Connect\" onClick=\"l2tp_connect()\">&nbsp;<input type=button name=\"l2tpdisconnect\" id=\"l2tpdisconnect\" value=\"Disconnect\" onClick=\"l2tp_disconnect()\">";
		}else{
			alert("connect type none");
		}

		//Check is wan current IP or russia phyical IP:2008/08/27 GraceYang
		var dat = get_by_id("wan_current_ipaddr").value.split("/");
				if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value == "1")
				||(get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value == "1")
				||(get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value == "1"))
				{	
					if(dat[0] == "0.0.0.0")
					{
					var temp_russia_wan_phy_ipaddr = get_by_id("russia_wan_phy_ipaddr").value.split("/");
					get_by_id("wan_ip").innerHTML = temp_russia_wan_phy_ipaddr[0];
					get_by_id("wan_netmask").innerHTML = temp_russia_wan_phy_ipaddr[1];
					get_by_id("wan_gateway").innerHTML = temp_russia_wan_phy_ipaddr[2];			
					get_by_id("wan_dns1").innerHTML = temp_russia_wan_phy_ipaddr[3];
						if(temp_russia_wan_phy_ipaddr[4])
							get_by_id("wan_dns2").innerHTML = temp_russia_wan_phy_ipaddr[4];
						else
							get_by_id("wan_dns2").innerHTML = "";
					}else{
						var temp_wan_current_ipaddr = get_by_id("wan_current_ipaddr").value.split("/");
						get_by_id("wan_ip").innerHTML = temp_wan_current_ipaddr[0];
						get_by_id("wan_netmask").innerHTML = temp_wan_current_ipaddr[1];
						get_by_id("wan_gateway").innerHTML = temp_wan_current_ipaddr[2];			
						get_by_id("wan_dns1").innerHTML = temp_wan_current_ipaddr[3];
						if(temp_wan_current_ipaddr[4])
						get_by_id("wan_dns2").innerHTML = temp_wan_current_ipaddr[4];
						else
						get_by_id("wan_dns2").innerHTML = "";
					}
				}
			
			
			if((get_by_id("wan_proto").value == "pptp")&&(get_by_id("wan_pptp_russia_enable").value == "1")
				||(get_by_id("wan_proto").value == "pppoe")&&(get_by_id("wan_pppoe_russia_enable").value == "1")
				||(get_by_id("wan_proto").value == "l2tp")&&(get_by_id("wan_l2tp_russia_enable").value == "1"))
				{	
					if(dat[0] == "0.0.0.0")
					{       get_by_id("wan_ip").innerHTML = xmlhttp.responseXML.getElementsByTagName("phy_wan_ip")[0].firstChild.nodeValue; 	
							get_by_id("wan_netmask").innerHTML = xmlhttp.responseXML.getElementsByTagName("phy_wan_netmask")[0].firstChild.nodeValue;		
							get_by_id("wan_gateway").innerHTML = xmlhttp.responseXML.getElementsByTagName("phy_wan_default_gateway")[0].firstChild.nodeValue;
							dns1 =  get_by_id("wan_dns1");
							dns1_value =xmlhttp.responseXML.getElementsByTagName("phy_wan_primary_dns")[0].firstChild.nodeValue;
							dns2 =  get_by_id("wan_dns2");
							dns2_value =xmlhttp.responseXML.getElementsByTagName("phy_wan_secondary_dns")[0].firstChild.nodeValue;
						
							if (dns1_value == "(null)" ){
								dns1_value="";
								dns1.innerHTML = dns1_value;
							}else{
								dns1.innerHTML = dns1_value;
							}
							
							if (dns2_value == "(null)" ){
								dns2_value="";
								dns2.innerHTML = dns2_value;
							}else{
								dns2.innerHTML = dns2_value;
							}
						
							if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2_value !=" " && dns2.innerHTML !="0.0.0.0"){
								dns1.innerHTML = dns1_value ;
								dns2.innerHTML = dns2_value ;
							}else if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2.innerHTML =="0.0.0.0"){
								dns1.innerHTML = dns1_value;
								dns2.innerHTML = " ";
							}else if(dns2 !=" " && dns2.innerHTML !="0.0.0.0" ){	
								dns2.innerHTML = dns2_value;
							}else{
								dns1.innerHTML = "0.0.0.0";
								dns2.innerHTML = " ";
							}
					}else{
							get_by_id("wan_ip").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_ip")[0].firstChild.nodeValue; 	
							get_by_id("wan_netmask").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_netmask")[0].firstChild.nodeValue;		
							get_by_id("wan_gateway").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_default_gateway")[0].firstChild.nodeValue;
							dns1 =  get_by_id("wan_dns1");
							dns1_value =xmlhttp.responseXML.getElementsByTagName("wan_primary_dns")[0].firstChild.nodeValue;
							dns2 =  get_by_id("wan_dns2");
							dns2_value =xmlhttp.responseXML.getElementsByTagName("wan_secondary_dns")[0].firstChild.nodeValue;
						
							if (dns1_value == "(null)" ){
								dns1_value="";
								dns1.innerHTML = dns1_value;
							}else{
								dns1.innerHTML = dns1_value;
							}
							if (dns2_value == "(null)" ){
								dns2_value="";
								dns2.innerHTML = dns2_value;
							}else{
								dns2.innerHTML = dns2_value;
		}
			  		
							if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2_value !=" " && dns2.innerHTML !="0.0.0.0"){
								dns1.innerHTML = dns1_value ;
								dns2.innerHTML = dns2_value ;
							}else if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2.innerHTML =="0.0.0.0"){
								dns1.innerHTML = dns1_value;
								dns2.innerHTML = " ";
							}else if(dns2 !=" " && dns2.innerHTML !="0.0.0.0" ){	
								dns2.innerHTML = dns2_value;
							}else{
								dns1.innerHTML = "0.0.0.0";
								dns2.innerHTML = " ";
							}
						}
				}else{//not Russia mode
							get_by_id("wan_ip").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_ip")[0].firstChild.nodeValue; 	
							get_by_id("wan_netmask").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_netmask")[0].firstChild.nodeValue;		
							get_by_id("wan_gateway").innerHTML = xmlhttp.responseXML.getElementsByTagName("wan_default_gateway")[0].firstChild.nodeValue;
							dns1 =  get_by_id("wan_dns1");
							dns1_value =xmlhttp.responseXML.getElementsByTagName("wan_primary_dns")[0].firstChild.nodeValue;
							dns2 =  get_by_id("wan_dns2");
							dns2_value =xmlhttp.responseXML.getElementsByTagName("wan_secondary_dns")[0].firstChild.nodeValue;
						
							if (dns1_value == "(null)" ){
								dns1_value="";
								dns1.innerHTML = dns1_value;
							}else{
								dns1.innerHTML = dns1_value;
							}
							if (dns2_value == "(null)" ){
								dns2_value="";
								dns2.innerHTML = dns2_value;
							}else{
								dns2.innerHTML = dns2_value;
							}
		
							if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2_value !=" " && dns2.innerHTML !="0.0.0.0"){
								dns1.innerHTML = dns1_value ;
								dns2.innerHTML = dns2_value ;
							}else if(dns1_value !=" " && dns1.innerHTML !="0.0.0.0" && dns2.innerHTML =="0.0.0.0"){
								dns1.innerHTML = dns1_value ;
								dns2.innerHTML = " ";
							}else if(dns2 !=" " && dns2.innerHTML !="0.0.0.0" ){	
								dns2.innerHTML = dns2_value;
							}else{
								dns1.innerHTML = "0.0.0.0";
								dns2.innerHTML = " ";
							}
						}
		
		//show cable status ;show network status
		wan_port_status = xmlhttp.responseXML.getElementsByTagName("wan_cable_status")[0].firstChild.nodeValue;
		wan_port_check = xmlhttp.responseXML.getElementsByTagName("wan_network_status")[0].firstChild.nodeValue;
		if(wan_port_status == "connect"){
			cable_status.innerHTML = "Connected";
				if(wan_port_check == "1"){
					network_status.innerHTML = "Established";
				}else{
					network_status.innerHTML = "Disconnecting";
							}
		}else{
			cable_status.innerHTML = "Disconnected";
			network_status.innerHTML = "Disconnected";
		}
			  		
	
		//wlan status
		d = get_by_id("wlan_channel");
		channel = xmlhttp.responseXML.getElementsByTagName("wlan_channel")[0].firstChild.nodeValue;
		if(channel !="(null)" )
			d.innerHTML = channel;
		else
			d.innerHTML = " ";
			
			
		//show wan_up time
		wTimesec = xmlhttp.responseXML.getElementsByTagName("wan_uptime")[0].firstChild.nodeValue;
		if(wTimesec == 0){
			wan_time = "N/A";
		}else{
			caculate_time();
		}
			
	}
}

	function get_File() {
		xmlhttp = createRequest(); 
		if(xmlhttp){
		var url;
			var lan_ip="<% CmoGetCfg("lan_ipaddr","none"); %>";
			var temp_cURL = document.URL.split("/");
			var mURL = temp_cURL[2];
			if(mURL == lan_ip){
					url="http://"+lan_ip+"/device.xml=device_status";
			}else{
					url="http://"+mURL+"/device.xml=device_status";
			}
			
		xmlhttp.onreadystatechange = xmldoc; 
		xmlhttp.open("GET", url, true); 
		xmlhttp.send(null); 
		}
		setTimeout("get_File()",3000);
	}
	
	
	function createRequest() {
		var XMLhttpObject = null;
		try {
			XMLhttpObject = new XMLHttpRequest();
		} catch (e) {
		try {
			XMLhttpObject = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
		try {
			XMLhttpObject = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e) {
			return null;
		}
		}
	}
		return XMLhttpObject;
	}

</script>
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style3 {font-size: 12px}
.style4 {
	font-size: 11px;
	font-weight: bold;
}
.style5 {font-size: 11px}
-->
</style>
</head>
<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("local_lan_ip"); %>">
<input type="hidden" id="igmp_list" name="igmp_list" value="<% CmoGetList("igmp_table"); %>">
<form id="form1" name="form1" method="post" action="st_device.cgi">
<input type="hidden" id="html_response_page" name="html_response_page" value="back.asp">
<input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp">

<input type="hidden" id="wan_current_ipaddr" name="wan_current_ipaddr" value="<% CmoGetStatus("wan_current_ipaddr_00"); %>">
<input type="hidden" id="wan_proto" name="wan_proto" value="<% CmoGetCfg("wan_proto","none"); %>">
<input type="hidden" id="wan_pppoe_dynamic_00" name="wan_pppoe_dynamic_00" value="<% CmoGetCfg("wan_pppoe_dynamic_00","none"); %>">
<input type="hidden" id="wan_pptp_dynamic" name="wan_pptp_dynamic" value="<% CmoGetCfg("wan_pptp_dynamic","none"); %>">
<input type="hidden" id="wan_l2tp_dynamic" name="wan_l2tp_dynamic" value="<% CmoGetCfg("wan_l2tp_dynamic","none"); %>">
<input type="hidden" id="dhcpd_enable" name="dhcpd_enable" value="<% CmoGetCfg("dhcpd_enable","none"); %>">

<input type="hidden" id="dhcpc_connection_status" name="dhcpc_connection_status" value="<% CmoGetStatus("dhcpc_connection_status"); %>">
<input type="hidden" id="pppoe_00_connection_status" name="pppoe_00_connection_status" value="<% CmoGetStatus("pppoe_00_connection_status"); %>">
<input type="hidden" id="pptp_connection_status" name="pptp_connection_status" value="<% CmoGetStatus("pptp_connection_status"); %>">
<input type="hidden" id="l2tp_connection_status" name="l2tp_connection_status" value="<% CmoGetStatus("l2tp_connection_status"); %>">
<input type="hidden" id="bigpond_connection_status" name="bigpond_connection_status" value="<% CmoGetStatus("bigpond_connection_status"); %>">
<input type="hidden" id="wan_pppoe_russia_enable" name="wan_pppoe_russia_enable" value="<% CmoGetCfg("wan_pppoe_russia_enable","none"); %>">
<input type="hidden" id="wan_pptp_russia_enable" name="wan_pptp_russia_enable" value="<% CmoGetCfg("wan_pptp_russia_enable","none"); %>">
<input type="hidden" id="wan_l2tp_russia_enable" name="wan_l2tp_russia_enable" value="<% CmoGetCfg("wan_l2tp_russia_enable","none"); %>">
<input type="hidden" id="wan_pptp_ipaddr" name="wan_pptp_ipaddr" value="<% CmoGetStatus("wan_pptp_ipaddr"); %>"> 
<input type="hidden" id="russia_wan_phy_ipaddr" name="russia_wan_phy_ipaddr" value="<% CmoGetStatus("russia_wan_phy_ipaddr"); %>">

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
			<td><img src="short_modnum.gif" width="125" height="25"></td>
			<td id="topnavoff"><a href="index.asp">SETUP</a></td>
			<td id="topnavoff"><a href="adv_virtual.asp">ADVANCED</a></td>
			<td id="topnavoff"><a href="tools_admin.asp">TOOLS</a></td>
			<td id="topnavon"><a href="st_device.asp">STATUS</a></td>
			<td id="topnavoff"><a href="support_men.asp">SUPPORT</a></td>
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
									<li><div id="sidenavoff">Device Info</div></li>
									<li><div><a href="st_log.asp">Logs</a></div></li>
									<li><div><a href="st_stats.asp">Statistics</a></div></li>
									<li><div><a href="internet_sessions.asp">Internet Sessions</a></div></li>
									<li><div><a href="st_routing.asp">Routing</a></div></li>
									<li><div><a href="st_wireless.asp">Wireless</a></div></li>
									<li><div style=" text-transform:none"><a href="st_ipv6.asp">IPv6</a></div></li>
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
			</td>
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					<!-- === BEGIN MAINCONTENT === -->
				  	<div id="box_header"> 
						<h1>Device Information</h1>
						All of your Internet and network connection details are displayed on this page. The firmware version is also displayed here.
						<br><br>
				  	</div>
				  	<div class="box">
						<h2>General</h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td class="duple">Time :</td>
								<td width="340">&nbsp;&nbsp;<span id="show_time"></span></td>
							</tr>
							<tr>
								<td class="duple">Firmware Version :</td>
								<td width="340">&nbsp;&nbsp;<strong><% CmoGetStatus("version"); %> , <% CmoGetStatus("version_date"); %></strong></td>
							</tr>
						</table>
				  	</div>
					<div class="box"> 
						<h2>WAN</h2>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
							  	<tr>
                                  <td class="duple">Connection Type:</td>
										
                                  <td width="340">&nbsp; 
								  <span id="connection_type"></span>
								  </td>
							  	</tr>
								<tr>
                                  <td class="duple">Cable Status :</td>
                                  <td width="340">&nbsp;
								  <span id="cable_status"></span>
								   </td>
							    </tr>
								<tr>
                                  <td class="duple">Network Status :</td>
                                  <td width="340">&nbsp;
								  <span id="network_status"></span>
								   </td>
							    </tr>
								<tr>
                                  <td class="duple">Connection Up Time :</td>
                                  <td width="340">&nbsp;&nbsp;<span id="show_uptime"></span></td>
							    </tr>
								<tr id="net_status" style="display:none">
                                  <td class="duple">&nbsp;</td>
                                  <td width="340">&nbsp;&nbsp;<span id="show_button"></span></td>
							    </tr>
								<tr>
                                  <td class="duple">MAC Address :</td>
                                  <td width="340">&nbsp;
                                   <% CmoGetCfg("wan_mac","none"); %>
								   </td>
							    </tr>
								<tr>
                                  <td class="duple">IP Address :</td>
								   
                                  <td width="340">&nbsp; 
								  <span id="wan_ip"></span>
								  </td>
							  	</tr>
								<tr>
                                  <td class="duple">Subnet Mask :</td>
                                  <td width="340">&nbsp;  
								  <span id="wan_netmask"></span>
								  </td>
							  	</tr>
								<tr>
                                  <td class="duple">Default Gateway :</td>
                                  <td width="340">&nbsp;
								  <span id="wan_gateway"></span>
								  </td>
							  	</tr>
								<tr>
                                  <td class="duple">Primary DNS Server :</td>
                                  <td width="340">&nbsp;
								  <span id="wan_dns1"></span>
								  </td>
							  	</tr>
								<tr>
                                  <td class="duple">Secondary DNS Server :</td>
                                  <td width="340">&nbsp;
								  <span id="wan_dns2"></span>
								  </td>
								<!--//2009/4/29 Tina add OPENDNS-->
								<tr>
								  <td class="duple">Advanced DNS :</td>
								  <td width="340">&nbsp;
								  <span id="opendns_enable"></span>
								</tr>
								<script>
									var opendns ="<% CmoGetCfg("opendns_enable","none"); %>";
									get_by_id("opendns_enable").innerHTML = (opendns=="1")? "Enabled":"Disabled";
								</script>
								<!--//OPENDNS-->								  
							  	</tr>
							</table>
					</div>
					<div class="box"> 
						<h2>LAN</h2>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
                                  <td class="duple">MAC Address :</td>
                                  <td width="340">&nbsp;
								  <% CmoGetCfg("lan_mac","none"); %>
								  </td>
							  </tr>
								<tr>
                                  <td class="duple">IP Address :</td>
                                  <td width="340">&nbsp;
								  <% CmoGetCfg("lan_ipaddr","none"); %>
								  </td>
							  </tr>
								<tr>
                                  <td class="duple">Subnet Mask :</td>
                                  <td width="340">&nbsp;
								  <% CmoGetCfg("lan_netmask","none"); %>
								  </td>
							  </tr>
								<tr>
                                  <td class="duple">DHCP Server :</td>
                                  <td width="340">&nbsp;
								  <script>
								  		if(get_by_id("dhcpd_enable").value == "1"){
											document.write("Enabled");
										}else{
											document.write("Disabled");
										}
										
								  </script>
								  <!-- insert name=dhcp_enable -->
								  </td>
							  </tr>
							</table>
					</div>
					<div class="box"> 
						<h2>Wireless LAN</h2>
							<table cellpadding="1" cellspacing="1" border="0" width="525">
								<tr>
									<td class="duple">Wireless Radio :</td>
									<td width="340">&nbsp;
									<script>
										var wlan0_enable = "<% CmoGetCfg("wlan0_enable","none"); %>";
										var lan_mac = "<% CmoGetCfg("lan_mac","none"); %>";
										if(wlan0_enable == "0"){
											document.write("Off");
										}else if(wlan0_enable == "1" && lan_mac == "00:00:00:00:00:00"){
											document.write("Init failed");
										}else if(wlan0_enable == "1"){
											document.write("Enabled");
										}
									</script>
									</td>
								</tr>
								<tr>
									<td class="duple">MAC Address :</td>
									<td width="340">&nbsp;
									<% CmoGetCfg("lan_mac","none"); %>
									</td>
								</tr>
								<tr>
									<td class="duple">Network Name (SSID) :</td>
									<td width="340">&nbsp;<% CmoGetCfg("wlan0_ssid","none"); %></td>
								</tr>
								<tr>
									<td class="duple">Channel :</td>
									<td width="340">&nbsp;
									<span id="wlan_channel"></span>
									</td>
								</tr>
								<tr>
								  	<td class="duple">Security Mode :</td>
									<td width="340">&nbsp;
									  <script>
										var security_w = "<% CmoGetCfg("wlan0_security","none"); %>";
										var show_security = security_w;
										if(security_w == "wpa2auto_eap"){
											show_security = "AUTO (WPA or WPA2) - EAP";
										}else if(security_w == "wpa2auto_psk"){
											show_security = "AUTO (WPA or WPA2) - PSK";
										}
										document.write(show_security);
									  </script>
									</td>
								</tr>
							</table>
				  </div>
				  <div class="box">
					  <h2>LAN Computers</h2>
						  <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
						  	<tr>
								<td>IP Address</td>
								<td>Name (if any)</td>
								<td>MAC</td>
							</tr>
							<script>set_mac_info();</script>
						  </table>
				  </div>
				  <div class="box">
					  <h2>IGMP Multicast memberships</h2>
						  <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
						  	<tr>
								<td>Multicast Group Address</td>
							</tr>
							<script>set_igmp_info();</script>
						  </table>
				  </div>
				  
				  <div id="renew_result" name="renew_result" style="display:none">
						  <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#ffffff border=1>
						  	<tr><td>
									<IFRAME id="iframe_result" name="iframe_result" align=middle border="0" frameborder="0" marginWidth=0 marginHeight=0 src="" width="100%" height=0 scrolling="no"></IFRAME>
								</td></tr>
						  </table>
				  </div>
					<!-- === END MAINCONTENT === -->
				</div>				
			</td>
			<td valign="top" width="150" id="sidehelp_container" align="left">
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#FFFFFF">
					<tr>
					  <td id="help_text">
					  	<strong>Helpful Hints&hellip;</strong>
					  	<p>All of your WAN and LAN connection details are displayed here.</p>
						<p><a href="support_status.asp#Device_Info">More&hellip;</a></p>
					  </td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<table id="footer_container" border="0" cellpadding="0" cellspacing="0" width="838" align="center">
		<tr>
			<td width="125" align="center">&nbsp;&nbsp;<img src="wireless_tail.gif" width="114" height="35"></td>
			<td width="10">&nbsp;</td><td>&nbsp;</td>
		</tr>
	</table></form>
<form id="form2" name="form2" method="post" action="dhcp_renew.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value="WAN is connecting. "></form>
<form id="form3" name="form3" method="post" action="dhcp_release.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<form id="form4" name="form4" method="post" action="pppoe_00_connect.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value="WAN is connecting. "></form>
<form id="form5" name="form5" method="post" action="pppoe_00_disconnect.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<form id="form6" name="form6" method="post" action="pptp_connect.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value="WAN is connecting. "></form>
<form id="form7" name="form7" method="post" action="pptp_disconnect.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<form id="form8" name="form8" method="post" action="l2tp_connect.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value="WAN is connecting. "></form>
<form id="form9" name="form9" method="post" action="l2tp_disconnect.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<form id="form10" name="form10" method="post" action="bigpond_connect.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="back.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"><input type="hidden" id="html_response_message" name="html_response_message" value="WAN is connecting. "></form>
<form id="form11" name="form11" method="post" action="bigpond_disconnect.cgi"><input type="hidden" id="html_response_page" name="html_response_page" value="st_device.asp"><input type="hidden" id="html_response_return_page" name="html_response_return_page" value="st_device.asp"></form>
<br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
<script>
	get_time();
	STime();
	WTime();
	get_File();
</script>
</body>
</html>
