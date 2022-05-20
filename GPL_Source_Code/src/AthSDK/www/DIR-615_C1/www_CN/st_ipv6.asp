<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">
<script type="text/javascript" src="uk.js"></script>
<script type="text/javascript" src="text.js"></script>
<script language="JavaScript" src="public.js"></script>
<script language="JavaScript" src="public_msg.js"></script>
<script>

	function set_mac_info()
	{
		var temp_dhcp_list = get_by_id("dhcp_list").value.split("@");
		
		for (var i = 0; i < temp_dhcp_list.length; i++)
		{	
			var temp_data = temp_dhcp_list[i].split("/");
			if(temp_data.length != 0)
			{		
				if(temp_data.length > 1)
				{
					var temp_ipv6_address = temp_data[2].split(",");
					if(temp_ipv6_address.length > 1)
					{
						for(var j = 0; j < temp_ipv6_address.length;j++)
						{
							if(j > 0)
							{
								temp_data[1]="";
								temp_data[0]="";
							}
							document.write("<tr><td>" + temp_data[1] + "</td><td>" + temp_data[0] + "</td><td>" + temp_ipv6_address[j] + "</td></tr>")
						}
					}
					else
						document.write("<tr><td>" + temp_data[1] + "</td><td>" + temp_data[0] + "</td><td>" + temp_data[2] + "</td></tr>")
				}
			}
		}
	}
	
function replace_null_to_none(item){
	if(item=="(null)")
		item="none";
	return item;
}


function xmldoc(){
	var ipv6_wan_type;
	var ipv6_network_status;
	var ipv6_network_status_flag;
	var ipv6_wan_ip;
	var ipv6_wan_ip_list;
	var ipv6_wan_gw;
	var ipv6_lan_ip;
	var ipv6_primary_dns;
	var ipv6_secondary_dns;
	var link_local;
	var ipv6_sel_wan = "<% CmoGetCfg("ipv6_wan_proto","none"); %>"; 
  if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 	
	ipv6_wan_type = document.getElementById("connection_ipv6_type");
	ipv6_network_status = document.getElementById("network_ipv6_status");
	ipv6_wan_ip = document.getElementById("wan_ipv6_addr");
	ipv6_wan_gw = document.getElementById("wan_ipv6_gw");
	ipv6_lan_ip = document.getElementById("lan_ipv6_addr");
	ipv6_primary_dns = document.getElementById("primary_ipv6_dns");
	ipv6_secondary_dns = document.getElementById("secondary_ipv6_dns");
	link_local = document.getElementById("lan_link_local_ip");

	((ipv6_network_status_flag=xmlhttp.responseXML.getElementsByTagName("ipv6_wan_network_status")[0].firstChild.nodeValue)=="connect") ? ipv6_network_status.innerHTML="connect" : ipv6_network_status.innerHTML="disconnect";	
	(ipv6_network_status_flag=="connect")? ipv6_wan_ip_list =replace_null_to_none(xmlhttp.responseXML.getElementsByTagName("ipv6_wan_ip")[0].firstChild.nodeValue).split(","):ipv6_wan_ip_list = "none".split(",");
	ipv6_lan_ip.innerHTML = replace_null_to_none(xmlhttp.responseXML.getElementsByTagName("ipv6_lan_ip_global")[0].firstChild.nodeValue);
	link_local.innerHTML = replace_null_to_none(xmlhttp.responseXML.getElementsByTagName("ipv6_lan_ip_local")[0].firstChild.nodeValue);
	ipv6_wan_gw.innerHTML = replace_null_to_none(xmlhttp.responseXML.getElementsByTagName("ipv6_wan_default_gateway")[0].firstChild.nodeValue);
  	(ipv6_network_status_flag=="connect")? ipv6_primary_dns.innerHTML = replace_null_to_none(xmlhttp.responseXML.getElementsByTagName("ipv6_wan_primary_dns")[0].firstChild.nodeValue):ipv6_primary_dns.innerHTML ="none";
  	(ipv6_network_status_flag=="connect")? ipv6_secondary_dns.innerHTML = replace_null_to_none(xmlhttp.responseXML.getElementsByTagName("ipv6_wan_secondary_dns")[0].firstChild.nodeValue):ipv6_secondary_dns.innerHTML = "none";	
	
	for (var i = 0; i < ipv6_wan_ip_list.length; i++){
		if(i==0)
			ipv6_wan_ip.innerHTML = ipv6_wan_ip_list[i];
		else{
			ipv6_wan_ip.innerHTML +="<br>&nbsp;";
			ipv6_wan_ip.innerHTML += ipv6_wan_ip_list[i];
		}		
	}
		
	tr_network_ipv6_status.style.display="";
	tr_wan_ipv6_addr.style.display="";
	tr_lan_ipv6_addr.style.display="";
	tr_wan_ipv6_gw.style.display="none";	
	tr_primary_ipv6_dns.style.display="";
	tr_secondary_ipv6_dns.style.display="";
	
	if(ipv6_sel_wan =="ipv6_static"){
			ipv6_wan_type.innerHTML = "Static IPv6";
			tr_wan_ipv6_gw.style.display="";
	}else if(ipv6_sel_wan =="ipv6_dhcp"){
			ipv6_wan_type.innerHTML = "DHCPv6";
	}else if(ipv6_sel_wan =="ipv6_pppoe"){
		  ipv6_wan_type.innerHTML = "IPv6 over PPPoE";
	}else if(ipv6_sel_wan =="ipv6_6in4"){
		  ipv6_wan_type.innerHTML = "IPv6 in IPv4 Tunnel";
		  tr_wan_ipv6_gw.style.display="";
	}else if(ipv6_sel_wan =="ipv6_6to4"){
		  ipv6_wan_type.innerHTML = "6 to 4";
	}else if(ipv6_sel_wan =="link_local"){
		  tr_network_ipv6_status.style.display="none";
		  tr_wan_ipv6_addr.style.display="none";		  
		  tr_lan_ipv6_addr.style.display="none";
		  tr_primary_ipv6_dns.style.display="none";
		  tr_secondary_ipv6_dns.style.display="none";			  
		  ipv6_wan_type.innerHTML = "Link Local";
	}else if(ipv6_sel_wan =="ipv6_stateless"){
		  ipv6_wan_type.innerHTML = "Stateless Autoconfiguration";
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
				url="http://"+lan_ip+"/device.xml=ipv6_status";
		}else{
				url="http://"+mURL+"/device.xml=ipv6_status";
		}
		
	xmlhttp.onreadystatechange = xmldoc; 
	xmlhttp.open("GET", url, true); 
	xmlhttp.send(null); 
	}
	setTimeout("get_File()",5000);
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
<title>D-Link公司 | 无线路由器 | 主页</title>
<meta http-equiv=Content-Type content="text/html; charset=UTF8">
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
<input type="hidden" id="dhcp_list" name="dhcp_list" value="<% CmoGetList("ipv6_client_list"); %>">

