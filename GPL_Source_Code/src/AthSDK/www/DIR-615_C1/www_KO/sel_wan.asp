﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF8">
<title></title>
<SCRIPT LANGUAGE="JavaScript">
function select_wan_page(){
var html_file;
var sel_wan = "<% CmoGetCfg("wan_proto","none"); %>"; 
var russia_pptp_enable = "<% CmoGetCfg("wan_pptp_russia_enable","none"); %>";
var russia_poe_enable = "<% CmoGetCfg("wan_pppoe_russia_enable","none"); %>";

	if(sel_wan =="dhcpc"){
		html_file = "wan_dhcp.asp";
	}else if(sel_wan =="static"){
		html_file = "wan_static.asp";
	}else if(sel_wan =="pppoe"){
		if(russia_poe_enable == "1"){
			html_file = "wan_rus_poe.asp";
		}else{
			html_file = "wan_poe.asp";
		}
	}else if(sel_wan =="pptp"){
		if(russia_pptp_enable == "1"){
			html_file = "wan_rus_pptp.asp";
		}else{
			html_file = "wan_pptp.asp";
		}
	}else if(sel_wan =="l2tp"){
		html_file = "wan_l2tp.asp";
	}else{
		html_file = "wan_bigpond.asp";
	}
	location.href = html_file;
}



</script>
</head>

<body>
</body>
<script>	
	select_wan_page();
</script>
</html>
