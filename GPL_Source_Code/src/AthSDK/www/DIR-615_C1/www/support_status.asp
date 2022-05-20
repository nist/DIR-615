<html>
<head>
<link rel="STYLESHEET" type="text/css" href="css_router.css">
<title>D-LINK CORPORATION, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
</head>

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
			<td id="topnavoff"><a href="st_device.asp">STATUS</a></td>
			<td id="topnavon"><a href="support_men.asp">SUPPORT</a></td>
		</tr>
	</table>
	<table border="1" cellpadding="2" cellspacing="0" width="838" height="100%" align="center" bgcolor="#FFFFFF" bordercolordark="#FFFFFF">
		<tr>
		  <td id="sidenav_container" valign="top" width="125" align="right">
				<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td id="sidenav_container">
							<div id=sidenav> 
							<!-- === BEGIN SIDENAV === -->
								<ul>
									<li><div><a href="support_men.asp">MENU</a></div></li>
									<li><div><a href="support_internet.asp">SETUP</a></div></li>
									<li><div><a href="support_adv.asp">ADVANCED</a></div></li>
									<li><div><a href="support_tools.asp">TOOLS</a></div></li>
									<li><div id="sidenavoff">STATUS</a></div></li>
									
								</ul>
								<!-- === END SIDENAV === -->
							</div>
						</td>			
					</tr>
				</table>			
		  </td>
			<td valign="top" id="maincontent_container">
				<div id="maincontent">
					
				  				  <div id="box_header"> 
						<h1> sTATUS Help </h1>
						<table width=75% border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td>
                              <ul>
                               <li><a href=support_status.asp#Device_Info>Device Info </a></li>
                                <li><a href=support_status.asp#Logs>Logs</a></li>
                                <li><a href=support_status.asp#Statistics>Statistics</a></li>
                                <li><a href=support_status.asp#Internet_Sessions>Internet Sessions</a></li>
                                <li><a href=support_status.asp#Wireless>Wireless</a></li>
                              </ul></td>
                          </tr>
                        </table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=Device_Info>Device Info</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P>All of your Internet and network connection details are displayed 
				            on the Device Info page. The firmware version is also displayed 
				            here. </P>
				            <P class=box_alert>Note: Some browsers have limitations that make it 
				            impossible to update the WAN status display when the status changes. 
				            Some browsers require that you refresh the display to obtain updated 
				            status. Some browsers report an error condition when trying to 
				            obtain WAN status. </P>
				            <P>Depending on the type of WAN connection, you can take one of the 
				            following sets of actions: </P>
				            <DL>
				              <DT>DHCP Connection 
				              <DD>Clicking the <SPAN class=button_ref>DHCP Release</SPAN> button 
				              unassigns the router's IP address. The router will not respond to 
				              IP messages from the WAN side until you click the <SPAN 
				              class=button_ref>DHCP Renew</SPAN> button or power-up the router 
				              again. Clicking the <SPAN class=button_ref>DHCP Renew</SPAN> 
				              button causes the router to request a new IP address from the 
				              ISP's server. 
				              <DT>PPPoE, PPTP, L2TP Connection 
				              <DD>Depending on whether the WAN connection is currently 
				              established, you can click either the <SPAN 
				              class=button_ref>Connect</SPAN> to attempt to establish the WAN 
				              connection or the <SPAN class=button_ref>Disconnect</SPAN> to 
				              break the WAN connection. 
<!--				              <DT>BigPond Connection 
				              <DD>Depending on whether you are currently logged in to BigPond, 
				              you can click either the <SPAN class=button_ref>BigPond 
				              Login</SPAN> to attempt to establish the WAN connection or the 
				              <SPAN class=button_ref>BigPond Logout</SPAN> to break the WAN 
				              connection. 
