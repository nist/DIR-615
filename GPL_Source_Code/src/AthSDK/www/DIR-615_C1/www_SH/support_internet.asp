
<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
<meta http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
.style6 {
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
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
									<li><div id="sidenavoff">SETUP</div></li>
									<li><div><a href="support_adv.asp">ADVANCED</a></div></li>
									<li><div><a href="support_tools.asp">TOOLS</a></div></li>
									<li><div><a href="support_status.asp">STATUS</a></div></li>
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
					<h1>SETUP HELP</h1>
					<table border=0 cellspacing=0 cellpadding=0>
			          <tr>
			            <td>
			              <ul>
			                <li><a href=support_internet.asp#Internet>Internet Connection</a></li>
							<li><a href=support_internet.asp#WAN>WAN</a></li>
							<li><a href=support_internet.asp#Wireless>Wireless</a></li>
							<li><a href=support_internet.asp#Network>Network Settings</a></li>
			
			              </ul></td>
			          </tr>
			        </table>
				    </div>
				  
					  <div class="box">
						<h2><A id=Internet name=Internet>Internet Connection</a></h2>
						<table border=0 cellspacing=0 cellpadding=0>
							  <tr>
				                <td>
				                	<DL>
						              <DT>Setup Wizard 
						              <DD>
						              <P>If you are new to networking and have never configured a router 
						              before, click on <SPAN class=button_ref>Setup Wizard</SPAN> and 
						              the router will guide you through a few simple steps to get your 
						              network up and running. </P>
						              <DT>Manual Configure 
						              <DD>
						              <P>If you consider yourself an advanced user and have configured a 
						              router before, click <SPAN class=button_ref>Manual 
						              Configure</SPAN> to input all the settings manually. </P>
						              </DD></DL>
				                </td>
							  </tr>
				        </table>
					</div>
				<div class="box">
					<h2><A id=WAN name=WAN>WAN</A></h2>
					<table border=0 cellspacing=0 cellpadding=0>
			 		<tr>
                       <td>
                       <P>The WAN (Wide Area Network) section is where you configure your 
			            Internet Connection type. </P>
			            <DL>
			              <DT>Internet Connection Type 
			              <DD>
			              <P>There are several connection types to choose from: Static IP, 
			              DHCP, PPPoE, PPTP, L2TP. If you are unsure of your 
			              connection method, please contact your Internet Service Provider. 
			              Note: If using the PPPoE option, you will need to ensure that any 
			              PPPoE client software on your computers is removed or disabled. 
			              </P>
			              <DL>
			                <DT>Static WAN Mode 
			                <DD>Used when your ISP provides you a set IP address that does 
			                not change. The IP information is manually entered in your IP 
			                configuration settings. You must enter the <SPAN class=option>IP 
			                address</SPAN>, <SPAN class=option>Subnet Mask</SPAN>, <SPAN 
			                class=option>Gateway</SPAN>, <SPAN class=option>Primary DNS 
			                Server</SPAN>, and <SPAN class=option>Secondary DNS 
			                Server</SPAN>. Your ISP provides you with all of this 
			                information. 
			                <DT>DHCP WAN Mode 
			                <DD>A method of connection where the ISP assigns your IP address 
			                when your router requests one from the ISP's server. Some ISP's 
			                require you to make some settings on your side before your 
			                router can connect to the Internet. 
			                <P><SPAN class=option>Host Name: </SPAN>Some ISP's may check 
			                your computer's Host Name. The Host Name identifies your system 
			                to the ISP's server. This way they know your computer is 
			                eligible to receive an IP address. In other words, they know 
			                that you are paying for their service. </P>
			                <P><SPAN class=option>Use Unicasting: </SPAN>This option is 
			                normally turned off, and should remain off as long as the 
			                WAN-side DHCP server correctly provides an IP address to the 
			                router. However, if the router cannot obtain an IP address from 
			                the DHCP server, the DHCP server may be one that works better 
			                with unicast responses. In this case, turn the unicasting option 
			                on, and observe whether the router can obtain an IP address. In 
			                this mode, the router accepts unicast responses from the DHCP 
			                server instead of broadcast responses. </P>
			                <!--<P><SPAN class=option>Enable BigPond:</SPAN> Check this option 
			                to connect to the internet through Telstra BigPond Cable 
			                Broadband in Australia. Telstra BigPond provides the values for 
			                <SPAN class=option>BigPond Server</SPAN>, <SPAN 
			                class=option>BigPond User Id</SPAN>, and <SPAN 
			                class=option>BigPond Password</SPAN>. </P>-->
			                <DT>PPPoE 
			                <DD>Select this option if your ISP requires you to use a PPPoE 
			                (Point to Point Protocol over Ethernet) connection. DSL 
			                providers typically use this option. This method of connection 
			                requires you to enter a <SPAN class=option>Username</SPAN> and 
			                <SPAN class=option>Password</SPAN> (provided by your Internet 
			                Service Provider) to gain access to the Internet. The supported 
			                authentication protocols are PAP and CHAP. 
			                <P><SPAN class=option>Dynamic IP: </SPAN>If the ISP's servers 
			                assign the router's IP addressing upon establishing a 
			                connection, select this option. </P>
			                <P><SPAN class=option>Static IP: </SPAN>If your ISP has assigned 
			                a fixed IP address, select this option. The ISP provides the 
			                value for the <SPAN class=option>IP Address</SPAN>. </P>
			                <P><SPAN class=option>Service Name: </SPAN>Some ISP's may 
			                require that you enter a Service Name. Only enter a Service Name 
			                if your ISP requires one. </P>
			                <P><SPAN class=option>Reconnect Mode: </SPAN>Typically PPPoE 
			                connections are not always on. The D-Link router allows you to 
			                set the reconnection mode. The settings are: </P>
			                <UL>
			                  <LI><SPAN class=option>Always on: </SPAN>A connection to the 
			                  Internet is always maintained. 
			                  <LI><SPAN class=option>On demand: </SPAN>A connection to the 
			                  Internet is made as needed. 
			                  <LI><SPAN class=option>Manual: </SPAN>You have to open up the 
			                  Web-based management interface and click the Connect button 
			                  manually any time that you wish to connect to the Internet. 
			                  </LI></UL>
			                <P><SPAN class=option>Maximum Idle Time: </SPAN>Time interval 
			                the machine can be idle before the PPPoE connection is 
			                disconnected. The Maximum Idle Time value is only used for the 
			                "On demand" and "Manual" reconnect modes. </P>
			                <DT>PPTP 
			                <DD>PPTP (Point to Point Tunneling Protocol) uses a virtual 
			                private network to connect to your ISP. This method of 
			                connection is primarily used in Europe. This method of 
			                connection requires you to enter a <SPAN 
			                class=option>Username</SPAN> and <SPAN 
			                class=option>Password</SPAN> (provided by your Internet Service 
			                Provider) to gain access to the Internet. The supported 
			                authentication protocols are PAP and CHAP. 
			                <P><SPAN class=option>Dynamic IP: </SPAN>If the ISP's servers 
			                assign the router's IP addressing upon establishing a 
			                connection, select this option. </P>
			                <P><SPAN class=option>Static IP: </SPAN>If your ISP has assigned 
			                a fixed IP address, select this option. The ISP provides the 
			                values for the following fields: <SPAN class=option>PPTP IP 
			                Address</SPAN>, <SPAN class=option>PPTP Subnet Mask </SPAN>, and 
			                <SPAN class=option>PPTP Gateway IP Address</SPAN>. </P>
			                <P><SPAN class=option>PPTP Server IP Address: </SPAN>The ISP 
			                provides this parameter, if necessary. The value may be the same 
			                as the Gateway IP Address. </P>
			                <P><SPAN class=option>Reconnect Mode: </SPAN>Typically PPTP 
			                connections are not always on. The D-Link router allows you to 
			                set the reconnection mode. The settings are: </P>
			                <UL>
			                  <LI><SPAN class=option>Always on: </SPAN>A connection to the 
			                  Internet is always maintained. 
			                  <LI><SPAN class=option>On demand: </SPAN>A connection to the 
			                  Internet is made as needed. 
			                  <LI><SPAN class=option>Manual: </SPAN>You have to open up the 
			                  Web-based management interface and click the Connect button 
			                  manually any time that you wish to connect to the Internet. 
			                  </LI></UL>
			                <P><SPAN class=option>Maximum Idle Time: </SPAN>Time interval 
			                the machine can be idle before the PPTP connection is 
			                disconnected. The Maximum Idle Time value is only used for the 
			                "On demand" and "Manual" reconnect modes. </P>
			                <DT>L2TP 
			                <DD>L2TP (Layer Two Tunneling Protocol) uses a virtual private 
			                network to connect to your ISP. This method of connection 
			                requires you to enter a <SPAN class=option>Username</SPAN> and 
			                <SPAN class=option>Password</SPAN> (provided by your Internet 
			                Service Provider) to gain access to the Internet. The supported 
			                authentication protocols are PAP and CHAP. 
			                <P><SPAN class=option>Dynamic IP: </SPAN>If the ISP's servers 
			                assign the router's IP addressing upon establishing a 
			                connection, select this option. </P>
			                <P><SPAN class=option>Static IP: </SPAN>If your ISP has assigned 
			                a fixed IP address, select this option. The ISP provides the 
			                values for the following fields: <SPAN class=option>L2TP IP 
			                Address</SPAN>, <SPAN class=option>L2TP Subnet Mask </SPAN>, and 
			                <SPAN class=option>L2TP Gateway IP Address</SPAN>. </P>
			                <P><SPAN class=option>L2TP Server IP Address: </SPAN>The ISP 
			                provides this parameter, if necessary. The value may be the same 
			                as the Gateway IP Address. </P>
			                <P><SPAN class=option>Reconnect Mode: </SPAN>Typically L2TP 
			                connections are not always on. The D-Link router allows you to 
			                set the reconnection mode. The settings are: </P>
			                <UL>
			                  <LI><SPAN class=option>Always on: </SPAN>A connection to the 
			                  Internet is always maintained. 
			                  <LI><SPAN class=option>On demand: </SPAN>A connection to the 
			                  Internet is made as needed. 
			                  <LI><SPAN class=option>Manual: </SPAN>You have to open up the 
			                  Web-based management interface and click the Connect button 
			                  manually any time that you wish to connect to the Internet. 
			                  </LI></UL>
			                <P><SPAN class=option>Maximum Idle Time: </SPAN>Time interval 
			                the machine can be idle before the L2TP connection is 
			                disconnected. The Maximum Idle Time value is used for the "On 
			                demand" and "Manual" reconnect modes. </P></DD></DL>
			              <DT> 
			              <DD>
			              <P>The following options apply to all WAN modes. </P>
			              <P><SPAN class=option>Primary DNS Server, Secondary DNS Server: 
			              </SPAN>Enter the IP addresses of the DNS Servers. Leave the field 
			              for the secondary server empty if not used. </P>
			              <P><SPAN class=option>MTU:</SPAN> The Maximum Transmission Unit 
			              (MTU) is a parameter that determines the largest packet size (in 
			              bytes) that the router will send to the WAN. If LAN devices send 
			              larger packets, the router will break them into smaller packets. 
			              Ideally, you should set this to match the MTU of the connection to 
			              your ISP. Typical values are 1500 bytes for an Ethernet connection 
			              and 1492 bytes for a PPPoE connection. If the router's MTU is set 
			              too high, packets will be fragmented downstream. If the router's 
			              MTU is set too low, the router will fragment packets unnecessarily 
			              and in extreme cases may be unable to establish some connections. 
			              In either case, network performance can suffer. </P>
			              <P><SPAN class=option>MAC Address:</SPAN> Each networking device 
			              has it's own unique MAC address defined by the hardware 
			              manufacturer. Some ISP's may check your computer's MAC address. 
			              Some ISP's record the MAC address of the network adapter in the 
			              computer or router used to initially connect to their service. The 
			              ISP will then only grant Internet access to requests from a 
			              computer or router with this particular MAC address. This router 
			              has a different MAC address than the computer or router that 
			              initially connected to the ISP. If you need to change the MAC 
			              address of the router's WAN-side Ethernet interface, either type 
			              in an alternate MAC address (for example, the MAC address of the 
			              router initially connected to the ISP) or copy the MAC address of 
			              a PC. To copy the MAC address of the computer that initially 
			              connected to the ISP, connect to the D-Link router using that 
			              computer and click the <SPAN class=button_ref>Clone Your PC's MAC 
			              Address</SPAN> button. The WAN interface will then use the MAC 
			              address of the network adapter in your computer. 
						</P></DD></DL>
                       </td>
                    </tr>
					</table>
				</div>
				<div class="box">
					<h2><A id=Wireless name=Wireless>Wireless</a></h2>
					<table border=0 cellspacing=0 cellpadding=0>
						 <tr>
		                   <td>
								<P>The wireless section is used to configure the wireless settings 
						            for your D-Link router. Note that changes made in this section may 
						            also need to be duplicated on wireless clients that you want to 
						            connect to your wireless network. </P>
						            <P>To protect your privacy, use the wireless security mode to 
						            configure the wireless security features. This device supports three 
						            wireless security modes including: WEP, WPA-Personal, and 
						            WPA-Enterprise. WEP is the original wireless encryption standard. 
						            WPA provides a higher level of security. WPA-Personal does not 
						            require an authentication server. The WPA-Enterprise option does 
						            require a RADIUS authentication server. </P>
						            <DL>
						              <DT>Enable Wireless 
						              <DD>This option turns off and on the wireless connection feature 
						              of the router. When you set this option, the following parameters 
						              are in effect. 
						              <DT>Wireless Network Name 
						              <DD>When you are browsing for available wireless networks, this is 
						              the name that will appear in the list (unless Visibility Status is 
						              set to Invisible, see below). This name is also referred to as the 
						              SSID. For security purposes, it is highly recommended to change 
						              from the pre-configured network name. 
						              <DT>Enable Auto Channel Scan 
						              <DD>If you select this option, the router automatically finds the 
						              channel with least interference and uses that channel for wireless 
						              networking. If you disable this option, the router uses the 
						              channel that you specify with the following <SPAN 
						              class=option>Wireless Channel</SPAN> option. 
						              <DT>Wireless Channel 
						              <DD>A wireless network uses specific channels in the wireless 
						              spectrum to handle communication between clients. Some channels in 
						              your area may have interference from other electronic devices. 
						              Choose the clearest channel to help optimize the performance and 
						              coverage of your wireless network. <!-- super_G -->
						              <DT>802.11 Mode 
						              <DD>If all of the wireless devices you want to connect with this 
						              router can connect in the same transmission mode, you can improve 
						              performance slightly by choosing the appropriate "Only" mode. If 
						              you have some devices that use a different transmission mode, 
						              choose the appropriate "Mixed" mode. 
						              <DT>Channel Width 
						              <DD>The "Auto 20/40 MHz" option is usually best. The other options 
						              are available for special circumstances. 
						              <DT>Transmission Rate 
						              <DD>By default the fastest possible transmission rate will be 
						              selected. You have the option of selecting the speed if necessary. 
						
						              <DT>Visibility Status 
						              <DD>The Invisible option allows you to hide your wireless network. 
						              When this option is set to Visible, your wireless network name is 
						              broadcast to anyone within the range of your signal. If you're not 
						              using encryption then they could connect to your network. When 
						              Invisible mode is enabled, you must enter the Wireless Network 
						              Name (SSID) on the client manually to connect to the network. 
						              <DT>Security Mode 
						              <DD>Unless one of these encryption modes is selected, wireless 
						              transmissions to and from your wireless network can be easily 
						              intercepted and interpreted by unauthorized users. 
						              <DT>WEP 
						              <DD>
						              <P>A method of encrypting data for wireless communication intended 
						              to provide the same level of privacy as a wired network. WEP is 
						              not as secure as WPA encryption. To gain access to a WEP network, 
						              you must know the key. The key is a string of characters that you 
						              create. When using WEP, you must determine the level of 
						              encryption. The type of encryption determines the key length. 
						              128-bit encryption requires a longer key than 64-bit encryption. 
						              Keys are defined by entering in a string in HEX (hexadecimal - 
						              using characters 0-9, A-F) or ASCII (American Standard Code for 
						              Information Interchange - alphanumeric characters) format. ASCII 
						              format is provided so you can enter a string that is easier to 
						              remember. The ASCII string is converted to HEX for use over the 
						              network. Four keys can be defined so that you can change keys 
						              easily. A default key is selected for use on the network. </P>
						              <DIV class=help_example>
						              <DL>
						                <DT>Example: 
						                <DD>64-bit hexadecimal keys are exactly 10 characters in length. 
						                (12345678FA is a valid string of 10 characters for 64-bit 
						                encryption.) 
						                <DD>128-bit hexadecimal keys are exactly 26 characters in 
						                length. (456FBCDF123400122225271730 is a valid string of 26 
						                characters for 128-bit encryption.) 
						                <DD>64-bit ASCII keys are up to 5 characters in length (DMODE is 
						                a valid string of 5 characters for 64-bit encryption.) 
						                <DD>128-bit ASCII keys are up to 13 characters in length 
						                (2002HALOSWIN1 is a valid string of 13 characters for 128-bit 
						                encryption.) </DD></DL></DIV>
						              <P>Note that, if you enter fewer characters in the WEP key than 
						              required, the remainder of the key is automatically padded with 
						              zeros. </P>
						              <DT>WPA-Personal and WPA-Enterprise 
						              <DD>
						              <P>Both of these options select some variant of Wi-Fi Protected 
						              Access (WPA) -- security standards published by the Wi-Fi 
						              Alliance. The <SPAN class=option>WPA Mode</SPAN> further refines 
						              the variant that the router should employ. </P>
						              <P><SPAN class=option>WPA Mode: </SPAN>WPA is the older standard; 
						              select this option if the clients that will be used with the 
						              router only support the older standard. WPA2 is the newer 
						              implementation of the stronger IEEE 802.11i security standard. 
						              With the "WPA2" option, the router tries WPA2 first, but falls 
						              back to WPA if the client only supports WPA. With the "WPA2 Only" 
						              option, the router associates only with clients that also support 
						              WPA2 security. </P>
						              <P><SPAN class=option>Group Key Update Interval: </SPAN>The amount 
						              of time before the group key used for broadcast and multicast data 
						              is changed. </P>
						              <DT>WPA-Personal 
						              <DD>
						              <P>This option uses Wi-Fi Protected Access with a Pre-Shared Key 
						              (PSK). </P>
						              <P><SPAN class=option>Pre-Shared Key: </SPAN>The key is entered as 
						              a pass-phrase of up to 63 alphanumeric characters in ASCII 
						              (American Standard Code for Information Interchange) format at 
						              both ends of the wireless connection. It cannot be shorter than 
						              eight characters, although for proper security it needs to be of 
						              ample length and should not be a commonly known phrase. This 
						              phrase is used to generate session keys that are unique for each 
						              wireless client. </P>
						              <DIV class=help_example>
						              <DL>
						                <DT>Example: 
						                <DD><CODE>Wireless Networking technology enables ubiquitous 
						                communication</CODE> </DD></DL></DIV>
						              <DT>WPA-Enterprise 
						              <DD>
						              <P>This option works with a RADIUS Server to authenticate wireless 
						              clients. Wireless clients should have established the necessary 
						              credentials before attempting to authenticate to the Server 
						              through this Gateway. Furthermore, it may be necessary to 
						              configure the RADIUS Server to allow this Gateway to authenticate 
						              users. </P>
						              <P><SPAN class=option>Authentication Timeout: </SPAN>Amount of 
						              time before a client will be required to re-authenticate. </P>
						              <P><SPAN class=option>RADIUS Server IP Address: </SPAN>The IP 
						              address of the authentication server. </P>
						              <P><SPAN class=option>RADIUS Server Port: </SPAN>The port number 
						              used to connect to the authentication server. </P>
						              <P><SPAN class=option>RADIUS Server Shared Secret: </SPAN>A 
						              pass-phrase that must match with the authentication server. </P>
						              <P><SPAN class=option>MAC Address Authentication: </SPAN>If this 
						              is selected, the user must connect from the same computer whenever 
						              logging into the wireless network. </P>
						              <P><SPAN class=option>Advanced: </SPAN></P>
						              <DL>
						                <DT>Optional Backup RADIUS Server 
						                <DD>This option enables configuration of an optional second 
						                RADIUS server. A second RADIUS server can be used as backup for 
						                the primary RADIUS server. The second RADIUS server is consulted 
						                only when the primary server is not available or not responding. 
						                The fields <SPAN class=option>Second RADIUS Server IP 
						                Address</SPAN>, <SPAN class=option>RADIUS Server Port</SPAN>, 
						                <SPAN class=option>Second RADIUS server Shared Secret</SPAN>, 
						                <SPAN class=option>Second MAC Address Authentication</SPAN> 
						                provide the corresponding parameters for the second RADIUS 
						                Server. </DD></DL></DD></DL>
							</td>
		                  </tr>
		            </table>
			    </div>
				<div class="box">
					<h2><A id=Network name=Network>Network Settings</A></h2>
						<table border=0 cellspacing=0 cellpadding=0>
						<tr>
                            <td>
                            
                            	<DL><!-- No Bridge issue 2007.05.08 -->
					              <DT>Router Settings 
					              <DD>These are the settings of the LAN (Local Area Network) 
					              interface for the router. The router's local network (LAN) 
					              settings are configured based on the IP Address and Subnet Mask 
					              assigned in this section. The IP address is also used to access 
					              this Web-based management interface. It is recommended that you 
					              use the default settings if you do not have an existing network. 
					              <DL>
					                <DT>IP Address 
					                <DD>The IP address of your router on the local area network. 
					                Your local area network settings are based on the address 
					                assigned here. For example, 192.168.0.1. 
					                <DT>Subnet Mask 
					                <DD>The subnet mask of your router on the local area network. 
					                <DT>Device Name 
					                <DD>Device Name allows you to configure this device easily when your network using TCP/IP protocol.
							You can enter the device name of the router, instead of IP address, into your web browser to access for configuration.
							Recommend to change the device name if there's more than on D-Link devices within the subnet.									
					                <DT>Local Domain Name 
					                <DD>This entry is optional. Enter a domain name for the local 
					                network. The AP's DHCP server will give this domain name to the 
					                computers on the wireless LAN. So, for example, if you enter 
					                <CODE>mynetwork.net</CODE> here, and you have a wireless laptop 
					                with a name of <CODE>chris</CODE>, that laptop will be known as 
					                <CODE>chris.mynetwork.net</CODE>. Note, however, if the AP's 
					                settings specify "DHCP (Dynamic)" Address, and the router's DHCP 
					                server assigns a domain name to the AP, that domain name will 
					                override any name you enter here. 
					                <DT>DNS Relay 
					                <DD>When DNS Relay is enabled, the router plays the role of a 
					                DNS server. DNS requests sent to the router are forwarded to the 
					                ISP's DNS server. This provides a constant DNS address that LAN 
					                computers can use, even when the router obtains a different DNS 
					                server address from the ISP upon re-establishing the WAN 
					                connection. You should disable DNS relay if you implement a 
					                LAN-side DNS server as a virtual server. </DD></DL><!--  No Bridge issue 2007.05.18
																		<p>If WAN Port Mode is set to "Bridge Mode", the following choices are displayed in place of the above choices, because the device is functioning as a bridge in a network that contains another router.</p>
					
																		<dl>
					
																		<dt>Router IP Address</dt>
																			<dd>The IP address of the this device on the local area network. 
																		Assign any unused IP address in the range of IP addresses available for the LAN.
																		For example, 192.168.0.101.</dd>
					
																		<dt>Subnet Mask</dt>
																			<dd>The subnet mask of the local area network.</dd>
					
																		<dt>Gateway</dt>
																			<dd>The IP address of the <span>rou</span><span>ter</span> on the local area network.
																				For example, 192.168.0.1.</dd>
																		<dt>
																			Primary DNS Server, Secondary DNS Server</dt>
																		<dd>
											Enter the IP addresses of the DNS Servers. Leave the field for the secondary server empty if not used.
											</dd>
					
																		</dl>
																		-->
					              <DT>DHCP Server Settings 
					              <DD>
					              <P>DHCP stands for Dynamic Host Configuration Protocol. The DHCP 
					              section is where you configure the built-in DHCP Server to assign 
					              IP addresses to the computers and other devices on your local area 
					              network (LAN). </P>
					              <DL>
					                <DT>Enable DHCP Server 
					                <DD>
					                <P>Once your D-Link router is properly configured and this 
					                option is enabled, the DHCP Server will manage the IP addresses 
					                and other network configuration information for computers and 
					                other devices connected to your Local Area Network. There is no 
					                need for you to do this yourself. </P>
					                <P>The computers (and other devices) connected to your LAN also 
					                need to have their TCP/IP configuration set to "DHCP" or "Obtain 
					                an IP address automatically". </P>
					                <P>When you set <SPAN class=option>Enable DHCP Server</SPAN>, 
					                the following options are displayed. </P>
					                <DT>DHCP IP Address Range 
					                <DD>These two IP values (<I>from</I> and <I>to</I>) define a 
					                range of IP addresses that the DHCP Server uses when assigning 
					                addresses to computers and devices on your Local Area Network. 
					                Any addresses that are outside of this range are not managed by 
					                the DHCP Server; these could, therefore, be used for manually 
					                configured devices or devices that cannot use DHCP to obtain 
					                network address details automatically. 
					                <P>It is possible for a computer or device that is manually 
					                configured to have an address that does reside within this 
					                range. In this case the address should be reserved (see <A 
					                href="#Static_DHCP">DHCP 
					                Reservation</A> below), so that the DHCP Server knows that this 
					                specific address can only be used by a specific computer or 
					                device. </P>
					                <P>Your D-Link router, by default, has a static IP address of 
					                192.168.0.1. This means that addresses 192.168.0.2 to 
					                192.168.0.254 can be made available for allocation by the DHCP 
					                Server. </P>
					                <DIV class=help_example>
					                <DL>
					                  <DT>Example: 
					                  <DD>Your D-Link router uses 192.168.0.1 for the IP address. 
					                  You've assigned a computer that you want to designate as a Web 
					                  server with a static IP address of 192.168.0.3. You've 
					                  assigned another computer that you want to designate as an FTP 
					                  server with a static IP address of 192.168.0.4. Therefore the 
					                  starting IP address for your DHCP IP address range needs to be 
					                  192.168.0.5 or greater. 
					                  <DT>Example: 
					                  <DD>Suppose you configure the DHCP Server to manage addresses 
					                  From 192.168.0.100 To 192.168.0.199. This means that 
					                  192.168.0.3 to 192.168.0.99 and 192.168.0.200 to 192.168.0.254 
					                  are NOT managed by the DHCP Server. Computers or devices that 
					                  use addresses from these ranges are to be manually configured. 
					                  Suppose you have a web server computer that has a manually 
					                  configured address of 192.168.0.100. Because this falls within 
					                  the "managed range" be sure to create a reservation for this 
					                  address and match it to the relevant computer (see <A 
					                  href="#Static_DHCP">Static 
					                  DHCP Client</A> below). </DD></DL></DIV>
					                <DT>DHCP Lease Time 
					                <DD>The amount of time that a computer may have an IP address 
					                before it is required to renew the lease. The lease functions 
					                just as a lease on an apartment would. The initial lease 
					                designates the amount of time before the lease expires. If the 
					                tenant wishes to retain the address when the lease is expired 
					                then a new lease is established. If the lease expires and the 
					                address is no longer needed than another tenant may use the 
					                address. 
					                <DT>Always Broadcast 
					                <DD>If all the computers on the LAN successfully obtain their IP 
					                addresses from the router's DHCP server as expected, this option 
					                can remain disabled. However, if one of the computers on the LAN 
					                fails to obtain an IP address from the router's DHCP server, it 
					                may have an old DHCP client that incorrectly turns off the 
					                broadcast flag of DHCP packets. Enabling this option will cause 
					                the router to always broadcast its responses to all clients, 
					                thereby working around the problem, at the cost of increased 
					                broadcast traffic on the LAN. 
					                <DT>NetBIOS Advertisement 
					                <DD>Check this box to allow the DHCP Server to offer NetBIOS 
					                configuration settings to the LAN hosts. NetBIOS allow LAN hosts 
					                to discover all other computers within the network, e.g. within 
					                Network Neighbourhood. 
					                <DT>Learn NetBIOS information from WAN 
					                <DD>If NetBIOS advertisement is swicthed on, switching this 
					                setting on causes WINS information to be learned from the WAN 
					                side, if available. Turn this setting off to configure manually. 
					
					                <DT>Primary WINS Server IP address 
					                <DD>Configure the IP address of the preferred WINS server. WINS 
					                Servers store information regarding network hosts, allowing 
					                hosts to 'register' themselves as well as discover other 
					                available hosts, e.g. for use in Network Neighbourhood. This 
					                setting has no effect if the 'Learn NetBIOS information from 
					                WAN' is activated. 
					                <DT>Secondary WINS Server IP address 
					                <DD>Configure the IP address of the backup WINS server, if any. 
					                This setting has no effect if the 'Learn NetBIOS information 
					                from WAN' is activated. 
					                <DT>NetBIOS Scope 
					                <DD>This is an advanced setting and is normally left blank. This 
					                allows the configuration of a NetBIOS 'domain' name under which 
					                network hosts operate. This setting has no effect if the 'Learn 
					                NetBIOS information from WAN' is activated. 
					                <DT>NetBIOS Registration mode 
					                <DD>Indicates how network hosts are to perform NetBIOS name 
					                registration and discovery.<BR>H-Node, this indicates a 
					                Hybrid-State of operation. First WINS servers are tried, if any, 
					                followed by local network broadcast. This is generally the 
					                preferred mode if you have configured WINS servers.<BR>M-Node 
					                (default), this indicates a Mixed-Mode of operation. First 
					                Broadcast operation is performed to register hosts and discover 
					                other hosts, if broadcast operation fails, WINS servers are 
					                tried, if any. This mode favours broadcast operation which may 
					                be preferred if WINS servers are reachable by a slow network 
					                link and the majority of network services such as servers and 
					                printers are local to the LAN.<BR>P-Node, this indicates to use 
					                WINS servers ONLY. This setting is useful to force all NetBIOS 
					                operation to the configured WINS servers. You must have 
					                configured at least the primary WINS server IP to point to a 
					                working WINS server.<BR>B-Node, this indicates to use local 
					                network broadcast ONLY. This setting is useful where there are 
					                no WINS servers available, however, it is preferred you try 
					                M-Node operation first.<BR>This setting has no effect if the 
					                'Learn NetBIOS information from WAN' is activated.<BR></DD></DL>
					              <DT><A id="Static_DHCP" name="Static_DHCP">Add/Edit DHCP 
					              Reservation</A> 
					              <DD>
					              <P>This option lets you reserve IP addresses, and assign the same 
					              IP address to the network device with the specified MAC address 
					              any time it requests an IP address. This is almost the same as 
					              when a device has a static IP address except that the device must 
					              still request an IP address from the D-Link router. The D-Link 
					              router will provide the device the same IP address every time. 
					              DHCP Reservations are helpful for server computers on the local 
					              network that are hosting applications such as Web and FTP. Servers 
					              on your network should either use a static IP address or use this 
					              option. </P>
					              <DL>
					                <DT>Computer Name 
					                <DD>
					                <P>You can assign a name for each computer that is given a 
					                reserved IP address. This may help you keep track of which 
					                computers are assigned this way. Example: <CODE>Game 
					                Server</CODE>. </P>
					                <DT>IP Address: 
					                <DD>The LAN address that you want to reserve. 
					                <DT>MAC Address 
					                <DD>
					                <P>To input the MAC address of your system, enter it in manually 
					                or connect to the D-Link router's Web-Management interface from 
					                the system and click the <SPAN class=button_ref>Copy Your PC's 
					                MAC Address</SPAN> button. </P>
					                <P>A MAC address is usually located on a sticker on the bottom 
					                of a network device. The MAC address is comprised of twelve 
					                digits. Each pair of hexadecimal digits are usually separated by 
					                dashes or colons such as 00-0D-88-11-22-33 or 00:0D:88:11:22:33. 
					                If your network device is a computer and the network card is 
					                already located inside the computer, you can connect to the 
					                D-Link router from the computer and click the <SPAN 
					                class=button_ref>Copy Your PC's MAC Address</SPAN> button to 
					                enter the MAC address. </P>
					                <P>As an alternative, you can locate a MAC address in a specific 
					                operating system by following the steps below: </P>
					                <TABLE summary="">
					                  <TBODY>
					                  <TR>
					                    <TD width="20%">Windows 98 <BR clear=none>Windows Me </TD>
					                    <TD>Go to the Start menu, select Run, type in 
					                      <CODE>winipcfg</CODE>, and hit Enter. A popup window will 
					                      be displayed. Select the appropriate adapter from the 
					                      pull-down menu and you will see the Adapter Address. This 
					                      is the MAC address of the device. </TD></TR>
					                  <TR>
					                    <TD width="20%">Windows 2000 <BR clear=none>Windows XP </TD>
					                    <TD>Go to your Start menu, select Programs, select 
					                      Accessories, and select Command Prompt. At the command 
					                      prompt type <CODE>ipconfig /all</CODE> and hit Enter. The 
					                      physical address displayed for the adapter connecting to 
					                      the router is the MAC address. </TD></TR>
					                  <TR>
					                    <TD width="20%">Mac OS X </TD>
					                    <TD>Go to the Apple Menu, select System Preferences, 
					                      select Network, and select the Ethernet Adapter connecting 
					                      to the D-Link router. Select the Ethernet button and the 
					                      Ethernet ID will be listed. This is the same as the MAC 
					                      address. </TD></TR></TBODY></TABLE></DD></DL>
					              <DT>DHCP Reservations List 
					              <DD>This shows clients that you have specified to have reserved 
					              DHCP addresses. An entry can be changed by clicking the Edit icon, 
					              or deleted by clicking the Delete icon. When you click the Edit 
					              icon, the item is highlighted, and the "Edit DHCP Reservation" 
					              section is activated for editing. 
					              <DT>Number of Dynamic DHCP Clients 
					              <DD>
					              <P>In this section you can see what LAN devices are currently 
					              leasing IP addresses. </P>
					              <DL>
					                <DT>Revoke 
					                <DD>The <CODE>Revoke</CODE> option is available for the 
					                situation in which the lease table becomes full or nearly full, 
					                you need to recover space in the table for new entries, and you 
					                know that some of the currently allocated leases are no longer 
					                needed. Clicking <CODE>Revoke</CODE> cancels the lease for a 
					                specific LAN device and frees an entry in the lease table. Do 
					                this only if the device no longer needs the leased IP address, 
					                because, for example, it has been removed from the network. 
					                <DT>Reserve 
					                <DD>The <CODE>Reserve</CODE> option converts this dynamic IP 
					                allocation into a DHCP Reservation and adds the corresponding 
					                entry to the DHCP Reservations List. </DD></DL></DD></DL>
                            </td>
                        </tr>
					</table>
				</div>

              </div></td>
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