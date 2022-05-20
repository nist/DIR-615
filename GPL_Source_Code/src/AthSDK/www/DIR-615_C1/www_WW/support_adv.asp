
<html>
<head>

<link rel="STYLESHEET" type="text/css" href="css_router.css">

<title>D-LINK SYSTEMS, INC | WIRELESS ROUTER | HOME</title>
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
									<li><div><div id="sidenavoff">ADVANCED</div></li>
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
						<h1>SUPPORT MENU</h1>
						<table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td>
                              <ul>
                                <li><a href=support_adv.asp#Virtual_Server>Virtual Server</a></li>
                                <li><a href=support_adv.asp#Gaming>Port Forwarding</a></li>
                                <li><a href=support_adv.asp#Special_Applications>Application Rules </a></li>
                                <li><a href=support_adv.asp#Traffic_Shaping>QoS Engine</a></li>
                                <li><a href=support_adv.asp#MAC_Address_Filter>Network Filter </a></li>
                                <li><a href=support_adv.asp#Access_Control>Access Control</a></li>
                                <li><a href=support_adv.asp#Web_Filter>Website Filter </a></li>
                                <li><a href=support_adv.asp#Inbound_Filter>Inbound Filter </a></li>
                                <li><a href=support_adv.asp#Firewall>Firewall Settings</a></li>
                                <li><a href=support_adv.asp#Advanced_Wireless>Advanced Wireless</a></li>
                                <@ wish <li><a href=support_adv.asp#WISH>WISH</a></li> @>
                                <!--li><a href=support_adv.asp#Protected_Setup>Wi-FI Protected Setup</a></li-->
                                <li><a href=support_adv.asp#Network>Advanced Network</a></li>
								<li><a href=support_adv.asp#ipv6>IPv6</a></li>
							</ul></td>
                          </tr>
                        </table>
				  </div>
				  <div class="box">
				  <h2><A name=Virtual_Server>Virtual Server</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  		<P>The Virtual Server option gives Internet users access to services 
			            on your LAN. This feature is useful for hosting online services such 
			            as FTP, Web, or game servers. For each Virtual Server, you define a 
			            public port on your router for redirection to an internal LAN IP 
			            Address and LAN port. </P>
			            <DIV class=help_example>
			            <DL>
			              <DT>Example: 
			              <DD>You are hosting a Web Server on a PC that has LAN IP Address 
			              of 192.168.0.50 and your ISP is blocking Port 80. 
			              <OL>
			                <LI>Name the Virtual Server (for example: <CODE>Web 
			                Server</CODE>) 
			                <LI>Enter the IP Address of the machine on your LAN (for 
			                example: <CODE>192.168.0.50</CODE> 
			                <LI>Enter the Private Port as [80] 
			                <LI>Enter the Public Port as [8888] 
			                <LI>Select the Protocol (for example <CODE>TCP</CODE>). 
			                <LI>Ensure the schedule is set to <CODE>Always</CODE> 
			                <LI>Click <SPAN class=button_ref>Save</SPAN> to add the settings 
			                to the Virtual Servers List 
			                <LI>Repeat these steps for each Virtual Server Rule you wish to 
			                add. After the list is complete, click <SPAN 
			                class=button_ref>Save Settings</SPAN> at the top of the page. 
			                </LI></OL>With this Virtual Server entry, all Internet traffic on 
			              Port 8888 will be redirected to your internal web server on port 
			              80 at IP Address 192.168.0.50. </DD></DL></DIV>
			            <DL>
			              <DT>Virtual Server Parameters 
			              <DD>
			              <DL>
			                <DT>Name 
			                <DD>Assign a meaningful name to the virtual server, for example 
			                <CODE>Web Server</CODE>. Several well-known types of virtual 
			                server are available from the "Application Name" drop-down list. 
			                Selecting one of these entries fills some of the remaining 
			                parameters with standard values for that type of server. 
			                <DT>IP Address 
			                <DD>The IP address of the system on your internal network that 
			                will provide the virtual service, for example 
			                <CODE>192.168.0.50</CODE>. You can select a computer from the 
			                list of DHCP clients in the "Computer Name" drop-down menu, or 
			                you can manually enter the IP address of the server computer. 
			                <DT>Traffic Type 
			                <DD>Select the protocol used by the service. The common choices 
			                -- UDP, TCP, and both UDP and TCP -- can be selected from the 
			                drop-down menu. To specify any other protocol, select "Other" 
			                from the list, then enter the corresponding protocol number (<A 
			                href="http://www.iana.org/assignments/protocol-numbers" 
			                target=_blank> as assigned by the IANA</A>) in the <SPAN 
			                class=option>Protocol</SPAN> box. 
			                <DT>Private Port 
			                <DD>The port that will be used on your internal network. 
			                <DT>Public Port 
			                <DD>The port that will be accessed from the Internet. 
			                <DT>Inbound Filter 
			                <DD>Select a filter that controls access as needed for this 
			                virtual server. If you do not see the filter you need in the 
			                list of filters, go to the 

 
                              

 
                              <a href="Inbound_Filter.asp">Advanced&rarr;Inbound&nbsp;Filter</a>).			                screen and create a new filter. 
			                <DT>Schedule 
			                <DD>Select a schedule for when the service will be enabled. If 
			                you do not see the schedule you need in the list of schedules, 
			                go to the <a href="tools_schedules.asp">Tools&rarr;Schedules </a>  screen and create a new schedule. </DD>
			              </DL>
			              <DT>24 -- Virtual Servers List 
			              <DD>Use the checkboxes at the left to activate or deactivate 
			              completed Virtual Server entries. </DD></DL>
			            <P><B>Note:</B> You might have trouble accessing a virtual server 
			            using its public identity (WAN-side IP-address of the gateway or its 
			            dynamic DNS name) from a machine on the LAN. Your requests may not 
			            be looped back or you may be redirected to the "Forbidden" page. 
						</P>
			            <P>This will happen if you have an Access Control Rule configured 
			            for this LAN machine. </P>
			            <P>The requests from the LAN machine will not be looped back if 
			            Internet access is blocked at the time of access. To work around 
			            this problem, access the LAN machine using its LAN-side identity. 
			            </P>
			            <P>Requests may be redirected to the "Forbidden" page if web access 
			            for the LAN machine is restricted by an Access Control Rule. Add the 
			            WAN-side identity (WAN-side IP-address of the router or its dynamic 
			            DNS name) on the 
                          <a href="adv_filters_url.asp">Advanced&rarr;Web&nbsp;Filter </a>			            screen to work around this problem. </P>
				  		</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Gaming>Port Forwarding</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  		<P>Multiple connections are required by some applications, such as 
			            internet games, video conferencing, Internet telephony, and others. 
			            These applications have difficulties working through NAT (Network 
			            Address Translation). This section is used to open multiple ports or 
			            a range of ports in your router and redirect data through those 
			            ports to a single PC on your network. You can enter ports in various 
			            formats: </P>
			            <P>Range (50-100) <BR clear=none>Individual (80, 68, 888) <BR 
			            clear=none>Mixed (1020-5000, 689) </P>
			            <DIV class=help_example>
			            <DL>
			              <DT>Example: 
			              <DD>Suppose you are hosting an online game server that is running 
			              on a PC with a private IP Address of 192.168.0.50. This game 
			              requires that you open multiple ports (6159-6180, 99) on the 
			              router so Internet users can connect. </DD></DL></DIV>
			            <DL>
			              <DT>Port Forwarding Fields 
			              <DD>
			              <DL>
			                <DT>Name 
			                <DD>Give the rule a name that is meaningful to you, for example 
			                <CODE>Game Server</CODE>. You can also select from a list of 
			                popular games, and many of the remaining configuration values 
			                will be filled in accordingly. However, you should check whether 
			                the port values have changed since this list was created, and 
			                you must fill in the IP address field. 
			                <DT>IP Address 
			                <DD>Enter the local network IP address of the system hosting the 
			                server, for example <CODE>192.168.0.50</CODE>. 
			                <DT>TCP Ports To Open 
			                <DD>Enter the TCP ports to open (for example <CODE>6159-6180, 
			                99</CODE>). 
			                <DT>UDP Ports To Open 
			                <DD>Enter the UDP ports to open (for example <CODE>6159-6180, 
			                99</CODE>). 
			                <DT>Inbound Filter 
			                <DD>Select a filter that controls access as needed for this 
			                rule. If you do not see the filter you need in the list of 
			                filters, go to the 

 
                              

 
                              <a href="Inbound_Filter.asp">Advanced&rarr;Inbound&nbsp;Filter</a> screen and create a new filter. 
			                <DT>Schedule 
			                <DD>Select a schedule for the times when this rule is in effect. 
			                If you do not see the schedule you need in the list of 
			                schedules, go to the 
                            <a href="tools_schedules.asp">Tools&rarr;Schedules</a> screen and create a new schedule. </DD></DL>
			              <DIV class=help_example>
			              <P>With the above example values filled in and this Port 
			              Forwarding Rule enabled, all TCP and UDP traffic on ports 6159 
			              through 6180 and port 99 is passed through the router and 
			              redirected to the Internal Private IP Address of your Game Server 
			              at 192.168.0.50. </P></DIV>
			              <P>Note that different LAN computers cannot be associated with 
			              Port Forwarding rules that contain any ports in common; such rules 
			              would contradict each other. </P>
			              <DT>24 -- Port Forwarding Rules 
			              <DD>Enable or disable defined rules with the checkboxes at the 
			              left. </DD></DL>
				  		</td>
				  	</tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Special_Applications>Application Rules</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P>An application rule is used to open single or multiple ports on 
				            your router when the router senses data sent to the Internet on a 
				            "trigger" port or port range. An application rule applies to all 
				            computers on your internal network. </P>
				            <DL>
				              <DT>Parameters for an Application Rule 
				              <DD>
				              <DIV class=help_example>
				              <DL>
				                <DT>Example: 
				                <DD>You need to configure your router to allow a software 
				                application running on any computer on your network to connect 
				                to a web-based server or another user on the Internet. 
				              </DD></DL></DIV>
				              <DL>
				                <DT>Name 
				                <DD>Enter a name for the Special Application Rule, for example 
				                <CODE>Game App</CODE>, which will help you identify the rule in 
				                the future. Alternatively, you can select from the <SPAN 
				                class=option>Application</SPAN> list of common applications. 
				                <DT>Application 
				                <DD>Instead of entering a name for the Special Application rule, 
				                you can select from this list of common applications, and the 
				                remaining configuration values will be filled in accordingly. 
				                <DT>Trigger Port 
				                <DD>Enter the outgoing port range used by your application (for 
				                example <CODE>6500-6700</CODE>). 
				                <DT>Trigger Traffic Type 
				                <DD>Select the outbound protocol used by your application (for 
				                example <CODE>Both</CODE>). 
				                <DT>Firewall Port 
				                <DD>Enter the port range that you want to open up to Internet 
				                traffic (for example <CODE>6000-6200</CODE>). 
				                <DT>Firewall Traffic Type 
				                <DD>Select the protocol used by the Internet traffic coming back 
				                into the router through the opened port range (for example 
				                <CODE>Both</CODE>). 
				                <DT>Schedule 
				                <DD>Select a schedule for when this rule is in effect. If you do 
				                not see the schedule you need in the list of schedules, go to 
				                the <a href="tools_schedules.asp">Tools&rarr;Schedules</a> screen and create a new schedule. </DD></DL>
				              <DIV class=help_example>
				              <P>With the above example application rule enabled, the router 
				              will open up a range of ports from 6000-6200 for incoming traffic 
				              from the Internet, whenever any computer on the internal network 
				              opens up an application that sends data to the Internet using a 
				              port in the range of 6500-6700. </P></DIV></DD></DL>
				            <DL>
				              <DT>24 -- Application Rules 
				              <DD>This section is where you define application rules. Enable or 
				              disable defined rules with the checkboxes at the left. 
				            </DD></DL>
				  		</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Traffic_Shaping>QoS Engine</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P>The QoS Engine feature helps improve your network performance by prioritizing applications. </P>
            <DL>
              <DT>WAN Traffic Shaping 
              <DD>
              <DL>
			    <DT>Enable QoS Engine 
                <DD>Enable this option for better performance and experience 
                with online games and other interactive applications, such as 
                VoIP. 
                <!--DT>Enable Traffic Shaping 
                <DD>When this option is enabled, the router restricts the flow 
                of outbound traffic so as not to exceed the WAN uplink 
                bandwidth. -->
                <DT>Automatic Uplink Speed 
                <DD>When enabled, this option causes the router to automatically 
                measure the useful uplink bandwidth each time the WAN interface 
                is re-established (after a reboot, for example). 
                <DT>Measured Uplink Speed 
                <DD>This is the uplink speed measured when the WAN interface was 
                last re-established. The value may be lower than that reported 
                by your ISP as it does not include all of the network protocol 
                overheads associated with your ISP's network. Typically, this 
                figure will be between 87% and 91% of the stated uplink speed 
                for xDSL connections and around 5 kbps lower for cable network 
                connections. 
                <DT>Manual Uplink Speed 
                <DD>If Automatic Uplink Speed is disabled, this option allows 
                you to set the uplink speed manually. Uplink speed is the speed 
                at which data can be transferred from the router to your ISP. 
                This is determined by your ISP. ISPs often specify speed as a 
                downlink/uplink pair; for example, 1.5Mbps/284kbps. For this 
                example, you would enter "284". Alternatively you can test your 
                uplink speed with a service such as <A 
                href="http://www.dslreports.com/">http://www.dslreports.com/</A>. 
                Note however that sites such as DSL Reports, because they do not 
                consider as many network protocol overheads, will generally note 
                speeds slightly lower than the Measured Uplink Speed or the ISP 
                rated speed. 
                <!--DT>Connection Type 
                <DD>By default, the router automatically determines whether the 
                underlying connection is an xDSL/Frame-relay network or some 
                other connection type (such as cable modem or Ethernet), and it 
                displays the result as <SPAN class=option>Detected xDSL or Frame 
                Relay Network</SPAN>. If you have an unusual network connection 
                in which you are actually connected via xDSL but for which you 
                configure either "Static" or "DHCP" in the WAN settings, setting 
                this option to <SPAN class=option>xDSL or Other Frame Relay 
                Network</SPAN> ensures that the router will recognize that it 
                needs to shape traffic slightly differently in order to give the 
                best performance. Choosing <SPAN class=option>xDSL or Other 
                Frame Relay Network</SPAN> causes the measured uplink speed to 
                be reported slightly lower than before on such connections, but 
                gives much better results. 
                <DT>Detected xDSL or Frame Relay Network 
                <DD>When <SPAN class=option>Connection Type</SPAN> is set to 
                <SPAN class=option>Auto-detect</SPAN>, the automatically 
                detected connection type is displayed here. </DD></DL-->
              <!--DT>QoS Engine Setup 
              <DD>
              <DL>
                
                <DT>Automatic Classification 
                <DD>This option is enabled by default so that your router will 
                automatically determine which programs should have network 
                priority. For best performance, use the Automatic Classification 
                option to automatically set the priority for your applications. 
                <DT>Dynamic Fragmentation 
                <DD>This option should be enabled when you have a slow Internet 
                uplink. It helps to reduce the impact that large low priority 
                network packets can have on more urgent ones by breaking the 
                large packets into several smaller packets. </DD></DL>
              <DT>QoS Engine Rules 
              <DD>A QoS Engine Rule identifies a specific message flow and 
              assigns a priority to that flow. For most applications, automatic 
              classification will be adequate, and specific QoS Engine Rules 
              will not be required. 
              <P>The QoS Engine supports overlaps between rules, where more than 
              one rule can match for a specific message flow. If more than one 
              rule is found to match the rule with the highest priority will be 
              used. </P>
              <DL>
                <DT>Name 
                <DD>Create a name for the rule that is meaningful to you. 
                <DT>Priority 
                <DD>The priority of the message flow is entered here -- 1 
                receives the highest priority (most urgent) and 255 receives the 
                lowest priority (least urgent). 
                <DT>Protocol 
                <DD>The protocol used by the messages. 
                <DT>Local IP Range 
                <DD>The rule applies to a flow of messages whose LAN-side IP 
                address falls within the range set here. 
                <DT>Local Port Range 
                <DD>The rule applies to a flow of messages whose LAN-side port 
                number is within the range set here. 
                <DT>Remote IP Range 
                <DD>The rule applies to a flow of messages whose WAN-side IP 
                address falls within the range set here. 
                <DT>Remote Port Range 
                <DD>The rule applies to a flow of messages whose WAN-side port 
                number is within the range set here. </DD></DL>
              <DT>10 -- QoS Engine Rules 
              <DD>This section is where you define QoS Engine Rules. Enable or 
              disable defined rules with the checkboxes at the left. 
            	</DD></DL-->
				  		</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=MAC_Address_Filter>MAC Address Filter (Network Filter)</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P>The MAC address filter section can be used to filter network 
				            access by machines based on the unique MAC addresses of their 
				            network adapter(s). It is most useful to prevent unauthorized 
				            wireless devices from connecting to your network. A MAC address is a 
				            unique ID assigned by the manufacturer of the network adapter. </P>
				            <DL>
				              <DT>24 -- MAC Filtering Rules 
				              <DD>
				              <DL>
				                <DT>Configure MAC Filtering 
				                <DD>When "OFF" is selected, MAC addresses are not used to 
				                control network access. When "ALLOW" is selected, only computers 
				                with MAC addresses listed in the MAC Address List are granted 
				                network access. When "DENY" is selected, any computer with a MAC 
				                address listed in the MAC Address List is refused access to the 
				                network. 
				                <DT>MAC Address 
				                <DD>Enter the MAC address of the desired. Computers that have 
				                obtained an IP address from the router's DHCP server will be in 
				                the DHCP Client List. Select a device from the drop down menu, 
				                then click the arrow to add that device's MAC address to the 
				                list. 
				                <DT>Clear 
				                <DD>Click the <SPAN class=button_ref>Clear</SPAN> button to 
				                remove the MAC address from the MAC Filtering list. 
				            </DD></DL></DD></DL>
				  		</td>
				  	</tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Access_Control>Access Control</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>
				  	<td>
				  	<P>The Access Control section allows you to control access in and 
		            out of devices on your network. Use this feature as Parental 
		            Controls to only grant access to approved sites, limit web access 
		            based on time or dates, and/or block access from applications such 
		            as peer-to-peer utilities or games. </P>
		            <DL>
		              <DT>Enable 
		              <DD>By default, the Access Control feature is disabled. If you 
		              need Access Control, check this option. 
		              <P><B>Note: </B>When Access Control is disabled, every device on 
		              the LAN has unrestricted access to the Internet. However, if you 
		              enable Access Control, Internet access is restricted for those 
		              devices that have an Access Control Policy configured for them. 
		              All other devices have unrestricted access to the Internet. </P>
		              <DT>Policy Wizard 
		              <DD>The Policy Wizard guides you through the steps of defining 
		              each access control policy. A policy is the "Who, What, When, and 
		              How" of access control -- whose computer will be affected by the 
		              control, what internet addresses are controlled, when will the 
		              control be in effect, and how is the control implemented. You can 
		              define multiple policies. The Policy Wizard starts when you click 
		              the button below and also when you edit an existing policy. 
		              <DL>
		                <DT>Add Policy 
		                <DD>Click this button to start creating a new access control 
		                policy. </DD></DL>
		              <DT>Policy Table 
		              <DD>This section shows the currently defined access control 
		              policies. A policy can be changed by clicking the Edit icon, or 
		              deleted by clicking the Delete icon. When you click the Edit icon, 
		              the Policy Wizard starts and guides you through the process of 
		              changing a policy. You can enable or disable specific policies in 
		              the list by clicking the "Enable" checkbox. </DD></DL>
				  	</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Web_Filter>Website Filter</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P>This section is where you add the Web sites to be used for Access 
				            Control. The Web sites listed here are used when the Web Filter 
				            option is enabled in 
                            <a href="adv_access_control.asp"> Advanced&rarr;Access&nbsp;Control</a>.</P>
				            <DL>
				              <DT>Website Filter Parameters 
				              <DD>
				              <DL>
				                <DT>Website URL/Domain 
				                <DD>Enter the URL (address) of the Web Site that you want to 
				                allow; for example: <CODE>google.com</CODE>. Do not enter the 
				                <CODE>http://</CODE> preceding the URL. Enter the most inclusive 
				                domain; for example, enter <CODE>dlink.com</CODE> and access 
				                will be permitted to both <CODE>www.dlink.com</CODE> and 
				                <CODE>support.dlink.com</CODE>. 
				                <P><B>Note: </B>Many web sites construct pages with images and 
				                content from other web sites. Access will be forbidden if you do 
				                not enable all the web sites used to construct a page. For 
				                example, to access <CODE>my.yahoo.com</CODE>, you need to enable 
				                access to <CODE>yahoo.com</CODE>, <CODE>yimg.com</CODE>, and 
				                <CODE>doubleclick.net</CODE>. </P></DD></DL></DD></DL>
				            <DL>
				              <DT>40 -- Website Filtering Rules 
				              <DD>The section lists the current denied or allowed web sites.
		              </DD></DL>			  		  </td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Inbound_Filter>Inbound Filter</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
                        <p>When you use the Virtual Server, Port Forwarding, or Remote Administration features to open specific ports to traffic from the Internet, you could be increasing the exposure of your LAN to cyberattacks from the Internet. In these cases, you can use Inbound Filters to limit that exposure by specifying the IP addresses of internet hosts that you trust to access your LAN through the ports that you have opened. You might, for example, only allow access to a game server on your home LAN from the computers of friends whom you have invited to play the games on that server. </p>
                        <p>Inbound Filters can be used for limiting access to a server on your network to a system or group of systems. Filter rules can be used with Virtual Server, Gaming, or Remote Administration features. Each filter can be used for several functions; for example a "Game Clan" filter might allow all of the members of a particular gaming group to play several different games for which gaming entries have been created. At the same time an "Admin" filter might only allows systems from your office network to access the WAN admin pages and an FTP server you use at home. If you add an IP address to a filter, the change is effected in all of the places where the filter is used. </p>
                        <dl>
                          <dt>Add/Update Inbound Filter Rule 
                          <dd>Here you can add entries to the Inbound Filter Rules List below, or edit existing entries.
                                          <dl>
                                            <dt>Name 
			                                <dd>Enter a name for the rule that is meaningful to you. 
			                                <dt>Action 
			                                <dd>The rule can either Allow or Deny messages. 
			                                <dt>Remote IP Range 
			                                <dd>Define the ranges of Internet addresses this rule applies to. For a single IP address, enter the same address in both the <span class=option>Start</span> and <span 
				                class=option>End</span> boxes. Up to eight ranges can be entered. The <span class=option>Enable</span> checkbox allows you to turn on or off specific entries in the list of ranges. 
			                                <dt>Add/Update 
			                                <dd>Saves the new or edited Inbound Filter Rule in the following list. 
			                                <dt>Clear 
			                                <dd>Re-initializes the Add/Update area of the screen, erasing any changes that you may have made prior to clicking the Add/Update button. </dd>
                                          </dl>
                          <dt>Inbound Filter Rules List 
                          <dd>The section lists the current Inbound Filter Rules. An Inbound Filter Rule can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the item is highlighted, and the "Update Inbound Filter Rule" section is activated for editing.
                                        <p>In addition to the filters listed here, two predefined filters are available wherever inbound filters can be applied: </p>
                                        <dl>
                                          <dt>Allow All 
			                              <dd>Permit any WAN user to access the related capability. 
			                              <dt>Deny All 
			                              <dd>Prevent all WAN users from accessing the related capability. (LAN users are not affected by Inbound Filter Rules.) </dd>
                                        </dl>
                          </dd>
                      </dl></td>
				  	</tr>
				  </table>
				  </div>
				  <div class="box">
				  <h2><A id=Firewall name=Firewall>Firewall Settings</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  		<P>The router provides a tight firewall by virtue of the way NAT 
			            works. Unless you configure the router to the contrary, the NAT does 
			            not respond to unsolicited incoming requests on any port, thereby 
			            making your LAN invisible to Internet cyberattackers. However, some 
			            network applications cannot run with a tight firewall. Those 
			            applications need to selectively open ports in the firewall to 
			            function correctly. The options on this page control several ways of 
			            opening the firewall to address the needs of specific types of 
			            applications. See also
                          <a href="adv_virtual.asp">Advanced&rarr;Virtual&nbsp;Server</a> ,
                          <a href="adv_portforward.asp">Advanced&rarr;Port&nbsp;Forwarding </a> ,  
                          <a href="adv_appl.asp">Advanced&rarr;Application&nbsp;Rules </a> , and 
                          <a href="adv_network.asp">Advanced&rarr;Network (UPnP) </a>  for related options. </P>
			            <DL>
			              <DT>Firewall Settings 
			              <DD>
			              <DL>
			                <DT>Enable SPI 
			                <DD>SPI ("stateful packet inspection" also known as "dynamic 
			                packet filtering") helps to prevent cyberattacks by tracking 
			                more state per session. It validates that the traffic passing 
			                through that session conforms to the protocol. When the protocol 
			                is TCP, SPI checks that packet sequence numbers are within the 
			                valid range for the session, discarding those packets that do 
			                not have valid sequence numbers. 
			                <P>Whether SPI is enabled or not, the router always tracks TCP 
			                connection states and ensures that each TCP packet's flags are 
			                valid for the current state. </P></DD></DL>
			              <DT>NAT Endpoint Filtering 
			              <DD>
			              <P>The NAT Endpoint Filtering options control how the router's NAT 
			              manages incoming connection requests to ports that are already 
			              being used. </P>
			              <DL>
			                <DT>Endpoint Independent 
			                <DD>Once a LAN-side application has created a connection through 
			                a specific port, the NAT will forward any incoming connection 
			                requests with the same port to the LAN-side application 
			                regardless of their origin. This is the least restrictive 
			                option, giving the best connectivity and allowing some 
			                applications (P2P applications in particular) to behave almost 
			                as if they are directly connected to the Internet. 
			                <DT>Address Restricted 
			                <DD>The NAT forwards incoming connection requests to a LAN-side 
			                host only when they come from the same IP address with which a 
			                connection was established. This allows the remote application 
			                to send data back through a port different from the one used 
			                when the outgoing session was created. 
			                <DT>Port And Address Restricted 
			                <DD>The NAT does not forward any incoming connection requests 
			                with the same port address as an already establish connection. 
			                </DD></DL>
			              <P>Note that some of these options can interact with other port 
			              restrictions. Endpoint Independent Filtering takes priority over 
			              inbound filters or schedules, so it is possible for an incoming 
			              session request related to an outgoing session to enter through a 
			              port in spite of an active inbound filter on that port. However, 
			              packets will be rejected as expected when sent to blocked ports 
			              (whether blocked by schedule or by inbound filter) for which there 
			              are no active sessions. Port and Address Restricted Filtering 
			              ensures that inbound filters and schedules work precisely, but 
			              prevents some level of connectivity, and therefore might require 
			              the use of port triggers, virtual servers, or port forwarding to 
			              open the ports needed by the application. Address Restricted 
			              Filtering gives a compromise position, which avoids problems when 
			              communicating with certain other types of NAT router (symmetric 
			              NATs in particular) but leaves inbound filters and scheduled 
			              access working as expected. </P>
			              <DL>
			                <DT>UDP Endpoint Filtering 
			                <DD>Controls endpoint filtering for packets of the UDP protocol. 
			
			                <DT>TCP Endpoint Filtering 
			                <DD>Controls endpoint filtering for packets of the TCP protocol. 
			                </DD></DL>
			              <P>Formerly, the terms "Full Cone", "Restricted Cone", "Port 
			              Restricted Cone" and "Symmetric" were used to refer to different 
			              variations of NATs. These terms are purposely not used here, 
			              because they do not fully describe the behavior of this router's 
			              NAT. While not a perfect mapping, the following loose 
			              correspondences between the "cone" classification and the 
			              "endpoint filtering" modes can be drawn: if this router is 
			              configured for endpoint independent filtering, it implements full 
			              cone behavior; address restricted filtering implements restricted 
			              cone behavior; and port and address restricted filtering 
			              implements port restricted cone behavior. </P>
			              <DT>Anti-Spoof checking 
			              <DD>
			              <P>This mechanism protects against activity from spoofed or forged 
			              IP addresses, mainly by blocking packets appearing on interfaces 
			              and in directions which are logically not possible. </P>
			              <DT>DMZ Host 
			              <DD>
			              <P>DMZ means "Demilitarized Zone." If an application has trouble 
			              working from behind the router, you can expose one computer to the 
			              Internet and run the application on that computer. </P>
			              <P>When a LAN host is configured as a DMZ host, it becomes the 
			              destination for all incoming packets that do not match some other 
			              incoming session or rule. If any other ingress rule is in place, 
			              that will be used instead of sending packets to the DMZ host; so, 
			              an active session, virtual server, active port trigger, or port 
			              forwarding rule will take priority over sending a packet to the 
			              DMZ host. (The DMZ policy resembles a default port forwarding rule 
			              that forwards every port that is not specifically sent anywhere 
			              else.) </P>
			              <P>The router provides only limited firewall protection for the 
			              DMZ host. The router does not forward a TCP packet that does not 
			              match an active DMZ session, unless it is a connection 
			              establishment packet (SYN). Except for this limited protection, 
			              the DMZ host is effectively "outside the firewall". Anyone 
			              considering using a DMZ host should also consider running a 
			              firewall on that DMZ host system to provide additional protection. 
			              </P>
			              <P>Packets received by the DMZ host have their IP addresses 
			              translated from the WAN-side IP address of the router to the 
			              LAN-side IP address of the DMZ host. However, port numbers are not 
			              translated; so applications on the DMZ host can depend on specific 
			              port numbers. </P>
			              <P>The DMZ capability is just one of several means for allowing 
			              incoming requests that might appear unsolicited to the NAT. In 
			              general, the DMZ host should be used only if there are no other 
			              alternatives, because it is much more exposed to cyberattacks than 
			              any other system on the LAN. Thought should be given to using 
			              other configurations instead: a virtual server, a port forwarding 
			              rule, or a port trigger. Virtual servers open one port for 
			              incoming sessions bound for a specific application (and also allow 
			              port redirection and the use of ALGs). Port forwarding is rather 
			              like a selective DMZ, where incoming traffic targeted at one or 
			              more ports is forwarded to a specific LAN host (thereby not 
			              exposing as many ports as a DMZ host). Port triggering is a 
			              special form of port forwarding, which is activated by outgoing 
			              traffic, and for which ports are only forwarded while the trigger 
			              is active. </P>
			              <P>Few applications truly require the use of the DMZ host. 
			              Following are examples of when a DMZ host might be required: </P>
			              <UL>
			                <LI>A host needs to support several applications that might use 
			                overlapping ingress ports such that two port forwarding rules 
			                cannot be used because they would potentially be in conflict. 
			                <LI>To handle incoming connections that use a protocol other 
			                than ICMP, TCP, UDP, and IGMP (also GRE and ESP, when these 
			                protocols are enabled by the PPTP and IPSec ALGs ). </LI></UL>
			              <DL>
			                <DT>Enable DMZ 
			                <DD>
			                <P><B>Note:</B> Putting a computer in the DMZ may expose that 
			                computer to a variety of security risks. Use of this option is 
			                only recommended as a last resort. </P>
			                <DT>DMZ IP Address 
			                <DD>Specify the LAN IP address of the LAN computer that you want 
			                to have unrestricted Internet communication. If this computer 
			                obtains its address Automatically using DHCP, then you may want 
			                to make a static reservation on the 
                              <a href="adv_network.asp">Setup&rarr;Network&nbsp;Settings </a>  page so that the IP address of the DMZ 
			                computer does not change. </DD>
			              </DL>
			              <!--DT>Non-UDP/TCP/ICMP LAN Sessions 
			              <DD>
			              <P>When a LAN application that uses a protocol other than UDP, 
			              TCP, or ICMP initiates a session to the Internet, the router's NAT 
			              can track such a session, even though it does not recognize the 
			              protocol. This feature is useful because it enables certain 
			              applications (most importantly a single VPN connection to a remote 
			              host) without the need for an ALG. </P>
			              <P>Note that this feature does not apply to the DMZ host (if one 
			              is enabled). The DMZ host always handles these kinds of sessions. 
			              </P>
			              <DL>
			                <DT>Enable 
			                <DD>Enabling this option (the default setting) enables single 
			                VPN connections to a remote host. (But, for multiple VPN 
			                connections, the appropriate VPN ALG must be used.) Disabling 
			                this option, however, only disables VPN if the appropriate VPN 
			                ALG is also disabled. </DD></DL>
			              <DT>Application Level Gateway (ALG) Configuration 
			              <DD>Here you can enable or disable ALGs. Some protocols and 
			              applications require special handling of the IP payload to make 
			              them work with network address translation (NAT). Each ALG 
			              provides special handling for a specific protocol or application. 
			              A number of ALGs for common applications are enabled by default. 
			              <DL>
			                <DT>PPTP 
			                <DD>Allows multiple machines on the LAN to connect to their 
			                corporate networks using PPTP protocol. When the PPTP ALG is 
			                enabled, LAN computers can establish PPTP VPN connections either 
			                with the same or with different VPN servers. When the PPTP ALG 
			                is disabled, the router allows VPN operation in a restricted way 
			                -- LAN computers are typically able to establish VPN tunnels to 
			                different VPN Internet servers but not to the same server. The 
			                advantage of disabling the PPTP ALG is to increase VPN 
			                performance. Enabling the PPTP ALG also allows incoming VPN 
			                connections to a LAN side VPN server (refer to 
                              <a href="adv_virtual.asp">Advanced&rarr;Virtual&nbsp;Server </a>).
<DT>IPSec (VPN) 
			                <DD>Allows multiple VPN clients to connect to their corporate 
			                networks using IPSec. Some VPN clients support traversal of 
			                IPSec through NAT. This option may interfere with the operation 
			                of such VPN clients. If you are having trouble connecting with 
			                your corporate network, try disabling this option. 
			                <P>Check with the system administrator of your corporate network 
			                whether your VPN client supports NAT traversal. </P>
			                <P>Note that L2TP VPN connections typically use IPSec to secure 
			                the connection. To achieve multiple VPN pass-through in this 
			                case, the IPSec ALG must be enabled. </P>
			                <DT>RTSP 
			                <DD>Allows applications that use Real Time Streaming Protocol to 
			                receive streaming media from the internet. QuickTime and Real 
			                Player are some of the common applications using this protocol. 
			                <DT>Windows/MSN Messenger 
			                <DD>Supports use on LAN computers of Microsoft Windows Messenger 
			                (the Internet messaging client that ships with Microsoft 
			                Windows) and MSN Messenger. The SIP ALG must also be enabled 
			                when the Windows Messenger ALG is enabled. 
			                <DT>FTP 
			                <DD>Allows FTP clients and servers to transfer data across NAT. 
			                Refer to the 
                              <a href="adv_virtual.asp">Advanced&rarr;Virtual&nbsp;Server</a>
			                page if you want to host an FTP server. 
			                <DT>H.323 (Netmeeting) 
			                <DD>Allows H.323 (specifically Microsoft Netmeeting) clients to 
			                communicate across NAT. Note that if you want your buddies to 
			                call you, you should also set up a virtual server for 
			                NetMeeting. Refer to the <A 
			                href="adv_virtual.asp">Advanced&rarr;Virtual Server</A> page for information on how to set up a 
			                virtual server. 
			                <DT>SIP 
			                <DD>Allows devices and applications using VoIP (Voice over IP) 
			                to communicate across NAT. Some VoIP applications and devices 
			                have the ability to discover NAT devices and work around them. 
			                This ALG may interfere with the operation of such devices. If 
			                you are having trouble making VoIP calls, try turning this ALG 
			                off. 
			                <DT>Wake-On-LAN 
			                <DD>This feature enables forwarding of "magic packets" (that is, 
			                specially formatted wake-up packets) from the WAN to a LAN 
			                computer or other device that is "Wake on LAN" (WOL) capable. 
			                The WOL device must be defined as such on the <A 
			                href="adv_virtual.asp">Advanced&rarr;Virtual Server</A> page. The LAN IP address for the virtual 
			                server is typically set to the broadcast address 192.168.0.255. 
			                The computer on the LAN whose MAC address is contained in the 
			                magic packet will be awakened. 
			                <DT>MMS 
			                <DD>Allows Windows Media Player, using MMS protocol, to receive 
	                  streaming media from the internet. </DD></DL></DD></DL-->
	            </td>
                    </tr>
                  </table>
				  </div>
				  <div class="box">
				  <h2><A name=Advanced_Wireless>Advanced Wireless</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>
				  	<td>
				  		<DL>
			              <DT>Transmit Power 
			              <DD>Normally the wireless transmitter operates at 100% power. In 
			              some circumstances, however, there might be a need to isolate 
			              specific frequencies to a smaller area. By reducing the power of 
			              the radio, you can prevent transmissions from reaching beyond your 
			              corporate/home office or designated wireless area. 
			              <DT>Beacon Period 
			              <DD>Beacons are packets sent by a wireless router to synchronize 
			              wireless devices. Specify a Beacon Period value between 20 and 
			              1000. The default value is set to 100 milliseconds. 
			              <DT>RTS Threshold 
			              <DD>When an excessive number of wireless packet collisions are 
			              occurring, wireless performance can be improved by using the 
			              RTS/CTS (Request to Send/Clear to Send) handshake protocol. The 
			              wireless transmitter will begin to send RTS frames (and wait for 
			              CTS) when data frame size in bytes is greater than the RTS 
			              Threshold. This setting should remain at its default value of 2346 
			              bytes. 
			              <DT>Fragmentation Threshold 
			              <DD>Wireless frames can be divided into smaller units (fragments) 
			              to improve performance in the presence of RF interference and at 
			              the limits of RF coverage. Fragmentation will occur when frame 
			              size in bytes is greater than the Fragmentation Threshold. This 
			              setting should remain at its default value of 2346 bytes. Setting 
			              the Fragmentation value too low may result in poor performance. 
			              <DT>DTIM Interval 
			              <DD>A DTIM is a countdown informing clients of the next window for 
			              listening to broadcast and multicast messages. When the wireless 
			              router has buffered broadcast or multicast messages for associated 
			              clients, it sends the next DTIM with a DTIM Interval value. 
			              Wireless clients detect the beacons and awaken to receive the 
			              broadcast and multicast messages. The default value is 1. Valid 
			              settings are between 1 and 255. 
			             <!-- <DT>802.11d Enable 
			              <DD>Enables 802.11d operation. 802.11d is a wireless specification 
			              for operation in additional regulatory domains. This supplement to 
			              the 802.11 specifications defines the physical layer requirements 
			              (channelization, hopping patterns, new values for current MIB 
			              attributes, and other requirements to extend the operation of 
			              802.11 WLANs to new regulatory domains (countries). The current 
			              802.11 standard defines operation in only a few regulatory domains 
			              (countries). This supplement adds the requirements and definitions 
			              necessary to allow 802.11 WLAN equipment to operate in markets not 
			              served by the current standard. Enable this option if you are 
			              operating in one of these "additional regulatory domains". -->
			              <DT>WLAN Partition 
			              <DD>Enabling WLAN Partition prevents associated wireless clients 
			              from communicating with each other. 
			              <DT>WMM Enable 
			              <DD>Enabling WMM can help control latency and jitter when 
			              transmitting multimedia content over a wireless connection. 
			              <DT>Short GI 
			              <DD>Using a short (400ns) guard interval can increase throughput. 
			              However, it can also increase error rate in some installations, 
			              due to increased sensitivity to radio-frequency reflections. 
			              Select the option that works best for your installation. 
			              <DT>Extra Wireless Protection 
			              <DD>Extra protection for neighboring 11b wireless networks. Turn 
			              this option off to reduce the adverse effect of legacy wireless 
			              networks on 802.11ng performance. This option is available only 
			              when <SPAN class=option>802.11 Mode</SPAN> is set to <SPAN 
			              class=option>802.11ng only</SPAN>. (Refer to the <A 
			              href="wireless.asp">Setup&rarr;Wireless 
			              Settings&rarr;Manual Wireless Network Setup</A> page.) </DD></DL>
				  	</td>
                    </tr>
				  </table>
				  </div>
				  <!--div class="box">
                    <h2><A name=WISH>WISH</A></h2>
                    <table border=0 cellspacing=0 cellpadding=0>
                      <tr>
                        <td>
                          <P>WISH is short for Wireless Intelligent Stream Handling, a technology developed to enhance your experience of using a wireless network by prioritizing the traffic of different applications. </P>
                          <DL>
                            <DT>WISH 
                            <DD>
                              <DL>
                                <DT>Enable WISH 
                                <DD>Enable this option if you want to allow WISH to prioritize your traffic. </DD>
                              </DL>
                            <DT>Priority Classifiers 
                            <DD>
                              <DL>
                                <DT>HTTP 
                                <DD>Allows the router to recognize HTTP transfers for many common audio and video streams and prioritize them above other traffic. Such streams are frequently used by digital media players. 
                                <DT>Windows Media Center 
                                <DD>Enables the router to recognize certain audio and video streams generated by a Windows Media Center PC and to prioritize these above other traffic. Such streams are used by systems known as Windows Media Extenders, such as the Xbox 360. 
                                <DT>Automatic 
                                <DD>When enabled, this option causes the router to automatically attempt to prioritize traffic streams that it doesn't otherwise recognize, based on the behavior that the streams exhibit. This acts to deprioritize streams that exhibit bulk transfer characteristics, such as file transfers, while leaving interactive traffic, such as gaming or VoIP, running at a normal priority. </DD>
                              </DL>
                            <DT>WISH Rules 
                            <DD>A WISH Rule identifies a specific message flow and assigns a priority to that flow. For most applications, the priority classifiers ensure the right priorities and specific WISH Rules are not required.
                                <P>WISH supports overlaps between rules. If more than one rule matches for a specific message flow, the rule with the highest priority will be used. </P>
                                <DL>
                                  <DT>Name 
                                  <DD>Create a name for the rule that is meaningful to you. 
                                  <DT>Priority 
                                  <DD>The priority of the message flow is entered here. Four priorities are defined:
                                      <UL>
                                        <LI>BK: Background (least urgent). 
                                        <LI>BE: Best Effort. 
                                        <LI>VI: Video. 
                                        <LI>VO: Voice (most urgent). </LI>
                                      </UL>
                                  <DT>Protocol 
                                  <DD>The protocol used by the messages. 
                                  <DT>Host 1 IP Range 
                                  <DD>The rule applies to a flow of messages for which one computer's IP address falls within the range set here. 
                                  <DT>Host 1 Port Range 
                                  <DD>The rule applies to a flow of messages for which host 1's port number is within the range set here. 
                                  <DT>Host 2 IP Range 
                                  <DD>The rule applies to a flow of messages for which the other computer's IP address falls within the range set here. 
                                  <DT>Host 2 Port Range 
                                  <DD>The rule applies to a flow of messages for which host 2's port number is within the range set here. </DD>
                                </DL>
                            <DT>24 -- WISH Rules 
                            <DD>This section is where you define WISH Rules. Enable or disable defined rules with the checkboxes at the left. </DD>
                        </DL></td>
                      </tr>
                    </table>
			      </div-->
				  <!--div class="box">
				  <h2><A name=Protected_Setup>Wi-Fi Protected Setup</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>
				  	<td>
				  		<DL>
			              <DT>Wi-Fi Protected Setup 
			              <DD>
			              <DL>
			                <DT>Enable 
			                <DD>Enable the Wi-Fi Protected Setup feature. 
			                <DT>Lock Wireless Security Settings 
			                <DD>Locking the wireless security settings prevents the settings 
			                from being changed by any new external registrar using its PIN. 
			                Devices can still be added to the wireless network using Wi-Fi 
			                Protected Setup. It is still possible to change wireless network 
			                settings with <A href="wireless.asp" 
			                shape=rect>Manual Wireless Network Setup</A>, <A 
			                href="wizard_wlan.asp" 
			                shape=rect>Wireless Network Setup Wizard</A>, or an existing 
			                external WLAN Manager Registrar. </DD></DL>
			              <DT>PIN Settings 
			              <DD>
			              <P>A PIN is a unique number that can be used to add the router to 
			              an existing network or to create a new network. The default PIN 
			              may be printed on the bottom of the router. For extra security, a 
			              new PIN can be generated. You can restore the default PIN at any 
			              time. Only the Administrator ("admin" account) can change or reset 
			              the PIN. </P>
			              <DL>
			                <DT>Current PIN 
			                <DD>Shows the current value of the router's PIN. 
			                <DT>Reset PIN to Default 
			                <DD>Restore the default PIN of the router. 
			                <DT>Generate New PIN 
			                <DD>Create a random number that is a valid PIN. This becomes the 
			                router's PIN. You can then copy this PIN to the user interface 
			                of the registrar. </DD></DL>
			              <DT>Add Wireless Station 
			              <DD>
			              <P>This Wizard helps you add wireless devices to the wireless 
			              network.</P>
			              <P>The wizard will either display the wireless network settings to 
			              guide you through manual configuration, prompt you to enter the 
			              PIN for the device, or ask you to press the configuration button 
			              on the device. If the device supports Wi-Fi Protected Setup and 
			              has a configuration button, you can add it to the network by 
			              pressing the configuration button on the device and then the on 
			              the router within 60 seconds. The status LED on the router will 
			              flash three times if the device has been successfully added to the 
			              network.</P>
			              <P>There are several ways to add a wireless device to your 
			              network. Access to the wireless network is controlled by a 
			              Registrar A registrar only allows devices onto the wireless 
			              network if you have entered the PIN, or pressed a special Wi-Fi 
			              Protected Setup button on the device. The router acts as a 
			              registrar for the network, although other devices may act as a 
			              registrar as well.</P>
			              <DL>
			                <DT>Add Wireless Device with WPS 
			                <DD>Start the wizard. </DD></DL></DD></DL>
				  	</td>
                    </tr>
				  </table>
				  </div-->

				  <div class="box">
				  <h2><A name=Network>Advanced Network</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>
				  	<td>
				  		<DL>
			              <DT>UPnP 
			              <DD>UPnP is short for Universal Plug and Play, which is a 
			              networking architecture that provides compatibility among 
			              networking equipment, software, and peripherals. This router has 
			              optional UPnP capability, and can work with other UPnP devices and 
			              software. 
			              <DL>
			                <DT>Enable UPnP 
			                <DD>If you need to use the UPnP functionality, you can enable it 
			                here. </DD></DL>
			              <DT>WAN Ping 
			              <DD>Pinging public WAN IP addresses is a common method used by 
			              hackers to test whether your WAN IP address is valid. 
			              <DL>
			                <DT>Enable WAN Ping Respond 
			                <DD>If you leave this option unchecked, you are causing the 
			                router to ignore <CODE>ping</CODE> commands for the public WAN 
			                IP address of the router. </DD></DL>
			              <DT>WAN Port Speed 
			              <DD>Normally, this is set to "auto". If you have trouble 
			              connecting to the WAN, try the other settings. 
			              <DT>Multicast Streams 
			              <DD>The router uses the IGMP protocol to support efficient 
			              multicasting -- transmission of identical content, such as 
			              multimedia, from a source to a number of recipients. 
			              <DL>
			                <DT>Enable Multicast Streams 
			                <DD>This option must be enabled if any applications on the LAN 
			                participate in a multicast group. If you have a multimedia LAN 
			                application that is not receiving content as expected, try 
			                enabling this option. </DD></DL></DD></DL>
				  	</td>
                    </tr>
				  </table>
				  </div>
				  <div class="box">
				  
          <h2><A name=ipv6>Ipv6</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  <tr>
				  	
              <td> <DL>
                  <DT>IPv6 
                  <DD>The IPv6 (Internet Protocol version 6) section is where 
                    you configure your IPv6 Connection type. 
                    
                  <DT>IPv6 Connection Type 
                  <DD>There are several connection types to choose from: Link-local, 
                    Static IPv6, DHCPv6, Stateless Autoconfiguration, PPPoE, IPv6 
                    in IPv4 Tunnel and 6to4. If you are unsure of your connection 
                    method, please contact your IPv6 Internet Service Provider. 
                    Note: If using the PPPoE option, you will need to ensure that 
                    any PPPoE client software on your computers is removed or 
                    disabled. 
                    <DL>
                      <DT>Link-local Mode 
                      <DD>Link-local address is used by nodes and routers when 
                        communicating with neighboring nodes on the same link. 
                        This mode enables IPv6-capable devices to communicate 
                        with each other in the LAN side. </DD>
                    </DL>
                    <DL>
                      <DT>Static IPv6 Mode 
                      <DD>Used when your ISP provides you a set IPv6 address that 
                        does not change. The IPv6 information is manually entered 
                        in your IPv6 configuration settings. You must enter the 
                        IPv6 address, Subnet Prefix Length, Default Gateway, Primary 
                        DNS Server, and Secondary DNS Server. Your ISP provides 
                        you with all of this information. </DD>
                    </DL>
                    <DL>
                      <DT>DHCPv6 Mode 
                      <DD>A method of connection where the ISP assigns your IPv6 
                        address when your router requests one from the ISP's server. 
                        Some ISP's require you to make some settings on your side 
                        before your router can connect to the IPv6 Internet. </DD>
                    </DL>
                    <!--DL>
                      <DT>Stateless Autoconfiguration Mode 
                      <DD>A method of connection where the ISP assigns your IPv6 
                        address when your router requests one from the Default 
                        Gateway. Configuration of IPv6 address is based on the 
                        receipt of Router Advertisement message. </DD>
                    </DL-->
                    <DL>
                      <DT>PPPoE 
                      <DD>Select this option if your ISP requires you to use a 
                        PPPoE (Point to Point Protocol over Ethernet) connection 
                        to IPv6 Internet. DSL providers typically use this option. 
                        This method of connection requires you to enter a <strong>Username</strong> 
                        and <strong>Password</strong> (provided by your Internet 
                        Service Provider) to gain access to the IPv6 Internet. 
                        The supported authentication protocols are PAP and CHAP. 
                      </DD>
                      <DD> 
                        <P><SPAN class=option>Dynamic IP: </SPAN>If the ISP's 
                          servers assign the router's WAN IPv6 addressing upon 
                          establishing a connection, select this option. </P>
                      <DD> 
                        <P><SPAN class=option>Static IP: </SPAN>If your ISP has 
                          assigned a fixed IPv6 address, select this option. The 
                          ISP provides the value for the <SPAN class=option>IPv6 
                          Address.</SPAN> </P>
                      <DD> 
                        <P><SPAN class=option>Service Name: </SPAN>Some ISP's 
                          may require that you enter a Service Name. Only enter 
                          a Service Name if your ISP requires one. </P>
                      <DD> 
                        <P><SPAN class=option>Reconnect Mode: </SPAN>Typically 
                          PPPoE connections are not always on. The D-Link router 
                          allows you to set the reconnection mode. The settings 
                          are: </P>
                        <UL>
                          <LI><SPAN class=option>Always on: </SPAN>A connection 
                            to the Internet is always maintained. 
                          <LI><SPAN class=option>On demand: </SPAN>A connection 
                            to the Internet is made as needed. 
                          <LI><SPAN class=option>Manual: </SPAN>You have to open 
                            up the Web-based management interface and click the 
                            Connect button manually any time that you wish to 
                            connect to the Internet. </LI>
                        </UL>
                        <P><SPAN class=option>Maximum Idle Time: </SPAN>Time interval 
                          the machine can be idle before the WAN link is disconnected. 
                          The Maximum Idle Time value is only used for the "On 
                          demand" and "Manual" reconnect modes. </P>
                      <dt>&nbsp; </dt>
                    </DL>
					<DL>
                  <DT>IPv6 in IPv4 Tunnel Mode 
                  <DD>IPv6 in IPv4 tunneling is the encapsulation of IPv6 packets 
                    in IPv4 packets so that IPv6 packets can be sent over an IPv4 
                    infrastructure. 
				</DL>	
                 <DL> <DT>6to4 Mode 
                  <DD>6to4 is an IPv6 address assignment and automatic tunneling 
                    technology that used to provide unicast IPv6 connectivity 
                    between IPv6 sites and hosts across the IPv4 Internet. </DD><br>
                   <DD>The following options apply to all WAN modes.</DD><br>
				   <DD>Primary DNS Server, Secondary DNS Server: Enter the IPv6 addresses of the DNS Servers. Leave the field for the secondary server empty if not used.</DD>
                  </DL>
				   
				 
				  <DT>LAN IPv6 Address Setting 
                  
                <DD>These are the settings of the LAN (Local Area Network) IPv6 
                  interface for the router. The router's LAN IPv6 Address is configured 
                  based on the IPv6 Address and Subnet assigned by your ISP. (A 
                  subnet with prefix /64 is supported in LAN.)</DD>
                <DT>LAN Address Autoconfiguration Settings 
                  
                <DD>Use this section to setup IPv6 Autoconfiguration to assign 
                  IPv6 address to the computers on your local network. A Stateless 
                  and a Stateful Autoconfiguration method are provided.</DD>
                <DD> 
                  <dl>
                    <DT>Enable Autoconfiguration 
                    <DD>These two values (from and to) define a range of IPv6 
                      addresses that the DHCPv6 Server uses when assigning addresses 
                      to computers and devices on your Local Area Network. Any 
                      addresses that are outside of this range are not managed 
                      by the DHCPv6 Server; these could, therefore, be used for 
                      manually configured devices or devices that cannot use DHCPv6 
                      to obtain network address details automatically. </DD>
                    <DD>When you selected Stateful (DHCPv6), the following options 
                      are displayed.</DD>
                    <DD>The computers (and other devices) connected to your LAN 
                      also need to have their TCP/IP configuration set to "DHCPv6" 
                      or "Obtain an IPv6 address automatically".</DD>
                    <DT>IPv6 Address Range (DHCPv6) 
                    <DD>Once your D-Link router is properly configured and this 
                      option is enabled, the router will manage the IPv6 addresses 
                      and other network configuration information for computers 
                      and other devices connected to your Local Area Network. 
                      There is no need for you to do this yourself. </DD>
                    <DD>It is possible for a computer or device that is manually 
                      configured to have an IPv6 address that does reside within 
                      this range. </DD>
                    <DT>IPv6 Address Lifetime 
                    <DD>The amount of time that a computer may have an IPv6 address before it is required to renew the lease. </DD>
                   
                  </dl>
                </DD>
               
				  
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
<div id="copyright">Copyright &copy; 2004-2008 D-Link Systems, Inc.</div>
<br>
</body>
</html>