-->				              <DT>Static IP 
				              <DD>Static IP mode is always on, so no action buttons are 
				              avaliable. </DD></DL>
				            <DL>
				              <DT>Wireless LAN 
				              <DD>This area of the screen reflects configuration settings from 
				              the <a href="wireless.asp">Setup&rarr;Wireless Settings</a> page. The <SPAN class=option>MAC 
				              Address</SPAN> is the factory-assigned identifier of the wireless 
				              card. 
				              <DT>LAN Computers 
				              <DD>This area of the screen continually updates to show all DHCP 
				              enabled computers and devices connected to the LAN side of your 
				              router. The detection "range" is limited to the address range as 
				              configured in DHCP Server. Computers that have an address outside 
				              of this range will not show. If the DHCP Client (i.e. a computer 
				              configured to "Automatically obtain an address") supplies a Host 
				              Name then that will also be shown. Any computer or device that has 
				              a static IP address that lies within the detection "range" may 
				              show, however its host name will not. 
				              <DT>IGMP Multicast memberships 
				              <DD>If IGMP is enabled, this area of the screen shows all 
				              multicast groups of which any LAN devices are members. 
				            </DD></DL>
				  		</td>
                    </tr>
				  </table>
				  </div>

				  <div class="box">
				  <h2><A name=Logs>Logs</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>
				  	<td>
				  		<P>The router automatically logs (records) events of possible 
			            interest in its internal memory. If there is not enough internal 
			            memory for all events, logs of older events are deleted, but logs of 
			            the latest events are retained. The Logs option allows you to view 
			            the router logs. You can define what types of events you want to 
			            view and the level of events to view. This router also has internal 
			            Syslog Server support so you can send the log files to a computer on 
			            your network that is running a Syslog utility. </P>
			            <DL>
			              <DT>What to View 
			              <DD>Select the kinds of events that you want to view. 
			              <UL>
			                <LI>Firewall and Security 
			                <LI>System 
			                <LI>Router Status </LI></UL>
			              <DT>View Levels 
			              <DD>Select the level of events that you want to view. 
			              <UL>
			                <LI>Critical 
			                <LI>Warning 
			                <LI>Informational </LI></UL>
			              <DT>Apply Log Settings Now 
			              <DD>Click this button after changing Log Options to make them 
			              effective and permanent. 
			              <DT>Refresh 
			              <DD>Clicking this button refreshes the display of log entries. 
			              There may be new events since the last time you accessed the log. 
			              <DT>Clear 
			              <DD>Clicking this button erases all log entries. 
			              <DT>Email Now 
			              <DD>If you provided email information with the 
                            <a href="tools_email.asp">Tools&rarr;Email</a>
                            screen, clicking the <SPAN class=button_ref>Email Now</SPAN> 
			              button sends the router log to the configured email address. 
			              <DT>Save Log 
			              <DD>Select this option to save the router log to a file on your 
			              computer. </DD></DL>
				  	</td>
                    </tr>
				  </table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=Statistics>Statistics</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P>The Statistics page displays all of the LAN, WAN, and Wireless 
				            packet transmit and receive statistics.</P>
				            <DL>
				              <DT>Sent 
				              <DD>The number of packets sent from the router. 
				              <DT>Received 
				              <DD>The number of packets received by the router. 
				              <DT>TX Packets Dropped 
				              <DD>The number of packets that were dropped while being sent, due 
				              to errors, collisions, or router resource limitations. 
				              <DT>RX Packets Dropped 
				              <DD>The number of packets that were dropped while being received, 
				              due to errors, collisions, or router resource limitations. 
				              <DT>Collisions 
				              <DD>The number of packets that were dropped due to Ethernet 
				              collisions (two or more devices attempting to use an Ethernet 
				              circuit at the same time). 
				              <DT>Errors 
				              <DD>The number of transmission failures that cause loss of a 
				              packet. A noisy radio-frequency environment can cause a high error 
				              rate on the wireless LAN. </DD></DL>
				  		</td>
                    </tr>
				  </table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=Internet_Sessions>Internet Sessions</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P>The Internet Sessions page displays full details of active 
				            Internet sessions through your router. An Internet session is a 
				            conversation between a program or application on a LAN-side computer 
				            and a program or application on a WAN-side computer. </P>
				            <DL>
				              <DT>Local 
				              <DD>The IP address and, where appropriate, port number of the 
				              local application. 
				              <DT>NAT 
				              <DD>The port number of the LAN-side application as viewed by the 
				              WAN-side application. 
				              <DT>Internet 
				              <DD>The IP address and, where appropriate, port number of the 
				              application on the Internet. 
				              <DT>Protocol 
				              <DD>The communications protocol used for the conversation. 
				              <DT>State 
				              <DD>State for sessions that use the TCP protocol. 
				              <UL>
				                <LI>NO: None -- This entry is used as a placeholder for a future 
				                connection that may occur. 
				                <LI>SS: SYN Sent -- One of the systems is attempting to start a 
				                connection. 
				                <LI>EST: Established -- the connection is passing data. 
				                <LI>FW: FIN Wait -- The client system has requested that the 
				                connection be stopped. 
				                <LI>CW: Close Wait -- the server system has requested that the 
				                connection be stopped. 
				                <LI>TW: Time Wait -- Waiting for a short time while a connection 
				                that was in FIN Wait is fully closed. 
				                <LI>LA: Last ACK -- Waiting for a short time while a connection 
				                that was in Close Wait is fully closed. 
				                <LI>CL: Closed -- The connection is no longer active but the 
				                session is being tracked in case there are any retransmitted 
				                packets still pending. </LI></UL>
				              <DT>Dir 
				              <DD>The direction of initiation of the conversation: 
				              <DL>
				                <DT>Out 
				                <DD>Initiated from LAN to WAN. 
				                <DT>In 
				                <DD>Initiated from WAN to LAN. </DD></DL>
				             <!-- <DT>Priority 
				              <DD>The preference given to outbound packets of this conversation 
				              by the QoS Engine logic. Smaller numbers represent higher 
				              priority. -->
				              <DT>Time Out 
				              <DD>The number of seconds of idle time until the router considers 
				              the session terminated. The initial value of Time Out depends on 
				              the type and state of the connection. 
				              <DL>
				                <DT>300 seconds 
				                <DD>UDP connections. 
				                <DT>240 seconds 
				                <DD>Reset or closed TCP connections. The connection does not 
				                close instantly so that lingering packets can pass or the 
				                connection can be re-established. 
				                <DT>7800 seconds 
				                <DD>Established or closing TCP connections. 
				            </DD></DL></DD></DL>
				  		</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Wireless>Wireless</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>  
				  	<tr>
				  		<td>
				  			<P>The wireless section allows you to view the wireless clients that 
				            are connected to your wireless router.</P>
				            <DL>
				              <DT>MAC Address 
				              <DD>The Ethernet ID (MAC address) of the wireless client. 
				              <DT>IP Address 
				              <DD>The LAN-side IP address of the client. 
				              <DT>Mode 
				              <DD>The transmission standard being used by the client. Values are 
				              11a, 11b, 11g, or 11n for 802.11a, 802.11b, 802.11g, or 802.11n 
				              respectively. 
				              <DT>Rate 
				              <DD>The actual transmission rate of the client in megabits per 
				              second. 
				              <DT>Signal 
				              <DD>This is a relative measure of signal quality. The value is 
				              expressed as a percentage of theoretical best quality. Signal 
				              quality can be reduced by distance, by interference from other 
				              radio-frequency sources (such as cordless telephones or 
				              neighboring wireless networks), and by obstacles between the 
				              router and the wireless device. </DD></DL>
				  		</td>
                    </tr>
				  </table>
				  </div>
					<!-- === END MAINCONTENT === -->
                </div></td>
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Corporation, Inc.</div>
<br>
</body>
</html>