<form id="form1" name="form1" method="post" action="st_device.cgi">

<body topmargin="1" leftmargin="0" rightmargin="0" bgcolor="#757575">
	<input type="hidden" id="ipv6_6to4_tunnel_address" name="ipv6_6to4_tunnel_address" maxLength=80 size=80 value="<% CmoGetStatus("6to4_tunnel_address","none"); %>">
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
									<li><div id="sidenavoff"><script>show_words(which_lang[_devinfo])</script></div></li>
									<li><div><a href="st_log.asp"><script>show_words(which_lang[_logs])</script></a></div></li>
									<li><div><a href="st_stats.asp"><script>show_words(which_lang[_stats])</script></a></div></li>
									<li><div><a href="internet_sessions.asp"><script>show_words(which_lang[YM157])</script></a></div></li>
									<li><div><a href="st_wireless.asp"><script>show_words(which_lang[_wireless])</script></a></div></li>
                                    
									<li><div id="sidenavoff" style="text-transform:none">IPv6</a></div></li>
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
						<h1 style=" text-transform:none"><script>show_words(which_lang[TEXT068])</script></h1>
						<script>show_words(which_lang[TEXT069])</script>
						<br>
						<br>
				  	</div>
				  	<div class="box">
						<h2 style=" text-transform:none"><script>show_words(which_lang[TEXT070])</script></h2>
						<table cellpadding="1" cellspacing="1" border="0" width="525">
							<tr>
								<td width="340" align=right class="duple" nowrap><script>show_words(which_lang[IPV6_TEXT29a])</script> :</td>
								<td width="340">&nbsp;
									<span id="connection_ipv6_type" nowrap></span>
								</td>
							</tr>
							<tr id="tr_network_ipv6_status">
								<td align=right class="duple" nowrap><script>show_words(which_lang[_networkstate])</script> :</td>
								<td width="340">&nbsp;
								<span id="network_ipv6_status" nowrap></span>
								</td>
							</tr>
							<tr id="tr_wan_ipv6_addr"x>
								<td align=right class="duple"  nowrap><script>show_words(which_lang[TEXT071])</script> :</td>
								<td width="340">&nbsp;
								<span id="wan_ipv6_addr" nowrap></span>
								</td>
							</tr>
							<tr id="tr_wan_ipv6_gw">
								<td align=right class="duple"  nowrap>IPv6 Default Gateway :</td>
								<td width="340">&nbsp;
								<span id="wan_ipv6_gw" nowrap></span>
								</td>
							</tr>
							<tr id="tr_lan_ipv6_addr">
								<td align=right class="duple"  nowrap>LAN IPv6 Address :</td>
								<td width="340">&nbsp; 
								<span id="lan_ipv6_addr" nowrap></span>
								</td>
							</tr>
							<tr id="tr_lan_link_local_ip">
								<td align=right class="duple" nowrap>LAN IPv6 Link-Local Address :</td>
								<td width="340">&nbsp;
								<span id="lan_link_local_ip" nowrap></span>
								</td>
							</tr>
							<tr id="tr_primary_ipv6_dns">
								<td align=right class="duple"  nowrap>Primary DNS Address :</td>
								<td width="340">&nbsp;
								<span id="primary_ipv6_dns" nowrap></span>
								</td>
							</tr>
							<tr id="tr_secondary_ipv6_dns">
								<td align=right class="duple"  nowrap>Seccondary DNS Address :</td>
								<td width="340">&nbsp;
								<span id="secondary_ipv6_dns" nowrap></span>
								</td>
							</tr>
						</table>
				  	</div>
										
				  <div class="box">
					  <h2 style=" text-transform:none">LAN IPv6 Computers</h2>
						  <table borderColor=#ffffff cellSpacing=1 cellPadding=2 width=525 bgColor=#dfdfdf border=1>
						  	<tr>
								<td>Name (if any)</td>
								<td>MAC</td>
								<td>IPv6 Address</td>
							</tr>
							<script>set_mac_info();</script>
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

<br>
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
<script>
	get_File();
</script>
</body>
</html>
