
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
									<li><div><a href="support_adv.asp">ADVANCED</a></div></li>
									<li><div id="sidenavoff">TOOLS</div></li>
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
						<h1> tools Help </h1>
						<table border=0 cellspacing=0 cellpadding=0>
                          <tr>
                            <td>
                              <ul>
                                <li><a href=support_tools.asp#Admin>Admin</a></li>
                                <li><a href=support_tools.asp#Time>Time</a></li>
                                <li><a href=support_tools.asp#SysLog>Syslog</a></li>
                                <li><a href=support_tools.asp#EMail>Email Settings </a></li>
                                <li><a href=support_tools.asp#System>System</a></li>
                                <li><a href=support_tools.asp#Firmware>Firmware</a></li>
                                <li><a href=support_tools.asp#Dynamic_DNS>Dynamic DNS</a></li>
                                <li><a href=support_tools.asp#System_Check>System Check</a></li>
                                <li><a href=support_tools.asp#Schedules>Schedules </a></li>
                              </ul></td>
                          </tr>
                        </table>
				  </div>
				  <div class="box"> 
				  <h2><A name=Admin>Admin</A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>
				  			<td>
				  				<P>The Admin option is used to set a password for access to the 
					            Web-based management. By default there is no password configured. It 
					            is highly recommended that you create a password to keep your new 
					            router secure.</P>
					            <DL>
					              <DT>Admin Password 
					              <DD>Enter a password for the user "admin", who will have full 
					              access to the Web-based management interface. 
					              <DT>User Password 
					              <DD>Enter a password for the user "user", who will have read-only 
					              access to the Web-based management interface. 
					              <DT>Gateway Name 
					              <DD>The name of the router can be changed here. 
					              <DT>Enable Remote Management 
					              <DD>Enabling Remote Management allows you to manage the router 
					              from anywhere on the Internet. Disabling Remote Management allows 
					              you to manage the router only from computers on your LAN. 
					              <DT>Remote Admin Port 
					              <DD>The port that you will use to address the management interface 
					              from the Internet. For example, if you specify port 1080 here, 
					              then, to access the router from the Internet, you would use a URL 
					              of the form: <CODE>http://my.domain.com:1080/</CODE>. 
					              <DT>Remote Admin Inbound Filter 
					              <DD>Select a filter that controls access as needed for this admin 
					              port. If you do not see the filter you need in the list of 
					              filters, go to the <A onclick="return jump_if();" 
					              href="Inbound_Filter.asp">Advanced&rarr;Inbound&nbsp;Filter</A> screen and create a new filter. 
					            </DD></DL>
				  			</td>
                          </tr>
                    </table>
				  </div>	
				 <div class="box">
				  <h2><A name=Time>Time</A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>
				  			<td>
				  				<P>The Time Configuration option allows you to configure, update, 
					            and maintain the correct time on the router's internal system clock. 
					            From this section you can set the time zone that you are in and set 
					            the Time Server. Daylight saving can also be configured to 
					            automatically adjust the time when needed. </P>
					            <DL>
					              <DT>Time Configuration 
					              <DD>
					              <DL>
					                <DT>Current Router Time 
					                <DD>Displays the time currently maintained by the router. If 
					                this is not correct, use the following options to configure the 
					                time correctly. 
					                <DT>Time Zone 
					                <DD>Select your local time zone from pull down menu. 
					                <DT>Enable Daylight Saving 
					                <DD>Check this option if your location observes daylight saving 
					                time. 
					                <!--<DT>Daylight Saving Offset 
					                <DD>Select the time offset, if your location observes daylight 
					                saving time. -->
					                <DT>DST Start and DST End 
					                <DD>Select the starting and ending times for the change to and 
					                from daylight saving time. For example, suppose for DST Start 
					                you select Month="Oct", Week="3rd", Day="Sun" and Time="2am". 
					                This is the same as saying: "Daylight saving starts on the third 
					                Sunday of October at 2:00 AM." </DD></DL>
					              <DT>Automatic Time Configuration 
					              <DD>
					              <DL>
					                <DT>Enable NTP Server 
					                <DD>Select this option if you want to synchronize the router's 
					                clock to a Network Time Server over the Internet. If you are 
					                using schedules or logs, this is the best way to ensure that the 
					                schedules and logs are kept accurate. 
					                <P>Note that, even when NTP Server is enabled, you must still 
					                choose a time zone and set the daylight saving parameters. </P>
					                <DT>NTP Server Used 
					                <DD>Select a Network Time Server for synchronization. You can 
					                type in the address of a time server or select one from the 
					                list. If you have trouble using one server, select another. 
					              </DD></DL>
					              <DT>Set the Date and Time Manually 
					              <DD>If you do not have the NTP Server option in effect, you can 
					              either manually set the time for your router here, or you can 
					              click the <SPAN class=button_ref>Copy Your Computer's Time 
					              Settings</SPAN> button to copy the time from the computer you are 
					              using. (Make sure that computer's time is set correctly.) </DD></DL>
					            <P><B>Note: </B>If the router loses power for any reason, it cannot 
					            keep its clock running, and will not have the correct time when it 
					            is started again. To maintain correct time for schedules and logs, 
					            either you must enter the correct time after you restart the router, 
					            or you must enable the NTP Server option. </P>
				  			</td>
				  		</tr>
					</table>
				  </div>
				  
				 <div class="box">
				  <h2><A name=SysLog>Syslog</A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
					     <tr>
                            <td>
                            	<P>This section allows you to archive your log files to a Syslog 
					            Server.</P>
					            <DL>
					              <DT>Enable Logging to Syslog Server 
					              <DD>Enable this option if you have a syslog server currently 
					              running on the LAN and wish to send log messages to it. 
					              <DT>Syslog Server IP Address 
					              <DD>Enter the LAN IP address of the Syslog Server. </DD></DL>
                            </td>
                      </tr>
					</table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=EMail>Email Settings</A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
					  <tr>
						 <td>
						 	<P>The Email feature can be used to send the system log files, 
				            router alert messages, and firmware update notification to your 
				            email address.</P>
				            <DL>
				              <DT>Enable 
				              <DD>
				              <DL>
				                <DT>Enable Email Notification 
				                <DD>When this option is enabled, router activity logs or 
				                firmware upgrade notifications can be emailed to a designated 
				                email address, and the following parameters are displayed. 
				              </DD></DL>
				              <DT>Email Settings 
				              <DD>
				              <DL>
				                <DT>From Email Address 
				                <DD>This email address will appear as the sender when you 
				                receive a log file or firmware upgrade notification via email. 
				                <DT>To Email Address 
				                <DD>Enter the email address where you want the email sent. 
				                <DT>SMTP Server Address 
				                <DD>Enter the SMTP server address for sending email. 
				                <DT>Enable Authentication 
				                <DD>If your SMTP server requires authentication, select this 
				                option. 
				                <DT>Account Name 
				                <DD>Enter your account for sending email. 
				                <DT>Password 
				                <DD>Enter the password associated with the account. 
				                <DT>Verify Password 
				                <DD>Re-type the password associated with the account. </DD></DL>
				              <DT>Email Log When Full or on Schedule 
				              <DD>
				              <DL>
				                <DT>On Log Full 
				                <DD>Select this option if you want logs to be sent by email when 
				                the log is full. 
				                <DT>On Schedule 
				                <DD>Select this option if you want logs to be sent by email 
				                according to a schedule. 
				                <DT>Schedule 
				                <DD>If you selected the On Schedule option, select one of the 
				                defined schedule rules. If you do not see the schedule you need 
				                in the list of schedules, go to the <A 
				                href="tools_schedules.asp">Tools&rarr;Schedules</A> screen and create a new schedule. 
				                <P><B>Note: </B>Normally email is sent at the start time defined 
				                for a schedule, and the schedule end time is not used. However, 
				                rebooting the router during the schedule period will cause 
				                additional emails to be sent. </P></DD></DL></DD></DL>
						 </td>
                      </tr>
					</table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=System>System</A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>
                            <td>
                            	<P>This section allows you to manage the router's configuration 
						            settings, reboot the router, and restore the router to the factory 
						            default settings. Restoring the unit to the factory default settings 
						            will erase all settings, including any rules that you've 
									created.</P>
						            <DL>
						              <DT>Save Settings To Local Hard Drive 
						              <DD>This option allows you to save the router's configuration to a 
						              file on your computer. Be sure to save the configuration before 
						              performing a firmware upgrade. 
						              <DT>Load Settings From Local Hard Drive 
						              <DD>Use this option to restore previously saved router 
						              configuration settings. 
						              <DT>Restore To Factory Default Settings 
						              <DD>This option restores all configuration settings back to the 
						              settings that were in effect at the time the router was shipped 
						              from the factory. Any settings that have not been saved will be 
						              lost. If you want to save your router configuration settings, use 
						              the Save Settings option above. 
						              <DT>Reboot The Device 
						              <DD>This restarts the router. Useful for restarting when you are 
						              not near the device. </DD></DL>
                            </td>
                          </tr>
					</table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=Firmware>Firmware</A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>
				  			<td>
				  				<P>The Firmware Upgrade section can be used to update to the latest 
					            firmware code to improve functionality and performance. If you would 
					            like to be notified when new firmware is released, place a checkmark 
					            in the box next to <SPAN class=option>Email Notification of Newer 
					            Firmware Version</SPAN>. </P>
					            <P>To upgrade the firmware, follow these steps: </P>
					            <OL>
					              <LI>Click the <SPAN class=button_ref>Browse</SPAN> button to 
					              locate the D-Link upgrade file on your computer. 
					              <LI>Once you have found the file to be used, click the <SPAN 
					              class=button_ref>Upload</SPAN> button below to start the firmware 
					              upgrade process. This can take a minute or more. 
					              <LI>Wait for the router to reboot. This can take another minute or 
					              more. 
					              <LI>Confirm updated firmware revision on status page. </LI></OL>
					            <DL>
					              <DT>Firmware Information 
					              <DD>
					              <P>Here are displayed the version numbers of the firmware 
					              currently installed in your router and the most recent upgrade 
					              that is available. </P>
					              <DT>Firmware Upgrade 
					              <DD>
					              <P><B>Note: </B>Firmware upgrade cannot be performed from a 
					              wireless device. To perform an upgrade, ensure that you are using 
					              a PC that is connected to the router by wire. </P>
					              <P><B>Note: </B>Some firmware upgrades reset the configuration 
					              options to the factory defaults. Before performing an upgrade, be 
					              sure to save the current configuration from the <A 
					              href="tools_system.asp">Tools&rarr;System</A> 
					              screen. </P>
					              <DL>
					                <DT>Upload 
					                <DD>Once you have a firmware update on your computer, use this 
					                option to browse for the file and then upload the information 
					                into the router. </DD></DL>
					              <DT>Firmware Upgrade Notification Options 
					              <DD>
					              <DL>
					                <DT>Automatically Check Online for Latest Firmware Version 
					                <DD>When this option is enabled, your router will check online 
					                periodically to see if a newer version of the firmware is 
					                available. 
					                <DT>Email Notification of Newer Firmware Version 
					                <DD>When this option is enabled, an email will be sent to the 
					                email address configured in the email section whenever new 
					                firmware is available. You must have Email Notification enabled 
					                from the <A href="tools_email.asp">Tools&rarr;Email&nbsp;Settings</A> page. </DD></DL></DD></DL>
				  			</td>
                          </tr>
					</table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=Dynamic_DNS>Dynamic DNS</A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
				  		<tr>
				  			<td>
				  				<P>The Dynamic DNS feature allows you to host a server (Web, FTP, 
					            Game Server, etc.) using a domain name that you have purchased 
					            (www.whateveryournameis.com) with your dynamically assigned IP 
					            address. Most broadband Internet Service Providers assign dynamic 
					            (changing) IP addresses. When you use a Dynamic DNS service 
					            provider, your friends can enter your host name to connect to your 
					            server, no matter what your IP address is.</P>
					            <DL>
					              <DT>Enable Dynamic DNS 
					              <DD>Enable this option only if you have purchased your own domain 
					              name and registered with a dynamic DNS service provider. The 
					              following parameters are displayed when the option is enabled. 
					              <DT>Server Address 
					              <DD>Select a dynamic DNS service provider from the pull-down list, 
					              or you may enter a dynamic DNS service provider manually. 
					              <DT>Host Name 
					              <DD>Enter your host name, fully qualified; for example: 
					              <CODE>myhost.mydomain.net</CODE>. 
					              <DT>Username or Key 
					              <DD>Enter the username or key provided by your service provider. 
					              If the Dynamic DNS provider supplies only a key, enter that key in 
					              all three fields. 
					              <DT>Password or Key 
					              <DD>Enter the password or key provided by your service provider. 
					              If the Dynamic DNS provider supplies only a key, enter that key in 
					              all three fields. 
					              <DT>Verify Password or Key 
					              <DD>Re-type the password or key provided by your service provider. 
					              If the Dynamic DNS provider supplies only a key, enter that key in 
					              all three fields. 
					              <DT>Timeout 
					              <DD>The time between periodic updates to the Dynamic DNS, if your 
					              dynamic IP address has not changed. The timeout period is entered 
					              in hours. </DD></DL>
					            <P><B>Note: </B>If a dynamic DNS update fails for any reason (for 
					            example, when incorrect parameters are entered), the router 
					            automatically disables the Dynamic DNS feature and records the 
					            failure in the log. </P>
					            <P><B>Note: </B>After configuring the router for dynamic DNS, you 
					            can open a browser and navigate to the URL for your domain (for 
					            example <CODE>http://www.mydomain.info</CODE>) and the router will 
					            attempt to forward the request to port 80 on your LAN. If, however, 
					            you do this from a LAN-side computer and there is no virtual server 
					            defined for port 80, the router will return the router's 
					            configuration home page. Refer to the <A 
					            href="adv_virtual.asp">Advanced&rarr; 
					            Virtual&nbsp;Server</A> configuration page to set up a virtual 
					            server. </P>
				  			</td>
                          </tr>
					</table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=System_Check>System Check</A></h2>
				  	<table border=0 cellspacing=0 cellpadding=0>
					  <tr>
                        <td>
                        	<dl>
                        		<dt>Ping Test</dt>
                        		<dd>
                        			<p>"Ping" is an Internet utility function that sends a series of short messages to a target computer and reports the results. You can use it to test whether a computer is running, and to get an idea of the quality of the connection to that computer, based on the speed of the responses.</p>
                        			
                    <dl>
                      <dt>Host Name or IP Address</dt>
                      <dd>Enter either the IP address of the target computer or 
                        enter its fully qualified domain name.</dd>
                      <dt>Ping</dt>
                      <dd>Start pinging the specified host.</dd>
                      <dt>&nbsp;</dt>
                    </dl>
                        			<div class="help_example">
                        			<dl>
                        				<dt>Example: </dt>
                        				<dd>
                        					<dl>
                        						<dt>Host Name or IP Address</dt>
                        						<dd>www.whitehouse.gov</dd>
                        						<dt>Ping Result</dt>
                        						<dd>&nbsp;</dd>
                            					<dd> <font size="2">Success</font></dd>
												<dt>&nbsp;</dt>
                        					</dl>
                        				</dd>
                        			</dl>
                        			</div>
                        		</dd>
                        	</dl>
                        </td>
                      </tr>
					</table>
				  </div>
				  
				  <div class="box">
				  <h2><A name=Schedules>Schedules</A></h2>
				  <table border=0 cellspacing=0 cellpadding=0>
				  	<tr>
				  		<td>
				  			<P>Schedules can be created for use with enforcing rules. For 
				            example, if you want to restrict web access to Mon-Fri from 3pm to 
				            8pm, you could create a schedule selecting Mon, Tue, Wed, Thu, and 
				            Fri and enter a Start Time of 3pm and End Time of 8pm. </P>
				            <DL>
				              <DT>Add/Update Schedule Rule 
				              <DD>In this section you can add entries to the Schedule Rules List 
				              below or edit existing entries. 
				              <DL>
				                <DT>Name 
				                <DD>Give the schedule a name that is meaningful to you, such as 
				                "Weekday rule". 
				                <DT>Day(s) 
				                <DD>Place a checkmark in the boxes for the desired days or 
				                select the All Week radio button to select all seven days of the 
				                week. 
				                <DT>All Day - 24 hrs 
				                <DD>Select this option if you want this schedule in effect all 
				                day for the selected day(s). 
				                <DT>Start Time 
				                <DD>If you don't use the All Day option, then you enter the time 
				                here. The start time is entered in two fields. The first box is 
				                for the hour and the second box is for the minute. Email events 
				                are normally triggered only by the start time. 
				                <DT>End Time 
				                <DD>The end time is entered in the same format as the start 
				                time. The hour in the first box and the minutes in the second 
				                box. The end time is used for most other rules, but is not 
				                normally used for email events. 
				                <DT>Save 
				                <DD>Saves the new or edited Schedule Rule. </DD></DL>
				              <DT>Schedule Rules List 
				              <DD>This section shows the currently defined Schedule Rules. A 
				              Schedule Rule can be changed by clicking the Edit icon, or deleted 
				              by clicking the Delete icon. When you click the Edit icon, the 
				              item is highlighted, and the "Edit Schedule Rule" section is 
				              activated for editing. </DD></DL>
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