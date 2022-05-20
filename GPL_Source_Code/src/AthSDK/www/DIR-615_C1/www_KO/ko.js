var which_lang = new Array(
"WAN 인터페이스 속도 측정이 완료되었습니다. ",	//GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED
"시스템 리소스가 낮아 WAN 인터페이스 속도 측정이 시작되지 못했습니다.",	//GW_WAN_RATE_ESTIMATOR_RESOURCE_ERROR
"MAC 주소가 (%m) 인 STA가 WPS 등록을 요청하였습니다.",	//WIFISC_AP_PROXY_PROCESS_START
"동일한 장비입니다. ",	//aa_alert_7_new1
"MSCHAP이 인증 응답(실패 와 응답 없음)을 전송하였습니다 ",	//IPMSCHAP_AUTH_FAIL_AND_NO_RETRY
"기다려 주십시오…",	//_please_wait
"최신 펌웨어 버전을 확인하십시오.",	//tf_FWCheckInf
"사용 가능한 최신 펌웨어가 있으면 이메일로 알려 주십시오.",	//tf_ENFA
"컨버즈(converge) 되지 않아 WAN 인터페이스 속도 측정이 중단되었습니다. ",	//GW_WAN_RATE_ESTIMATOR_CONVERGENCE_ERROR
"WAN 인터페이스 속도 측정이 완료되었습니다. 상향 속도는 %u kbps 입니다. ",	//GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED
"MSCHAP 인증자(authenticator)가 챌린저(challenge)를 전송합니다. ",	//IPMSCHAP_AUTH_SEND_CHALLENGE
"새로운 펌웨어 버전이 있을 경우 이메일 공지를 받을 수 있도록 이메일 알림 온라인 서비스에 등록하십시오.",	//help890_1
"6th",	//tt_week_6
"목적지 네트워크와 게이트웨이 주소는 같은 서브넷 %v 에 있어서는 안됩니다. ",	//GW_ROUTES_GATEWAY_SUBNET_SAME
"지금 검색",	//tf_CKN
"WPS Internal Registrar가 2 분동안 어떤 무선 장치로부터도 요청을 받지 않았기 때문에 중단되었습니다. ",	//WIFISC_IR_REGISTRATION_FAIL_3
"MSCHAP가 피어에게 인증 응답을 전송합니다.",	//IPMSCHAP_AUTH_RESULT
"MSCHAP 인증 상세 정보가 인증자(authenticator) 에게 전송되었습니다.",	//IPMSCHAP_AUTH_SENT
"피어에게 MSCHAP 인증 챌린저를 수신하였습니다.",	//IPMSCHAP_CHALLENGE_RECVD
"게이트웨이 주소 %v가 목적지 인터페이스의 주소여서는 안됩니다.",	//GW_ROUTES_GATEWAY_IP_ADDRESS_CONFLICTS
"펌웨어 업그레이드를 위해, 검색 버튼으로 로컬 하드 드라이브에서 파일 위치를 확인하십시오. 사용할 파일을 찾았으면, 업로드 버튼을 눌러 펌웨어 업데이트를 시작하십시오.",	//tf_intro_FWChB
"지금 검색을 눌러 최신 펌웨어가 있는지 확인하십시오.",	//tf_COLF
"WPS Internal Registrar가 무선 장치 추가에 실패하였습니다.%m, 원인: %s, err_code %u.",	//WIFISC_IR_REGISTRATION_FAIL_2
"인터넷 접속 제어에 의해 %v:%u 에서 %v:%u (protocol %u) 로 패킷이 차단되었습니다.",	//GW_INET_ACCESS_DROP_ACCESS_CONTROL_WITH_PORT
"MSCHAP 인증 실패 -- 상세한 로그인 정보를 확인하십시오.",	//IPMSCHAP_AUTH_FAIL
"<warn>현재 인터넷 연결 모드에서는 인터넷으로 부터 WINS/NetBIOS 설정을 확인할 수 없습니다. - WINS가 기대했던 대로 동작하지 않습니다.</warn>",	//GW_DHCP_SERVER_WINS_INCOMPATIBILITY_WARNING
"사용중이므로 삭제하거나 이름을 변경할 수 없습니다.",	//GW_SCHEDULES_IN_USE_INVALID_s2
"다운로드 사이트 사용 가능",	//tf_ADS
"MAC 주소가 (%m) 인 STA의 WPS 프로세스가 종료되었습니다.",	//WIFISC_AP_PROXY_PROCESS_CLOSE
"기능과 성능향상 목적으로",	//tf_intro_FWU2
"WPS Internal Registrar가 %s 등록을 시작하였습니다.",	//WIFISC_IR_REGISTRATION_INPROGRESS
"MSCHAP 인증 시간 만료 - 인증 실패",	//IPMSCHAP_AUTH_TIMEOUT
"최신 펌웨에 일자",	//tf_LFWD
"WPS Internal Registrar가 새로운 장치 추가에 실패하였습니다, 원인 %s",	//WIFISC_IR_REGISTRATION_FAIL_1
"인터넷 접속 포트 필터가 %v:%u 에서 %v:%u (protocol %u) 로 패킷을 차단하였습니다.",	//GW_INET_ACCESS_DROP_PORT_FILTER_WITH_PORT
"WINS/NetBIOS 가 현재 인터넷 연결 설정에서 동작하지 못할 수 있습니다. ",	//GW_DHCP_SERVER_WINS_MODE_INVALID
"MSCHAP 인증 성공",	//IPMSCHAP_AUTH_SUCCESS
"<warn>게이트웨이 IP %v 가 목적지 인터페이스 주소와 일치하여 사용할 수 없습니다.</warn>",	//GW_ROUTES_GATEWAY_IP_ADDRESS_CONFLICTS_WARNING
"스케쥴",	//GW_SCHEDULES_IN_USE_INVALID_s1
"UPnP가 엔트리 %v <-> %v:%d <-> %v%d %s '%s'(클라이언트가 갱신한 주소) 를 삭제하였습니다. ",	//GW_UPNP_IGD_PORTMAP_RELEASE
"WPS end for STA with MAC (%m) on msg: %s ",	//WIFISC_AP_PROXY_END_ON_MSG
"WPS Internal Registrar가 %m 와 %m 간에 중첩 세션을 감지하였습니다.",	//WIFISC_IR_REGISTRATION_SESSION_OVERLAP
"네트워크 컴퓨터(%s)에 IP 주소 %v가 할당 되었습니다.",	//GW_DHCPSERVER_NEW_ASSIGNMENT
"새로운 펌웨어가 있을 것입니다.",	//tf_intro_FWU1
"PPTP 전송 윈도우는 %u 입니다.",	//PPTP_EVENT_REMOTE_WINDOW_SIZE
"유동 IP",	//Dynamic_PPPoE
"고정 IP",	//static_PPPoE
"무선 장치 추가 : ",	//add_wireless_device
"gw_wireless_schedule 시작",	//GW_WLS_SCHEDULE_START
"허용(ALLOW) 사이트 리스트",	//dlink_wf_op_1
"현재 차단 또는 허용된 웹사이트를 보여줍니다.",	//dlink_help148
"무선 설정 스케쥴링 ",	//dlink_1_bwl_schld
"웹사이트 필터 옵션을 사용하여 허용 또는 차단하고 싶은 웹사이트 목록을 만들 수 있습니다. 이 기능을 사용하기 위해서는, 접속 제어에 있는 &quot;웹 필터 적용&quot; 체크박스를 먼저 선택하셔야 합니다. ",	//dlink_awf_intro_WF
"gw_wireless_schedule 중지",	//GW_WLS_SCHEDULE_STOP
"gw_wireless_schedule 초기화",	//GW_WLS_SCHEDULE_INIT
"무선이 활성화 된 경우, 스케쥴의 기본 선택사항은 &quot;항상&quot;입니다. 다른 스케쥴을 선택하시려면 &quot;스케쥴&quot; 페이지에서 스케쥴을 직접 지정하신 후, 드랍다운 메뉴에서 스케쥴을 선택할 수 있습니다. 이 기능은 무선이 비활성화 되면 함께 비활성화 됩니다. ",	//dlink_1_bw1_schld_help
"허용 또는 차단하고자 하는 웹사이트 리스트를 생성하십시오. ",	//dlink_hhwf_intro
"허용 또는 차단을 원하시는 웹사이트의 주소를 입력하십시오(예: <code>google.com</code>). 주소 앞에 <code>http://</code>  를 입력하지 마시고, 가장 포괄적인 도메인 이름을 입력하십시오. 예: 허용을 선택한 후 <code>dlink.com</code>  을 입력하시면 <code>www.dlink.com</code> 과 <code>support.dlink.com</code> 이 모두 허용됩니다. ",	//dlink_help145
"많은 웹 사이트들이 다른 웹사이트로 부터 가져온 이미지와 컨텐츠를 가지고 있으므로, <code>my.yahoo.com</code>에 접속하기 위해서 <code>yahoo.com</code>, <code>yimg.com</code>, <code>doubleclick.net</code> 등의 사이트를 허용 리스트에 입력하셔야 합니다.",	//dlink_help146
"신규 추가",	//dlink_1_add_new
"차단(DENY) 사이트 리스트",	//dlink_wf_op_0
"웹사이트 필터 설정 :",	//dlink_wf_intro
"목적지 포트와 시작 포트는 포트 필터 0 이 되어서는 안됩니다. ",	//dlink_1_YM23
"<warn>Rule %s conflicts with an existing connection (%v:%u (public %v:%u)--->%v:%u). Connectivity to the rule may be affected until this connection ends.</warn>",	//GW_NAT_CONFLICTING_CONNECTIONS_WARNING
"펌웨어 파일을 업로드하여 공유기를 재 시작 합니다.  프로세스가 끝날 때까지 <span id='show_sec'></span>&nbsp; 초 기다려 주십시오. 그 다음, 웹 페이지에 다시 접속하실 수 있습니다. 재시작(reload) 버튼이나 웹 브라우저를 종료하시거나의 뒤로 돌아가기 버튼을 누르면, 이 프로세스가 실패하는 원인이 될 수 있습니다.",	//_upgintro
"Web site %S accessed from %v",	//WEB_FILTER_LOG_URL_ACCESSED
"펌웨어 업그레이드 서버 %s 는 IP 주소 %v 에 있습니다. ",	//GW_FW_NOTIFY_RESOLVED_DNS
"DHCP 주소 %v 가 사용자에게 할당되었습니다. ",	//DHCP_CLIENT_RELEASED_LEASE
"PPTP connected to server &quot; %s&quot;  with ID 0x%04X ",	//PPTP_EVENT_TUNNEL_CONNECTED
"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no TCP connection active between %v:%u and %v:%u ",	//IPNAT_TCP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no session active for protocol %u between %v and %v",	//IPNAT_BLOCKED_INGRESS_ICMP_ERROR_PACKET
"Blocked incoming ICMP packet (ICMP type %u) from %v to %v",	//IPNAT_ICMP_BLOCKED_INGRESS_PACKET
"RTSP ALG가 %v:%u 에서 %v:%u로의 비정상 RTP 포트 %u를 차단하였습니다.  ",	//IPRTSPALG_REJECTED_ODD_RTP_PACKET
"포트 포워딩 ALG가 %v:%u 에서 %v:%u 로의 TCP 패킷 세션 할당에 실패하였습니다.  ",	//IPPORTFORWARDALG_TCP_PACKET_ALLOC_FAILURE
"패킷 헤더를 처리할 수 없어 %v 에서  %v 로의 UDP 패킷이 폐기되었습니다. ",	//IPNAT_UDP_UNABLE_TO_HANDLE_HEADER
"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no ICMP session active between %v and %v",	//IPNAT_ICMP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
"주의: 이 기능과 관련한 제약 사항은 <a href='../Help/Tools.shtml#wcn' onclick='return jump_if();' style='white-space: nowrap;'>Help &rarr; Tools 를 참조하시기 바랍니다.",	//ta_wcn_note
"PC에서 프린터를 공유하려면, <a href='../Help/Basic.shtml#PS' onclick='return jump_if();' style='white-space: nowrap;'>Help &rarr; Home &rarr; Printer Wizard 에 있는 설정 안내를 따라하십시오.",	//tps_intro5
"The lease %v was revoked.",	//IPDHCPSERVER_LEASE_REVOKED2	
"Lease reservation %v was deleted.",	//IPDHCPSERVER_LEASE_RESERVATION_DELETED	
"Lease %v renewed by client %m",	//IPDHCPSERVER_LEASE_RENEW
"Start IP address(%v) of '%s' should not be within LAN subnet(%v).",	//GW_INET_ACL_START_IP_ADDRESS_IN_LAN_SUBNET_INVALID
"Web site %S accessed from %s",	//WEB_FILTER_LOG_URL_ACCESSED_MAC
"웹사이트 %S 가  %s 때문에 차단되었습니다.",	//WEB_FILTER_LOG_URL_BLOCKED_MAC
"인터넷 액세스 제어에 의해 %v:%u[%s] 에서 %v:%u 로 (protocol %u) 패킷이 차단되었습니다.",	//GW_INET_ACCESS_DROP_ACCESS_CONTROL_MAC
"인터넷 접속 포트 필터가 %v:%u[%s] 에서 %v:%u (프로토콜 %u) 로의 패킷을 차단하였습니다.",	//GW_INET_ACCESS_DROP_PORT_FILTER_MAC
"raw TCP 포트 프린팅 프토토콜은 프린터와 통신하기 위해 고정 IP 주소와 TCP 포트를 사용합니다.     ",	//tps_raw1
"(GMT+06:30) Rangoon ",	//up_tz_52
"목적지 IP와 동일합니다.",	//_r_alert_new1
"WEP ",	//LS321
"이메일",	//te_EmSt
"Nov ",	//tt_Nov
"%v 에서 %v (IP protocol %u)로의 송신 패킷이 차단되었습니다.",	//IPNAT_BLOCKED_EGRESS
"Wake on LAN ",	//help738
"무선 보안 모드",	//bws_WSMode
"무선 네트워크",	//help759
"LAN 환경에서 가장 광범위하게 사용되는 기술입니다.",	//help517
"Ping 손실:",	//tsc_pingt_msg102
"규칙은 알기 쉬운 이름으로 설정하십시오. 예를 들어, <code>Game Server</code>. 유명한 게임 이름을 선택할 수 도 있고 남아 있는 설정 값들은 따라서 입력할 수 있습니다. 목록이 생성되면서 포트 설정 값이 변경되었는지 확인하시기 바랍니다. IP 주소도 반드시 입력하십시오.",	//help65
"UPnP ",	//ta_upnp
"전송률",	//bwl_TxR
"평균 Ping 응답시간 (in milliseconds): ",	//tsc_pingt_msg106
"하루 종일 ",	//tsc_AllDay
"Tiger Woods 2K4 ",	//gw_gm_53
"DHCP IP 주소 리스를 잃었습니다. ",	//DHCP_CLIENT_LOST_LEASE
"인증 타임아웃:",	//help385
"이 정책이 적용될 스케쥴을 선택하십시오.",	//_aa_wiz_s3_msg
"정확한 로그 기록 및 방화벽 규칙 적용을 위하여 시간을 정확히 입력하십시오. ",	//hhtt_intro
"초당 Bit 수",	//help443
"A-Z 또는 0-9 문자 ",	//help414
"날짜와 시각을 직접 설정합니다. ",	//tt_StDT
"인증 서버의 IP 주소",	//help388
"Final Fantasy XI (PC) ",	//gw_gm_20
"추가",	//_ok
"상태",	//_status
"이더넷을 통해 원격에 있는 다수의 컴퓨터를 연결하기 위해 Point-to-Point Protocol over Ethernet 을 사용합니다.",	//help656
"Out ",	//_Out
"볼 것 ",	//sl_WtV
"When you are browsing for available wireless networks, this is the name that will appear in the list (unless Visibility Status is set to Invisible, see below). This name is also referred to as the SSID. For security purposes, it is highly recommended to change from the pre-configured network name. ",	//help352
"설정 마법사가 프린터와 통신할 수 없습니다. ",	//wprn_nopr2
"네트워크 이름 (SSID) ",	//wwz_wwl_wnn
"IP 주소 ",	//_ipaddr
"The direction of initiation of the conversation: ",	//help820
"(GMT+07:00) Krasnoyarsk ",	//up_tz_54
"LAN 의 모든 컴퓨터가 공유기의 DHCP 서버로부터 정상적으로 IP 주소를 할당받은 경우, 이 옵션은 비활성화 됩니다. 그러나, 한 대의 컴퓨터라도 공유기의 DHCP 서버로 부터 IP 주소를 할당 받지 못 할 경우  이 옵션을 활성화 하는 것은 공유기가 모든 클라이언트에게 브로드캐스트로 응답하도록 하며, 이로 인해 LAN 구간의 성능 저하 및 장애를 유발할 수 있습니다.",	//help326
"주의: 일부 브라우저는 WAN 상태 변화 시 업데이트 내용을 제대로 반영하지 못 할 수 있습니다. 또한 일부 브라우저는 업데이트 내용을 반영하기 위해 브라우저의 새로고침을 기능을 사용하여야 합니다.",	//help773
"MAC 필터링 규칙 ",	//am_MACFILT
"오래된 장비 혹은 기술",	//help600
"모든 네트워크 장비는 하드웨어 제조사로부터 부여된 고유의 MAC 주소를 가지고 있습니다. 일부 ISP 는 가입자의 MAC 주소를 확인하거나, 최초로 접속한 컴퓨터나 공유기에 설치된 네트워크 어댑터의 MAC 주소를 기록합니다. 이후부터 ISP 는 기록된 특정 MAC 주소에 대해서만 접속을 허용합니다. ",	//help302
"This shows clients that you have specified to have reserved DHCP addresses. An entry can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the item is highlighted, and the &quot;Edit DHCP Reservation&quot; section is activated for editing. ",	//help348
"접근제어 옵션으로 네트워크에 나가고 들어오는 액세스를 제어할 수 있습니다. 인증된 사이트, 시간/날짜에 따른 웹 접속 제한, P2P 유틸리티 또는 게임과 같은 응용프로그램 접속을 차단하는 등의 접속 허가 여부를 제어하는 경우에만 이 기능을 사용하십시오.",	//aa_intro
"Default ",	//help486
"PainKiller ",	//gw_gm_35
"Informational ",	//sl_Infrml
"무선",	//_wireless
"RADIUS 서버 IP 주소 ",	//bws_RIPA
"WLAN 분리 기능을 활성화 하면 접속된 사용자들 간 통신은 제한됩니다. ",	//KR58_ww
"If Automatic Uplink Speed is disabled, this option allows you to set the uplink speed manually. Uplink speed is the speed at which data can be transferred from the router to your ISP. This is determined by your ISP. ISPs often specify speed as a downlink/uplink pair; for example, 1.5Mbps/284kbps. For this example, you would enter &quot;284&quot;. Alternatively you can test your uplink speed with a service such as <a href='http://www.dslreports.com'>www.dslreports.com</a>. Note however that sites such as DSL Reports, because they do not consider as many network protocol overheads, will generally note speeds slightly lower than the Measured Uplink Speed or the ISP rated speed. ",	//help83
"<strong>Measured Uplink Speed</strong> 가 정확하지 않다면, <strong>Automatic Uplink Speed</strong> 를 비활성화하고 <strong>Manual Uplink Speed</strong>를 직접 입력하십시오. 최적 값을 모으기 위해서 일부 성능 측정 도구가 필요할 수 도 있습니다.",	//hhase_intro
"NVRAM 에서 설정을 불러오는 동안 에러가 발생하였습니다(Magic number 불일치). 설정을 초기화 하십시오. ",	//RUNTIME_CONFIG_MAGIC_NUM_ERROR
"Sat ",	//_Sat
"웹싸이트 필터링 규칙",	//awf_title_WSFR
"You can select a computer from the list of DHCP clients in the &quot;Computer Name&quot; drop-down menu, or you can manually enter the IP address of the server computer. ",	//help18_a
"Far Cry ",	//gw_gm_18
"Call of Duty ",	//gw_gm_7
"DSL ",	//help503
"서브클래스 %u protocol %u 인 USB 대용량 스토리지를 검색하였습니다. ",	//USB_LOG_STORAGE_TYPE
"Game Server",	//help346
"현재 설정을 잃게 됩니다.",	//up_rb_5
"WEP",	//_WEP
"일부 기능들이 비활성화되었습니다. 이 경고 메시지들을 반드시 확인하십시오. ",	//KR112
"SWAT 4",	//gw_gm_82
"지원 가능한 인증 프로토콜은 PAP과 CHAP 입니다.",	//bw_sap
"네트워크 연결이 끊어졌습니다. '확인' 버튼을 누르십시오",	//li_alert_2
"디지털 신호와 아날로그 신호의 감쇠. 신호의 감쇠는 전송 거리가 길어질 수록 심해집니다.",	//help426
"ISP 로부터 할당받은 IP 주소 정보를 입력하십시오.",	//bwn_msg_SWM
"When Access Control is disabled, every device on the LAN has unrestricted access to the Internet. However, if you enable Access Control, Internet access is restricted for those devices that have an Access Control Policy configured for them. All other devices have unrestricted access to the Internet. ",	//help120
"부족한 시스템 자원으로 인해 IGMP 호스트가 그룹 %v 의 요청을 거절하였습니다.",	//IGMP_HOST_LOW_RESOURCES
"0~9, A~F를 사용하는 10자 또는 26자의 16진수 ",	//wwl_s4_intro_z3
"Bandwidth ",	//help432
"Enable this option if you have a syslog server currently running on the LAN and wish to send log messages to it. ",	//help858
"Windows 2000 ",	//help339
"시스템 로그 서버에 로그 메시지 저장하기",	//help857
"외부 환경에서 접근 가능한 포트 범위를 입력하십시오. (예 <code>6000-6200</code>).",	//help51
"PPPoE 를 통해 할당된 IP 주소가 LAN 구간의 IP 대역과 충돌합니다. 이 문제를 해결하기 위하여 LAN 구간의 IP 대역을 변경하지 않을 경우 인터넷 연결이 제한됩니다. ",	//GW_WAN_LAN_ADDRESS_CONFLICT_PPP
"오류 ",	//ss_Errors
"If a dynamic DNS update fails for any reason (for example, when incorrect parameters are entered), the router automatically disables the Dynamic DNS feature and records the failure in the log. ",	//help899
"저장하기 쉽도록 데이터 나누기 ",	//help527
"무선 네트워크 장비에 PIN 을 입력하고 아래의 '연결' 버튼을 누르십시오 ",	//wps_p3_4
"DMZ은 NAT로 요청하지 않는 수신 요청을 허용하는 몇 가지 방법 중 한가지입니다. 일반적으로 DMZ 호스트는 다른 대체 방법이 없는 경우에만 사용합니다. 왜냐하면, LAN 상의 다른 시스템보다 사이버 공격에 훨씬 더 노출이 많기 때문입니다. DMZ 대신에 가상서버, 포트 포워딩 규칙, 포트 트리거 같은 설정을 사용하는 것을 고려해 보십시오. 가상서버는 특정 응용프로그램으로 가는 수신 세션에 대해 포트 하나만 열어 줍니다(포트 리다이렉션과 ALG 사용도 가능). 포트 포워딩은 선택적 DMZ 과 유사해서 한 포트 또는 한 포트 이상의 포트가 목적지인 수신 트래픽을 특정 LAN 호스트로 포워딩합니다(DMZ 호스트 보다는 공격 노출이 적음). 포트 트리거는 포트 포워딩의 특별한 형태로 송신 트래픽에서 동작되고 포트 트리거가 동작하는 동안에만 포워드됩니다.",	//haf_dmz_40
"웹 필터 옵션을 이용하여 다수의 사용자들이 접근 가능한 웹 사이트 목록을 지정할 수 있습니다.  웹 필터를 활성화 하면 이 페이지의 목록에 존재하지 않은 웹 사이트는 모두 접근이 제한됩니다. 이 기능을 사용하려면 접근 제어 페이지의 &quot;웹 필터 적용&quot; 체크 박스를 체크하십시오. ",	//awf_intro_WF
"설정된 스케쥴을 변경하려면 <strong>Edit</strong> 아이콘을 클릭하십시오. ",	//hhts_edit
"무선 네트워크 이름 (SSID) ",	//wwl_wnn
"WMM 설정",	//aw_WE
"Setup Help ",	//help201a
"30일 무료 사용을 활성화하십시오. ",	//_bsecure_activate_trial
"ISP 로부터 제공받은 패스워드 또는 Key 를 입력하십시오. Dynamic DNS 서비스 제공 업체가 한 개의 Key 만 제공했을 경우에는 구 Key 를 3개의 창에 모두 입력하십시오.",	//help896
"통신에 사용된 프로토콜 ",	//help815
"넷마스크 ",	//_netmask
"메일 수신은 POP3 프로토콜을 사용합니다. ",	//help652
"가상 서버 규칙을 추가하려면 이 과정을 반복하십시오. 설정 완료 후,  페이지 위의 <span class='button_ref'>Save Settings</span> 버튼을 클릭하십시오.",	//help12
"MAC 주소 필터 옵션은 네트워크 어댑터의 MAC 주소를 기반으로 네트워크 접근을 제어하기 위하여 사용됩니다. MAC 주소는 네트워크 어댑터 제조사로부터 할당 받은 고유한 식별자입니다. 이 기능을 통해 네트워크 및 인터넷의 접근을 허용하거나 거부할 수 있습니다. ",	//am_intro_1
"LCP sets local auth: %04x",	//IPPPPLCP_SET_LOCAL_AUTH
"Crimson Skies ",	//gw_gm_11
"카드버스 ",	//help456
"설정을 저장하지 않습니다. ",	//_dontsavesettings
"WPA (Wi-Fi Protected Access) key 는 다음의 기준 중 하나와 맞아야 합니다. ",	//wwl_s4_intro_za1
"MAC ",	//aa_AT_1
"L2TP 로컬 터널 0x%04X 이 중단되었습니다. ",	//IPL2TP_TUNNEL_ABORTING
"DHCP Reservation 추가/편집",	//help330
"4 am ",	//tt_time_5
"L2TP 클라이언트",	//wwa_msg_l2tp
"LAN 에 있는 장비의 IP 주소를 입력하십시오. (예: <code>192.168.0.50</code> ",	//help6
"시간",	//_time
"Normally, this is set to &quot;auto&quot;. If you have trouble connecting to the WAN, try the other settings. ",	//help296
"Step 2: 컴퓨터에서 설정 실행을 시작하십시오.",	//wprn_intro4
"xDSL 또는 다른 프레임 릴레이 네트워크",	//at_xDSL
"LAN ",	//_LAN
"Warcraft III ",	//gw_gm_60
"Graphical user interface ",	//help539
"64 bits ",	//wwl_64bits
"정책을 적용할 장비를 선택하십시오. ",	//_aa_wiz_s4_msg
"디스크가 꽉 찼습니다.",	//IPFAT_DISK_FULL
"D-Link 공유기가 다수의 사용자를 위하여 통합 프린터 서버 기능을 제공하며, 이 페이지에서 프린터 서버와 연결되어 있는 프린터의 정보를 확인할 수 있습니다. ",	//sps_intro3
"시작 메뉴에서 프로그램 선택, 보조 프로그램 선택, 명령 프롬프트을 실행한 후 <code>ipconfig /all</code> 입력. 공유기에 연결된 어댑터의 물리적 인터페이스 주소가 MAC 주소입니다. ",	//help341
"Database ",	//help472
"OK' 버튼을 누르면 변경된 사항들이 취소되고 스케쥴 페이지에 표시됩니다. ",	//aa_sched_conf_2
"시간 동기화에 실패하였습니다.  (상태 %d)",	//NET_RTC_SYNCHRONIZATION_FAILED
"L2TP 로컬 세션 0x%04X 시작 시도",	//IPL2TP_SESSION_CONNECTING
"파일 서버",	//help520
"최신 펌웨어 버젼 자동 확인 ",	//tf_AutoCh
"프린터에서 제공한 ID를 확인할 수 없어 프린터 제조사, 또는 모델의 확인이 불가능합니다. 해당 정보 없이는 마법사가 진행되지 않습니다.",	//wprn_iderr2
"These two IP values (<i>from</i> and <i>to</i>) define a range of IP addresses that the DHCP Server uses when assigning addresses to computers and devices on your Local Area Network. Any addresses that are outside of this range are not managed by the DHCP Server; these could, therefore, be used for manually configured devices or devices that cannot use DHCP to obtain network address details automatically. ",	//help319
"Clicking this button refreshes the display of log entries. There may be new events since the last time you accessed the log. ",	//help800
"<b>주의:</b> DMZ에 컴퓨터를 두면 여러 가지 보안 위험에 노출 될 수 있습니다. 다른 방법이 없는 경우 마지막 수단으로 이 옵션을 사용하십시오.",	//af_intro_2
"장비 정보",	//sd_title_Dev_Info
"인터넷 접속 포트 필터가 %v:%u 에서 %v:%u (프로토콜 %u) 로의 패킷을 차단하였습니다. ",	//GW_INET_ACCESS_DROP_PORT_FILTER
"Windows Connect Now ",	//_connow
"SIP ALG  %v:%u 에서 %v:%u 로의 패킷의 거부하였습니다.",	//IPSIPALG_REJECTED_PACKET
"헤더 옵션을 수정할 수 없어 %v:%u 에서 %v:%u 로의 TCP 패킷이 차단되었습니다. ",	//IPNAT_TCP_UNABLE_TO_MODIFY_OPTIONS
"NTP 서버를 선택하십시오. ",	//tt_SelNTPSrv
"VoIP ",	//help737
"User ",	//_user
"주파수의 잡음은 무선 랜의 오류를 증가시킬 수 있습니다. ",	//help812
"(GMT+08:00) Taipei ",	//up_tz_59
"스페셜 응용프로그램",	//SPECIAL_APP
"NONE ",	//wwl_NONE
"WAN 서비스 시작 ",	//GW_WAN_SERVICES_STARTED
"금지된 웹 액세스",	//fb_FbWbAc
"You have to open up the Web-based management interface and click the Connect button manually any time that you wish to connect to the Internet. ",	//help275
"OSI 모델의 첫 번째 계층은 데이터 전송에 대한 전기적 전송 신호 규격을 제공합니다. ",	//help646
"검색된 프린터가 없음",	//wprn_nopr
"시간대",	//tt_TimeZ
"장애처리 도움말",	//wprn_tt
"메뉴에서 로컬 시간대를 선택하십시오.",	//help841
"새로운 규칙을 지정하십시오. ",	//aa_sched_new
"1 pm ",	//tt_time_14
"시스템 로그 설정",	//tsl_SLSt
"HTTP ",	//gw_vs_1
"H.323 ALG가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//IPH323ALG_REJECTED_PACKET
"Step 4 - 필터링 방법 선택",	//aa_wiz_s1_msg4
"Windows 98 ",	//help336
"시스템 이름",	//ta_sn
"Depending on whether you are currently logged in to BigPond, you can click either the <span class='button_ref'>BigPond Login</span> to attempt to establish the WAN connection or the <span class='button_ref'>BigPond Logout</span> to break the WAN connection. ",	//help780
"Web browser ",	//help745
"네트워크 상의 장비간 통신 시간 동기화 시 사용됩니다.",	//help659
"인터페이스",	//_interface
"웹사이트 %S 가  %v 때문에 차단되었습니다. ",	//WEB_FILTER_LOG_URL_BLOCKED
"원격 관리 포트가 가상 서버 항목과 충돌합니다.",	//vs_http_port
"(GMT-06:00) Central America ",	//up_tz_07
"공유기는  NAT가 동작하는 방식에 의해 엄격한 방화벽을 지원합니다. 공유기를 반대로 설정하지 않은 한, NAT는 확실치 않은 수신 요청에 대해 어떤 포트도 응답하지 않고 따라서 사이버공격자들로부터 LAN 네트워크를 보이지 않게 해 줍니다. 그러나 일부 네트워크 응용프로그램들은 방화벽 없이는 동작할 수 없습니다. 이런 응용프로그램들은 제대로 동작할 수 있도록 방화벽에서 선택적으로 포트를 열어 주어야 합니다. 이 페이지에 있는 옵션으로 특정 응용프로그램의 필요에 따라 방화벽을 여는 몇 가지 방법을 제어하는 방법을 알려줍니다.",	//haf_intro_1
"게이트웨이 주소 ",	//wwa_gw
"고급 무선 설정에 익숙하지 않으면, 설정을 변경하기 전에 도움말을 참조하시기 바랍니다.",	//aw_intro
"Sentinel 서비스",	//_sentinel_serv
"USB ",	//help727
"가입하신 인터넷 서비스 공급업체(ISP)로 부터 고정 IP 주소를 받은 경우에 이 옵션을 선택하십시오.",	//wwa_msg_sipa
"무선 ISP ",	//help753
"한 컴퓨터에서 인터넷에 있는 다른 컴퓨터로의 데이터 통신 방법 ",	//help574
"패킷 헤더 인식 불가로 인한 %v 부터 %v 까지 패킷 드롭 ",	//IPNAT_TCP_UNABLE_TO_HANDLE_HEADER
"일부 응용프로그램은 DMZ 호스트를 사용하여야 합니다. 다음은 DMZ 호스트가 필요한 경우의 예 입니다.",	//haf_dmz_50
"<strong>컴퓨터 이름</strong> 메뉴의 DHCP 클라이언트 목록 중에서 컴퓨터를 선택하거나 특정 포트를 열어야 할 컴퓨터의 IP 주소를 직접 입력할 수 있습니다. ",	//hhav_ip
"정책 %s 가 중단되었습니다.; MAC 주소 %m의 인터넷 접속이 변경되었습니다.: %s ",	//GW_INET_ACCESS_POLICY_END_MAC
"여러가지 방화벽과 자녀 보호 기능을 위한 스케쥴을 관리하는데 사용되는 스케쥴 설정 옵션입니다. ",	//tsc_intro_Sch
"%m MAC 주소의 무선 시스템 접근 제한 ",	//GW_WLAN_ACCESS_DENIED
"이 옵션은 특정 프로그램이 네트워크의 우선순위를 공유기로부터 자동으로 할당받기 위해 기본값으로 활성화 되어 있습니다.",	//help79
"적절하게 설정되지 않은 BigPond ",	//GW_BIGPOND_CONFIG
"연결 중 (기다려 주십시오...)",	//_sdi_s3
"높음",	//aw_TP_0
"Ping 테스트 ",	//tsc_pingt
"WPA-Personal ",	//_WPApersonal
"이메일 설정",	//_email
"PPPoE 컨펌 세션 제공",	//PPPOE_EVENT_DISCOVERY_REQUEST
"고정 IP 주소 연결 ",	//wwa_wanmode_sipa
"방화벽",	//_firewall
"시스템 확인",	//_syscheck
"클라이언트의 LAN 구간 IP 주소.",	//help784
"네트워크 자원에 접근하려면 Remote Authentication Dial-In User Service 를 통해 인증을 받아야 합니다.",	//help663
"Unknown ",	//UNKNOWN
"본 공유기는 192.168.0.1 를 IP 주소로 사용하고 있습니다. 웹 서버를 192.168.0.3 으로 설정하고, FTP 서버를 192.168.0.4 로 설정하였다면 DHCP IP 주소의 범위는 192.168.0.5 이상이어야 합니다. ",	//help322
"UPnP는 Universal Plug and Play의 약자로 네트워크 장비와 스포트웨어 주변장치간에 호환성을 제공하는 네트워킹 아키텍쳐입니다. 이 공유기는 UPnP 기능을 지원하므로 다른 UPnP 장비와 소프트웨어와 호환됩니다.",	//help_upnp_1
"Wolfenstein: Enemy Territory ",	//gw_gm_61
"Wi-Fi ",	//help748
"프래그멘테이션이 너무 작아 성능의 저하를 초래할 수 있습니다.",	//help181
"(optional) ",	//_optional
"내부 네트워크에서 접근 가능한 웹 서버의 목록을 생성하십시오.",	//hhwf_intro
"인터넷",	//help569
"고급 네트워크 설정이 익숙하지 않다면, 설정을 변경하기 전에 도움말 항목을 참조하시기 바랍니다.",	//anet_intro
"전자메일을 보낼 IP 주소를 입력하십시오. ",	//help862
"Blocked outgoing TCP packet from %v:%u to %v:%u as %s received but there is no active connection  ",	//IPNAT_TCP_BLOCKED_EGRESS_NOT_SYN
"게이트웨이 이름",	//ta_GWN
"공유기 설정 권한이 없습니다. 관리자에게 문의하십시오.",	//wprn_tt3
"MTU: ",	//help293
"ISP 로부터 고정 IP 주소를 할당받았다면, 이 옵션을 선택하시기 바랍니다. The ISP provides the value for the ",	//help265_2
"새로운 세션을 생성할 수 없어 %v 에서 %v 로 (IP 프로토콜 %u) 패킷을 폐기하였습니다. ",	//IPNAT_UNABLE_TO_CREATE_CONNECTION
"Always on: ",	//help270
"고급 무선 설정",	//aw_title_2
"방화벽 설정",	//_firewalls
"Enables 802.11d operation. 802.11d is a wireless specification for operation in additional regulatory domains. This supplement to the 802.11 specifications defines the physical layer requirements (channelization, hopping patterns, new values for current MIB attributes, and other requirements to extend the operation of 802.11 WLANs to new regulatory domains (countries). The current 802.11 standard defines operation in only a few regulatory domains (countries). This supplement adds the requirements and definitions necessary to allow 802.11 WLAN equipment to operate in markets not served by the current standard. Enable this option if you are operating in one of these &quot;additional regulatory domains&quot;.",	//help186
"PPPoE 세션 0x%04X 이 이루어졌습니다. ",	//PPPOE_EVENT_UP
"프로토콜",	//_protocol
"WPA-Personal and WPA-Enterprise ",	//help372
"(GMT+02:00) Bucharest ",	//up_tz_32
"kbps ",	//at_kbps
"Cable 또는 기타 Broadband Network",	//at_Cable
"<warn>모든 스테이션이 100-140 채널에서 동작 할 수 없습니다. 스테이션이 연결에 실패할 경우 채널을 변경하십시오.</warn>",	//GW_WLAN_11A_CH_MID_BAND_WARN
"100Mbps ",	//anet_wp_1
"Assign a meaningful name to the virtual server, for example <code>Web Server</code>. Several well-known types of virtual server are available from the &quot;Application Name&quot; drop-down list. Selecting one of these entries fills some of the remaining parameters with standard values for that type of server. ",	//help17
"기본 설정에는 암호가 설정되어 있지 않습니다. 공유기의 보안을 위하여 암호를 설정하시기 바랍니다.",	//ta_intro_Adm2
", 확인하십시오 ",	//tool_admin_check
"발광 다이오드 ",	//help598
"xDSL ",	//help761
"IP address that is assigned by a DHCP server and that may change. Cable Internet providers usually use this method to assign IP addresses to their customers. ",	//help510
"Stop ",	//_stop
"Syslog 서버의 주소를 IP 주소 %v 로 설정합니다. ",	//GW_SYSLOG_STATUS
"DHCP 서버 설정",	//bd_title_DHCPSSt
"여기서 공유기의 이름을 변경할 수 있습니다.",	//help827
"펌웨어 정보",	//tf_FWInf
"최대 8개의 WAN IP 주소 범위를 각각의 규칙으로 관리할 수 있습니다. 각 IP 범위의 체크박스를 이용하여 설정된 범위를 활성화 또는 비활성화 할 수 있습니다.",	//hhai_ipr
"이 항목은 초기값으로 유지하십시오. 이 항목을 변경하는 것은 무선 네트워크의 성능을 저하시킬 수 있습니다.",	//hhaw_1
"NTP 서버 활성화",	//tt_EnNTP
"Allows multiple VPN clients to connect to their corporate networks using IPSec. Some VPN clients support traversal of IPSec through NAT. This option may interfere with the operation of such VPN clients. If you are having trouble connecting with your corporate network, try disabling this option. ",	//help34
"LAN 에 설치된  공유기의 서브넷 마스크 ",	//help309
"새로운 MAC 주소를 추가할 수 없습니다. MAC 주소는 다른 정책 설정 시 재사용할 수 있습니다.",	//aa_alert_15
"설정 저장",	//_savesettings
"스케쥴에 &quot; 주간 규칙&quot; 과 같이 알기 쉬운 이름을 부여하십시오.",	//help193
"가상 서버 변수",	//help14_p
"Need for Speed: Hot Pursuit 2 ",	//gw_gm_32
"%v:%u 에서 %v:%u 로의 수신 TCP 연결 요청이 차단되었습니다. ",	//IPNAT_TCP_BLOCKED_INGRESS_SYN
"이 기능을 활성화 하면, 인터넷에서 들어오는 WAN 포트의 IP로의 Ping 요청에 대해 응답을 하게 합니다.",	//anet_msg_wan_ping
"L2TP 서브넷 마스크",	//help285
"네트워크의 시스템 또는 시스템 그룹상의 서버 접속을 제한하는 수신 필터의 사용이 가능합니다. ",	//ai_intro_2
"LAN 통계 자료 ",	//ss_LANStats
"IPsec ",	//help584
"복구가 이미 진행 중입니다.",	//ta_alert_4
"사용자 PC 의 MAC 주소 복사",	//_clone
"Diablo I and II ",	//gw_gm_14
"패킷 헤더를 처리할 수 없어 %v 에서 %v 로의 GRE 패킷을 차단하였습니다. ",	//PPTP_ALG_GRE_UNABLE_TO_HANDLE_HEADER
"A utility displays the routes between you computer and specific destination ",	//help716
"일부 접속 제한 ",	//_aa_block_some
"11 pm ",	//tt_time_24
"Established -- the connection is passing data. ",	//help819_3
"Normally email is sent at the start time defined for a schedule, and the schedule end time is not used. However, rebooting the router during the schedule period will cause additional emails to be sent. ",	//help873
"충돌",	//ss_Collisions
"전자메일 송신을 위하여 SMTP 서버의 주소를 입력하십시오.",	//help863
"This option enables configuration of an optional second RADIUS server. A second RADIUS server can be used as backup for the primary RADIUS server. The second RADIUS server is consulted only when the primary server is not available or not responding. The fields <span class='option'>Second RADIUS Server IP Address</span>, <span class='option'>RADIUS Server Port</span>, <span class='option'>Second RADIUS server Shared Secret</span>, <span class='option'>Second MAC Address Authentication</span> provide the corresponding parameters for the second RADIUS Server. ",	//help397
"가상 서버 목록",	//av_title_VSL
"Off ",	//_off
"anti-spoof 검사 확인",	//KR106
"With this Virtual Server entry, all Internet traffic on Port 8888 will be redirected to your internal web server on port 80 at IP Address 192.168.0.50. ",	//help13
"Step 3: 인터넷 연결 설정하기",	//wwa_title_s3
"BigPond ",	//wwa_wanmode_bigpond
"Bit rate ",	//help440
"The WAN (Wide Area Network) section is where you configure your Internet Connection type. ",	//help254
"수신 연결을 처리하기 위해 ICMP, TCP, UDP, IGMP,GRE, ESP(PPTP와 IPSec ALG에서 설정 된 경우) 이외의 프로토콜을 사용합니다.)",	//haf_dmz_70
"스케쥴 %s 를 설정하는 동안 시스템 오류가 발생했습니다. ",	//GW_SCHED_ATTACH_FAILED
"SSID 항목은 비워 둘 수 없습니다.",	//_badssid
"NVRAM 에 저장된 설정",	//RUNTIME_CONFIG_STORING_CONFIG_IN_NVRAM
"Asymmetric Digital Subscriber Line ",	//help410
"펌웨어 업데이트가 가능합니다.",	//FW_UPDATE_AVAILABLE
"The Dynamic DNS feature allows you to host a server (Web, FTP, Game Server, etc.) using a domain name that you have purchased (www.whateveryournameis.com) with your dynamically assigned IP address. Most broadband Internet Service Providers assign dynamic (changing) IP addresses. When you use a Dynamic DNS service provider, your friends can enter your host name to connect to your server, no matter what your IP address is. ",	//help891
"PPPoE, PPTP, L2TP Connection ",	//help777
"dBi ",	//help480
"MAC Address Authentication: ",	//help393
"인터넷 연결 타입",	//bwn_ict
"IEEE ",	//help559
"Jun ",	//tt_Jun
"L2TP 로컬 터컬 0x%04X 이 &quot; %s&quot;  에 연결 되었습니다. ",	//IPL2TP_TUNNEL_CONNECTED
"Command and Conquer Zero Hour ",	//gw_gm_9
"이더넷",	//help516
"Aliens vs. Predator ",	//gw_gm_2
"무선 네트워크 설정 마법사",	//wwl_wl_wiz
"DHCP 범위가 유효하지 않습니다, FROM 이 TO 보다 크지 않습니다.",	//network_dhcp_range
"Step 4: 테스트 페이지 출력",	//wprn_intro6
"BigPond failed, state=%d with error=%d, server response=%s ",	//GW_BIGPOND_FAIL
"주소가 제한되었습니다. ",	//af_EFT_1
"유니캐스트 사용",	//_use_unicasting
"네트워크 상태",	//_networkstate
"년 ",	//tt_Year
"USB 장비를 설치하는데 실패했습니다 ",	//IPASYNCFILEUSB_MOUNT_FAILED
"UDP 엔드포인트 필터링",	//af_UEFT
"Alphanumeric ",	//help413
"기본값으로 가장 빠른 전송속도가 설정됩니다. 필요한 경우 전송속도를 선택할 수 있습니다.",	//help356
"Pre-Shared Key: ",	//help381
"수신 필터 ",	//_inboundfilter
"이 메카니즘은 주로 논리적으로 불가능한 방향이나 인터페이스상에서 나타나는 패킷을 차단하여 조작된 IP 주소로 부터 네트워크를 보호합니다.  ",	//KR108
"고급 포트 필터 적용",	//_aa_apply_port_filter
"Maximum Transmission Unit is the largest packet that can be transmitted on a packet-based network like the Internet ",	//help619
"Dest<br />Port<br />End ",	//aa_FPR_c7
"Jedi Knight III: Jedi Academy ",	//gw_gm_27
"BigPond 가 제대로 설정되었습니다. ",	//BIGPOND_NOT_PROPERLY_CFGD
"(GMT+08:00) Perth ",	//up_tz_58
"As an alternative, you can locate a MAC address in a specific operating system by following the steps below: ",	//help335
"Never",	//_never
"Clicking this button erases all log entries. ",	//help801
"A computer on a network that stores data so that the other computers on the network can all access it ",	//help521
"Longest ping time (in milliseconds): ",	//tsc_pingt_msg105
"경고: JavaScript 가 설치되어 있지 않습니다!",	//li_WJS
"받는 메일(POP3)",	//te_ToEm
"12 am ",	//tt_time_1
"신호",	//help787
"DHCP 로 부터 할당받은 IP. IP 주소는 %v 입니다. ",	//DHCP_CLIENT_GOT_LEASE
"게이트웨이 로그",	//GW_EMAIL_SUBJ
"포트 트리거 ALG가 %v:%u 에서 %v:%u 로의 UDP 패킷을 할당받기에 실패하였습니다.",	//IPPORTTRIGGERALG_UDP_PACKET_ALLOC_FAILURE
"DSSS: 802.11b 무선장치에 의해 사용되는 무선 변조(modulation) 기술 ",	//help494
"도메인명 시스템: 도메인 명을 IP 주소로 전환합니다. ",	//help498
"네트워크 및 라우터 설정을 처음으로 하신다면 <span class='button_ref'>Setup Wizard</span> 을 클릭 하시기 바랍니다. 몇 가지 간단한 방법을 통해 네트워크 구성 및 운영이 가능합니다. ",	//bi_wiz
"Out ",	//EGRESS
"Network Interface Card ",	//help628
"두개의 컴퓨터 사이에 모든 커뮤니케이션 세션을 위한 암호화 및 비암호화",	//help683
"DHCP 연결(유동 IP 주소)",	//_dhcpconn
"공유기 설정",	//bln_title_Rtrset
"미리 정해진 응용프로그램 리스트의 드랍 다운 메뉴에서 <strong>응용프로그램 이름</strong> 을 확인하시기 바랍니다. 이미 정해진 응용프로그램 중 하나를 선택하신다면 드랍 다운 메뉴 옆의 화살표 버튼을 클릭하시기 바랍니다.",	//hhpt_app
"프린터 서버",	//_ps
"WPA2을 지원하는 무선 랜카드를 사용하시는 경우 이 옵션을 선택하시기 바랍니다. ",	//wwl_text_best
"PPTP 서버의 IP 주소 (gateway와 동일할 수도 있습니다. )",	//wwa_pptp_svraddr
"현재 사용중인 이메일 클라이언트 프로그램과 유사한 이메일 설정을 할 수 있습니다. ",	//hhte_intro
"LAN 컴퓨터",	//_LANComputers
"설치마법사",	//wwa_setupwiz
"H.323 (Netmeeting) ",	//as_NM
"and ",	//help264
"(일부 DHCP 서버와의 호환)",	//bw_WDUU_note
"규칙 %s 은 현재 연결되어 있는 것과 충돌합니다. (%v:%u (public %v:%u)--->%v:%u). 이 연결이 종료될 때까지 이 규칙 연결이 영향을 받을 수도 있습니다. ",	//GW_NAT_CONFLICTING_CONNECTIONS_LOG
"MMS ",	//as_MMS
"The rule applies to a flow of messages whose LAN-side IP address falls within the range set here. ",	//help93
"서비스 이름",	//_srvname
"분",	//tt_Minute
"State ",	//sa_State
"호스트 명 또는 IP 주소",	//tsc_pingt_h
"802.11d 설정",	//aw_dE
"무선 상세 정보 ",	//ss_WStats
"D-Link 프린트 설치 마법사를 실행합니다.",	//wprn_intro1
"Gigabits per second ",	//help535
"When this option is enabled, your router will check online periodically to see if a newer version of the firmware is available. ",	//help889
"포트 포워딩 종류 ",	//tool_admin_pfname
"H.323 (NetMeeting) ",	//as_H323
"세션이 이미 있어서 %v 에서 %v로 (프로토콜 %u) 의 패킷이 폐기되었습니다. ",	//IPNAT_SESSION_ALREADY_EXISTS
"BigPond 케이블 연결 설정",	//wwa_title_set_bigpond
"(GMT-04:00) Santiago ",	//up_tz_16
"BigPond 상태변경, 새로운 상태 = %d",	//GW_BIGPOND_STATUS
"인증 설정 ",	//te_EnAuth
"연결을 설정하기 위해 ISP 사업자로부터 사용자 명, 패스워드 및 BigPond 서버 IP 주소를 받으시기 바랍니다.  만약 이같은 정보가 없다면 ISP 사업자에게 확인하십시오. ",	//wwa_msg_set_bigpond
"공유기 시간을  Network Time Server와 연동시키고 싶다면 이 옵션을 선택하시기 바랍니다. 스케쥴이나 로그를 사용하고 있다면 이들을 정확하게 유지하는 가장 좋은 방법입니다.",	//help848
"SPI ",	//help695
"Castle Wolfenstein로 돌아갑니다.",	//gw_gm_41
"정책 마법사",	//_aa_pol_wiz
"IP 필터",	//IP_FILTERS
"Starsiege Tribes ",	//gw_gm_50
"현재 인터넷 연결이 확인되지 않습니다. 리스트에서 현재 ISP 사업자를 선택하시기 바랍니다. 만약 리스트에 없을경우, 기본적 연결을 위해 &quot; 리스트에 없거나 알 수 없습니다&quot;  를 선택하시기 바랍니다.",	//wwa_intro_s3
"Wide Area Network ",	//help740
"%v 에서 %v 로의 연결 시도가 이미 진행중이어서 %v 에서 오는 ESP 패킷이 폐기되었습니다. ",	//IPSEC_ALG_ESP_ESTABLISH_ALREADY_PENDING
"개별 포트 (80, 68, 888)",	//help59
"정말로 장비를 설정되지 않은 상태로 리셋 하시겠습니까? ",	//wps_reboot_need
"Dynamic Fragmentation ",	//at_DF
"DST 마지막 달은 DST 시작 달과 반드시 달라야 합니다.",	//tt_alert_dstchkmonth
"(GMT-01:00) Cape Verde Is. ",	//up_tz_23
"연결설정 시, ISP 서버가 공유기 IP 주소에 할당된다면 이 옵션을 선택하시기 바랍니다.",	//help265_7
"고급",	//_advanced
"고정 IP 주소",	//STATIC_IP_ADDRESS
"현재 사용중인 무선 공유기에 연결되어 있는 모든 무선 클라이언트 리스트 입니다.",	//hhsw_intro
"Step 2: 무선 네트워크 보안",	//wwl_title_s3
"Menu ",	//ish_menu
"(GMT+02:00) Cairo ",	//up_tz_33
"새로운 펌웨어 확인에 실패하였습니다.",	//GW_FW_NOTIFY_FIRMWARE_ERROR
"More info... ",	//_bsecure_more_info
"2nd ",	//tt_week_2
"현재 펌웨어 버전 ",	//tf_CFWV
"Example: ",	//help3
"Creator ",	//_creator
"DNS 릴레이",	//bln_title_DNSRly
"네트워크의 모든 컴퓨터의 시간을 동기화하는데 사용됩니다. ",	//help633
"Glossary ",	//ish_glossary
"긴 WEP key가 짧은 WEP key보다 안전합니다.",	//wwl_s4_intro_z4
"An ISP provides access to the Internet to individuals or companies",	//help578
"Beacon ",	//help438
"Dynamic DNS is provided by companies to allow users with Dynamic IP addresses to obtain a Domain Name that will always by linked to their changing IP address. The IP address is updated by either client software running on a computer or by a router that supports Dynamic DNS, whenever the IP address changes ",	//help508
"ASCII ",	//help423
"By default, the Access Control feature is disabled. If you need Access Control, check this option. ",	//help118
"Shareaza ",	//gw_gm_66
"When DNS Relay is enabled, the router plays the role of a DNS server. DNS requests sent to the router are forwarded to the ISP's DNS server. This provides a constant DNS address that LAN computers can use, even when the router obtains a different DNS server address from the ISP upon re-establishing the WAN connection. You should disable DNS relay if you implement a LAN-side DNS server as a virtual server.",	//help312dr2
"하루 종일 - 24 hrs ",	//tsc_24hrs
"드랍 다운 메뉴의 <strong>응용프로그램 이름</strong>을 확인하시기 바랍니다. 미리 지정된 응용프로그램을 선택한다면 드랍 다운 메뉴 옆의 화살표 버튼을 클릭하시기 바랍니다.",	//hhag_10
"Some ISP's may check your computer's Host Name. The Host Name identifies your system to the ISP's server. This way they know your computer is eligible to receive an IP address. In other words, they know that you are paying for their service. ",	//help261
"트리거 트래픽 종류 ",	//as_TPrt
"This will happen if you have an Access Control Rule configured for this LAN machine. ",	//help28
"11 am ",	//tt_time_12
"상세 통계 정보 새로 고침",	//ss_reload
"DMZ 호스트가 수신한 패킷들은 WAN 쪽 IP에서 LAN 쪽 IP로 전송됩니다. 다만 포트 번호 전송되지 않습니다. 따라서 DMZ 호스트의 응용프로그램들은 특정 포트 번호에 따라 변경됩니다.",	//haf_dmz_30
"<span id='status_text'>printer is</span> 가 라우터에 연결되어 있습니다.",	//sps_fp
"현재 사용중인 인터넷 연결이 자동으로 IP 주소를 제공한다면 이것을 선택하시기 바랍니다. 대부분의 케이블 모뎀은 이와 같은 종류의 연결을 사용하고 있습니다.",	//wwa_msg_dhcp
"Unreal Tournament 2004 ",	//gw_gm_57
"Step 1-  고유한 정책 이름을 선택하십시오. ",	//aa_wiz_s1_msg1
"NetBIOS ",	//help625
"Server ",	//help680
"반드시 '관리자'으로 로그인 하시기 바랍니다. ",	//MUST_BE_LOGGED_IN_AS_ADMIN
"(GMT+09:30) Darwin ",	//up_tz_64
"Wake-on-LAN ALG가 %v:%u에서 %v:%u로의 패킷을 거부하였습니다. ",	//IPWOLALG_REJECTED_PACKET
"wsetting.wfc 로 장비 업데이트  ",	//WCN_LOG_UPDATE
"In terms of a wireless network, this is when wireless clients use an Access Point to gain access to the network ",	//help568
"This option should be enabled when you have a slow Internet uplink. It helps to reduce the impact that large low priority network packets can have on more urgent ones by breaking the large packets into several smaller packets. ",	//help80
"Here you can add entries to the Inbound Filter Rules List below, or edit existing entries. ",	//help171
"Mon ",	//_Mon
"(GMT+10:00) Canberra, Melbourne, Sydney ",	//up_tz_66
"Step 2: 무선 보안 패스워드 설정",	//wwl_title_s4_2
"Multicast ",	//help620
"If you don't use the All Day option, then you enter the time here. The start time is entered in two fields. The first box is for the hour and the second box is for the minute. Email events are normally triggered only by the start time. ",	//help196
"PPPoE 세션에 에러가 발생하였습니다. 연결 시도가 실패하였습니다. ",	//PPPOE_EVENT_DISCOVERY_REQUEST_ERROR
"Apple's version of UPnP, which allows for devices on a network to discover each other and be connected without the need to configure any settings ",	//help667
"A family of specifications for wireless local area networks (WLANs) developed by a working group of the Institute of Electrical and Electronics Engineers (IEEE). ",	//help766
"로그인",	//li_Log_In
"디폴트 게이트웨이",	//_defgw
"비 UDP/TCP/ICMP LAN 세션 ",	//af_gss
"NTP 서버 사용",	//tt_NTPSrvU
"Enter the Public Port as [8888] ",	//help8
"Your ISP provides you with all of this information. ",	//help258
"PPPoE 세션 0x%04X 이 액세스 콘센트레이트에 의해  종료되었습니다. ",	//PPPOE_EVENT_TERMINATED
"장비를 정말로 다시 시작하시겠습니까? ",	//up_rb_1
"Use the checkboxes at the left to activate or deactivate completed Virtual Server entries. ",	//help25_b
"로그 저장",	//sl_saveLog
"공유기 로그를 확인하기 위해서 이 옵션을 사용하십시오. 확인하고 싶은 이벤트 종류와 레벨을 정의할 수 있습니다. 공유기에서 내부 시스템 로그 서버를 설정하여 로그 파일을 시스템 로그 유틸리티가 운영되는 PC로 전송할 수 있습니다.",	//sl_intro
"IP 주소 또는 MAC 주소가 있는 장치를 지정하거나, 정책이 없는 장비는 &quot;다른 장비&quot;에서 선택하십시오. ",	//_aa_wiz_s4_help
"WAN 인터페이스의 연결이 끊어졌습니다. ",	//GW_WAN_CARRIER_LOST
"(bytes) ",	//bwn_bytes
"BigPond Connection ",	//help779
"MAC 주소",	//_macaddr
"Reset or closed TCP connections. The connection does not close instantly so that lingering packets can pass or the connection can be re-established. ",	//help823_13
"멀티캐스트 스트림 설정 ",	//anet_multicast_enable
"다음 DDNS 업데이트 스케쥴 %s",	//GW_DYNDNS_UPDATE_NEXT
"Enter the password associated with the account. ",	//help866
"공유기 상태",	//sl_RStat
"RADIUS ",	//help662
"Roger Wilco ",	//gw_gm_78
"Create a name for the rule that is meaningful to you. ",	//help90
"PPTP 터널 ID 0x%04X 가 종료되었습니다. ",	//PPTP_EVENT_TUNNEL_DOWN
"정적 WAN 모드",	//bwn_SWM
"웹필터가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//IPWEBFILTER_REJECTED_PACKET
"펌웨어 업그레이드 이미지 업로드가 잘못되었습니다.  - 취소합니다. ",	//GW_UPGRADE_FAILED
"여러 개의 포트 또는 포트 범위를 열어서 이 포트들을 통해 데이터를 PC 한대로 전송할 수 있습니다.(redirection) 포트 범위 (100-150),  각각의 포트 번호 (80, 68, 888), 혼합 (1020-5000, 689) 모드와 같은 여러 가지 방식으로 포트를 입력하실 수 있습니다. ",	//ag_intro
"웹 기반으로 공유기에 접속할 수 있도록 관리자용 비밀번호를 Admin 옵션에서 설정합니다. 디폴트로는 비밀번호가 설정되어 있지 않습니다.  공유기 보안을 위해 새로운 비밀번호를 생성하도록 권장합니다.",	//ta_intro_Adm
"L2TP 서버 IP 주소",	//bwn_L2TPSIPA
"동작 중인 인터넷 접속 정책이 없습니다. 모든 사용자들이 인터넷에 접속할 수 있습니다. ",	//GW_INET_ACCESS_UNRESTRICTED
"(GMT-05:00) Bogota, Lima, Quito ",	//up_tz_11
"설정 안 함",	//_disabled
"로그가 가득차서 이메일을 전송합니다. ",	//GW_LOG_EMAIL_ON_LOG_FULL
"7 am ",	//tt_time_8
"연결",	//ddns_connecting
"Allows Windows Media Player, using MMS protocol, to receive streaming media from the internet. ",	//help43
"Stateful inspection ",	//help701
"Typically PPTP connections are not always on. The D-Link router allows you to set the reconnection mode. The settings are: ",	//help282
"접근제어",	//aa_EAC
"On Log Full ",	//te_OnFull
"Apr ",	//tt_Apr
"날짜 또는 시간이 잘못되었습니다. ",	//tt_alert_invlddt
"Half-duplex ",	//help542
"(Mbit/s) ",	//bwl_MS
"마법사를 사용하시면 공유기를 인터넷에 쉽게 연결할 수 있습니다. ",	//wwa_intro_wel
"A system of worldwide networks which use TCP/IP to allow for resources to be accessed from computers around the world ",	//help570
"DMZ: A single computer or group of computers that can be accessed by both users on the Internet as well as users on the Local Network, but that is not protected by the same security as the Local Network. ",	//help489
"원격지 관리 포트가 충돌됩니다. ",	//tool_admin_portconflict
"응용프로그램 이름",	//gw_SelVS
"To install a more recent version of a software or firmware product ",	//help723
"항상",	//bwn_RM_0
"<strong>Edit</strong> 버튼을 눌러 규칙 리스트를 수정하십시오. ",	//hhai_edit
"보내는 메일(SMTP)",	//te_FromEm
"%v 로부터의 요청 시간 ",	//NET_RTC_REQUEST_TIME
"Enter a password for the user &quot;admin&quot;, who will have full access to the Web-based management interface. ",	//help824
"N/A ",	//N_A
"PPTP Subnet Mask",	//help279
"Kilobyte ",	//help593
"A time during processes when something causes the process to slowdown or stop all together ",	//help447
"사용 ",	//bwl_VS_1
"Soldier of Fortune II: Double Helix ",	//gw_gm_48
"Confirm updated firmware revision on status page. ",	//help882
"(GMT+03:00) Tehran ",	//up_tz_41
"NVRAM 에서 설정 파일 불러오기 ",	//RUNTIME_CONFIG_LOADED_CONFIG_FROM_NVRAM
"세션이 종료되었습니다. 다시 시작하십시오. ",	//li_alert_1
"The IP address of your router on the local area network. Your local area network settings are based on the address assigned here. For example, 192.168.0.1. ",	//help307
"System Logger -- a distributed logging interface for collecting in one place the logs from different sources. Originally written for UNIX, it is now available for other operating systems, including Windows. ",	//help705
"Connecting to a Local Area Network over one of the 802.11 wireless standards ",	//help755
"A connection to the Internet is made as needed. ",	//help273
"PlayStation2 ",	//gw_gm_81
"장비를 공장 초기 설정으로 리셋하시겠습니까? ",	//up_rb_4
"Newer Firmware Version %d.%d for your %s %s router is now available at",	//NEWER_FW_VERSION
"PPTP 인터넷 연결 유형",	//bwn_PPTPICT
"펌웨어 업그레이드 이미지 업로드가 성공하였습니다. - 설치중 ",	//GW_UPGRADE_SUCCEEDED
"H.323 ",	//_H323
"The rule applies to a flow of messages whose WAN-side port number is within the range set here. ",	//help96
"(SSID로 불림)",	//bwl_AS
"무선 채널",	//_wchannel
"네트워크 키를 직접 할당하십시오. ",	//wwz_manual_key
"무선 장비에 push 버튼을 누른 후,  120초 안에 아래의 '연결' 버튼을 누르십시오.  ",	//wps_p3_5
"LPD/LPR 프린팅 설정",	//tps_enlpd
"To provide credentials, like a Password, in order to verify that the person or device is really who they are claiming to be ",	//help427
"L2TP ",	//_L2TP
"DHCP IP 주소 범위 ",	//bd_DIPAR
"상세 통계 정보 ",	//_stats
"8 ~ 64 자(WPA 키 길이가 길수록 보안이 더 강화됩니다.)  ",	//wwl_s4_intro_za2
"L2TP 로컬 세션 0x%04X이  다운되었습니다. ",	//IPL2TP_SESSION_DOWN
"To unscramble an encrypted message back into plain text ",	//help485
"Go to the Start menu, select Run, type in <code>winipcfg</code>, and hit Enter. A popup window will be displayed. Select the appropriate adapter from the pull-down menu and you will see the Adapter Address. This is the MAC address of the device. ",	//help338
"동적 IP(DHCP) 인터넷 연결 종류  ",	//bwn_DIAICT
"Enter the LAN IP address of the Syslog Server. ",	//help859
"Dynamic Host Configuration Protocol: Used to automatically assign IP addresses from a predefined pool of addresses to computers or devices that request them ",	//help490
"추가",	//_add
"접속 제어",	//_acccon
"DNS 이름을 확인할 수 없습니다. 이름이 정확하지 확인하십시오. ",	//tsc_pingt_msg4
"연결이 끊겼습니다. ",	//ddns_disconnect
"비밀번호 확인 ",	//_verifypw
"MAC 필터링 설정 ",	//am_intro_2
"정책 추가",	//_aa_pol_add
"Click <span class='button_ref'>Save</span> to add the settings to the Virtual Servers List ",	//help11
"Warcraft II ",	//gw_gm_59
"HTTP over SSL is used to encrypt and decrypt HTTP transmissions ",	//help555
"시스템",	//_system
"This option is normally turned off, and should remain off as long as the WAN-side DHCP server correctly provides an IP address to the router. However, if the router cannot obtain an IP address from the DHCP server, the DHCP server may be one that works better with unicast responses. In this case, turn the unicasting option on, and observe whether the router can obtain an IP address. In this mode, the router accepts unicast responses from the DHCP server instead of broadcast responses. ",	//help261a
"설정 변경으로 경고가 생성되었습니다. ",	//KR111
"&quot;Ping&quot;으로 PC 가 동작하는지 응답하는 지등을 확인합니다. ",	//hhtsc_pingt_intro
"(GMT-10:00) Hawaii ",	//up_tz_02
"Name the Virtual Server (for example: <code>Web Server</code>) ",	//help5
"Support Menu ",	//help767s
"Splinter Cell: Pandora Tomorrow ",	//gw_gm_45
"사용자명 / 비밀번호 연결 (PPPoE)",	//wwa_wanmode_pppoe
"Collision ",	//help462
"한 PC에서 몇 가지 응용프로그램을 사용하기 위해 수신 포트를 중첩해서 사용할 수도 있는데, 잠재적으로 충돌이 일어 날 수 있으므로 두 개의 포트 포워딩 규칙을 사용할 수 없습니다.",	//haf_dmz_60
"이메일 기능으로 시스템 로그 파일, 공유기 경고 메시지, 펌웨어 업데이트 공지 등을 관리자 이메일 주소로 전송합니다. ",	//te_intro_Em
"VPN: A secure tunnel over the Internet to connect remote offices or users to their company's network ",	//help732
"보안 기능을 활성화 하지 않을 경우, 이 옵션을 선택하십시오. ",	//wwl_text_none
"Enter the username or key provided by your service provider. If the Dynamic DNS provider supplies only a key, enter that key in all three fields. ",	//help895
"Typically PPPoE connections are not always on. The D-Link router allows you to set the reconnection mode. The settings are: ",	//help269
"Kbyte ",	//help592
"on-demand WAN 연결을 다시 하도록 시도 ",	//GW_WAN_RECONNECT_ON_ACTIVE
"A device that allows you to connect a computer up to a coaxial cable and receive Internet access from your Cable provider ",	//help455
"장비",	//aa_Machine
"The fifth layer of the OSI model which coordinates the connection and communication between applications on both ends ",	//help685
"Wed ",	//_Wed
"7 pm ",	//tt_time_20
"Dest IP<br />Start",	//aa_FPR_c3
"Enter the TCP ports to open (for example <code>6159-6180, 99</code>). ",	//help68
"계정",	//te_Acct
"It is most useful to prevent unauthorized wireless devices from connecting to your network. ",	//help150
"Many web sites construct pages with images and content from other web sites. Access will be forbidden if you do not enable all the web sites used to construct a page. For example, to access <code>my.yahoo.com</code>, you need to enable access to <code>yahoo.com</code>, <code>yimg.com</code>, and <code>doubleclick.net</code>. ",	//help146
"SMTP 클라이언트가 성공적으로 이메일을 전송하였습니다. ",	//IPSMTPCLIENT_MSG_SENT
"Quake 3 ",	//gw_gm_38
"1 am ",	//tt_time_2
"This option works with a RADIUS Server to authenticate wireless clients. Wireless clients should have established the necessary credentials before attempting to authenticate to the Server through this Gateway. Furthermore, it may be necessary to configure the RADIUS Server to allow this Gateway to authenticate users. ",	//help384
"자동 업링크 속도",	//at_AUS
"<strong>Delete</strong> 버튼을 눌러 스케쥴을 완전히 삭제하십시오. ",	//hhts_del
"The preference given to outbound packets of this conversation by the QoS Engine logic. Smaller numbers represent higher priority. ",	//help818
"Firmware upgrade cannot be performed from a wireless device. To perform an upgrade, ensure that you are using a PC that is connected to the router by wire. ",	//help886
"Point-to-Point Protocol is used for two computers to communicate with each over a serial interface, like a phone line ",	//help655
"A data frame by which one of the stations in a Wi-Fi network periodically broadcasts network control data to other wireless stations. ",	//help439
"구분할 수 있는 정책 이름을 선택하십시오. ",	//_aa_wiz_s2_msg
"Select the protocol used by the Internet traffic coming back into the router through the opened port range (for example <code>Both</code>). ",	//help52
"초 …",	//wps_KR46
"최대 32자까지 네트워크 이름을 부여하십시오. ",	//wwz_wwl_intro_s3_1
"DDNS 기능으로 구매한 도메인 이름(www.whateveryournameis.com)을 사용하여 유동 IP 주소로 서버(WEB, FTP, 게임서버 등) 호스팅이 가능합니다. 대부분의 인터넷 서비스 공급업체(ISP)는 유동 IP 주소를 사용합니다. DDNS 서비스 공급업체를 사용하여, 실제 서버가 가지고 있는 IP 주소와 상관 없이 등록한 호스트 이름을 입력하여 내부 서버에 접속할 수 있습니다.",	//td_intro_DDNS
"Ghost Recon ",	//gw_gm_19
"(GMT+07:00) Bangkok, Hanoi, Jakarta ",	//up_tz_53
"DST Start and DST End ",	//help845
"Used to transmit and receive RF signals. ",	//help416
"(GMT+06:00) Sri Jayawardenepura ",	//up_tz_51
"대체방법으로, 프린터 제조업체 웹사이트에서 다운로드 받은 드라이버 실행파일을 PC에서 직접 실행할 수 있습니다. ",	//wprn_s3d
"CHAP 인증 실패 - 로그인 상세 정보를 확인하십시오. ",	//IPPPPCHAP_AUTH_FAIL
"로그 엔트리",	//KR109
"Tiberian Sun ",	//gw_gm_52
"Uniform Resource Locator is a unique address for files accessible on the Internet ",	//help726
"Blocked TCP packet from %v:%u to %v:%u as control %s in not valid  ",	//IPNAT_TCP_BAD_FLAGS
"이름",	//_name
"Enter the local network IP address of the system hosting the server, for example <code>192.168.0.50</code>. ",	//help66
"Blocked incoming ICMP error message (ICMP type %u) from %v to %v as there is no UDP session active between %v:%u and %v:%u  ",	//IPNAT_UDP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
"FTP ALG가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//IPFTPALG_REJECTED_PACKET
"SNMP ",	//help692
"PC에서 웹사이트 접속이 거부되었습니다. ",	//fb_p_1
"연결 유형 ",	//_contype
"The port that you will use to address the management interface from the Internet. For example, if you specify port 1080 here, then, to access the router from the Internet, you would use a URL of the form: <code>http://my.domain.com:1080/</code>. ",	//help829
"응용프로그램 규칙",	//_specappsr
"The Invisible option allows you to hide your wireless network. When this option is set to Visible, your wireless network name is broadcast to anyone within the range of your signal. If you're not using encryption then they could connect to your network. When Invisible mode is enabled, you must enter the Wireless Network Name (SSID) on the client manually to connect to the network. ",	//help353
"Halo: Combat Evolved ",	//gw_gm_23
"Always Broadcast ",	//help325
"Host ",	//help550
"재연결 모드",	//bwn_RM
"로그 옵션",	//sl_LogOps
"All of your Internet and network connection details are displayed on the Device Info page. The firmware version is also displayed here. ",	//help772
"로그 상세정보",	//sl_LogDet
"방법",	//_aa_method
"This is a relative measure of signal quality. The value is expressed as a percentage of theoretical best quality. Signal quality can be reduced by distance, by interference from other radio-frequency sources (such as cordless telephones or neighboring wireless networks), and by obstacles between the router and the wireless device. ",	//help788
"계속",	//_continue
"Retransmits the signal of an Access Point in order to extend it's coverage ",	//help669
"The wireless section is used to configure the wireless settings for your D-Link router. Note that changes made in this section may also need to be duplicated on wireless clients that you want to connect to your wireless network. ",	//help349
"The Statistics page displays all of the LAN, WAN, and Wireless packet transmit and receive statistics. ",	//help804
"장비 정보",	//_devinfo
"예",	//_yes
"SSID ",	//help699
"(GMT+09:00) Yakutsk ",	//up_tz_62
"In this section you can add entries to the Schedule Rules List below or edit existing entries. ",	//help192
"DMZ 설정 ",	//af_ED
"속도 필요",	//gw_gm_31
"A connection to the Internet is always maintained. ",	//help271
"Allows multiple machines on the LAN to connect to their corporate networks using PPTP protocol. ",	//help33
"Blocked incoming TCP packet from %v:%u to %v:%u with unexpected acknowledgement %lu (expected %lu to %lu)",	//IPNAT_TCP_BLOCKED_INGRESS_BAD_ACK
"지정된 호스트로 핑 시작 ",	//htsc_pingt_p
"The amount of data that can be transferred in a given time period ",	//help714
"프린터 상태 확인",	//wprn_cps
"(GMT+05:00) Ekaterinburg ",	//up_tz_45
"By default, the router automatically determines whether the underlying connection is an xDSL/Frame-relay network or some other connection type (such as cable modem or Ethernet), and it displays the result as <span class='option'>Detected xDSL or Frame Relay Network</span>. If you have an unusual network connection in which you are actually connected via xDSL but for which you configure either &quot; Static&quot;  or &quot; DHCP&quot; in the WAN settings, setting this option to <span class='option'> xDSL or Other Frame Relay Network</span> ensures that the router will recognize that it needs to shape traffic slightly differently in order to give the best performance. Choosing <span class='option'>xDSL or Other Frame Relay Network</span> causes the measured uplink speed to be reported slightly lower than before on such connections, but gives much better results. ",	//help84
"최신 펌웨어 버전 %d.%02d 을 사용할 수 있습니다. ",	//GW_FW_NOTIFY_FIRMWARE_AVAIL
"RX 패킷이 폐기되었습니다. ",	//ss_RXPD
"포트 트리거 ALG가 %v:%u 에서 %v:%u 로의 TCP 패킷 세션 할당에 실패하였습니다.  ",	//IPPORTTRIGGERALG_TCP_PACKET_ALLOC_FAILURE
"주의: 호스트 이름에 대한 정보가 없으면 가입하신 서비스 공급업체(ISP)에서 확인하십시오.",	//wwa_note_hostname
"Digital Subscriber Line. High bandwidth Internet connection over telephone lines ",	//help504
"동작",	//ai_Action
"공장 초기값으로 설정 복구",	//RUNTIME_CONFIG_RESET_CONFIG_TO_FACTORY_DEFAULTS
"프린터가 검색되지 않았습니다. ",	//sps_nopr
"Fri ",	//_Fri
"시간  ",	//gw_hours
"LPD/LPR 프린팅",	//tps_lpd
"펌웨어 업그레이드",	//tf_FWUg
"Battlefield 1942 ",	//gw_gm_4
"10Mbps ",	//anet_wp_0
"Uses a randomly selected 56-bit key that must be known by both the sender and the receiver when information is exchanged ",	//help469
"Both of these options select some variant of Wi-Fi Protected Access (WPA) -- security standards published by the Wi-Fi Alliance. The <span class='option'>WPA Mode</span> further refines the variant that the router should employ. ",	//help373
"일광 절약 시간 오프셋 ",	//tt_dsoffs
"A card installed in a computer or built onto the motherboard that allows the computer to connect to a network ",	//help629
"자동으로 네트워크 키 할당(권장) ",	//wwz_auto_assign_key
"무선 랜카드 정보를 확인하시려면 랜카드 설명서를 참고하십시오. ",	//wwl_s3_note_1
"Doom 3 ",	//gw_gm_15
"<strong>Save</strong> 버튼을 눌러 아래 리스트에 스케쥴을 완성하십시오. ",	//hhts_save
"자동 감지 ",	//at_Auto
"LED ",	//help597
"Place a checkmark in the boxes for the desired days or select the All Week radio button to select all seven days of the week. ",	//help194
"A utility that allows you to view content and interact with all of the information on the World Wide Web ",	//help746
"주소 종류",	//aa_AT
"Ubi.com ",	//gw_gm_71
"BigPond 실패,  자세한 사항을 로그에서 확인하십시오. ",	//BIGPOND_FAILED
"Step 3 - 정책을 적용할 장비 선택 ",	//aa_wiz_s1_msg3
"The time between periodic updates to the Dynamic DNS, if your dynamic IP address has not changed. The timeout period is entered in hours. ",	//help898
"PPTP 서버 IP 주소",	//bwn_PPTPSIPA
"Wireless Fidelity ",	//help749
"라우팅",	//_routing
"네트워크에 허용 또는 거부할 MAC 주소 리스트를 생성하십시오. ",	//hham_intro
"The second layer of the OSI model. Controls the movement of data on the physical link of a network ",	//help471
"수신 필터 옵션은 인터넷에서 수신되는 데이터를 제어하는 수단입니다. 이 기능으로, IP 주소 범위에 따른 데이터를 제어하는 수신 데이터 필터링 규칙을 설정할 수 있습니다.",	//ai_intro_1
"(GMT+10:00) Vladivostok ",	//up_tz_69
"Step 2: 시간대역 선택 ",	//wwa_title_s2
"HNAP SetAccessPointMode %s returns %s, %s",	//GW_PURE_SETACCESSPOINTMODE
"현재 시스템 설정을 로컬 하드 드라이버에 파일로 저장할 수 있습니다. 저장된 파일이나 장비에서 생성된 설정은 장비에 업로드 할 수 있습니다. ",	//tss_intro2
"Sending voice information over the Internet as opposed to the PSTN ",	//help736
"(GMT-03:00) Buenos Aires, Georgetown ",	//up_tz_19
"If you select this option, the router automatically finds the channel with least interference and uses that channel for wireless networking. If you disable this option, the router uses the channel that you specify with the following <span class='option'>Wireless Channel</span> option. ",	//help354
"The amount of time that it takes a packet to get from the one point to another on a network. Also referred to as delay ",	//help596
"먼저 설정 파일 이름을 입력해야 합니다. ",	//ta_alert_5
"항상 브로드캐스트",	//bd_DAB
"WPA-Enterprise ",	//_WPAenterprise
"(GMT+02:00) Harare, Pretoria ",	//up_tz_34
"프린터",	//sps_pr
"Transmission Control Protocol ",	//help706
"Pre-Shared Key ",	//_psk
"Dynamic DNS ",	//_dyndns
"거부",	//_deny
"Reboot ",	//help664
"Blocked incoming TCP packet from %v:%u to %v:%u as %s is not allowed in state %s",	//IPNAT_TCP_BLOCKED_INGRESS_UNEXP_FLAGS
"Maximum Idle Time: ",	//help276
"to ",	//_to
"IP ",	//aa_AT_0
"Dec ",	//tt_Dec
"(GMT+12:00) Fiji, Kamchatka, Marshall Is. ",	//up_tz_72
"Click the <span class='button_ref'>Browse</span> button to locate the D-Link upgrade file on your computer. ",	//help879
"정책 %s 시작; 확인 되지 않은 모든 시스템의 인터넷 접속 변경 : %s",	//GW_INET_ACCESS_POLICY_START_OTHERS
"A feature of a firewall that monitors outgoing and incoming traffic to make sure that only valid responses to outgoing requests are allowed to pass though the firewall ",	//help702
"호스트에서 응답이 없습니다, 다시 시도… ",	//tsc_pingt_msg11
"이 엔트리를 삭제하시겠습니까?",	//up_ae_de_1
"This area of the screen continually updates to show all DHCP enabled computers and devices connected to the LAN side of your router. The detection &quot; range&quot;  is limited to the address range as configured in DHCP Server. Computers that have an address outside of this range will not show. If the DHCP Client (i.e. a computer configured to &quot; Automatically obtain an address&quot; ) supplies a Host Name then that will also be shown. Any computer or device that has a static IP address that lies within the detection &quot; range&quot;  may show, however its host name will not. ",	//help781
"Enter the MAC address of the desired. ",	//help161_2
"6 pm ",	//tt_time_19
"MAC 필터링 설정: ",	//am_intro
"The number of transmission failures that cause loss of a packet. ",	//help811
"중간 ",	//aw_TP_1
"(GMT) Casablanca, Monrovia ",	//up_tz_24
"WISP ",	//help756
"이 옵션을 사용하여 무선 공유기에 연결되어 있는 무선 클라이언트를 확인할 수 있습니다. ",	//sw_intro
"LPD/LPR 프린팅 프로토콜은 프린터와 통신하기 위해서 고정 IP 주소와 큐를 사용합니다. ",	//tps_lpd1
"and ",	//help257
"Closed -- The connection is no longer active but the session is being tracked in case there are any retransmitted packets still pending. ",	//help819_8
"(초)",	//bws_secs
"포트 포워딩",	//PORT_FORWARDING
"Blocked outgoing ICMP packet (ICMP type %u) from %v to %v ",	//IPNAT_ICMP_BLOCKED_EGRESS_PACKET
"Internet Protocol ",	//help573
"A group of computers in a building that usually access files from a server ",	//help601
"시",	//tt_Hour
"유동 IP (DHCP)",	//bwn_Mode_DHCP
"Enter the IP addresses of the DNS Servers. Leave the field for the secondary server empty if not used. ",	//help290a
"BigPond 로그 아웃 ",	//BIGPOND_LOGGING_OUT
"DMZ(Demilitarized Zone)기능으로 PC를 공유기의 외부에 두는 것처럼 설정할 수 있습니다. 공유기 밑에서 제대로 동작하지 않는 응용프로그램이 있는 경우, 인터넷 접속을 제한을 받진 않는 DMZ 구간에 PC를 두십시오.",	//af_intro_1
"1차 DNS 서버",	//_dns1
"인터넷에서 멀티캐스트 스트림 수신에 문제가 있는 경우, 멀티캐스트 스트림 옵션이 설정되어 있는지 확인하십시오. ",	//hhan_mc
"도구",	//_tools
"연결이 끊어졌습니다. ",	//_sdi_s2
"USB 포트",	//sps_usbport
"스케쥴 %s 할당시 시스템 에러가 발생하였습니다. ",	//GW_SCHED_ALLOC_FAILED
"Prevent all WAN users from accessing the related capability. (LAN users are not affected by Inbound Filter Rules.) ",	//help179
"일광 절약 시간 설정 ",	//tt_dsen2
"허용",	//_allow
"Oct ",	//tt_Oct
"Select the level of events that you want to view. ",	//help798
"WAN 포트 속도",	//anet_wan_phyrate
"주의",	//_note
"Dest<br />Port<br />Start ",	//aa_FPR_c6
"UDP Ports To Open ",	//help69
"DHCP 대여 기간",	//bd_DLT
"디링크 인터넷 연결 설정 마법사에 오신것을 환영합니다. ",	//wwa_title_wel
"LAN 인터페이스가 연결되었습니다. ",	//GW_LAN_INTERFACE_UP
"수신 필터 규칙 리스트 ",	//ai_title_IFRL
"로그",	//_logs
"관리자 요청으로 로그 이메일 전송 ",	//GW_LOG_EMAIL_ON_USER_REQUEST
"MAC 필터링 비활성화  ",	//am_FM_2
"The port that will be accessed from the Internet. ",	//help21
"802.11 Mode ",	//bwl_Mode
"주소 모드",	//bwn_AM
"BigPond 서버",	//bwn_BPS
"가입하신 인터넷 서비스 공급업체(ISP)에서 제공한 정보를 입력하십시오. ",	//_ispinfo
"속도",	//_rate
"Your D-Link router, by default, has a static IP address of 192.168.0.1. This means that addresses 192.168.0.2 to 192.168.0.254 can be made available for allocation by the DHCP Server. ",	//help321
"(GMT-07:00) Mountain Time (US/Canada) ",	//up_tz_06
"자녀 보호 서비스 ",	//_bsecure_parental_serv
"성공",	//_success
"사용자명과 비밀번호 연결 설정(L2TP)",	//wwa_set_l2tp_title
"Step 1: 디링크 무선 보안 설정 마법사에 오신 것을 환영합니다. ",	//wwz_wwl_title_s3
"Mac OS X ",	//help342
"Select this option if your ISP requires you to use a PPPoE (Point to Point Protocol over Ethernet) connection. DSL providers typically use this option. This method of connection requires you to enter a <span class='option'>Username</span> and <span class='option'>Password</span> (provided by your Internet Service Provider) to gain access to the Internet. ",	//help265
"핑 수신:",	//tsc_pingt_msg101
"SMTP (Email) 서버 %s 는 IP 주소 %v 에 있습니다. ",	//GW_SMTP_EMAIL_RESOLVED_DNS
"RADIUS 서버 포트",	//bws_RSP
"세션 계층",	//help684
"PPPoE 연결 완료 시도 ",	//PPPOE_EVENT_CONNECT
"시간 자동 설정 ",	//tt_auto
"RSA ",	//help678
"PPTP 서브시스템 자원이 낮습니다. 연결에 영향을 받을 수 있습니다. ",	//PPTP_EVENT_LOW_RESOURCES_TO_QUEUE
"L2TP 로컬 터널 0x%04X이 예상밖의 제어 메시지를 수신했습니다.(무시)",	//IPL2TP_TUNNEL_UNEXPECTED_MESSAGE
"Neverwinter Nights ",	//gw_gm_34
"5th ",	//tt_week_5
"Wi-Fi Protected Access. A Wi-Fi security enhancement that provides improved data encryption, relative to WEP. ",	//help760
"아래는 무선 보안 설정의 상세 내용을 요약한 것입니다. 이 페이지를 인쇄하거나 기록하여 PC의 무선 랜카드에 정확한 정보를 설정하십시오. ",	//wwl_intro_end
"정책 테이블",	//aa_Policy_Table
"시간 설정",	//tt_TimeConf
"None ",	//_none
"A device that protects resources of the Local Area Network from unauthorized users outside of the local network ",	//help524
"Gigabit Ethernet ",	//help536
"Step 2: 스케쥴 선택",	//_aa_wiz_s3_title
"A pass-phrase that must match with the authentication server. ",	//help392
"스케쥴에 맞게 로그 이메일 전송 ",	//GW_LOG_EMAIL_ON_SCHEDULE
"Domain name",	//help499
"Internet Group Management Protocol is used to make sure that computers can report their multicast group membership to adjacent routers ",	//help562
"계신 곳의 적절한 표준 시간대를 선택하십시오. 이 정보는 공유기의 시간 기반 옵션들을 설정할 때 꼭 필요합니다. ",	//wwa_intro_s2
"PPTP 게이트웨이 IP 주소",	//_PPTPgw
"MMS ALG 가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//IPMMSALG_REJECTED_PACKET
"무선 설정",	//_wirelesst
"인터넷 연결을 설정하는 방법에는 두 가지가 있습니다: 웹기반 인터넷 연결 설정 마법사를 사용하시거나 직접 연결을 설정할 수 있습니다. ",	//int_intro
"WCN ",	//help741
"A standard that provides consistency of voice and video transmissions and compatibility for videoconferencing devices ",	//help541
"MAC 주소가 %m 인 LAN 시스템의 접속이 거부되었습니다. ",	//GW_LAN_ACCESS_DENIED
"잘못된 네트워크 인터페이스(IP address spoofing)로 수신된 %v 에서 %v 로의 패킷이 차단되었습니다. ",	//GW_NAT_REJECTED_SPOOFED_PACKET
"User Datagram Protocol ",	//help717
"%v 에서 %v 로의 수신 GRE 패킷 차단",	//PPTP_ALG_GRE_BLOCKED_INGRESS
"Jedi Knight II: Jedi Outcast ",	//gw_gm_26
"(GMT+01:00) West Central Africa ",	//up_tz_30
"스케쥴",	//_sched
"Starcraft ",	//gw_gm_49
"FAT 장치 마운트에 실패하였습니다. ",	//IPFAT_MOUNT_FAILED
"Here are displayed the version numbers of the firmware currently installed in your router and the most recent upgrade that is available. ",	//help883
"KALI ",	//gw_gm_75
"Layer 2 Tunneling Protocol ",	//help604
"설정 파일을 업로드 하는 동안 잠시만 기다려 주십시오. ",	//ta_alert_6
"정책 %s 시작; IP 주소 %v 의 인터넷 접속이 변경되었습니다.: %s",	//GW_INET_ACCESS_POLICY_START_IP
"10 pm ",	//tt_time_23
"Displays the time currently maintained by the router. If this is not correct, use the following options to configure the time correctly. ",	//help841a
"포트 포워딩 규칙 ",	//ag_title_4
"Unicast ",	//help718
"Computer on a network ",	//help551
"Blocked outgoing TCP packet from %v:%u to %v:%u as %s is not allowed in state %s  ",	//IPNAT_TCP_BLOCKED_EGRESS_UNEXP_FLAGS
"WinMX ",	//gw_gm_68
"Internet Service Provider ",	//help577
"Host Name ",	//help260
"FIN Wait -- The client system has requested that the connection be stopped. ",	//help819_4
"If all of the wireless devices you want to connect with this router can connect in the same transmission mode, you can improve performance slightly by choosing the appropriate &quot; Only&quot;  mode. If you have some devices that use a different transmission mode, choose the appropriate &quot; Mixed&quot; mode. ",	//help357
"TCP ",	//_TCP
"Converting data into cyphertext so that it cannot be easily read ",	//help515
"UPnP(Universal Plug and Play)는 네트워크 장치의 PC 대 PC 플러그 앤 플레이를 지원합니다. ",	//anet_msg_upnp
"자동 시간 설정 또는 직접 시간 설정 중 한 가지를 선택해 주십시오. (둘 다는 선택할 수 없음) ",	//tt_alert_1only
"Clicking the <span class='button_ref'>DHCP Release</span> button unassigns the router's IP address. The router will not respond to IP messages from the WAN side until you click the <span class='button_ref'>DHCP Renew</span> button or power-up the router again. Clicking the <span class='button_ref'>DHCP Renew</span> button causes the router to request a new IP address from the ISP's server. ",	//help776
"Here you can enable or disable ALGs. Some protocols and applications require special handling of the IP payload to make them work with network address translation (NAT). Each ALG provides special handling for a specific protocol or application. A number of ALGs for common applications are enabled by default. ",	//help32
"Asheron's Call ",	//gw_gm_3
"The number of seconds of idle time until the router considers the session terminated. ",	//help823
"L2TP IP 주소",	//_L2TPip
"시스템 재부팅 ",	//_reboot
"무선 네트워크에 무선 장치를 추가하는 방법에는 두 가지가 있습니다. ",	//wps_p3_1
"RJ-45 ",	//help674
"Step 3: 요청이 있으면, 프린터 드라이버 CD를 삽입하십시오. ",	//wprn_intro5
"Sentinel 보안 서비스 ",	//_bsecure_security_serv
"Sending data from one device to many devices on a network ",	//help621
"AES. Government encryption standard ",	//help412
"수신",	//tsc_pingt_msg8
"Typically L2TP connections are not always on. The D-Link router allows you to set the reconnection mode. The settings are: ",	//help286
"Unreal Tournament",	//gw_gm_56
"펌웨어 업그레이드 설정 섹션에서 성능과 기능을 향상시킨 가장 최신 펨웨어를 업데이트 할 수 있습니다. ",	//tf_intro_FWU
"(GMT+08:00) Kuala Lumpur, Singapore ",	//up_tz_57
"(GMT-12:00) Eniwetok, Kwajalein ",	//up_tz_00
"제한된 포트와 주소 ",	//af_EFT_2
"스케쥴은 그 기능들이 동작하도록 지정된 경우 여러 다른 기능들과 함께 사용됩니다. ",	//hhts_intro
"Throughput ",	//help713
"인증",	//_auth
"재시도 후 시간 동기화에 실패하였습니다… 중단 ",	//NET_RTC_SYNCHRONIZATION_FAILED_AFTER_RETRIES
"L2TP 로컬 터널 0x%04X 이 끊어집니다. ",	//IPL2TP_TUNNEL_DISCONNECTING
"스케쥴 규칙 리스트 ",	//tsc_SchRuLs
"펌웨어 버전",	//sd_FWV
"Enabling WMM can help control latency and jitter when transmitting multimedia content over a wireless connection. ",	//help188_wmm
"Used for sending and receiving email ",	//help687
"Infrastructure ",	//help567
"Optional Backup RADIUS Server ",	//help396
"설정 저장",	//ta_SavConf
"Microsoft Point-to-Point Encryption is used to secure data transmissions over PPTP connections ",	//help618
"This option restores all configuration settings back to the settings that were in effect at the time the router was shipped from the factory. Any settings that have not been saved will be lost. If you want to save your router configuration settings, use the Save Settings option above. ",	//help876
"This option uses Wi-Fi Protected Access with a Pre-Shared Key (PSK). ",	//help380
"2차 DNS 주소",	//wwa_sdns
"The amount of bits that pass in given amount of time ",	//help441
"네트워크 필터",	//_netfilt
"Data ",	//help466
"로그인",	//li_Login
"Days ",	//gw_days
"WAN 이 이미 연결되었습니다. ",	//WAN_ALREADY_CONNECTED
"SMTP ",	//gw_vs_5
"WPA2 Only ",	//bws_WPAM_3
"Demilitarized zone ",	//help488
"비밀 번호 또는 키(Key)",	//td_PWK
"가상 서버 종류 ",	//tool_admin_vsname
"(GMT+06:00) Astana, Dhaka ",	//up_tz_50
"시작 시간 ",	//tsc_StrTime
"가장 짧은 핑 시간 (밀리세컨드):",	//tsc_pingt_msg104
"Kilobits per second ",	//help591
"프린터 장치 ID 에러 ",	//wprn_iderr
"무선 장치를 직접 설정할 수 있도록 현재 무선 설정을 이 옵션에서 확인할 수 있습니다. ",	//wps_KR42
"타임아웃",	//td_Timeout
"AP. Device that allows wireless clients to connect to it and access the network ",	//help402
"웹필터 적용",	//_aa_apply_web_filter
"Quality of Service ",	//help661
"설정하지 않은 상태로 리셋",	//resetUnconfiged
"게임",	//GAMING
"8 am ",	//tt_time_9
"DMZ ",	//help495
"WAN 인터페이스가 살았습니다. IP 주소 %v 와 디폴트 게이트웨이 %v 로 인터넷 연결이 이루어졌습니다. ",	//GW_WAN_INTERFACE_UP
"%v 에서 %v 로 (IP 프로토콜 %u) 수신 패킷이 차단되었습니다. ",	//IPNAT_BLOCKED_INGRESS
"공유기 IP 주소",	//_ripaddr
"타임아웃",	//sa_TimeOut
"Blocked outgoing TCP packet from %v:%u to %v:%u with unexpected sequence %lu (expected %lu to %lu)  ",	//IPNAT_TCP_BLOCKED_EGRESS_BAD_SEQ
"ISP ",	//help587
"LAN 인터페이스가 다운되었습니다. ",	//GW_LAN_INTERFACE_DOWN
"Depending on whether the WAN connection is currently established, you can click either the <span class='button_ref'>Connect</span> to attempt to establish the WAN connection or the <span class='button_ref'>Disconnect</span> to break the WAN connection. ",	//help778
"큐 이름",	//sps_qname
"Preamble ",	//help658
"초",	//_seconds
"IP 주소 %v 에 의해 로그가 삭제되었습니다. ",	//GW_LOGS_CLEARED
"경고",	//sl_Warning
"사용하고 계신 무선 장치가 WPS(Wi-Fi Protected Setup)를 지원하는 경우 이 옵션을 선택하십시오. ",	//wps_KR51
"장치 주소 ",	//aa_MAC
"Manual:",	//help274
"짧은 (400ns) 가드 인터벌 사용으로 실제 처리량(throughput)을 향상시킬 수 있습니다. 그러나 무선 주파수 반사의 민감도를 증가시켜 일부 설치 중에 에러률도 증가시킬 수 있습니다.",	//aw_sgi_h1
"%v 에서 %v 로 소스 라우트 된 패킷이 차단되었습니다. ",	//IPSTACK_REJECTED_SOURCE_ROUTED_PACKET
"Upgrade ",	//help722
"Use this option to restore previously saved router configuration settings. ",	//help834
"1차 DNS 주소",	//wwa_pdns
"Sun ",	//_Sun
"동적 DHCP 클라이언트 수 ",	//bd_title_clients
"네트워크에 접속하는 외부 침입자를 방지하기 위해, 공유기는 WEP 또는 WPA 키를 자동으로 할당할 것입니다. ",	//wwz_auto_assign_key2
"무선 클라이언트 수",	//sw_title_list
"(GMT-04:00) Caracas, La Paz ",	//up_tz_15
"Decibels relative to one milliwatt ",	//help483
"Once your D-Link router is properly configured and this option is enabled, the DHCP Server will manage the IP addresses and other network configuration information for computers and other devices connected to your Local Area Network. There is no need for you to do this yourself. ",	//help316
"L2TP 서버 연결 시도",	//IPL2TP_TUNNEL_CONNECTING
"시간이 동기화되었습니다. ",	//NET_RTC_SYNCHRONIZED
"SPI 설정 ",	//af_ES
"(GMT-06:00) Saskatchewan ",	//up_tz_10
"On demand",	//bwn_RM_1
"%v 에서 %v 로 수신 GRE 패킷이 차단되었습니다. ",	//IPSEC_ALG_ESP_BLOCKED_INGRESS
"로그인 되어 있지 않습니다. 윈도우 브라우저를 새로 고침 하십시오. ",	//NOT_LOGGED_IN_PLEASE_REFRESH
"계속",	//ub_continue
"사용자명 또는 키 ",	//td_UNK
"PV%d 장비 마운트에 실패하였습니다. ",	//IPPMVM_MOUNT_FAILED
"Rise of Nations ",	//gw_gm_42
"1 주 내내",	//tsc_AllWk
"가상 서버",	//_virtserv
"The Virtual Server option gives Internet users access to services on your LAN. This feature is useful for hosting online services such as FTP, Web, or game servers. For each Virtual Server, you define a public port on your router for redirection to an internal LAN IP Address and LAN port. ",	//help2
"Select this option if you want logs to be sent by email when the log is full. ",	//help869
"RIP ",	//help670
"LCP 로컬 옵션 설정 :  ACCM: %lx, ACFC: %u, PFC: %u, MRU: %u",	//IPPPPLCP_SET_LOCAL_OPTIONS
"Wi-Fi Protected Access ",	//help750
"시스템 재부팅 ",	//ts_rd
"Browser ",	//help452
"IPSec ALG가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//IPSEC_ALG_REJECTED_PACKET
"잠시만 기다려 주십시오. ",	//tsc_pingt_msg3
"MAC 주소가 %m인 무선 시스템이 원인: %s 으로 연결이 끊겼습니다. ",	//GW_WIRELESS_DEVICE_DISCONNECTED
"To input the MAC address of your system, enter it in manually or connect to the D-Link router's Web-Management interface from the system and click the <span class='button_ref'>Copy Your PC's MAC Address</span> button. ",	//help333
"Wireless Radio ",	//sd_WRadio
"허용, 웹사이트 - %s%s, 포트 - %s",	//ALLOWED_WEB_SITES
"BitTorrent ",	//gw_sa_1
"Stateful Packet Inspection ",	//help696
"UDP ",	//_UDP
"Putting a computer in the DMZ may expose that computer to a variety of security risks. Use of this option is only recommended as a last resort. ",	//help166
"The Access Control section allows you to control access in and out of devices on your network. Use this feature as Parental Controls to only grant access to approved sites, limit web access based on time or dates, and/or block access from applications such as peer-to-peer utilities or games. ",	//help117
"The router automatically logs (records) events of possible interest in its internal memory. If there is not enough internal memory for all events, logs of older events are deleted, but logs of the latest events are retained. The Logs option allows you to view the router logs. You can define what types of events you want to view and the level of events to view. This router also has internal Syslog Server support so you can send the log files to a computer on your network that is running a Syslog utility. ",	//help795
"L2TP 인터넷 연결 유형",	//bwn_L2TPICT
"No ",	//_no
"(GMT+09:30) Adelaide ",	//up_tz_63
"먼저 펌웨어 이름을 입력해 주십시오. ",	//tf_FWF1
"(GMT+10:00) Brisbane ",	//up_tz_65
"우선순위",	//_priority
"WAN 연결이 이미 끊겼습니다. ",	//WAN_ALREADY_DISCONNECTED
"이 페이지에 저장되지 않는 데이터가 있습니다. 그 데이터를 버리시겠습니까? ",	//up_jt_1
"지정되지 않는 모든 시스템의 인터넷 접속 설정 : %s",	//GW_INET_ACCESS_INITIAL_OTHERS
"시작 주소와 마지막 주소가 WAN 쪽 주소입니다. ",	//hhai_ip
"이 옵션은 &quot;트리거&quot; 포트 또는 포트 범위에서 인터넷으로 데이터를 전송할 때, 공유기에서 단일 또는 복수개의 포트를 여는데 사용됩니다. 스페셜 응용프로그램 규칙이 내부 네트워크의 모든 PC에 적용됩니다.",	//as_intro_SA
"공인 WAN IP 주소로 핑을 하는 것은 공유기의 WAN 주소가 유효한지 아닌지를 확인하기 위해 해커들이 사용하는 일반적인 방법입니다. ",	//anet_wan_ping_1
"(GMT+04:30) Kabul ",	//up_tz_44
"You might have trouble accessing a virtual server using its public identity (WAN-side IP-address of the gateway or its dynamic DNS name) from a machine on the LAN. Your requests may not be looped back or you may be redirected to the &quot; Forbidden&quot; page. ",	//help27
"IPSec (VPN) ",	//as_IPSec
"관리자",	//_admin
"차단",	//BLOCKED
"eDonkey ",	//gw_gm_65
"BigPond Cable (Australia) ",	//wwa_msg_bigpond
"시스템 로그 서버로 로깅 설정",	//tsl_EnLog
"Repeater ",	//help668
"Close Wait -- the server system has requested that the connection be stopped. ",	//help819_5
"낮음 ",	//aw_TP_2
"The maximum amount of bytes or bits per second that can be transmitted to and from a network device ",	//help433
"인증 타임아웃",	//bwsAT_
"설정 완료!",	//_setupdone
"공유기에 로그인 하십시오. ",	//li_intro
"SMTP 클라이언트가 이메일 전송에 실패하였습니다. ",	//IPSMTPCLIENT_MSG_FAILED
"이 마법사들을 실행하기 전에, 제품 박스안에 들어있는 설치 매뉴얼에서 강조한 모든 단계를 따라했는지 확인하시기 바랍니다. ",	//bwz_note_ConWz
"Gnutella ",	//gw_gm_64
"Reconnect Mode: ",	//help268
"A computer on a network that provides services and resources to other computers on the network ",	//help681
"차단되지 않았습니다. ",	//NONE_BLOCKED
"May ",	//tt_May
"Big Pond 인터넷 연결 종류 ",	//bwn_BPICT
"2 pm ",	//tt_time_15
"Tue ",	//_Tue
"통계 정보 삭제 ",	//ss_clear_stats
"Network Time Protocol",	//help632
"ADSL ",	//help409
"The end time is entered in the same format as the start time. The hour in the first box and the minutes in the second box. The end time is used for most other rules, but is not normally used for email events. ",	//help197
"802.11 ",	//help765
"WAN 연결 비활성 상태가 너무 오래 되어 연결을 끊습니다. ",	//GW_WAN_DISCONNECT_ON_INACTIVE
"필터 규칙은 가상 서버, 포트 포워딩, 원격 관리 기능과 할께 사용할 수 있습니다. ",	//ai_intro_3
"고정 IP 주소 연결 설정 ",	//wwa_set_sipa_title
"Application layer ",	//help421
"URL ",	//help725
"(GMT+12:00) Auckland, Wellington ",	//up_tz_71
"ALG는 일부 프로토콜과 응용프로그램의 IP 페이로드를 특별히 처리하여 NAT와 동작할 수 있도록 해 줍니다. 응용프로그램을 사용하는 데 문제가 있는 경우, ALG를 설정하거나 또는 설정을 풀어 보시기 바랍니다.",	//hhaf_alg
"Check this option if your location observes daylight saving time. ",	//help843
"QoS ",	//help660
"공유기의 USB 포트에 연결되어 있는 프린터를 확인하십시오. ",	//wprn_tt11
"트래픽 통계",	//_tstats
"LCP가 원격지 옵션을 설정합니다. : ACCM: %lx, ACFC: %u, PFC: %u, MRU: %u",	//IPPPPLCP_SET_REMOTE_OPTIONS
"Mar ",	//tt_Mar
"(GMT+01:00) Brussels, Copenhagen, Madrid, Paris ",	//up_tz_28
"IPsec provides security at the packet processing layer of network communication ",	//help576
"웹 접속 로그만",	//_aa_allow_all
"사용자명/비밀번호 연결(L2TP)",	//wwa_wanmode_l2tp
"DMZ 호스트",	//_dmzh
"타임서버 %s 는 IP 주소 %v 에 있습니다. ",	//GW_TIME_RESOLVED_DNS
"EAP (802.1x) ",	//bws_EAPx
"정책명",	//aa_PolName
"An updated version of security for wireless networks that provides authentication as well as encryption ",	//help751
"Voice over IP ",	//help735
"인터넷에 연결하기 위해서는 가입하신 인터넷 서비스 공급자(ISP)에서 제공하는 IP 정보 리스트가 필요합니다. 고정 IP를 가지고 있으면서 연결이 이루어지지 않는 경우에는 가입하신 ISP에 확인하시기 바랍니다. ",	//wwa_set_sipa_msg
"WCN 호환 USB 대량 스토리지 인터페이스를 찾을 수 없습니다. ",	//USB_LOG_STORAGE_NOT_FOUND
"Step 1: 정책명을 선택하십시오.",	//_aa_wiz_s2_title
"장비가 초기화되었습니다. ",	//GW_INIT_DONE
"유동 IP",	//carriertype_ct_0
"These are the settings of the LAN (Local Area Network) interface for the router. The router's local network (LAN) settings are configured based on the IP Address and Subnet Mask assigned in this section. The IP address is also used to access this Web-based management interface. ",	//help305
"Raw TCP 포트 프린팅",	//tps_raw
"공인 포트",	//av_PubP
"WPA Mode: ",	//help374
"PPTP가 터널 종료 요청을 받았습니다. 터널을 종료합니다. ",	//PPTP_EVENT_TUNNEL_CLEAR_DOWN_REQUEST
"<strong>Delete</strong> 버튼을 눌러 규칙을 완전히 삭제 하십시오. ",	//hhac_delete
"Access Point",	//help401
"L2TP 로컬 세션 0x%04X 종료",	//IPL2TP_SESSION_CLEAR_DOWN_REQUEST
"정책",	//aa_ACR_c2
"The requests from the LAN machine will not be looped back if Internet access is blocked at the time of access. To work around this problem, access the LAN machine using its LAN-side identity. ",	//help29
"(GMT-11:00) Midway Island, Samoa ",	//up_tz_01
"응용프로그램",	//_app
"LAN 서브넷 마스크가 잘못되었습니다.",	//bln_alert_1
"WAN 속도 측정",	//GW_WAN_RATE_ESTIMATOR_STARTED_ON_WAN
"Firewall &amp; Security ",	//sl_FWandSec
"보안 강화를 위해, WAN Ping 응답 옵션 비활성화를 권장합니다. Ping이 때때로 악의적인 인터넷 사용자에 의해 네트워크나 PC 등의 위치를 파악하는데 사용되기도 하기 때문입니다. ",	//hhan_ping
"NAT ",	//sa_NAT
"원격 관리 설정으로 외부 네트워크상에 있는 PC에서 공유기 설정을 변경할 수 있습니다. ",	//hhta_en
"SMTP (Email) 서버 %s 용 DNS 레코드를 찾을 수 없습니다. ",	//GW_SMTP_EMAIL_FAILED_DNS
"The number of packets that were dropped due to Ethernet collisions (two or more devices attempting to use an Ethernet circuit at the same time). ",	//help810
"Wake-On-LAN ",	//_WOL
"On demand: ",	//help272
"None -- This entry is used as a placeholder for a future connection that may occur. ",	//help819_1
"(GMT-04:00) Atlantic Time (Canada) ",	//up_tz_14
"POP3 ",	//gw_vs_6
"Star Trek: Elite Force II ",	//gw_gm_51
"서버 주소",	//td_SvAd
"포트를 여러 가지 방식으로 입력할 수 있습니다. :",	//hhag_40
"Inbound Filters can be used for limiting access to a server on your network to a system or group of systems. Filter rules can be used with Virtual Server, Gaming, or Remote Administration features. Each filter can be used for several functions; for example a &quot;Game Clan&quot; filter might allow all of the members of a particular gaming group to play several different games for which gaming entries have been created. At the same time an &quot; Admin&quot;  filter might only allows systems from your office network to access the WAN admin pages and an FTP server you use at home. If you add an IP address to a filter, the change is effected in all of the places where the filter is used. ",	//help169
"The amount of time that a computer may have an IP address before it is required to renew the lease. The lease functions just as a lease on an apartment would. The initial lease designates the amount of time before the lease expires. If the tenant wishes to retain the address when the lease is expired then a new lease is established. If the lease expires and the address is no longer needed than another tenant may use the address. ",	//help324
"&quot;Ping&quot;은 목적지 PC에 연속된 메시지를 전송하고 그 결과를 받아서 연결 상태를 확인합니다. PC가 동작하고 있는지, Ping 응답 속도에 따라 커넥션의 질(Quality)을 확인할 수 있습니다. ",	//htsc_intro
"WLAN 분리",	//KR4_ww
"The computers (and other devices) connected to your LAN also need to have their TCP/IP configuration set to &quot;DHCP&quot; or &quot;Obtain an IP address automatically&quot;. ",	//help317
"멀티캐스트 스트림",	//anet_multicast
"Digital certificate: ",	//help491
"Last ACK -- Waiting for a short time while a connection that was in Close Wait is fully closed. ",	//help819_7
"L2TP 로컬 터널 0x%04X RTE 모듈이 중단되었습니다. ",	//IPL2TP_SHUTDOWN_COMPLETE
"새 정책 추가 ",	//_aa_wiz_s1_title
"The number of packets that were dropped while being received, due to errors, collisions, or router resource limitations. ",	//help809
"Select the Protocol (for example <code>TCP</code>). ",	//help9
"로그를 모두 제거하시겠습니까?",	//sl_alert_1
"LAN 이더넷 캐리어가 감지되었습니다. ",	//GW_LAN_CARRIER_DETECTED
"트리거 포트",	//as_TPRange_b
"1st ",	//tt_week_1
"원하시면, 확인을 누르십시오.",	//up_jt_3
"Broadband ",	//help448
"삭제",	//_clear
"PPPoE 세션 0x%04X 종료 ",	//PPPOE_EVENT_DISCONNECT
"고정 IP",	//_sdi_staticip
"Internet Key Exchange is used to ensure security for VPN connections ",	//help566
"Help Glossary ",	//help398
"처음에 인터넷에 연결하였던 PC가 공유기에 연결되었는지를 확인하시기 바랍니다. 맞으면, MAC 복사 버튼을 눌러 PC의 MAC 주소를 공유기에 복사하십시오. ",	//wwa_msg_set_dhcp
"각 스케쥴에 이름을 부여하십시오. 예, 월요일에서 금요일, 오후 3시에서 9시까지를 &quot;방과후&quot; 로 설정. ",	//hhts_name
"Enter a password for the user &quot;user&quot;, who will have read-only access to the Web-based management interface. ",	//help825
"WAN ",	//WAN
"Internetwork Packet Exchange is a networking protocol developed by Novel to enable their Netware clients and servers to communicate ",	//help586
"공유기의 DHCP 서버에서 IP주소를 받은 PC는 DHCP 클라이언트 리스트에 나타납니다. 드랍다운 메뉴에서 장비를 선택한 후 화살표를 눌러 장비의 MAC 주소를 리스트에 추가하십시오. ",	//hham_add
"WAN 통계",	//ss_WANStats
"on-demand WAN 연결 시도 ",	//GW_WAN_CONNECT_ON_ACTIVE
"새로운 스케쥴을 지정하기 위해서는 모든 수정사항을  버리시기 바랍니다. ",	//aa_sched_conf_1
"정책 %s 이 중단되었습니다.: 지정 되지 않은 모든 시스템의 인터넷 연결이 변경되었습니다. : %s",	//GW_INET_ACCESS_POLICY_END_OTHERS
"DHCP 주소 보유 리스트",	//bd_title_list
"웹 접속 로깅",	//_aa_logging
"사용자명",	//_username
"A TCP/IP protocol for transmitting streams of printer data. ",	//help710
"설정",	//_enable
"타임서버 %s 용 DNS 레코드를 찾을 수 없습니다. ",	//GW_TIME_FAILED_DNS
"사용하고 계신 운영체제(OS)에 맞는 프린터 설정을 위해 공유기 박스에 들어 있는 문서를 참조하십시오. ",	//wprn_tt1
"9 pm ",	//tt_time_22
"IP address ",	//help256
"IP 주소 %v 의 인터넷 접속 정책을 설정 할 수 없습니다. ",	//GW_INET_ACCESS_INITIAL_IP_FAIL
"상세 정보",	//_aa_details
"Allows applications that use Real Time Streaming Protocol to receive streaming media from the internet. QuickTime and Real Player are some of the common applications using this protocol. ",	//help36
"The port number of the LAN-side application as viewed by the WAN-side application. ",	//help817
"PPPoE (사용자명 / 비밀번호)",	//bwn_Mode_PPPoE
"Simple Mail Transfer Protocol ",	//help686
"모두 허용",	//_allowall
"리스트 모두 삭제",	//awf_clearlist
"Characters 0-9 and A-F ",	//help547
"이전 페이지에서 저장한 설정이 유효하기 위해서는 공유기를 반드시 다시 시작(reboot)해 주셔야 합니다. 아래에 있는 '재시작' 버튼을 누르거나 또는 '연결' 버튼을 눌러 장비를 다시 시작하고 다른 사항을 수정할 수 있습니다.",	//sc_intro_rb3
"TCP Ports To Open ",	//help67
"Transmission technology that provides a data rate of 1 billion bits per second ",	//help537
"Quake 2 ",	//gw_gm_37
"해당 되지 않으면 '취소' 버튼을 누르십시오. ",	//up_ae_wic_3
"Step 1: 비밀번호 설정",	//wwa_title_s1
"PC 의 시간 설정 복사 ",	//tt_CopyTime
"드라이버 명",	//tps_drname
"L2TP 세션 서버가 로컬 세션 0x%04X 를 위한 연속된 수 전송을 시작하였습니다. ",	//IPL2TP_SEQUENCING_ACTIVATED
"보유(Reserve)",	//bd_Reserve
"MSN 메신저 ALG가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//IPMSNMESSENGERALG_REJECTED_PACKET
"The wireless section allows you to view the wireless clients that are connected to your wireless router. ",	//help782
"Dungeon Siege ",	//gw_gm_16
"포트 포워딩 ALG가 %v:%u 에서 %v:%u 로의 UDP 패킷 세션 할당에 실패하였습니다. ",	//IPPORTFORWARDALG_UDP_PACKET_ALLOC_FAILURE
"Model ",	//wprn_mod
"주의: ",	//help119
"Silent Hunter II ",	//gw_gm_46
"MAC 필터링 ALLOW 옵션으로 PC들의 네트워크 접속 허용",	//am_FM_3
"LPD/LPR 인쇄 설정을 위해 정보를 사용하십시오. ",	//sps_lpd1
"시스템 설정",	//tss_SysSt
"파일에서 설정 복구",	//ta_ResConf
"무선 설정이 플래쉬 메모리에 업데이트 되었습니다. ",	//WCN_LOG_SAVE
"UDP connections.",	//help823_11
"방화벽 트래픽 종류",	//as_FPrt
"매일",	//tsc_EvDay
"<span class='button_ref'>Clear</span> 버튼을 눌러 MAC 필터링 리스트에서 MAC 주소를 삭제하십시오.  ",	//ham_del
"PPPoE ",	//_PPPoE
"새로운 공유기로 인터넷에 성공적으로 연결되었습니다. ",	//wwa_intro_online1
"DST 마침",	//tt_dstend
"스케쥴 규칙",	//tsc_SchRu
"PPP ",	//help654
"IP 주소 %v 가 시도한 설정 인증시도가 실패하였습니다. ",	//GW_AUTH_FAILED
"스케쥴",	//_scheds
"(GMT+08:00) Irkutsk, Ulaan Bataar ",	//up_tz_56
"Transmission Control Protocol/Internet Protocol ",	//help708
"2차 DNS 서버",	//_dns2
"호스트 명 또는 IP 주소를 입력하셔야 합니다. ",	//tsc_pingt_msg2
"이 설정들은 자동으로 구성되었고 관리자 계정만이 수정할 수 있습니다. ",	//tps_apc1
"(GMT+05:45) Kathmandu ",	//up_tz_48
"관리자 비밀번호 ",	//_password_admin
"내장된 DHCP 서버를 설정하여 네트워크에 연결되어 있는 PC 들에게 IP 주소를 할당할 수 있습니다. ",	//bd_intro_
"RADIUS Server IP Address: ",	//help387
"IP 주소 %v 에 의한 설정 인증이 허용 되었습니다. ",	//GW_AUTH_SUCCEEDED
"자녀 보호 서비스는 단순하지만 효과적인 방법으로 공격적이고 불법적이거나 혐오스러운 웹 사이트를 제한합니다. 이 서비스는 공유기에 연결 되어 있는 모든 종류의 PC나 애플 컴퓨터에서 실시간으로 자동 업데이트가 이루어집니다.(다운로드 받거나 직접 사이트를 입력할 필요 없음.) 이 서비스는 아주 신속해서 네트워크 속도에 영햐을 주지 않습니다. ",	//_bsecure_parental_blurb
"상세 CHAP 인증이 peer 로 전송되었습니다. ",	//IPPPPCHAP_AUTH_SENT
"American Standard Code for Information Interchange. This system of characters is most commonly used for text files ",	//help424
"마법사를 사용하여 새로운 액세스 제어 정책을 추가하십시오.",	//_aa_wiz_s1_msg
"The number of packets received by the router. ",	//help807
"(GMT+09:00) Seoul ",	//up_tz_61
"L2TP 게이트웨이 IP 주소",	//_L2TPgw
"Advanced: ",	//help395
"Once you have found the file to be used, click the <span class='button_ref'>Upload</span> button below to start the firmware upgrade process. This can take a minute or more. ",	//help880
"Medal of Honor: 게임",	//gw_gm_29
"The rule applies to a flow of messages whose WAN-side IP address falls within the range set here. ",	//help95
"비컨(beacon) 주기",	//aw_BP
"WAN 서비스 중지 ",	//GW_WAN_SERVICES_STOPPED
"TeamSpeak ",	//gw_gm_79
"Select a Network Time Server for synchronization. You can type in the address of a time server or select one from the list. If you have trouble using one server, select another. ",	//help850
"Duplex ",	//help505
"You are hosting a Web Server on a PC that has LAN IP Address of 192.168.0.50 and your ISP is blocking Port 80. ",	//help4
"(GMT-03:00) Brazilia ",	//up_tz_18
"When you use the Virtual Server, Port Forwarding, or Remote Administration features to open specific ports to traffic from the Internet, you could be increasing the exposure of your LAN to cyberattacks from the Internet. ",	//help168a
"A 32-bit number, when talking about Internet Protocol Version 4, that identifies each computer that transmits data on the Internet or on an Intranet ",	//help583
"PPTP ALG가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//PPTP_ALG_REJECTED_PACKET
"SMTP 서버 주소",	//te_SMTPSv
"A MAC address is usually located on a sticker on the bottom of a network device. The MAC address is comprised of twelve digits. Each pair of hexadecimal digits are usually separated by dashes or colons such as 00-0D-88-11-22-33 or 00:0D:88:11:22:33. If your network device is a computer and the network card is already located inside the computer, you can connect to the D-Link router from the computer and click the <span class='button_ref'>Copy Your PC's MAC Address</span> button to enter the MAC address. ",	//help334
"L2TP 로컬 터널 0x%04X RTE 모듈 리소스가 낮습니다. ",	//IPL2TP_LOW_RESOURCES
"Battlefield 2 ",	//gw_gm_84
"<strong>Add Policy</strong> 눌러 새로운 규칙을 생성하십시오. 진행중 언제라도 프로세스를 삭제할 수 있습니다. 규칙 생성이 끝나면,  아래의 <strong>Policy Table</strong>에 추가 될 것입니다. ",	//hhac_add
"RTSP ",	//as_RTSP
"10/100Mbps 자동",	//anet_wp_auto2
"인증 &amp; 보안",	//_authsecmodel
"MTU ",	//bwn_MTU
"Steam ",	//gw_gm_72
"WAN ",	//_WAN
"Ensure the schedule is set to <code>Always</code> ",	//help10
"Backward Compatible ",	//help430
"Decrypt ",	//help484
"Command and Conquer Generals ",	//gw_gm_8
"WPA ",	//_WPA
"Cable modem ",	//help454
"Re-type the password or key provided by your service provider. If the Dynamic DNS provider supplies only a key, enter that key in all three fields. ",	//help897
"로부터의 응답",	//tsc_pingt_msg7
"Blocked incoming TCP packet from %v:%u to %v:%u with unexpected sequence %lu (expected %lu to %lu)",	//IPNAT_TCP_BLOCKED_INGRESS_BAD_SEQ
"Jan ",	//tt_Jan
"Battlefield: Vietnam ",	//gw_gm_5
"고급 무선설정 ",	//_adwwls
"Ping 전송 :",	//tsc_pingt_msg100
"Unreal ",	//gw_gm_55
"디폴트로는 웹기반 설정을 위한  관리자용 비밀 번호가 설정되어 있지 않습니다. 보안을 위해 아래에 비밀번호를 설정하고 확인하십시오.   ",	//wwa_intro_s1
"Hub ",	//help556
"WAN Ping",	//anet_wan_ping
"MAC 주소 인증",	//bws_RMAA
"Step 2 - 스케쥴 선택",	//aa_wiz_s1_msg2
"Data-Link layer ",	//help470
"6 am ",	//tt_time_7
"Initiated from WAN to LAN. ",	//help822a
"America's Army ",	//gw_gm_1
"메시지",	//KR110
"(GMT+03:00) Baghdad ",	//up_tz_37
"보안 모드",	//bws_SM
"Governs the management and monitoring of network devices ",	//help689
"Cookie ",	//help464
"A program or user that requests data from a server ",	//help461
"(GMT+10:00) Hobart ",	//up_tz_68
"0-9 와 A-Z 를 사용하여 정확하게 64 문자 사용",	//wwl_s4_intro_za3
"이전",	//_prev
"무선 활성화",	//bwl_EW
"프린터 설정 마법사는 raw TCP 포트 프린팅 프로토콜이 반드시 필요합니다. 현재 공유기에는 이 프로토콜이 비활성화되어 있습니다. ",	//wprn_foo1
"A wireless network uses specific channels in the wireless spectrum to handle communication between clients. Some channels in your area may have interference from other electronic devices. Choose the clearest channel to help optimize the performance and coverage of your wireless network. ",	//help355
"웹 접근 로깅 ",	//aa_ACR_c6
"2차 RADIUS 서버 Shared Secret",	//bws_2RSSS
"RADIUS Server Shared Secret: ",	//help391
"NTP ",	//help635
"트레이스루트",	//help715
"PM ",	//_PM
"Network Address Translation allows many private IP addresses to connect to the Internet, or another network, through one IP address ",	//help622
"Define the ranges of Internet addresses this rule applies to. For a single IP address, enter the same address in both the <span class='option'>Start</span> and <span class='option'>End</span> boxes. Up to eight ranges can be entered. The <span class='option'>Enable</span> checkbox allows you to turn on or off specific entries in the list of ranges. ",	//help174
"PPPoE 연결이 타임아웃 되었습니다.  연결 시도에 실패하였습니다. ",	//PPPOE_EVENT_DISCOVERY_TIMEOUT
"장비 %s, wsetting.wfc: 파일이 없습니다. ",	//WCN_LOG_NO_WSETTING
"Virtual Private Network ",	//help731
"응용프로그램 규칙 변수 ",	//haar_p
"이 옵션을 체크하지 않으면, 공유기 WAN 쪽의 공인 IP 주소로 <code>ping</code> 명령에 응답하지 않습니다. ",	//anet_wan_ping_2
"To upgrade the firmware, follow these steps: ",	//help878
", Logged ",	//LOGGED
"ARP. Used to map MAC addresses to IP addresses so that conversions can be made in both directions. ",	//help408
"수동 ",	//bwn_RM_2
"RADIUS server Shared Secret",	//bws_RSSs
"(GMT+04:00) Baku, Tbilisi, Yerevan ",	//up_tz_43
"RTSP ALG가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//IPRTSPALG_REJECTED_PACKET
"Advanced Help ",	//help1
"Simple Network Management Protocol ",	//help688
"MSN 게임 존",	//gw_gm_73
"어떤 링크나 버튼을 클릭하여도 다른 웹사이트로 이동하여 더 자세한 정보를 확인할 수 있습니다. ",	//hhtsn_intro
"Ping 결과",	//tsc_pingr
"수동 업링크 속도",	//at_UpSp
"Information that is stored on the hard drive of your computer that holds your preferences to the site that gave your computer the cookie ",	//help465
"서브넷 마스크",	//help703
"SSH ",	//help697
"Step 6 - 웹 액세스 로깅 설정",	//aa_wiz_s1_msg6
"PPTP IP 주소",	//_PPTPip
"Click this button after changing Log Options to make them effective and permanent. ",	//help799
"A DTIM is a countdown informing clients of the next window for listening to broadcast and multicast messages. When the wireless router has buffered broadcast or multicast messages for associated clients, it sends the next DTIM with a DTIM Interval value. Wireless clients detect the beacons and awaken to receive the broadcast and multicast messages. The default value is 1. Valid settings are between 1 and 255. ",	//help185
"(GMT-03:30) Newfoundland ",	//up_tz_17
"인터넷과 네트워크 설정 상세 정보를 이 페이지에서 확인할 수 있습니다. 펌웨어 버전 또한 여기에서 확인할 수 있습니다.",	//sd_intro
"업로드",	//tf_Upload
"MAC address ",	//help605
"초",	//tt_Second
"The action of data packets being transmitted from one router to another ",	//help549
"Sending and Receiving data transmissions at the sane time ",	//help506
"이 설정으로 인해 무선 설정을 잃게 됩니다.",	//wps_lost
"주의: ",	//help26
"(GMT+02:00) Helsinki, Riga, Tallinn ",	//up_tz_35
"A sequence of characters that is used to authenticate requests to resources on a network ",	//help642
"인터넷 연결 유형을 설정합니다. 선택할 수 있는 연결 종류가 여러 가지입니다. (Static IP, DHCP, PPPoE, PPTP, L2TP) 연결 종류가  확실하지 않으면, 가입하신 인터넷 서비스 사업자(ISP)에 확인하십시오. ",	//bwn_intro_ICS
"When enabled, this option causes the router to automatically measure the useful uplink bandwidth each time the WAN interface is re-established (after a reboot, for example). ",	//help81
"This option allows you to save the router's configuration to a file on your computer. Be sure to save the configuration before performing a firmware upgrade. ",	//help833
"내부 네트워크 상에 여러 대의 PC 간에 프린터를 공유해서 사용할 수 있도록 통합 프린터 서버를 설정할 수 있습니다. 이 페이지에서 사용할 프린팅 프로토콜을 선택할 수 있습니다. ",	//tps_intro3
"Automatic Private IP Addressing",	//help428
"전송하였습니다. ",	//ss_Sent
"Group Key Update Interval: ",	//help378
"Session key ",	//help682
"Tribes of Vengeance ",	//gw_gm_80
"업로드가 성공하였습니다. ",	//_uploadgood
"-PIN (Personal Identification Number) ",	//wps_p3_2
"PC에서 호환 가능한 프린터 드라이버를 검색합니다. 드라이버가 검색되지 않으면, 프린터와 같이 들어 있는 드라이버 CD를 삽입하도록 팝업 창이 뜰 것입니다. ",	//wprn_s3c
"공유기는 DMZ 보호를 위해 제한적인 방화벽 기능을 제공합니다. 공유기는 연결 확인 패킷(SYN)이 아니면 액티브 DMZ 세션과 맞지 않는 TCP 패킷은 전송하지 않습니다. 제한된 보호 기능외에 DMZ 호스트는 실제적으로  &quot; 방화벽 외부&quot; 에 있습니다. DMZ 사용을 고려한다면 추가적인 보호를 제공하기 위해 DMZ 시스템 상에서 방화벽을 두는 것도 고려하시기 바랍니다. ",	//haf_dmz_20
"Go to the Apple Menu, select System Preferences, select Network, and select the Ethernet Adapter connecting to the D-Link router. Select the Ethernet button and the Ethernet ID will be listed. This is the same as the MAC address. ",	//help343
"수신되었습니다. ",	//ss_Received
"Check this option to connect to the internet through Telstra BigPond Cable Broadband in Australia. Telstra BigPond provides the values for ",	//help263
"30일 무료 버전",	//_bsecure_free_trial
"펌웨어 업그레이드 알림 옵션 ",	//tf_FUNO
"An electronic method of providing credentials to a server in order to have access to it or a network ",	//help492
"Short GI ",	//aw_sgi
"Amount of time before a client will be required to re-authenticate. ",	//help386
"There are several connection types to choose from: Static IP, DHCP, PPPoE, PPTP, L2TP. If you are unsure of your connection method, please contact your Internet Service Provider. Note: If using the PPPoE option, you will need to ensure that any PPPoE client software on your computers is removed or disabled. ",	//help254_ict
"필터링 방법을 선택하십시오. ",	//_aa_wiz_s5_msg1
"비밀번호 또는 키 재입력",	//td_VPWK
"Fragmentation ",	//help526
"Speed 3 필요",	//gw_gm_33
"Age of Empires ",	//gw_gm_0
"The third layer of the OSI model which handles the routing of traffic on a network ",	//help631
"MAC 주소 필터",	//_macfilt
"A unique hardware ID assigned to every Ethernet adapter by the manufacturer. ",	//help606
"(일부 DHCP 클라이언트와의 호환성)",	//bd_DAB_note
"Select the kinds of events that you want to view. ",	//help796
"To restart a computer and reload it's operating software or firmware from nonvolatile storage. ",	//help665
"3 pm ",	//tt_time_16
"(GMT-07:00) Arizona ",	//up_tz_05
"This email address will appear as the sender when you receive a log file or firmware upgrade notification via email. ",	//help861
"Select the protocol used by the service. ",	//help19
"DHCP WAN Mode ",	//bwn_DWM
"ICMP ",	//_ICMP
"The section lists the currently allowed web sites. ",	//help148
"Email Log When Full or on Schedule ",	//help868
"Half Life ",	//gw_gm_22
"비밀번호",	//_password
"속도 측정이 리소스 부족으로 중단되었습니다. ",	//RATE_ESTIMATOR_RESOURCE_ERROR
"5 am ",	//tt_time_6
"A standard that allows network devices to discover each other and configure themselves to be a part of the network ",	//help721
"<warn>게이트웨이 IP %v 가 인터페이스 서브넷 (%v/%v)에 없고 비활성화 됩니다.</warn>",	//GW_ROUTES_ROUTE_GATEWAY_NOT_IN_SUBNET_WARNING
"LAN에 있는 특정 PC에서의 인터넷 접속을 제한하고자 하면 <strong>접근 제어 설정</strong>를 확인하십시오. ",	//hhac_en
"수동 설정",	//int_LWlsWz
"전송 속도 선택",	//at_STR
"HTTPS ",	//gw_vs_2
"Aug ",	//tt_Aug
"MAC 필터링 DENY 옵션으로 PC들의 네트워크 접속 차단   ",	//am_FM_4
"Step 5 - 필터 선택",	//aa_wiz_s1_msg5
"접근 제어",	//ACCESS_CONTROL
"다이나믹 DNS 엔트리: %s 에러 업데이트. 설정을 확인하십시오. DynDNS 비활성화.  ",	//GW_DYNDNS_HERROR
"UTP ",	//help729
"오픈 포트 ",	//sps_ports
"Wireless Internet Service Provider ",	//help757
"If you do not have the NTP Server option in effect, you can either manually set the time for your router here, or you can click the <span class='button_ref'>Copy Your Computer's Time Settings</span> button to copy the time from the computer you are using. (Make sure that computer's time is set correctly.) ",	//help851
"<strong>컴퓨터 이름</strong> 드랍 다운 메뉴의 DHCP 클라이언트 리스트에서 PC에서 선택하거나, 지정된 포트를 열기 위해 LAN 컴퓨터의 IP 주소를 직접 입력할 수 있습니다. ",	//hhag_20
"장비 규칙이 이미 사용중입니다. ",	//aa_alert_7
"DMZ IP 주소 ",	//af_DI
"핑 테스트는 인터넷상에 있는 PC를 테스트하기 위해 &quot;ping&quot; 패킷을 보냅니다. ",	//tsc_pingt_mesg
"Latency ",	//help595
"뷰 레벨",	//sl_VLevs
"종료 시간",	//tsc_EndTime
"A MAC address is a unique ID assigned by the manufacturer of the network adapter. ",	//help151
"원격 관리를 위해 사용할 포트를 선택하십시오. ",	//hhta_pt
"인터넷 액세스 제어에 의해 %v:%u 에서 %v:%u 로 (protocol %u) 패킷이 차단되었습니다. ",	//GW_INET_ACCESS_DROP_ACCESS_CONTROL
"Routing Information Protocol is used to synchronize the routing table of all the routers on a network ",	//help671
"자동 채널 스캔 설정",	//ebwl_AChan
"Wired Equivalent Privacy is security for wireless networks that is supposed to be comparable to that of a wired network ",	//help747
"컴퓨터 이름 ",	//bd_CName
"TCP/IP ",	//help707
"It is recommended that you use the default settings if you do not have an existing network. ",	//help305rt
"비밀번호가 맞지 않습니다. 다시 시도하십시오. ",	//li_alert_3
"타임아웃으로 인한 DDNS 엔트리  업데이트 ",	//GW_DYNDNS_UPDATE_TO
"4th ",	//tt_week_4
"Transmitting data in all directions at once ",	//help451
"일 ",	//tt_Day
"LAN 이더넷 신호가 손실되었습니다. ",	//GW_LAN_CARRIER_LOST
"각각의 규칙에서 WAN 으로부터의 접속을 <strong>허용</strong> 또는 <strong>거부</strong> 할 수 있습니다.",	//hhai_action
"The Policy Wizard guides you through the steps of defining each access control policy. A policy is the &quot;Who, What, When, and How&quot; of access control -- whose computer will be affected by the control, what internet addresses are controlled, when will the control be in effect, and how is the control implemented. You can define multiple policies. The Policy Wizard starts when you click the button below and also when you edit an existing policy. ",	//help121
"여기에서 공유기의 무선 설정을 할 수 있습니다. 여기에서 수정한 사항은 무선 클라이언트에서도 동일하게 해 주셔야 합니다. ",	//bwl_Intro_1
"인터넷에 연결하기 위해서는 가입하신 인터넷 사업자(ISP)에서 받은 사용자명과 비밀번호가 필요합니다. 사용자명과 비밀번호를 모르시면 ISP에 확인하십시오.  ",	//wwa_msg_set_pppoe
"Raw 포트 프린팅 설정",	//tps_enraw
"보안 서비스는 어떤 웹브라우저에서도 관리가 되도록 하는 통합 서비스로 PC를 보호할 수 있습니다. 안티 바이러스, 방화벽, 침입 탐지, 콘텐츠 필터링, 스팸 킬러, 팝업 차단기 등을 포함합니다. 이런 모든 서비스는 낮은 가격으로 선택할 수 있습니다.",	//_bsecure_security_blurb
"DHCP 클라이언트 리스트",	//bd_DHCP
"Enter your account for sending email. ",	//help865
"Download ",	//help501
"WEP 키는 다음과 같은 기준에 맞아야 합니다. ",	//wwl_s4_intro_z1
"The ISP provides this parameter, if necessary. The value may be the same as the Gateway IP Address. ",	//help280
"DHCP Connection ",	//help775
"BigPond 설정",	//GW_BIGPOND_INIT
"연결",	//_connect
"Always",	//_always
"(분)",	//_minutes
"방화벽 포트",	//as_IPR_b
"eMule ",	//gw_gm_67
"Electronic Mail is a computer-stored message that is transmitted over the Internet ",	//help514
"인터넷 접속 제어에 의해 %v 에서 %v (protocol %u) 로 불량 패킷을 폐기하였습니다. ",	//GW_INET_ACCESS_DROP_BAD_PKT
"Dark Reign 2 ",	//gw_gm_12
"Select the starting and ending times for the change to and from daylight saving time. For example, suppose for DST Start you select Month=&quot;Oct&quot;, Week=&quot;3rd&quot;, Day=&quot;Sun&quot; and Time=&quot;2am&quot;. This is the same as saying: &quot;Daylight saving starts on the third Sunday of October at 2:00 AM.&quot; ",	//help846
"Hexen II ",	//gw_gm_25
"아래의 설정 방법 중 한 가지를 선택하고 다음 버튼을 눌러 계속 하십시오. ",	//wps_KR37
"Gamespy Arcade ",	//gw_gm_76
"Extensible Authentication Protocol ",	//help512
"IP 주소 %v 에서 로그 보기 ",	//GW_LOGS_VIEWED
"WAN 쪽 PC와 LAN 쪽 PC 간의 액티브 통신 리스트입니다. ",	//hhsa_intro
"WPA 엔터프라이즈 설정시, 원격 RADIUS 서버를 통해 클라이언트 인증을 위해 EAP(802.1x)를 사용합니다. ",	//bws_msg_EAP
"The most commonly used connection method for Ethernet ",	//help675
"This section allows you to archive your log files to a Syslog Server. ",	//help856
"Dir ",	//sa_Dir
"IGMP 멀티캐스트 멤버십",	//_bln_title_IGMPMemberships
"Access Control List ",	//help399
"Network Basic Input/Output System ",	//help626
"L2TP (사용자명 / 비밀번호)",	//bwn_Mode_L2TP
"Thu ",	//_Thu
"Ping ",	//_ping
"Beacons are packets sent by a wireless router to synchronize wireless devices. Specify a Beacon Period value between 20 and 1000. The default value is set to 100 milliseconds. ",	//help184
"설치에 가장 적합한 옵션을 선택하십시오.",	//_worksbest
"사용할 수 없음.",	//_unavailable
"검색된 파일 시스템이 호환되지 않습니다. (FAT32,FAT16,FAT12)",	//IPFAT_INCOMPATIBLE_FILESYS
"Antenna ",	//help415
"(GMT-08:00) Pacific Time (US/Canada), Tijuana ",	//up_tz_04
"Blocked incoming TCP packet from %v:%u to %v:%u as %s received but there is no active connection",	//IPNAT_TCP_BLOCKED_INGRESS_NOT_SYN
"Log Settings Now 적용 ",	//sl_ApplySt
"Peer 에서 CHAP 인증 챌린저를 수신하였습니다. ",	//IPPPPCHAP_CHALLENGE_RECVD
"This section is where you add the Web sites to be used for Access Control. ",	//help141
"무효 ",	//bd_Revoke
"A device that connects your network to another, like the internet ",	//help533
"연결 시간",	//_conuptime
"Step 1: 프린터가 검색되었습니다. ",	//wprn_intro3
"프린터가 켜져 있는지 확인하십시오. ",	//wprn_tt4
"Wireless Networking technology enables ubiquitous communication ",	//help383
"공유기에서 Ping 응답이 없습니다. 다시 시도하십시오. ",	//tsc_pingt_msg6
"Initiated from LAN to WAN. ",	//help821a
"A World Wide Web browser created and provided by Microsoft ",	//help572
"PPPoE 세션을 수신하였습니다. ",	//PPPOE_EVENT_SESSION_OFFER_RECVD
"Myth ",	//gw_gm_30
"공유기 설정에 익숙하시면 <span class='button_ref'>Manual Configure</span> 를 눌러 설정을 직접하셔도 됩니다.",	//bi_man
"A networking device that connects multiple devices together ",	//help557
"혼합 포트(1020-5000, 689) ",	//help60
"Data Encryption Standard ",	//help468
"원격 관리 포트 ",	//ta_RAP
"BigPond (Australia) ",	//bwn_Mode_BigPond
"DST 시작",	//tt_dststart
"현재 프린터 상태로 인해 설정 중에 테스트 페이지가 인쇄가 실패할 것입니다.",	//wprn_cps2
"When the protocol is TCP, SPI checks that packet sequence numbers are within the valid range for the session, discarding those packets that do not have valid sequence numbers. ",	//help164_1
"To send a request from one computer to another and have a file transmitted from the requesting computer to the other ",	//help724
"A utility program that verifies that a given Internet address exists and can receive messages. The utility sends a control packet to the given address and waits for a response. ",	//help648
"기다리십시오. ",	//wt_title
"Email Now ",	//sl_emailLog
"무선 네트워크 설정",	//bwl_title_1
"BigPond 비밀번호",	//bwn_BPP
"갱신",	//sl_reload
"Step 1: 무선 네트워크에 이름을 부여하십시오. ",	//wwl_title_s1
"드라이버 마운트에 실패하였습니다. ",	//IPDRIVE_MOUNT_FAILED
"인터넷 연결 설정 마법사 ",	//int_ConWz
"Permit any WAN user to access the related capability. ",	//help178
"Point-to-Point Tunneling Protocol is used for creating VPN tunnels over the Internet between two networks ",	//help657
"The <code>Revoke</code> option is available for the situation in which the lease table becomes full or nearly full, you need to recover space in the table for new entries, and you know that some of the currently allocated leases are no longer needed. Clicking <code>Revoke</code> cancels the lease for a specific LAN device and frees an entry in the lease table. Do this only if the device no longer needs the leased IP address, because, for example, it has been removed from the network. ",	//help329
"L2TP 로컬 터널 0x%04X 이 끊어졌습니다. ",	//IPL2TP_TUNNEL_DISCONNECTED
"Remote Admin Inbound Filter ",	//help830
"The Maximum Transmission Unit (MTU) is a parameter that determines the largest packet size (in bytes) that the router will send to the WAN. If LAN devices send larger packets, the router will break them into smaller packets. Ideally, you should set this to match the MTU of the connection to your ISP. Typical values are 1500 bytes for an Ethernet connection and 1492 bytes for a PPPoE connection. If the router's MTU is set too high, packets will be fragmented downstream. If the router's MTU is set too low, the router will fragment packets unnecessarily and in extreme cases may be unable to establish some connections. In either case, network performance can suffer. ",	//help294
"(GMT-02:00) Mid-Atlantic ",	//up_tz_21
"dBm ",	//help482
"Algorithm used for encryption and authentication ",	//help679
"BigPond logged in, state=%d, server response=%s ",	//GW_BIGPOND_SUCCESS
"모두 거부",	//_denyall
"자동 분류",	//at_AC
"무선 네트워크 이름 숨김",	//bwl_VS
"In this section you can see what LAN devices are currently leasing IP addresses. ",	//help327
"(시간)",	//td_
"설정 완료를 위해, 마법사가 실행 파일을 시작합니다. ",	//wprn_s2a
"원격지 PPTP 접속 집선 장치의 응답이 느립니다.  연결에 문제가 있을 수도 있습니다. ",	//PPTP_EVENT_TUNNEL_WINDOW_TIMEOUT
"출력 파워",	//aw_TP
"고정 IP 주소 인터넷 연결 종류",	//bwn_SIAICT
"Multiple connections are required by some applications, such as internet games, video conferencing, Internet telephony, and others. These applications have difficulties working through NAT (Network Address Translation). This section is used to open multiple ports or a range of ports in your router and redirect data through those ports to a single PC on your network. You can enter ports in various formats: ",	//help57
"DHCP 서버 설정",	//bd_EDSv
"연결이 끊어집니다.(기다려 주세요…) ",	//_sdi_s5
"2 am ",	//tt_time_3
"제조사",	//wprn_man
"PPPoE 옵션을 사용하시면, PC 에서 PPPoE 클라이언트 소프트웨어 프로그램을 삭제하시기 바랍니다.     ",	//bwn_note_clientSW
"(GMT-03:00) Greenland ",	//up_tz_20
"시스템 리소스가 낮아서  %v from peer router %v 루트를 거부하였습니다.",	//RIP_LOW_RESOURCES
"Service Name: ",	//help266
"연결되었습니다. ",	//CONNECTED
"If your ISP has assigned a fixed IP address, select this option. The ISP provides the values for the following fields: ",	//help265_5
"Day(s) ",	//tsc_Days
"The ability for new devices to communicate and interact with older legacy devices to guarantee interoperability ",	//help431
"(GMT-05:00) Indiana (East) ",	//up_tz_13
"일반",	//sd_General
"UPnP는 공유기와 다른 UPnP LAN 클라이언트와 통신하도록 도와 줍니다. LAN 상에 다른 UPnP 응용프로그램이 있으면 UPnP 옵션을 설정 상태로 두십시오. ",	//hhan_upnp
"Check with the system administrator of your corporate network whether your VPN client supports NAT traversal. ",	//help35
"The IP address of the system on your internal network that will provide the virtual service, for example <code>192.168.0.50</code>. ",	//help18
"프린터 설정 마법사",	//bwz_psw
"날짜와 시간",	//tt_DaT
"Schedules can be created for use with enforcing rules. For example, if you want to restrict web access to Mon-Fri from 3pm to 8pm, you could create a schedule selecting Mon, Tue, Wed, Thu, and Fri and enter a Start Time of 3pm and End Time of 8pm. ",	//help190
"SYN Sent -- One of the systems is attempting to start a connection. ",	//help819_2
"Institute of Electrical and Electronics Engineers ",	//help560
"최대 휴지(idle) 시간",	//bwn_MIT
"각 규칙에 의미 있는 <strong>이름</strong> 을 부여하십시오. ",	//hhai_name
"FULL 또는 스케쥴에 맞는 경우 이메일 로그 ",	//te__title_EmLog
"Windows Connect Now. A Microsoft method for configuring and bootstrapping wireless networking hardware (access points) and wireless clients, including PCs and other devices. ",	//help742
"(GMT+05:30) Calcutta, Chennai, Mumbai, New Delhi ",	//up_tz_47
"A wide band of frequencies available for transmitting data ",	//help449
"송/수신 중에 SMTP가 실패하였습니다. ",	//IPSMTPCLIENT_DIALOG_FAILED
"<strong>삭제</strong> 버튼을 눌러 MAC 필터링 리스트에서 MAC 주소를 삭제하십시오. ",	//hham_del
"가입하신 인터넷 서비스 공급자(ISP) 가 리스트에 없거나 ISP가 어디인지를 모르시면, 아래에 있는 인터넷 연결 유형을 선택하십시오. ",	//wwa_msg_ispnot
"The number of packets that were dropped while being sent, due to errors, collisions, or router resource limitations. ",	//help808
"PPTP 연결 시도 ",	//PPTP_EVENT_TUNNEL_ESTABLISH_REQUEST
"Supports use on LAN computers of Microsoft Windows Messenger (the Internet messaging client that ships with Microsoft Windows) and MSN Messenger. The SIP ALG must also be enabled when the Windows Messenger ALG is enabled. ",	//help37
"WCN 재시작 요청 ",	//WCN_LOG_REBOOT
"PPTP 연결 시도가 실패하였습니다. 원격지 PPTP 서버를 자세히 확인하십시오. ",	//PPTP_EVENT_TUNNEL_CONNECT_FAIL
"채널 간격",	//bwl_CWM
"(GMT-05:00) Eastern Time (US/Canada) ",	//up_tz_12
"IKE ",	//help565
"UPnP 설정",	//ta_EUPNP
"취소",	//_cancel
"Organizes information so that it can be managed updated, as well as easily accessed by users or applications. ",	//help473
"DNS 릴레이 설정",	//bln_EnDNSRelay
"(GMT+03:00) Kuwait, Riyadh ",	//up_tz_38
"DTIM 주기",	//aw_DI
"(GMT+02:00) Athens, Istanbul, Minsk ",	//up_tz_31
"<strong>Delete</strong> 아이콘을 눌러 정책 리스트(Rules List)에 있는 규칙을 완전히 삭제하십시오. ",	//hhai_delete
"항상(always-on) WAN 연결 재시도 ",	//GW_WAN_RECONNECT_ALWAYS_ON
"가상 서버 옵션으로 공유기에 내부 IP 주소와 사설 LAN 포트로 한개의 공인 포트를 중계(redirection) 하도록 설정 할 수 있습니다. FTP 또는 웹서버와 같은 온라인 서비스를 호스팅하는 경우에 유용한 기능입니다.",	//av_intro_vs
"In ",	//INGRESS
"무선 보안 비밀번호",	//wwl_WSP
"Restricted ",	//RESTRICTED
"Legacy ",	//help599
"인터넷 서비스 제공업체(ISP) 에서 IP 주소 정보 또는 사용자명과 비밀번호를 받지 못한 경우, 이 인터넷 연결 유형을 사용하십시오. ",	//bwn_msg_DHCPDesc
"Enabling Remote Management allows you to manage the router from anywhere on the Internet. Disabling Remote Management allows you to manage the router only from computers on your LAN. ",	//help828
"The port number used to connect to the authentication server. ",	//help390
"Re-type the password associated with the account. ",	//help867
"항상 WAN 연결 시작 시도 ",	//GW_WAN_CONNECT_ALWAYS_ON
"Port Forwarding Fields ",	//help60f
"IPX ",	//help585
"Counter Strike ",	//gw_gm_10
"(minutes, 0=infinite) ",	//bwn_min
"Sending and Receiving data at the same time ",	//help530
"월",	//tt_Month
"NetBEUI ",	//help623
"WEP 대신 WPA 암호를 사용하십시오.(WPA는 WEP 보다 더 강력한 암호화 방식이고 모든 D-Link 무선 카드들이 WPA를 지원합니다.)",	//wwz_wpa_support
"현재 펌웨어 일자",	//tf_CFWD
"고급 네트워크",	//_advnetwork
"PPPoE 인터넷 연결 유형",	//bwn_PPPOEICT
"Select the time offset, if your location observes daylight saving time. ",	//help844
"RADIUS Server Port: ",	//help389
"4 pm ",	//tt_time_17
"L2TP (Layer Two Tunneling Protocol) uses a virtual private network to connect to your ISP. This method of connection requires you to enter a <span class='option'>Username</span> and <span class='option'>Password</span> (provided by your Internet Service Provider) to gain access to the Internet. ",	//help284
"MAC 주소가 %m 인 무선 시스템이 연결되었습니다.  ",	//GW_WIRELESS_DEVICE_ASSOCIATED
"2차 MAC 주소 인증 ",	//bws_2RMAA
"SIP ",	//as_SIP
"Syslog ",	//help704
"WLAN ",	//help758
"(GMT) Greenwich Time: Dublin, Edinburgh, Lisbon, London ",	//up_tz_25
"NIC ",	//help634
"With the above example application rule enabled, the router will open up a range of ports from 6000-6200 for incoming traffic from the Internet, whenever any computer on the internal network opens up an application that sends data to the Internet using a port in the range of 6500-6700. ",	//help55
"무선 링크가 연결되었습니다. ",	//GW_WLAN_LINK_UP
"The larger network that your LAN is connected to, which may be the Internet itself, or a regional or corporate network ",	//help752
"Dynamic DNS 설정",	//td_EnDDNS
"Internet Protocol Security ",	//help575
"수신 필터 규칙",	//ai_title_IFR
"PPTP ",	//_PPTP
"Both ",	//_both
"(GMT+03:00) Nairobi ",	//up_tz_40
"프린터의 USB 케이블을 빼서 다시 꽂으십시오. ",	//wprn_tt8
"소프트 리셋을 비활성화하십시오. ",	//tps_dsr
"다른 장비",	//_aa_other_machines
"Broadcast ",	//help450
"This restarts the router. Useful for restarting when you are not near the device. ",	//help875
"웹사이트 필터 변수",	//awsf_p
"5자 또는 13자의 상용문자",	//wwl_s4_intro_z2
"물리 계층",	//help645
"인터넷 연결을 하기 위해서는 가입하신 인터넷 서비스 제공업체(ISP)의 사용자명과 비밀번호와 L2TP IP 주소가 필요합니다. 이 정보가 없는 경우, 가입하신 ISP에서 확인하십시오. ",	//wwa_set_l2tp_msg
"(GMT+04:00) Abu Dhabi, Muscat ",	//up_tz_42
"에러",	//_error
"Dest IP<br />End",	//aa_FPR_c4
"Enable or disable defined rules with the checkboxes at the left. ",	//help75a
"DHCP 서버 범위에 있는 LAN IP 주소가 잘못되었습니다. ",	//network_dhcp_ip_in_server
"펌웨어 업데이트를 위해서는 PC를 공유기에 반드시 유선으로 연결하십시오.찾아보기 버튼을 눌러 펌웨어 파일을 선택하신 뒤, 확인을 클릭 후 업로드 버튼을 클릭하십시오. ",	//tf_msg_wired
"호스트 명 또는 IP 주소를 입력한 다음 'Ping'을 누르십시오. ",	//tsc_pingt_msg1
"사용자 명과 비밀번호 연결 설정(PPPoE)",	//wwa_title_set_pppoe
"특별한 상황에 맞는 다른 옵션들이 있습니다. ",	//bwl_CWM_h2
"Check Online ",	//help884
"재시작",	//rb_Rebooting
"Time Wait -- Waiting for a short time while a connection that was in FIN Wait is fully closed. ",	//help819_6
"9 am ",	//tt_time_10
"This section shows the currently defined Schedule Rules. A Schedule Rule can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the item is highlighted, and the &quot;Edit Schedule Rule&quot; section is activated for editing. ",	//help199
"A method of connection where the ISP assigns your IP address when your router requests one from the ISP's server. Some ISP's require you to make some settings on your side before your router can connect to the Internet. ",	//help259
"애플리케이션 계층 게이트웨어(ALG) 설정",	//af_algconfig
"PPTP 클라이언트",	//wwa_msg_pptp
"2차 RADIUS 서버 IP 주소",	//bws_2RIPA
"Step 3: 장비 선택 ",	//_aa_wiz_s4_title
"주의 : 서비스 명을 입력해야 할 경우도 있습니다. 이 정보를 모르시는 경우, 가입하신 ISP에서 확인하십시오. ",	//wwa_note_svcn
"Detected xDSL or Frame Relay Network ",	//help85
"If you need to change the MAC address of the router's WAN-side Ethernet interface, either type in an alternate MAC address (for example, the MAC address of the router initially connected to the ISP) or copy the MAC address of a PC. To copy the MAC address of the computer that initially connected to the ISP, connect to the D-Link router using that computer and click the <span class='button_ref'>Clone Your PC's MAC Address</span> button. The WAN interface will then use the MAC address of the network adapter in your computer. ",	//help304
"BigPond 상태",	//sd_BPSt
"(GMT+06:00) Almaty, Novosibirsk ",	//up_tz_49
"World of Warcraft ",	//gw_gm_62
"BigPond 로그 아웃",	//BIGPOND_LOGGED_OUT
"새로운 펌웨어 버전 이메일 알림",	//tf_EmNew
"MAC 주소 %m의 인터넷 접속 정책을 설정할 수 없습니다. ",	//GW_INET_ACCESS_INITIAL_MAC_FAIL
"MAC Address: ",	//help303
"리스트에 없거나 알 수 없습니다. ",	//wwa_selectisp_not
"Blocked outgoing TCP packet from %v:%u to %v:%u with unexpected acknowledgement %lu (expected %lu to %lu)",	//IPNAT_TCP_BLOCKED_EGRESS_BAD_ACK
"The rule applies to a flow of messages whose LAN-side port number is within the range set here. ",	//help94
"Xbox Live ",	//gw_gm_70
"패킷 헤더를 처리할 수 없어 %v 에서 %v 로의 ICMP 패킷이 폐기되었습니다. ",	//IPNAT_ICMP_UNABLE_TO_HANDLE_HEADER
"FTP ",	//_FTP
"NAT 엔드포인트 필터링",	//_neft
"When do two devices on the same Ethernet network try and transmit data at the exact same time. ",	//help463
"관리",	//ta_A12n
"D-Link DVC-1000 ",	//gw_gm_83
"BigPond 로그 아웃",	//GW_BIGPOND_LOGOUT
"An application rule is used to open single or multiple ports on your router when the router senses data sent to the Internet on a &quot;trigger&quot; port or port range. An application rule applies to all computers on your internal network. ",	//help46
"자주 로그를 확인하여 허가 받지 않은 사용자가 네트워크를 사용하는지 확인하십시오. ",	//hhsl_intro
"Tools Help ",	//help770
"인터넷에 연결하기 위해 가입하신 인터넷 서비스 공급업체(ISP)의 사용자명과 비밀번호와 PPTP 주소가 필요합니다. 이 정보가 없는 경우, ISP에서 확인하십시오.",	//wwa_msg_set_pptp
"펌웨어 업그레이드 서버의 %s DNS 레코드를 찾을 수 없습니다. ",	//GW_FW_NOTIFY_FAILED_DNS
"Rainbow Six: Raven Shield ",	//gw_gm_40
"Address Resolution Protocol",	//help407
"IGMP 프로토콜을 사용하여 효과적인 멀티캐스팅(멀티미디어와 같이 동일한 콘텐츠를 여러 수신 장비들에 전송)을 지원합니다.",	//bln_IGMP_title_h
"국가별 요구에 맞추어 <strong>802.11d</strong> 단독 모드를 사용하십시오. ",	//hhaw_11d
"취소를 누르고 난 후 설정을 저장하십시오. ",	//up_jt_2
"정책 %s 을 시작합니다; MAC 주소 %s 의 인터넷 접속이 %s 로 변경되었습니다. ",	//GW_INET_ACCESS_POLICY_START_MAC
"A program that allows you to access resources on the web and provides them to you graphically ",	//help453
"인터넷에 연결하기 위해서는 사용자명과 비밀번호가 필요합니다. 대부분의 DSL 모뎀이 이 유형을 사용합니다.  ",	//wwa_msg_pppoe
"Suppose you configure the DHCP Server to manage addresses From 192.168.0.100 To 192.168.0.199. This means that 192.168.0.3 to 192.168.0.99 and 192.168.0.200 to 192.168.0.254 are NOT managed by the DHCP Server. Computers or devices that use addresses from these ranges are to be manually configured. Suppose you have a web server computer that has a manually configured address of 192.168.0.100. Because this falls within the \"managed range\" be sure to create a reservation for this address and match it to the relevant computer (see <a href='#Static_DHCP'>Static DHCP Client</a> below).",	//help323
"'관리자' 과 '사용자' 계정으로 관리 인터페이스에 접속할 수 있습니다. '관리자' 은 읽기/쓰기 권한이 있으며 비밀번호를 변경할 수 있습니다. '사용자' 는 읽기 권한만 있습니다.",	//ta_intro1
"IGMP ",	//help561
"Bit/sec ",	//help442
"3rd ",	//tt_week_3
"DHCP 서버",	//_dhcpsrv
"A generic term for the family of digital subscriber line (DSL) technologies, such as ADSL, HDSL, RADSL, and SDSL. ",	//help762
"설정",	//_enabled
"한 개 이상의 인터넷 정책이 효력이 있습니다.  이런 정책에 따라 인터넷 접속이 제한 됩니다. ",	//GW_INET_ACCESS_RESTRICTED
"WON 서버",	//gw_gm_69
"필터링",	//aa_ACR_c5
"This option lets you reserve IP addresses, and assign the same IP address to the network device with the specified MAC address any time it requests an IP address. This is almost the same as when a device has a static IP address except that the device must still request an IP address from the D-Link router. The D-Link router will provide the device the same IP address every time. DHCP Reservations are helpful for server computers on the local network that are hosting applications such as Web and FTP. Servers on your network should either use a static IP address or use this option. ",	//help331
"설정 마법사로 설정을 수정하시는 경우 공유기와의 연결을 유지하기 위해 무선 랜카드의 설정을 일부 변경해야 할 수도 있습니다. ",	//bwz_note_WlsWz
"You can assign a name for each computer that is given a reserved IP address. This may help you keep track of which computers are assigned this way. ",	//help345
"이미 지정된 서버 유형 리스트는 <strong>응용프로그램 이름</strong>  드랍다운 메뉴에서 확인하십시오. 미리 지정된 서버 유형을 선택하면, 해당하는 항목을 채울 때까지 드랍다운 메뉴 옆에 있는 화살표 버튼을 누르십시오.",	//hhav_name
"사설 포트",	//av_PriP
"% 손실",	//tsc_pingt_msg103
"Hypertext Transfer Protocol is used to transfer files from HTTP servers (web servers) to HTTP clients (web browsers) ",	//help553
"If you need to use the UPnP functionality, you can enable it here. ",	//help_upnp_2
"WAN 연결 모드가 정확하지 않습니다. ",	//WAN_MODE_INCORRECT
"Kbps ",	//help590
"WEP 비밀번호는 5자리 문자/숫자로 입력해 주십시오. ",	//wwl_alert_pv5_2_5
"Megabits per second",	//help608
"Step 4: 필터링 방법 선택",	//_aa_wiz_s5_title
"PIN 번호가 잘못되었습니다. ",	//KR22_ww
"특정 IP 주소와 포트로의 접속을 제한하기 위한 규칙을 정의하십시오. ",	//_aa_wiz_s7_help
"L2TP 세션 서버가 로컬 세션 0x%04X 의 연속 번호 송신을 중단되었습니다. ",	//IPL2TP_SEQUENCING_DEACTIVATED
"고급 프린터 설정 ",	//tps_apc
"(GMT-06:00) Mexico City ",	//up_tz_09
"Jul ",	//tt_Jul
"WAN 인터페이스가 다운되었습니다. ",	//GW_WAN_INTERFACE_DOWN
"무선 설정 복구 ",	//WCN_LOG_RESTORE
"Everquest ",	//gw_gm_17
"Advanced Encryption Standard ",	//help411
"DNS ",	//gw_vs_4
"인터넷 접속을 위한 IP 주소 %v 가 %s 로 변경 되었습니다. ",	//GW_INET_ACCESS_INITIAL_IP
"Hexadecimal ",	//help546
"마법사에서 수정한 것을 모두 취소하시겠습니까? ",	//_wizquit
"시스템 설정에서 장비를 다시 시작 하거나 공유기를 공장 초기화 값으로 복구할 수 있습니다. 장비를 공장 초기화 값으로 복구하면 생성하신 규칙을 포함해 모든 설정이 삭제됩니다. ",	//tss_intro
"Endpoint Independent",	//af_EFT_0
"When you set <span class='option'>Enable DHCP Server</span>, the following options are displayed. ",	//help318
"시스템 로그 옵션에서 시스템 로그 서버의 로그 정보를 전송할 수 있습니다. ",	//tsl_intro
"3 am ",	//tt_time_4
"이 옵션을 설정하면, 공유기가 WAN 업링크 대역폭을 초과하지 않도록 송신 트래픽 흐름을 제한합니다.  ",	//KR107
"8 pm ",	//tt_time_21
"프레그멘테이션 값",	//aw_FT
"L2TP 로컬 세션  0x%04X 이 연결되었습니다. ",	//IPL2TP_SESSION_CONNECTED
"저장",	//_save
"측정 되지 않았습니다. ",	//at_NEst
"Once you have a firmware update on your computer, use this option to browse for the file and then upload the information into the router. ",	//help888
"A logical channel endpoint in a network. A computer might have only one physical channel (its Ethernet channel) but can have multiple ports (logical channels) each identified by a number. ",	//help653
"Decibels relative to isotropic radiator ",	//help481
"Anti-Spoof 확인",	//KR105
"펌웨어",	//_firmware
"Rogue Spear ",	//gw_gm_43
"무선 네트워크에 추가하고 있는 무선 장비에서 WPS을 시작하십시오. ",	//wps_messgae1_1
"L2TP 로컬 터널 0x%04X RTE 모듈이 중단되고 있습니다. ",	//IPL2TP_SHUTDOWN_STARTED
"TX 패킷이 차단되었습니다. ",	//ss_TXPD
"(GMT+08:00) Beijing, Chongqing, Hong Kong, Urumqi ",	//up_tz_55
"공유기 보안을 위해 비밀번호와 시간 대 설정을 위해 다음 버튼을 누르십시오. ",	//wwa_intro_online2
"Select the outbound protocol used by your application (for example <code>Both</code>). ",	//help50
"Enter the UDP ports to open (for example <code>6159-6180, 99</code>). ",	//help70
"DHCP 보유(Reservation)",	//bd_title_SDC
"암호화",	//wwl_enc
"(GMT+09:00) Osaka, Sapporo, Tokyo ",	//up_tz_60
"Ultima ",	//gw_gm_54
"관리자 로그 아웃",	//GW_ADMIN_LOGOUT
"2차 RADIUS 서버는 옵션입니다. ",	//bws_ORAD
"Serious Sam II ",	//gw_gm_44
"WAN Ping 응답 설정 ",	//bwn_RPing
"LAN 상의 멀티캐스트 그룹에 속하는 응용프로그램이 있으면 이 옵션을 설정하십시오. 예상 대로 컨텐트를 수신하지 못하는 멀티미디어 LAN 응용프로그램이 있는 경우, 이 옵션을 다시 설정하십시오. ",	//igmp_e_h
"Full-duplex ",	//help529
"Attenuation ",	//help425
"ACL. This is a database of network devices that are allowed to access resources on the network. ",	//help400
"The number of packets sent from the router. ",	//help806
"Enter the outgoing port range used by your application (for example <code>6500-6700</code>). ",	//help49
"Example: ",	//help367
"Dynamic IP address ",	//help509
"Links ",	//gw_gm_28
"Windows Me ",	//help337
"관리자 설정",	//ta_AdmSt
"(GMT-06:00) Central Time (US/Canada) ",	//up_tz_08
"시스템 로그",	//_syslog
"If this is selected, the user must connect from the same computer whenever logging into the wireless network. ",	//help394
"Step 5: 포트 필터",	//_aa_wiz_s7_title
"시간 설정 옵션으로 내부 시스템 시간을 정확하게 설정, 업데이트, 관리할 수 있습니다. 여기에서 현재 계신 곳의 시간 대역과  NTP(Network Time Protocol) 서버를 설정할 수 있습니다. 필요한 경우, 일광 절약 시간도 설정하여 자동으로 조정할 수 있습니다.",	//tt_intro_Time
"DDNS 엔트리 업데이트 에러: %s 다시 시도해 주십시오. ",	//GW_DYNDNS_SERROR
"DHCP ",	//_DHCP
"주의: 모든 D-Link 무선 랜카드들은 현재 WPA를 지원합니다. ",	//wwl_s3_note_2
"TCP Raw ",	//help709
"Enable BigPond: ",	//help262
"포트",	//sps_port
"Whether SPI is enabled or not, the router always tracks TCP connection states and ensures that each TCP packet's flags are valid for the current state. ",	//help164_2
"Wait for the router to reboot. This can take another minute or more. ",	//help881
"목적지 IP",	//_destip
"The Time Configuration option allows you to configure, update, and maintain the correct time on the router's internal system clock. From this section you can set the time zone that you are in and set the Time Server. Daylight saving can also be configured to automatically adjust the time when needed. ",	//help840
"일광 시간 절약 날짜 ",	//tt_dsdates
"L2TP 서버 IP 주소 (게이트웨이와 같은 주소)",	//wwa_l2tp_svra
"Note that L2TP VPN connections typically use IPSec to secure the connection. To achieve multiple VPN pass-through in this case, the IPSec ALG must be enabled. ",	//help34b
"10 am ",	//tt_time_11
"이메일 알림 기능",	//te_EnEmN
"The actual transmission rate of the client in megabits per second. ",	//help786
"사용자명",	//bwn_UN
"정책 명이 이미 사용중입니다. ",	//aa_alert_8
"Universal Plug and Play ",	//help720
"원격 관리 설정 ",	//ta_ERM
"LCP가 원격 인증을 설정합니다 : %04x",	//IPPPPLCP_SET_REMOTE_AUTH
"Universal Serial Bus ",	//help728
"L2TP 로컬 터널 0x%04X RTE 모듈 시간 만료 - 원격지 서버가 응답하지 않습니다. ",	//IPL2TP_FATAL_TIMEOUT
"<strong>Non-UDP/TCP/ICMP LAN Sessions</strong> 이 정상적으로 설정되었습니다. 이 설정으로 원격지 단말 장치에 단일 VPN 연결을 할 수 있습니다. ",	//hhaf_ngss
"네트워크 설정",	//bln_title_NetSt
"트래픽 종류",	//av_traftype
"Information that has been translated into binary so that it can be processed or moved to another device ",	//help467
"PPTP (사용자명/비밀번호 )",	//bwn_Mode_PPTP
"This section shows the currently defined access control policies. A policy can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the Policy Wizard starts and guides you through the process of changing a policy. You can enable or disable specific policies in the list by clicking the &quot;Enable&quot; checkbox. ",	//help140
"모든 WAN과 LAN  연결 상세 정보를 여기에서 확인할 수 있습니다.  ",	//hhsd_intro
"필수 프린팅 프로토콜이 비활성화되었습니다. ",	//wprn_rppd
"Suppose you are hosting an online game server that is running on a PC with a private IP Address of 192.168.0.50. This game requires that you open multiple ports (6159-6180, 99) on the router so Internet users can connect. ",	//help63
"무선 장비상의 Push Button(physical or virtual)을 눌러 무선 네트워크에 장비를 추가하십시오. ",	//wps_messgae1_2
"새로운 설정이 적용되었습니다. ",	//ap_intro_sv
"L2TP 서브넷 마스크",	//_L2TPsubnet
"리부팅 전에 로그 이메일 전송  ",	//GW_LOG_EMAIL_BEFORE_REBOOT
"모두",	//at_Any
"The following options apply to all WAN modes. ",	//help288
"암호화 종류중 한 가지를 선택하지 않으면, 무선 네트워크로 송/수신 트래픽이 쉽게 중간에 가로채일 수 있고, 인가 받지 못한 사용자들이 접속할 수 있습니다. ",	//bws_SM_h1
"In addition to the filters listed here, two predefined filters are available wherever inbound filters can be applied: ",	//help177
"(GMT+05:00) Islamabad, Karachi, Tashkent ",	//up_tz_46
"<span id='show_sec'></span>&nbsp; 초 기다려 주십시오. ",	//rb_wait
"Communication between a single sender and receiver ",	//help719
"%v 에서 %v 로의 패킷이 차단되었습니다. (LAND Attack)",	//IPSTACK_REJECTED_LAND_ATTACK
"무선 네트워크 이름",	//bwl_NN
"Local Area Network",	//help594
"L2TP 로컬 세션 0x%04X 연결 시도가 실패하였습니다. ",	//IPL2TP_SESSION_CONNECT_FAIL
"Final Fantasy XI (PS2) ",	//gw_gm_21
"BEST ",	//wwl_BEST
"지원",	//_support
"새로운 IP 주소를 추가할 수 없습니다. 다른 정책의 IP 주소를 재사용만 가능합니다. ",	//aa_alert_14
"케이블 상태 ",	//_cablestate
"DHCP stands for Dynamic Host Configuration Protocol. The DHCP section is where you configure the built-in DHCP Server to assign IP addresses to the computers and other devices on your local area network (LAN). ",	//help314
"무선 장비 WITH WPS (WI-FI PROTECTED SETUP) 마법사를 추가하십시오. ",	//wps_LW13
"중요도 높음",	//sl_Critical
"시스템 LOG 가 동작하지 않습니다. ",	//SYSTEM_LOG_INACTIVE
"새로운 설정이 저장되었습니다. ",	//sc_intro_sv
"내 인터넷 연결 ",	//bwn_mici
"If the router loses power for any reason, it cannot keep its clock running, and will not have the correct time when it is started again. To maintain correct time for schedules and logs, either you must enter the correct time after you restart the router, or you must enable the NTP Server option. ",	//help852
"분",	//gw_mins
"In ",	//_In
"A newer version of the PC Card or PCMCIA interface. It supports a 32-bit data path, DMA, and consumes less voltage ",	//help457
"Select this option if you want logs to be sent by email according to a schedule. ",	//help870
"Firewall and Security ",	//help797
"MSN Game Zone (DX) ",	//gw_gm_74
"Rainbow Six ",	//gw_gm_39
"Rendezvous ",	//help666
"WEP 키는 정확하게 10 자리 헥사 값을 입력하십시오.(0-9, A-F)",	//wwl_alert_pv5_3_10
"The MAC address filter section can be used to filter network access by machines based on the unique MAC addresses of their network adapter(s). ",	//help149
"열거 되어 있는 응용프로그램을 실행했는데 예상대로 동작되지 않는 경우에 이 기능을 사용하십시오. ",	//hhpt_intro
"WAN 인터페이스 케이블이 연결되었습니다. ",	//GW_WAN_CARRIER_DETECTED
"Secure Shell is a command line interface that allows for secure connections to remote computers ",	//help698
"BigPond 사용자 Id",	//bwn_BPU
"GUI ",	//help538
"Select this option if you want this schedule in effect all day for the selected day(s). ",	//help195
"The initial value of Time Out depends on the type and state of the connection. ",	//help823_1
"인터넷 연결",	//_internetc
"Resolved to ",	//tsc_pingt_msg5
"Enter a name for the rule that is meaningful to you. ",	//help172
"트리거",	//_trigger
"The Ethernet ID (MAC address) of the wireless client. ",	//help783
"게이트웨이가 수정 되었습니다. ",	//ub_intro_2
"보안을 위해, 관리자와 사용자용 비밀번호를 변경하실 것을 권장합니다. 비밀번호 분실을 방지하기 위해 새로운 비밀번호를 기록해 두십시오.",	//hhta_pw
"Status Help ",	//help771
"Step 6: 웹 접속 로깅 설정",	//_aa_wiz_s8_title
"The rule can either Allow or Deny messages. ",	//help173
"시스템 로그 서버 IP 주소 ",	//tsl_SLSIPA
"포트 필터 규칙 추가 ",	//_aa_wiz_s7_msg
"12 pm ",	//tt_time_13
"(GMT+10:00) Guam, Port Moresby ",	//up_tz_67
"Primary DNS Server, Secondary DNS Server ",	//help289a
"BigPond 로긴하였습니다. ",	//BIGPOND_LOGGED_IN
"Network Layer ",	//help630
"DMZ 호스트로 설정된 경우, 일부 다른 수신 세션 또는 수신 규칙과 맞지 않는 모든 수신 패킷의 목적지가 됩니다. 다른 수신 규칙이 있는 경우는, DMZ 호스트로 보내는 대신 그 규칙이 사용됩니다. 즉, 액티브 세션, 가상 서버, 액티브 포트 트리거, 포트 포워딩 규칙등이 패킷을 DMZ 호스트로 보내는 것보다 우선 순위가 높다는 의미입니다.(DMZ 정책은 모든 포트를 포워드하는 디폴트 포트 포워딩 규칙과 비슷합니다.)",	//haf_dmz_10
"State for sessions that use the TCP protocol. ",	//help819
"TCP 포트",	//sps_tcpport
"진행 사항이 나타나지 않으면, 설정 실행이 시작되지 않았고, 아직 완료되지 않은 것입니다. 아래에 있는 장애처리 방법을 참고하십시오.",	//wprn_s3b
"7th Layer of the OSI model. Provides services to applications to ensure that they can communicate properly with other applications on a network. ",	//help422
"웹사이트 필터",	//_websfilter
"BigPond 서버명",	//sd_BPSN
"사용자 비밀번호",	//_password_user
"정책 %s 이 중단되었습니다; 인터넷 접속을 위한 IP 주소 %v 가 : %s 로 변경되었습니다. ",	//GW_INET_ACCESS_POLICY_END_IP
"인터넷에 연결되어 있는 공유기에서 사용되는 모드를 선택하십시오. ",	//bwn_msg_Modes
"IP 주소 ' + mf.dmz_address.value + ' 가 잘못되었습니다. ",	//up_gX_1
"다음 ",	//_next
"설정",	//_setup
"핑을 중단하시려면 이 버튼을 누르십시오. ",	//htsc_pingt_s
"이메일",	//EMAIL
"Direct Sequence Spread Spectrum ",	//help493
"모드",	//_mode
"Feb ",	//tt_Feb
"Raw TCP 포트 프린팅을 설정하기 위해서 이 정보를 사용하십시오. ",	//sps_raw1
"%s 를 위한 DDNS 엔트리를 성공적으로 업데이트되었습니다. ",	//GW_DYNDNS_SUCCESS
"IGMP 라우터가 낮은 시스템 리소스 때문에 그룹 %v 을 거부하였습니다. ",	//IGMP_ROUTER_LOW_RESOURCES
"&quot;Auto 20/40 MHz&quot; 옵션이 일반적으로 사용하기에 가장 좋습니다.",	//bwl_CWM_h1
"(GMT+03:00) Moscow, St. Petersburg, Volgograd ",	//up_tz_39
"Allows devices and applications using VoIP (Voice over IP) to communicate across NAT. Some VoIP applications and devices have the ability to discover NAT devices and work around them. This ALG may interfere with the operation of such devices. If you are having trouble making VoIP calls, try turning this ALG off. ",	//help40
"D-Link 무료 DDNS 서비스에 가입하십시오. ",	//td_intro_DDNS_DLINK
"포트 포워딩",	//_pf
"인터넷 접속을 위한 MAC 주소 %m가 %s 로 설정되었습니다. ",	//GW_INET_ACCESS_INITIAL_MAC
"CHAP 인증 성공",	//IPPPPCHAP_AUTH_SUCCESS
"Normally the wireless transmitter operates at 100% power. In some circumstances, however, there might be a need to isolate specific frequencies to a smaller area. By reducing the power of the radio, you can prevent transmissions from reaching beyond your corporate/home office or designated wireless area. ",	//help187
"모든 접속 차단",	//_aa_block_all
"무선 링크가 다운되었습니다.",	//GW_WLAN_LINK_DOWN
"The amount of time before the group key used for broadcast and multicast data is changed. ",	//help379
"(GMT+11:00) Magadan, Solomon Is., New Caledonia ",	//up_tz_70
"Dynamic DNS service ",	//help507
"이 웹 사이트 공유기의 허용 웹 사이트 리스트에 없습니다. ",	//fb_p_2
"인터넷 익스플로러",	//help571
"프린터 상태",	//sps_ps
"측정수치 통합 실패로 속도 측정이 중단되었습니다. ",	//RATE_ESTIMATOR_CONVERGENCE_ERROR
"You need to configure your router to allow a software application running on any computer on your network to connect to a web-based server or another user on the Internet. ",	//help47
"5 pm ",	//tt_time_18
"Step 4: 설정을 저장하고 연결하십시오. ",	//wwa_title_s4
"When this option is enabled, router activity logs or firmware upgrade notifications can be emailed to a designated email address, and the following parameters are displayed. ",	//help860
"인터넷 연결 설정 마법사가 완료되었습니다. 연결 버튼을 눌러 설정을 저장하고 공유기를 다시 시작하십시오. ",	//wwa_intro_s4
"A predetermined value or setting that is used by a program when no user input has been entered for this value or setting ",	//help487
"Some ISP's may require that you enter a Service Name. Only enter a Service Name if your ISP requires one. ",	//help267
"L2TP 로컬 세션 0x%04X 이 중단되었습니다. ",	//IPL2TP_SESSION_ABORTED
"This section allows you to manage the router's configuration settings, reboot the router, and restore the router to the factory default settings. Restoring the unit to the factory default settings will erase all settings, including any rules that you've created. ",	//help874
"Sep ",	//tt_Sep
"패킷 헤더를 처리할 수 없어 %v 에서  %v 로의 ESP 패킷이 폐기되었습니다. ",	//IPSEC_ALG_ESP_UNABLE_TO_HANDLE_HEADER
"NetBIOS Extended User Interface is a Local Area Network communication protocol. This is an updated version of NetBIOS ",	//help624
"그룹 키 업데이트 주기",	//bws_GKUI
"<strong>WMM</strong> 설정으로 무선으로 멀티미디어를 전송할 때 지연과 지터를 줄일 수 있습니다.",	//hhaw_wmm
"In these cases, you can use Inbound Filters to limit that exposure by specifying the IP addresses of internet hosts that you trust to access your LAN through the ports that you have opened. You might, for example, only allow access to a game server on your home LAN from the computers of friends whom you have invited to play the games on that server. ",	//help168c
"BigPond 로긴",	//BIGPOND_LOGGING_IN
"사용자명 / 비밀번호 연결 (PPTP)",	//wwa_wanmode_pptp
"Data cannot be transmitted and received at the same time ",	//help543
"Service Set Identifier is a name for a wireless network ",	//help700
"범위지정 (50-100) ",	//help58
"This option will check D-Link's support site to see if you have the latest version of the firmware available. If a newer version is available, download instructions will be displayed. ",	//help885
"연결되었습니다. ",	//ddns_connected
"업로드에 실패하였습니다. ",	//ub_Upload_Failed
"PPTP (Point to Point Tunneling Protocol) uses a virtual private network to connect to your ISP. This method of connection is primarily used in Europe. This method of connection requires you to enter a <span class='option'>Username</span> and <span class='option'>Password</span> (provided by your Internet Service Provider) to gain access to the Internet. ",	//help278
"Client ",	//help460
"시스템 로그는 여러 곳에서 발생하는 로그를 한곳에 모으는 서버입니다. 시스템 로그 서버에 설치되어 있으면, 공유기 로그를 서버로 보내기 위해서 이 옵션을 사용하십시오.",	//hhts_def
"목적지 PC의 IP 주소 또는 유효한 도메인 명을 입력 하십시오. ",	//htsc_pingt_h
"Used when your ISP provides you a set IP address that does not change. The IP information is manually entered in your IP configuration settings. You must enter the ",	//help255
"2차 RADIUS 서버 포트",	//bws_2RSP
"Enter the Private Port as [80] ",	//help7
"사용안함",	//bwl_VS_0
"TCP 엔드포인트 필터링",	//af_TEFT
"When <span class='option'>Connection Type</span> is set to <span class='option'> Auto-detect</span>, the automatically detected connection type is displayed here. ",	//help86
"네트워크 이름 (SSID)",	//sd_NNSSID
"게이트 웨이 ",	//_gateway
"현재 공유기 시간",	//tt_CurTime
"AM ",	//_AM
"연결이 끊어졌습니다. ",	//DISCONNECTED
"(GMT-01:00) Azores ",	//up_tz_22
"Unshielded Twisted Pair ",	//help730
"Soldier of Fortune ",	//gw_gm_47
"WAN IP가 %v로 변경되었습니다. DDNS 공급업체에 업데이트합니다.  ",	//GW_DYNDNS_UPDATE_IP
"두 개의 비밀번호가 같은지 확인하시고 다시 시도하십시오. ",	//_pwsame
"Windows/MSN Messenger ",	//as_WM
"(GMT-09:00) Alaska ",	//up_tz_03
"To send a request from one computer to another and have the file transmitted back to the requesting computer ",	//help502
"박스안에 동일한 비밀번호를 입력하여 확인하십시오. ",	//ta_msg_TW
"Depending on the type of WAN connection, you can take one of the following sets of actions: ",	//help774
"PBC (Push Button Configuration)",	//wps_p3_3
"(GMT+02:00) Jerusalem ",	//up_tz_36
"<strong>수정</strong> 아이콘을 눌러 정책 마법사를 사용하여 현재 있는 규칙을 수정할 수 있습니다. ",	//hhac_edit
"인터넷 접속 제어 초기화에 실패하였습니다. ",	//GW_INET_ACCESS_INITIAL_FAIL
"호스트 이름",	//_hostname
"웹 필터 초기화에 실패하였습니다. ",	//GW_WEB_FILTER_INITIAL_FAIL
"스케쥴에 맞게 ",	//te_OnSch
"이메일",	//help513
"Step 3: 무선 보안 비밀번호를 설정하십시오. ",	//wwl_title_s4
"Reconnect Mode: ",	//help281
"Gamespy Tunnel ",	//gw_gm_77
"PC MAC 주소 복사",	//_clonemac
"공유기가 초기화되어 WAN과 LAN 사이를 통과하는 패킷 번호를 정리한 것입니다. ",	//hhss_intro
"업링크 속도 ",	//at_MUS
"Enable this option only if you have purchased your own domain name and registered with a dynamic DNS service provider. The following parameters are displayed when the option is enabled. ",	//help892
"일반적으로 WAN 속도는 자동으로 감지됩니다. WAN 연결에 문제가 있는 경우, 직접 속도를 선택할 수도 있습니다. ",	//hhan_wans
"Mbps ",	//help607
"The key is entered as a pass-phrase of up to 63 alphanumeric characters in ASCII (American Standard Code for Information Interchange) format at both ends of the wireless connection. It cannot be shorter than eight characters, although for proper security it needs to be of ample length and should not be a commonly known phrase. This phrase is used to generate session keys that are unique for each wireless client. ",	//help382
"(hour:minute, 12 hour time) ",	//tsc_hrmin
"This is the uplink speed measured when the WAN interface was last re-established. The value may be lower than that reported by your ISP as it does not include all of the network protocol overheads associated with your ISP's network. Typically, this figure will be between 87% and 91% of the stated uplink speed for xDSL connections and around 5 kbps lower for cable network connections. ",	//help82
"Programming that is inserted into a hardware device that tells it how to function ",	//help525
"Heretic II ",	//gw_gm_24
"Delta Force ",	//gw_gm_13
"A company that provides a broadband Internet connection over a wireless connection ",	//help754
"RTS 값 ",	//aw_RT
"윈도우 XP",	//help340
"무선 LAN",	//sd_WLAN
"If your SMTP server requires authentication, select this option. ",	//help864
"MPPE ",	//help617
"A name that is associated with an IP address ",	//help500
"지원되지 않는 운영체제(OS) 입니다. ",	//wprn_bados
"메트릭",	//_metric
"수신 필터 ",	//INBOUND_FILTER
"%v:%u 에서 %v:%u 로의 수신 UDP 패킷이 차단되었습니다. ",	//IPNAT_UDP_BLOCKED_INGRESS
"This option turns off and on the wireless connection feature of the router. When you set this option, the following parameters are in effect. ",	//help351
"키를 직접 생성하고 싶으시면 이 옵션을 사용하십시오. ",	//wwz_manual_key2
"PPTP 서브넷 마스크",	//_PPTPsubnet
"The port that will be used on your internal network. ",	//help20
"Internet Control Message Protocol ",	//help558
"Black and White ",	//gw_gm_6
"APIPA. An IP address that that a Windows computer will assign itself when it is configured to obtain an IP address automatically but no DHCP server is available on the network ",	//help429
"EAP ",	//help511
"WPA Mode ",	//bws_WPAM
"GOOD ",	//wwl_GOOD
"Enter your host name, fully qualified; for example: <code>myhost.mydomain.net</code>. ",	//help894
"Postal 2: Share the Pain ",	//gw_gm_36
"Gbps ",	//help534
"서브넷 마스크",	//_subnet
"Step 1: 무선 네트워크 설정 방법 선택",	//wps_KR35
"The <code>Reserve</code> option converts this dynamic IP allocation into a DHCP Reservation and adds the corresponding entry to the DHCP Reservations List. ",	//help329_rsv
"Vietcong ",	//gw_gm_58
"&quot;Demilitarized Zone&quot;. A computer that logically sits in a &quot;no-mans land&quot; between the LAN and the WAN. The DMZ computer trades some of the protection of the router's security mechanisms for the convenience of being directly addressable from the Internet. ",	//help496
"Bottleneck ",	//help446
"Allows you to power up a computer though it's Network Interface Card ",	//help739
"%s 를 사용하여 WAN 표시 ",	//GW_WAN_MODE_IS
"Determines what portion of an IP address designates the Network and which part designates the Host ",	//help627
"공유기 내부 네트워크 설정이나 DHCP 서버를 설정하여 PC에 IP를 할당할 수 있습니다. 여기에서 설정한 IP 주소는 웹관리 인터페이스에 접속하는데 사용되는 그 IP 주소입니다. 여기에서 IP 주소 변경 후, 네트워크에 다시 접속하려면 PC의 네트워크 설정을 다시 해야 합니다.",	//ns_intro_
"DNS 릴레이 ALG가 %v:%u 에서 %v:%u 로의 패킷을 거부하였습니다. ",	//IPDNSRELAYALG_REJECTED_PACKET
"공유기를 통과하는 송/수신 트래픽 패킷의 상세 정보가 표시됩니다. ",	//ss_intro
"이 규칙에 필요할 경우 접근 제어 필터를 선택하십시오. 필요한 필터가 목록에 없을 경우, <a href='Inbound_Filter.asp'> Advanced&rarr;InboundFilter</a> 화면에서 새 필터를 생성하십시오.",	//help71
"무선 장비의 PIN 을 입력하십시오 ",	//KR20
"세션 시간 초과 ",	//KR25
"규칙을 활성화 할 스케쥴을 선택하십시오. 사용할 스케쥴이 목록에 없을 경우 <a href='tools_schedules.asp' onclick='return jump_if();'>도구 &rarr; 스케줄</a> 로 이동하여 새로운 스케쥴을 생성하십시오.",	//hhag_30
"%s' [protocol:%u]->%v 와 '%s' [protocol:%u]->%v 가 충돌합니다.",	//GW_NAT_VS_PROTO_CONFLICT_INVALID
"%s': 우선순위, %u 는 0과 7 사이의 값이어야 합니다. ",	//GW_WISH_RULES_PRIORITY_RANGE
"After configuring the router for dynamic DNS, you can open a browser and navigate to the URL for your domain (for example <code>http://www.mydomain.info</code>) and the router will attempt to forward the request to port 80 on your LAN. If, however, you do this from a LAN-side computer and there is no virtual server defined for port 80, the router will return the router's configuration home page. Refer to the <a href='adv_virtual.asp'>Advanced &rarr; VirtualServer</a> configuration page to set up a virtual server. ",	//help900
"관리 포트의 접근을 제어하기 위해 설정된 필터를 선택하십시오. 필요한 필터가 목록에 없으면  <a href='Inbound_Filter.asp' onclick='return jump_if();'>고급 -> 수신필터</a> 에서 새로운 필터를 생성하시기 바랍니다.",	//hhta_831
"%s': Host 1 port start, %u, must be less than host 1 port end, %u",	//GW_WISH_RULES_HOST1_PORT
"Select a filter that controls access as needed for this virtual server. If you do not see the filter you need in the list of filters, go to the <a href='Inbound_Filter.asp'> Advanced&rarr;InboundFilter</a> screen and create a new filter. ",	//help22
"%s': Local IP 마지막  '%v' 가  LAN 서브넷에 없습니다. ",	//GW_QOS_RULES_LOCAL_IP_END_SUBNET
"%s': 원격 포트 시작 %u은 원겨지 마지막 포트 %u보다 작아야 합니다. ",	//GW_QOS_RULES_REMOTE_PORT
"%s': 로컬 시작 포트 %u, 는 로컬 마지막 포트 %u 보다 적습니다. ",	//GW_QOS_RULES_LOCAL_PORT
"%s': 로컬 시작 IP '%v' 가 LAN 서브넷에 없습니다. ",	//GW_QOS_RULES_LOCAL_IP_START_SUBNET
"WPS 무선 장비 추가 ",	//LW13
"Select a schedule for the times when this rule is in effect. If you do not see the schedule you need in the list of schedules, go to the <a href='tools_schedules.asp'> Tools&rarr;Schedules</a> screen and create a new schedule. ",	//help72
"서비스에 해당하는 스케쥴을 선택하십시오. 스케쥴 리스트에 필요한 스케쥴이 없는 경우, <a href='tools_schedules.asp' onclick='return jump_if();'>도구 &rarr; 스케줄</a> 스크린에서 새로운 스케쥴을 생성하십시오.",	//hhpt_sch
"<em>Tools</em> 메뉴 아래의 <em>Print ServerÂ </em> 페이지에서 raw TCP 포트 프린팅을 설정하십시오.",	//wprn_tt2
"Select a schedule for when this rule is in effect. If you do not see the schedule you need in the list of schedules, go to the <a href='tools_schedules.asp'> Tools&rarr;Schedules</a> screen and create a new schedule. ",	//help53
"%s': 호스트 1 시작 주소, %v 는 반드시 호스트 1 IP 마지막 주소 %v 보다 적어야 합니다. ",	//GW_WISH_RULES_HOST1_IP
"프로세스를 중단할 수 없습니다. ",	//KR24
"Super G Mode ",	//help358
"WLAN 분리",	//KR4
"Wep Key 길이 ",	//wwl_WKL
"컴퓨터에서 공유 프린터를 사용하기 위해서, <a href='../Basic/Wizard.shtml' onclick='return jump_if();'> <i>WizardÂ </i> page</a> 의 프린터 마법사를 실행하십시오. ",	//tps_intro4
"%s': 프로토콜, %u, 0 ~ 257이어야 합니다. ",	//GW_WISH_RULES_PROTOCOL
"%s': 원격지 마지막 주소 '%v' 가 LAN 네트워크와 같은 네트워크에 있습니다 ",	//GW_QOS_RULES_REMOTE_IP_END_SUBNET
"Allows FTP clients and servers to transfer data across NAT. Refer to the <a href='adv_virtual.asp'>Advanced&rarr;VirtualServer</a> page if you want to host an FTP server. ",	//help38
"The Web Filter section is one of two means by which you can specify the web sites you want to allow. You also have the alternative of using the Sentinel Parental Controls Service, which allows you to specify broad categories of web sites and saves you the trouble of entering specific web site URLs. For more information about the Sentinel service, refer to <a href='../Tools/Sentinel.shtml'>Tools&rarr;Sentinel</a>. ",	//help143s
"%s': Host 2  시작 IP, %v 는 반드시 host 2 의 마지막 IP, %v 보다 적어야 합니다. ",	//GW_WISH_RULES_HOST2_IP
"프로세스가 중단되엇습니다. 아래에 있는 취소 버튼을 눌러 마법사 페이지로 돌아가신 후 해당 프로세스를 다시 시작하십시오.",	//KR23
"다른 IP 주소 상에서 '%s' [%s:%s] 와 '%s'[%s:%s] 이 충돌합니다. ",	//GW_NAT_PORT_FORWARD_CONFLICT_INVALID
"PIN (2nd half) 이 맞지 않습니다. ",	//KR30
"%s' [%s:%d]->%v/%d 와 '%s' [%s:%d]->%v:%d 충돌합니다. ",	//GW_NAT_VS_PORT_CONFLICT_INVALID
"AP가 %s 를 통해 Registrar (%s) 등록에 실패하였습니다. 원인 (%s), 에러 코드 (%u) ",	//WIFISC_AP_REGISTRATION_FAIL
"PIN (1st half) 이 맞지 않습니다. ",	//KR29
"이 옵션을 활성화하면, 스트림을 표시하는 방식에 따라 확인하지 않는 트래픽 스트림에 공유기가 자동으로 우선권을 부여할 수 있습니다. 예를 들어, 파일 전송과 같은 용량을 많이 전송하는 벌크 트래픽은 우선 순위를 낮게하고 게임, VoIP 등에는 우선 순위를 높게 줄 수 있습니다.",	//YM143
"Specifies the interface -- WAN -- that the IP packet must use to transit out of the router, when this route is used. ",	//help111
"%s': Remote IP start '%v'이 LAN 서브넷에 있습니다. ",	//GW_QOS_RULES_REMOTE_IP_START_SUBNET
"%s': 우선순위 %d 는 1~255 입니다. ",	//GW_QOS_RULES_PRIORITY_RANGE
"Specifies the next hop to be taken if this route is used. A gateway of 0.0.0.0 implies there is no next hop, and the IP address matched is directly connected to the router on the interface specified: WAN. ",	//help109
"Wi-Fi Protected 설정으로 설정한 무선 네트워크가 이미 있으면, <strong>WPS 무선장비 추가</strong>  버튼을 눌러 무선 네트워크에 새 장비를 추가하십시오.",	//LW45
"알지 못하는 메시지를 수신하였습니다. ",	//KR32
"네트워크에 무선 장비를 추가하는 방법에는 여러 가지가 있습니다. 무선 네트워크로의 접속은 Registrar에 의해 제어 됩니다. Registrar는 PIN을 입력한 경우나 또는 Wi-Fi Protected 설정을 한 경우에만 무선 네트워크에 장비를 허용합니다. 공유기가 registrar로 동작하고, 다른 장비들 역시 registrar 로 동작할 수 있습니다.",	//LW63
"%s': Host 2 시작 포트, %u 는 반드시 host 2 마지막 포트, %u 보다 낮아야 합니다.",	//GW_WISH_RULES_HOST2_PORT
"%s': 프로토콜, %d 은 0 ~ 257 입니다. ",	//GW_QOS_RULES_PROTOCOL
"%s' 와 '%s' 은 중복입니다. ",	//GW_WISH_RULES_DUPLICATED
"%s': 원격지 시작 IP , '%v' 는 원격지 마지막 IP , '%v' 보다 적어야 합니다. ",	//GW_QOS_RULES_REMOTE_IP
"%s': 로컬 시작 IP, '%v' 는 로컬 마지막  IP, '%v'  보다 적어야 합니다. ",	//GW_QOS_RULES_LOCAL_IP
"Requests may be redirected to the &quot;Forbidden&quot; page if web access for the LAN machine is restricted by an Access Control Rule. Add the WAN-side identity (WAN-side IP-address of the router or its dynamic DNS name) on the <a href='adv_filters_url.asp'> Advanced&rarr;WebFilter</a> screen to work around this problem. ",	//help30
"IP 주소가 잘못되었습니다. ",	//LS46
"로컬 네트워크 <span>rou</span><span>ter</span> 의 IP 주소 ",	//KR78
"Active Sessions",	//_actsess
"The common choices -- UDP, TCP, and both UDP and TCP -- can be selected from the drop-down menu. ",	//help19x1
"To specify any other protocol, select &quot;Other&quot; from the list, then enter the corresponding protocol number (<a href='http://www.iana.org/assignments/protocol-numbers' target='_blank'> as assigned by the IANA</a>) in the <span class='option'>Protocol</span> box. ",	//help19x2
"Select a schedule for when the service will be enabled. If you do not see the schedule you need in the list of schedules, go to the <a href='tools_schedules.asp'> 도구 &rarr; 스케줄</a> screen and create a new schedule. ",	//help23
"With the above example values filled in and this Port Forwarding Rule enabled, all TCP and UDP traffic on ports 6159 through 6180 and port 99 is passed through the router and redirected to the Internal Private IP Address of your Game Server at 192.168.0.50. ",	//help74
"스페셜 응용프로그램 규칙 이름을 입력하십시오. 예, <code>Game App</code> 은 향휴 해당 규칙을 확인하는데 도움이 됩니다. 다른 방법으로 일반 응용프로그램 리스트 <span class='option'>Application</span> 에서 선택할 수도 있습니다.",	//help48
"Instead of entering a name for the Special Application rule, you can select from this list of common applications, and the remaining configuration values will be filled in accordingly. ",	//help48a
"This section is where you define application rules. ",	//help56_a
"The QoS Engine feature helps improve your network performance by prioritizing applications. ",	//help76
"좋은 성능과 온라인 게임, VoIP와 같은 응용프로그램을 위해 이 옵션을 설정하십시오. ",	//help78
"QoS 엔진 규칙이 상세 메시지 flow를 확인하고 해당 flow에 대해 우선 순위를 할당합니다. ",	//help88
"For most applications, automatic classification will be adequate, and specific QoS Engine Rules will not be required. ",	//help88b
"The QoS Engine supports overlaps between rules, where more than one rule can match for a specific message flow. If more than one rule is found to match the rule with the highest priority will be used. ",	//help88c
"The priority of the message flow is entered here -- 1 receives the highest priority (most urgent) and 255 receives the lowest priority (least urgent). ",	//help91
"Priority 0 is reserved.",	//help91a
"Flows that are not prioritized by any rule receive lowest priority.",	//help91b
"The protocol used by the messages. ",	//help92
"The common choices can be selected from the drop-down menu.",	//help92x1
"To specify any other protocol, enter its protocol number (<a href='http://www.iana.org/assignments/protocol-numbers' target='_blank'>as assigned by the IANA</a>) in the <span class='option'>Protocol</span> box.",	//help92x2
"This section is where you define QoS Engine Rules. ",	//help99_s
"The Web sites listed here are used when the Web Filter option is enabled in <a href='#Access_Control'>Advanced &rarr; AccessControl</a>. ",	//help141_a
"허용할 웹 싸이트의 URL(주소)를 입력하십시오; 예를 들어: <code>google.com</code>. URL 앞에 <code>http://</code> 를 입력하지 마십시오. 가장 포괄적인 도메인 주소를 입력하십시오; 예를 들어, <code>dlink.com</code> 를 입력하면 <code>www.dlink.com</code> 와 <code>support.dlink.com</code> 가 모두 허용됩니다. ",	//help145
"When &quot;OFF&quot; is selected, MAC addresses are not used to control network access. When &quot;ALLOW&quot; is selected, only computers with MAC addresses listed in the MAC Address List are granted network access. When &quot;DENY&quot; is selected, any computer with a MAC address listed in the MAC Address List is refused access to the network. ",	//help155_2
"<a href='adv_virtual.asp'> Advanced &rarr; Virtual&rarr;Server</a>, <a href='adv_portforward.asp'>Advanced &rarr; Port&rarr;Forwarding</a>, <a href='adv_appl.asp'> Advanced  ApplicationRules</a>, <a href='adv_network.asp'>Advanced  Network (UPnP)</a> 에서 관련 옵션을 확인하십시오. ",	//haf_intro_2
"SPI (&quot;stateful packet inspection&quot; also known as &quot;dynamic packet filtering&quot;) helps to prevent cyberattacks by tracking more state per session. It validates that the traffic passing through that session conforms to the protocol. ",	//help164
"DMZ means &quot;Demilitarized Zone.&quot; If an application has trouble working from behind the router, you can expose one computer to the Internet and run the application on that computer. ",	//help165
"Specify the LAN IP address of the LAN computer that you want to have unrestricted Internet communication. If this computer obtains its address Automatically using DHCP, then you may want to make a static reservation on the <a href='lan.asp'>Setup &rarr; NetworkSettings</a> page so that the IP address of the DMZ computer does not change. ",	//help167
"When a LAN application that uses a protocol other than UDP, TCP, or ICMP initiates a session to the Internet, the router's NAT can track such a session, even though it does not recognize the protocol. This feature is useful because it enables certain applications (most importantly a single VPN connection to a remote host) without the need for an ALG.",	//TA21
"Note that this feature does not apply to the DMZ host (if one is enabled). The DMZ host always handles these kinds of sessions.",	//TA22
"When the PPTP ALG is enabled, LAN computers can establish PPTP VPN connections either with the same or with different VPN servers. When the PPTP ALG is disabled, the router allows VPN operation in a restricted way. LAN computers are typically able to establish VPN tunnels to different VPN Internet servers but not to the same server. The advantage of disabling the PPTP ALG is to increase VPN performance. Enabling the PPTP ALG also allows incoming VPN connections to a LAN side VPN server (refer to <a href='adv_virtual.asp'>Advanced &rarr; VirtualServer</a>). ",	//help33b
"Allows H.323 (specifically Microsoft Netmeeting) clients to communicate across NAT. Note that if you want your buddies to call you, you should also set up a virtual server for NetMeeting. Refer to the <a href='adv_virtual.asp'> Advanced &rarr; Virtual Server</a> page for information on how to set up a virtual server. ",	//help39
"This feature enables forwarding of &quot;magic packets&quot; (that is, specially formatted wake-up packets) from the WAN to a LAN computer or other device that is &quot;Wake on LAN&quot; (WOL) capable. The WOL device must be defined as such on the <a href='adv_virtual.asp'> Advanced &rarr; Virtual Server</a> page. The LAN IP address for the virtual server is typically set to the broadcast address 192.168.0.255. The computer on the LAN whose MAC address is contained in the magic packet will be awakened. ",	//help41
"Add/Update Inbound Filter Rule ",	//help170
"Saves the new or edited Inbound Filter Rule in the following list. ",	//help175
"The section lists the current Inbound Filter Rules. An Inbound Filter Rule can be changed by clicking the Edit icon, or deleted by clicking the Delete icon. When you click the Edit icon, the item is highlighted, and the &quot;Update Inbound Filter Rule&quot; section is activated for editing. ",	//help176
"이 설정은 기본 값인 2346 bytes 로 유지하십시오.",	//help182
"are recommended.",	//help183
"This setting should remain at its default value of 2346 bytes. ",	//help180
"주위의 무선 네트워크 보호를 위해 이 옵션을 비활성화하여 802.11ng 성능에 나쁜 영향을 주는 요소를 줄이십시오. ",	//aw_erpe_h
"This router has a USB port; so, if you have a USB flash drive, a USB port on your PC, and your PC runs Windows XP Service Pack 2 (SP2) or later, you can transfer wireless configuration data between your PC and the router with the USB flash drive. Go to the Windows Control Panel and select Wireless Network Setup Wizard. The Wireless Network Setup Wizard gives you the choices: &quot;Use a USB flash drive&quot; and &quot;Set up a network manually&quot;. Select &quot;Use a USB flash drive&quot;. ",	//help202
"Note: Do not connect more than one USB flash drive to the router, not even with a USB hub. ",	//help203
"Time interval the machine can be idle before the PPPoE connection is disconnected. The Maximum Idle Time value is only used for the &quot;On demand&quot; and &quot;Manual&quot; reconnect modes. ",	//help277
"Time interval the machine can be idle before the PPTP connection is disconnected. The Maximum Idle Time value is only used for the &quot;On demand&quot; and &quot;Manual&quot; reconnect modes. ",	//help283
"Time interval the machine can be idle before the L2TP connection is disconnected. The Maximum Idle Time value is used for the &quot;On demand&quot; and &quot;Manual&quot; reconnect modes. ",	//help287
"It is possible for a computer or device that is manually configured to have an address that does reside within this range. In this case the address should be reserved (see <a href='#Static_DHCP'>Static DHCP Client</a> below), so that the DHCP Server knows that this specific address can only be used by a specific computer or device.",	//help320
"To protect your privacy, use the wireless security mode to configure the wireless security features. This device supports three wireless security modes including: WEP, WPA-Personal, and WPA-Enterprise. WEP is the original wireless encryption standard. WPA provides a higher level of security. WPA-Personal does not require an authentication server. The WPA-Enterprise option does require a RADIUS authentication server. ",	//help350
"A method of encrypting data for wireless communication intended to provide the same level of privacy as a wired network. WEP is not as secure as WPA encryption. To gain access to a WEP network, you must know the key. The key is a string of characters that you create. When using WEP, you must determine the level of encryption. The type of encryption determines the key length. 128-bit encryption requires a longer key than 64-bit encryption. Keys are defined by entering in a string in HEX (hexadecimal - using characters 0-9, A-F) or ASCII (American Standard Code for Information Interchange - alphanumeric characters) format. ASCII format is provided so you can enter a string that is easier to remember. The ASCII string is converted to HEX for use over the network. Four keys can be defined so that you can change keys easily. A default key is selected for use on the network. ",	//help366
"64-bit hexadecimal keys are exactly 10 characters in length. (12345678FA is a valid string of 10 characters for 64-bit encryption.) ",	//help368
"128-bit hexadecimal keys are exactly 26 characters in length. (456FBCDF123400122225271730 is a valid string of 26 characters for 128-bit encryption.) ",	//help369
"64-bit ASCII keys are up to 5 characters in length (DMODE is a valid string of 5 characters for 64-bit encryption.) ",	//help370
"128-bit ASCII keys are up to 13 characters in length (2002HALOSWIN1 is a valid string of 13 characters for 128-bit encryption.) ",	//help371
"Note that, if you enter fewer characters in the WEP key than required, the remainder of the key is automatically padded with zeros. ",	//help371_n
"WPA is the older standard; select this option if the clients that will be used with the router only support the older standard. WPA2 is the newer implementation of the stronger IEEE 802.11i security standard. With the &quot;WPA2&quot; option, the router tries WPA2 first, but falls back to WPA if the client only supports WPA. With the &quot;WPA2 Only&quot; option, the router associates only with clients that also support WPA2 security. ",	//help375
"Check this box to allow the DHCP Server to offer NetBIOS configuration settings to the LAN hosts.",	//help400_b
"If NetBIOS advertisement is swicthed on, switching this setting on causes WINS information to be learned from the WAN side, if available.",	//help401_b
"Configure the IP address of the preferred WINS server.",	//help402_b
"ActiveX",	//help403
"Configure the IP address of the backup WINS server, if any.",	//help403_b
"A Microsoft specification for the interaction of software components.",	//help404
"This is an advanced setting and is normally left blank. This allows the configuration of a NetBIOS &quot; domain&quot;  name under which network hosts operate.",	//help404_b
"Ad-hoc network",	//help405
"Indicates how network hosts are to perform NetBIOS name registration and discovery.",	//help405_b
"Peer-to-Peer network between wireless clients",	//help406
"AppleTalk",	//help417
"A set of Local Area Network protocols developed by Apple for their computer systems",	//help418
"AppleTalk Address Resolution Protocol",	//help419
"AARP. Used to map the MAC addresses of Apple computers to their AppleTalk network addresses, so that conversions can be made in both directions.",	//help420
"Basic Input/Output System",	//help434
"BIOS. A program that the processor of a computer uses to startup the system once it is turned on",	//help435
"Baud",	//help436
"Data transmission speed",	//help437
"BOOTP",	//help444
"Bootstrap Protocol. Allows for computers to be booted up and given an IP address with no user intervention",	//help445
"CAT 5",	//help458
"Category 5. Used for 10/100 Mbps or 1Gbps Ethernet connections",	//help459
"DB-25",	//help474
"A 25 ping male connector for attaching External modems or RS-232 serial devices",	//help475
"DB-9",	//help476
" A 9 pin connector for RS-232 connections",	//help477
"dBd",	//help478
"Decibels related to dipole antenna",	//help479
"Fiber optic",	//help518
"A way of sending data through light impulses over glass or plastic wire or fiber",	//help519
"File sharing",	//help522
"Allowing data from computers on a network to be accessed by other computers on the network with different levels of access rights",	//help523
"File Transfer Protocol. Easiest way to transfer files between computers on the Internet",	//help528
"Gain",	//help531
"The amount an amplifier boosts the wireless signal",	//help532
"Hashing",	//help544
"Transforming a string of characters into a shorter string with a predefined length",	//help545
"Hop",	//help548
"IIS",	//help563
"Internet Information Server is a WEB server and FTP server provided by Microsoft",	//help564
"Intranet",	//help579
"A private network",	//help580
"Intrusion Detection",	//help581
"A type of security that scans a network to detect attacks coming from inside and outside of the network",	//help582
"Java",	//help588
"A programming language used to create programs and applets for web pages",	//help589
"LPR/LPD",	//help602
"Line Printer Requestor/&quot; Line Printer Daemon&quot; . A TCP/IP protocol for transmitting streams of printer data.",	//help603
"MDI",	//help609
"Medium Dependent Interface is an Ethernet port for a connection to a straight-through cable",	//help610
"MDIX",	//help611
"Medium Dependent Interface Crossover, is an Ethernet port for a connection to a crossover cable",	//help612
"MIB",	//help613
"Management Information Base is a set of objects that can be managed by using SNMP",	//help614
"Modem",	//help615
"A device that Modulates digital signals from a computer to an analog signal in order to transmit the signal over phone lines. It also Demodulates the analog signals coming from the phone lines to digital signals for your computer",	//help616
"OFDM",	//help636
"Orthogonal Frequency-Division Multiplexing is the modulation technique for both 802.11a and 802.11g",	//help637
"OSI",	//help638
"Open Systems Interconnection is the reference model for how data should travel between two devices on a network",	//help639
"OSPF",	//help640
"Open Shortest Path First is a routing protocol that is used more than RIP in larger scale networks because only changes to the routing table are sent to all the other routers in the network as opposed to sending the entire routing table at a regular interval, which is how RIP functions",	//help641
"Personal Area Network",	//help643
"The interconnection of networking devices within a range of 10 meters",	//help644
"PoE",	//help649
"Power over Ethernet is the means of transmitting electricity over the unused pairs in a category 5 Ethernet cable",	//help650
"RJ-11",	//help672
"The most commonly used connection method for telephones",	//help673
"RS-232C",	//help676
"The interface for serial communication between computers and other related devices",	//help677
"SOHO",	//help693
"Small Office/Home Office",	//help694
"TFTP",	//help711
"Trivial File Transfer Protocol is a utility used for transferring files that is simpler to use than FTP but with less features",	//help712
"VLAN",	//help733
"Virtual LAN",	//help734
"WDS",	//help743
"Wireless Distribution System. A system that enables the interconnection of access points wirelessly.",	//help744
"Yagi antenna",	//help763
"A directional antenna used to concentrate wireless signals on a specific location",	//help764
"IGMP를 설정하면, 여기에서 멀티캐스트 그룹에 속하는 모든 멤버를 확인할 수 있습니다. ",	//_bln_title_IGMPMemberships_h
"The transmission standard being used by the client. Values are 11a, 11b, 11g, or 11n for 802.11a, 802.11b, 802.11g, or 802.11n respectively. ",	//help785
"Note that a log message uses the language that is in effect at the time of the logged event. If you change languages, you may see some log messages in one language and other log messages in another language.",	//help795a
"If you provided email information with the <a href='tools_email.asp'>Tools &rarr; Email</a> screen, clicking the <span class='button_ref'>Email Now</span> button sends the router log to the configured email address. ",	//help802
"Select this option to save the router log to a file on your computer. ",	//help803
"The Internet Sessions page displays full details of active Internet sessions through your router. An Internet session is a conversation between a program or application on a LAN-side computer and a program or application on a WAN-side computer. ",	//help813
"Internal",	//sa_Internal
"The IP address and, where appropriate, port number of the local application. ",	//help814
"External",	//sa_External
"The IP address and, where appropriate, port number of the application on the Internet. ",	//help816
"Opening or closing TCP connections.",	//help823_15
"Established or closing TCP connections. ",	//help823_17
"Select a filter that controls access as needed for this admin port. If you do not see the filter you need in the list of filters, go to the <a href='Inbound_Filter.asp' onclick='return jump_if();'>Advanced &rarr; InboundFilter</a> screen and create a new filter. ",	//help831
"Select a filter that controls access as needed for this admin port. If you do not see the filter you need in the list of filters, go to the <a href='Inbound_Filter.asp' onclick='return jump_if();'>Advanced &rarr; Inbound&nbsp;Filter</a> screen and create a new filter.",	//help831_1
"If you selected the On Schedule option, select one of the defined schedule rules. If you do not see the schedule you need in the list of schedules, go to the <a href='tools_schedules.asp'>Tools &rarr; Schedules</a> screen and create a new schedule. ",	//help872
"로컬 드라이브에 저장 ",	//ts_ss
"로컬 드라이브에서 불러오기",	//ts_ls
"공장 초기화 값으로 복구 ",	//ts_rfd
"To check for the latest firmware, click the <span class='button_ref'>Check Online Now</span> button. ",	//help877
"Some firmware upgrades reset the configuration options to the factory defaults. Before performing an upgrade, be sure to save the current configuration from the <a href='tools_system.asp'>Tools &rarr; System</a> screen. ",	//help887
"이 옵션을 설정하는 경우, 새로운 펌웨어가 나올 때마다 설정된 이메일 주소로 이메일을 전송할 것입니다. <a href='tools_email.asp'>Tools &rarr; EmailSettings</a> 페이지에서 이메일 알림 옵션을 설정해 주시기 바랍니다.",	//help890
"Select a dynamic DNS service provider from the pull-down list, or you may enter a dynamic DNS service provider manually. ",	//help893
"Or you may enter a dynamic DNS service provider manually.",	//help893b
"Add/Edit Schedule Rule",	//help191
"Saves the new or edited Schedule Rule in the following list. When finished updating the Schedule Rules, you must still click the <span class='button_ref'>Save Settings</span> button at the top of the page to make the changes effective and permanent.",	//help198
"공유기의 IP 주소를 변경하면, 관리 웹 화면으로 다시 접속하기 전에 웹 창에 변경된 IP 주소를 입력하시기 바랍니다.",	//rb_change
"공유기의 액티브 인터넷 세션의 상세사항을 확인할 수 있습니다. ",	//sa_intro
"Unknown (Please wait...)",	//_unknown_wait
"Unknown",	//_unknown
"N/A",	//_na
"No computer information yet.",	//_sdi_nciy
"DHCP Client",	//_sdi_dhcpclient
"BigPond Client",	//_sdi_bpc
"On",	//_on
"No multicast group membership information yet.",	//_bln_nmgmy
"Incorrectly configured",	//_sdi_s1
"Unknown ",	//_sdi_s6
"연결: 속도 측정",	//_sdi_s4
" Status change (please wait...)",	//_sdi_s10
"잘못된 설정- 로그를 확인하십시오. ",	//_sdi_s7
" Logged out",	//_sdi_s8
" Failed",	//_sdi_s9
"day(s),",	//_sdi_days
" (disconnection pending in",	//_sdi_disconnectpending
" seconds)",	//_sdi_secs
"DHCP Renew",	//sd_Renew
"DHCP Release",	//sd_Release
"Disconnect",	//sd_Disconnect
"BigPond Login",	//sd_bp_login
"BigPond Logout",	//sd_bp_logout
"Channel",	//_channel
"보안 모드",	//sd_SecTyp
"로그가 이메일 주소로 전송되었습니다. ",	//sl_alert_2
"전자메일 알림 기능이 활성화 되지 않았습니다. ",	//sl_alert_3
"System Logs",	//sl_SLogs
"주기적으로 로그를 메일로 받을 수 있습니다. <a href='tools_email.asp' onclick='return jump_if();'>도구 -> 이메일 설정</a> 를 참고하십시오. ",	//hhsl_lmail
"Print Server Status",	//sps_intro2
"printers are",	//sps_pare
"프린팅 프로토콜이 현재 비활성화 되어 있습니다. <a href='../Tools/PS.shtml' onclick='return jump_if();'>here</a> 에서 활성화할 수 있습니다. ",	//sps_protdis
"Routing Table",	//sr_RTable
"This page displays the routing details configured for your router.",	//sr_intro
"Network Traffic Stats",	//ss_title_stats
"Associated Wireless Client List",	//sw_title
"신호",	//_rssi
"Invalid value for Admin Idle Timeout, should be in range (1..65535)",	//ta_alert_1
"Please make the two admin passwords the same and try again",	//_pwsame_admin
"Please make the two user passwords the same and try again",	//_pwsame_user
"Invalid remote management port '+data.wan_web_port+', should be in range (1..65535)",	//ta_alert_3
"원격 관리 <a href='Inbound_Filter.asp' onclick='return jump_if();'>Inbound Filter</a>",	//ta_RAIF
"The specified Dynamic DNS Service Provider is not supported",	//_invalidddnsserver
"The specified Server Address is blank",	//_blankddnsserver
"Please check the configured Server Address",	//tt_alert_checkdyndns
"The timeout value can not be less than or equal to zero.",	//td_alert_2
"The timeout value can not be greater than 8760.",	//td_alert_3
"Dynamic DNS (DDNS)",	//td_DDNSDDNS
"Select Dynamic DNS Server",	//tt_SelDynDns	
"(e.g.: me.mydomain.net) ",	//_hostname_eg		
"이 기능을 사용하기 위해서는 반드시 드랍다운 메뉴에 있는 서비스 공급업체 중 한 회사의 DDNS 계정이 있어야 합니다. ",	//TA16
"Account Name must be valid",	//_emailaccnameisblank
"From email address should not be blank",	//_blankfromemailaddr
"To email address should not be blank",	//_blanktomemailaddr
"SMTP Server address should not be blank",	//_blanksmtpmailaddr
"The Email address ' + from_addr + ' is not valid.",	//_badfromemailaddr
"The Email address ' + to_addr + ' is not valid.",	//_badtoemailaddr
" The SMTP Server Address' + data.smtp_email_server_addr + ' is not valid.",	//_invalidsmtpserveraddr
" SMTP Server Address is not allowed",	//_badsmtpserveraddr
"Newer firmware version is available.",	//tf_NFWA
"온라인에서 펌웨어에 접속하려면 여기를 누르십시오. ",	//tf_ClickDL
"주의 : 일부 펌웨어 업그레이드로 인해 공유기 설정이 공장 초기화 값으로 리셋될 수 있습니다. \n 펌웨어 업그레이드를 실행하기 전에, 도구 -> 시스템 화면에서 현재 설정을 저장하는 것을 잊지 마십시오. \n 업그레이드 하시겠습니까? ",	//tf_USSW
"The web session has timed out. Please re-login to access this page.",	//tf_alert_1
"Based on the result of checking online, the latest firmware version is",	//tf_LFWVis
"Failed to check online. Server is unavailable or you might not be connected to the Internet.",	//tf_FailFWC
"Firmware update check is in progress.",	//tf_FWCinP
"Checking availability of new firmware",	//tf_Ching_FW
"Email notification is not enabled on Tools -> Email Settings page",	//tf_EM_not
"최신 펌웨어를 확인하려면 [Check Online Now...] 을 클릭하십시오. ",	//tf_intro_FWCh
"일부 펌웨어 업그레이드로 설정이 공장 초기화로 리셋합니다. 업그레이드를 하기 전에 <a href='tools_system.asp' onclick='return jump_if();'> 도구 &rarr; 시스템</a> 에서 현재 설정을 꼭 저장하십시오. ",	//tf_msg_FWUgReset
"Latest Firmware Version",	//tf_LFWV
"Check Online Now for Latest Firmware Version",	//tf_FWChNow
"주의 : 현재 업로드중입니다. 업로드하는데 1 분 정도 걸립니다. ",	//tf_msg_Upping
"Firmware updates are released periodically to improve the functionality of your router and to add features. If you run into a problem with a specific feature of the router, check our support site by clicking on the <strong>Check Online Now for Latest Firmware Version</strong> link and see if updated firmware is available for your router.",	//TA17
"Searching for Printers...",	//tps_sfp
"Double-click on an icon to install printer",	//tps_dci
"Print Server Setup",	//tps_intro2
"프린터의 IP 주소와 TCP 포트는 <a href='../Status/PS.shtml' onclick='return jump_if();'>here</a> 에서 확인할 수 있습니다.",	//tps_foo
"프린터의 IP 주소와 큐 이름은 <a href='../Status/PS.shtml' onclick='return jump_if();'>here</a> 에서 확인할 수 있습니다.",	//tps_foo2
"No day is selected for schedule name '+(data.sched_table[i].sched_name)+'",	//tsc_alert_1
"Invalid Time",	//tsc_alert_2
"The schedule name '+(data.sched_table[i].sched_name)+' is reserved and can not be used",	//tsc_alert_3
"This schedule is already used",	//tsc_alert_6
"There is no room for any more entries",	//tsc_alert_9
"Select Day(s)",	//tsc_SelDays
"Time Frame",	//tsc_TimeFr
"Syslog server IP address should not be same as Gateway IP address",	//tsl_alert_3
"Syslog server IP address is in WAN subnet, it should be within LAN subnet (+lan_subnet+)",	//tsl_alert_1
"Syslog server IP address should be within LAN subnet (+lan_subnet+)",	//tsl_alert_2
"공장 초기 값으로 모든 설정 복구 ",	//tss_RestAll
"Once your router is configured the way you want it, you can save the configuration settings to a configuration file. You might need this file so that you can load your configuration later in the event that the router's default settings are restored. To save the configuration, click the <strong>Save Configuration</strong> button.",	//TA18
"milliseconds. TTL =",	//tsc_pingt_msg9
"User stopped",	//tsc_pingt_msg10
"NTP Server is not configured",	//tt_alert_nontp
"Gateway Time has been updated",	//tt_alert_tupdt
"Week",	//TA24
"Day of Week",	//TA25
"<span id='show_sec'></span>초 뒤 이전 화면으로 복구되지 않을 경우, 아래 버튼을 눌러 공유기 설정을 계속하십시오. ",	//ap_intro_noreboot
"Forbidden Access",	//fb_FbAc
"Sentinel Blocked Web Access",	//sentinel_1
"Access to this Web site has been blocked on this computer by your router's Sentinel Service.",	//sentinel_2
"Contact your Sentinel Service Administrator to enable access to this page.",	//sentinal_3
"Failure",	//fl_Failure
"The new settings have NOT been saved because an error occurred.",	//fl_text
"A new firmware update is available. You will be directed to the upgrade page upon login.",	//li_newfw
"You will now be redirected to the login page.",	//rd_p_1
"If the login page does not appear, click <a href='login.asp'>this link</a>.",	//rd_p_2
"Restoring Settings",	//rs_Restoring_Settings
"The settings file is invalid.",	//reh
"Restoring Settings, Please Wait",	//rs_RSPW
"Converted local data",	//rs_cld
"Done",	//rs_Done
"Unpacked local data",	//rs_uld
"Unpacked saved data",	//rs_usd
"Converted saved data",	//rs_csd
"Repacked",	//rs_Repacked
"Converted",	//rs_Converted
"Saving",	//rs_Saving
"The router must be rebooted before the new settings will take effect. You can reboot the router now using the button below, or make other changes and then use the reboot button on the Tools/System page.",	//sc_intro_rb
"업로드한 펌웨어 파일이 잘못되었습니다.  업로드한 파일이 이 장비의 파일이 아니거나 파일이 손상되었을 수 있습니다. ",	//ub_intro_1
"파일을 업로드할 경우, 공유기의 처리량이 많아 해당 파일을 수신하기에 매우 바쁠 수도 있습니다. 이 경우, 업로드를 다시 시도하시기 바랍니다. '관리자' 계정 대신에 '사용자' 계정으로 로긴할 수도 있지만, 관리자 계정으로만 새로운 펌웨어를 업로드할 수 있습니다.",	//ub_intro_3
"권한 부족 ",	//_cantapplysettings
"<strong>user</strong> 계정이 요청을 처리하지 못했습니다. ",	//ca_intro
"Re-login",	//_relogin
"게이트웨이가 현재 네트워크 연결을 확인하고 있습니다. ",	//wt_p_1
"웹페이지 접속이 측정에 영향을 줄 수 있습니다.",	//wt_p_2
"잠시 후 페이지가 새로 고침됩니다.",	//wt_p_3
"마법사가 설정 단계를 안내할 것입니다. <em>Next</em> 버튼을 눌러 시작하시기 바랍니다. ",	//wprn_intro2
"프린터 설치 마법사는 Windows XP/2000/98/ME 환경에서 정상 동작 합니다. 현재 사용중인 컴퓨터는 <span id='wz_page_1_err_1_os'>&nbsp;</span> 시스템 환경 입니다.",	//wprn_bados2
"다른 프린터가 검색 되었습니다. 프린터를 설치하려면 <em>Next</em> 를 클릭하십시오. ",	//wprn_s1a
"<em>Refresh</em> 눌러 다시 시도하십시오. ",	//wprn_tt5
"프린터 문제를 해결하려면 <em>Refresh</em> 눌러 프린터 상태를 업데이트하십시오. ",	//wprn_tt6
"OR, <em>Next</em> 버튼을 눌러 계속 진행하고 인쇄 테스트 페이지를 할 것인지 물으면 <em>No</em> 를 누르십시오.  ",	//wprn_tt7
"<em>Next</em> 버튼을 누르면, 실행 파일을 다운 받을지를 물어봅니다. <em>Run/Open</em> 을 누르면, PC에서 실행할 수 있습니다. 퍼블리서를 확인하는 두 번째 창이 나타나면, <em>Run</em> 를 한번 더 누르십시오.",	//wprn_s2b
"<em>다음</em> 버튼을 누른 후, 실행 파일을 다운로드할 수 있는 권한을 요청받습니다. 'OK' 버튼을 눌러 파일을 다운로드하십시오. <br/><br/>파일 브라우저를 사용하여 파일 다운로드 폴더를 열고 <em>Printer_Setup.exe</em> 를 더블 클릭하여 실행하십시오.",	//wprn_s2c
"현재 실행시킨 설정마법사는 실행 상태를 바를 통해 보여주며 실행완료 후 알려드립니다. 설치 완료후에는 프린트 설치 마법사를 완료하기 위해 <em>Finish</em>를 누르시기 바랍니다. ",	//wprn_s3a
"PC에 다운로드 한 후 실행 파일이 자동으로 시작되지 않으면, 파일 브라우저를 사용하여 <em>Printer_Setup.exe.</em> 파일을 두 번 클릭 후 폴더를 직접 실행하십시오.",	//wprn_tt10
"Invalid WAN subnet mask.",	//_badWANsub
"Invalid Gateway IP address.",	//wwa_pv5_alert_4
"The gateway IP address is not in the WAN subnet",	//wwa_pv5_alert_5
"You must specify the primary DNS server",	//wwa_pv5_alert_8
"Invalid Primary DNS IP address.",	//wwa_pv5_alert_6
"Invalid Secondary DNS IP address.",	//wwa_pv5_alert_7
"The User Name field can not be blank",	//wwa_pv5_alert_21
"Invalid PPTP Gateway IP Address",	//_badPPTPgwip
"Invalid PPTP Server address",	//wwa_pv5_alert_15
"Invalid L2TP Gateway IP Address",	//_badL2TPgwip
"Invalid L2TP Server address",	//wwa_pv5_alert_20
"사용자명 비밀번호 연결 설정 (PPTP)",	//wwa_title_set_pptp
"무선 보안 비밀번호는 5자 또는 13자의 상용문자로 구성되어야 합니다.",	//wwl_alert_pv5_1
"WEP 비밀번호는 정확히 13 자리 영, 숫자입니다. ",	//wwl_alert_pv5_2
"WEP 키는 반드시 26자의  헥사값 (0-9 or A-F) 을 입력하십시오.",	//wwl_alert_pv5_3
"무선 보안 비밀번호는 최소 8 문자입니다. ",	//wwl_alert_pv5_4
"무선 보안 설정 마법사에 오신 것을 환영합니다.",	//wwl_title_wel
"마법사를 사용하여 단계별 프로세스로 무선 네트워크와 무선 보안을 설정합니다. ",	//wwl_intro_wel
"무선 네트워크에서는 무선 클라이언트가 쉽게 확인할 수 있는 이름이 필요합니다.  보안을 위해, 디폴트로 설정되어 있는 네트워크 이름을 변경하실 것을 권장합니다.",	//wwl_intro_s1
"In order to protect your network from hackers and unauthorized users, it is highly recommended you choose one of the following wireless network security settings.",	//wwl_intro_s3_1
"There are three levels of wireless security -Good Security, Better Security, AND Best Security. The level you choose depends on the security features your wireless adapters support.",	//wwl_intro_s3_2r
"BETTER ",	//wwl_BETTER
"무선 어댑터가 WPA 를 지원한다면 이 옵션을 선택하십시오",	//wwl_text_better
"무선 랜카드가 WPA를 지원하지 않는 경우 이 옵션을 선택하십시오. ",	//wwl_text_good
"보안 단계를 선택하십시오. - 무선 보안 비밀번호 설정이 필요합니다. ",	//wwl_s4_intro
"주의: 적절한 무선 통신을 이루기 위해 이번 단계에서 설정한 동일한 key를 무선 클라이언트에 입력해야 합니다. ",	//wwl_s4_note
"Wireless Security Password",	//wwl_WSP_1
"(13 characters or 26 hex digits)",	//wwl_wsp_chars_1
"(8 to 63 characters)",	//wwl_wsp_chars_2
"128 bits ",	//wwl_128bits
"사용가능한 기본 WEP Key",	//wwl_DWKL
"Wep Key ",	//wwl_WK
"WPA-PSK/TKIP (also known as WPA Personal)",	//wwl_wpa
"WPA2-PSK/AES (also known as WPA2 Personal)",	//wwl_wpa2
"TELNET",	//gw_vs_0
"REMOTE DESKTOP",	//gw_vs_8
"AIM Talk",	//gw_sa_0
"Calista IP phone",	//gw_sa_2
"ICQ",	//gw_sa_3
"MSN Messenger",	//gw_sa_4
"PalTalk",	//gw_sa_5
"Select BigPond Server",	//gw_SelBPS
"Name1",	//gw_bp_0
"Name2",	//gw_bp_1
"Name3",	//gw_bp_2
"Please accept and install the ActiveX, then try it again.",	//gw_wcn_alert_3
"WCN ActiveX control is not available. Please check the security setting and refresh this page to install it.",	//gw_wcn_alert_4
"WCN does not support key index other than 1 now.",	//gw_wcn_alert5
"WCN does not support WPA2 mode now.",	//gw_wcn_alert6
"WCN does not support WPA enterprise authentication now.",	//gw_wcn_alert7
"Wireless settings saved successfully",	//gw_wcn_err_ok
"Error code",	//gw_wcn_err_code
"This version of the operation system does not support WCN",	//gw_wcn_err_os_version
"Loading the Wireless Configuration file failed. Please run Windows Wireless Network Setup Wizard to create/re-create the configuration file",	//gw_wcn_err_load_config
"Failed to add the wireless profile. Please make sure that the new SSID does not conflict with an existing profile",	//gw_wcn_err_provision
"Failed to write wireless data in to configuration file. Please check the security setting",	//gw_wcn_err_io_write_config
"Failed to encrypt wireless data.",	//gw_wcn_err_encryption
"Internal exception occured",	//gw_wcn_err_exception
"WCN ActiveX control is not registered. Please check the security setting and refresh this page to install it.",	//gw_wcn_err_com
"Invalid wireless settings. Please check wireless settings",	//gw_wcn_err_bad_wsetting_entry
"Cannot create the wirless profile XML file",	//gw_wcn_err_bad_wps_profile
"WPA security mode is not enabled. Please check WPA security settings",	//gw_wcn_err_unsupported_wsetting
"MSXML2 DOM parser failed to parse the string in XML format",	//gw_wcn_err_dom_processing
"Unexpected error",	//gw_wcn_err_default
"Everyone allowed",	//adv_Everyone
"No one allowed",	//adv_Noone
"Queued",	//psQueued
"Starting",	//psStarting
"Closed",	//psClosed
"Idle",	//psIdle
"Ready",	//psReady
"Offline",	//psOffline
"Unplugged",	//psUnplugged
"Printing",	//psPrinting
"Paper Error",	//psPaperError
"The string ' + value + ' is too long\n(maximum length is ' + length + ' characters).",	//up_gS_1
"The number ' + value + ' is not valid.",	//up_gIUH_1
"The number ' + value + ' must be positive.",	//up_gIUH_2
"The number ' + value + ' should be in between '+ min + ' to ' + max + '.",	//up_gIUH_3
"The hex string ' + value + ' is not valid.",	//up_gH_1
"There is no room for any more entries.",	//up_ae_se_1
"The '+this.primary_key_name+' field can not be blank",	//up_ai_se_2
"this.primary_key_name+'+ this.thearray[-1][this.primary_key] +' is already used",	//up_ae_se_3
"You have unsaved changes in the entry you are editing.",	//up_ae_wic_1
"Press &quot; Ok&quot;  to abandon these changes and perform the requested action.",	//up_ae_wic_2
"Nothing has changed on this page. Do you want to save it anyway?",	//up_nosave
"Do you want to abandon all changes you made to this page?",	//up_fm_dc_1
"The restoration of settings failed",	//up_fm_re_1
"Press OK to continue",	//up_fm_re_2
"bad settings file",	//up_fm_dr_1
"Bad settings file",	//up_fm_dr_2
"Restored data not acceptable",	//up_fm_dr_3
"The action can not complete because the network connection seems to be down",	//up_if_1
"다시 시작하면 연결되어 있는 모든 인터넷 세션이 끊어집니다. ",	//up_rb_2
"Rebooting.",	//up_rb_3			
"Resetting to factory defaults and rebooting.",	//up_rb_6			
"The +name+' port range string ''+input_string+'' is invalid.'",	//up_vp_1			
"The +name+' port ''+n+'' in the port range string ''+input_string+'' should be in between 1 to 65535.'",	//up_vp_2			
"The +name+' port range''+got2[0]+'' in the port range string ''+input_string+'' should go from low port to high port.'",	//up_vp_3			
"The +name+' port range string can't be empty.'",	//up_vp_0			
"A MAC address field can not be empty.",	//up_vm_1			
"input_string+' is not a valid MAC address'",	//up_vm_2			
"(GMT+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm ",	//up_tz_26
"(GMT+01:00) Belgrade, Brastislava, Ljubljana ",	//up_tz_27
"(GMT+01:00) Sarajevo, Skopje, Sofija, Vilnus, Zagreb ",	//up_tz_29
"(GMT+13:00) Nuku'alofa, Tonga ",	//up_tz_73
"An error occurred on this page. This might be because you are\n+ &quot; not properly logged in, for example just after a reboot.\n&quot; ",	//up_he_1			
"Press OK to go to the login page, or Cancel if you want to see\n+ &quot; the error message.&quot; ",	//up_he_2			
"The error on line +line+' of '+url+' is \n\''+msg+'\'.'",	//up_he_5		
"PPP network down",	//IPPPPIPCP_PPP_LINK_DOWN			
"PAP authentication failed - please check login details.",	//IPPPPPAP_AUTH_FAIL
"PPP 네트워크가 다운되었습니다. ",	//IPPPPIPCP_PPP_LINK_DOWN
"HNAP SetDeviceSettings 를 DeviceName '%s' 로 수정하였습니다. ",	//GW_PURE_SETDEVICESETTINGS
"고급 네트워크 ",	//ADVANCED_NETWORK
"Lease assignment attempt fail - detected a LAN host active with address %v and MAC of %m",	//IPDHCPSERVER_HOST_IS_ACTIVE
"%S service authorization failed service is unregistered",	//BSECURE_LOG_AUTH_FAIL_UNREG
"Estimated rate of link is %d kbps",	//RATE_ESTIMATOR_RATE_IS
"Filter - Denied packet from IP address %v port %u, protocol %u, to %v port %u",	//GW_IPFILTER_DENY
"HNAP AddPortMapping '%s' %v:%d<->%v:%d %S 가 %dth virtual server entry '%s' %v:%d<->%v:%d %S 와 충돌합니다. ",	//GW_PURE_ADDPORTMAPPING_CONFLICT
"HNAP SetDeviceSettings wan %S, %v/%v/%v 설정 ",	//GW_PURE_SETWANSETTINGS
"Unable to create connection to email server",	//GW_SMTP_EMAIL_CANNOT_CREATE_CONNECTION
"IP 주소가 %v인 PPP 네트워크가 동작합니다.",	//IPPPPIPCP_PPP_LINK_UP
"Dropped packet to illegal destination %v from %v",	//IPNAT_ILLEGAL_DEST
"HNAP AddPortMapping 은 %dth 서버 엔트리 주소를 '%s' %v:%d<->%v:%d %S 에서 %S로 수정하였습니다. ",	//GW_PURE_ADDPORTMAPPING_CHG_PROTOCOL
"%S filter server disconnected timeout",	//BSECURE_LOG_FLTR_DISCONNECTED_TIMEOUT
"The client %02x%02x%02x%02x%02x%02x had its lease (%v) revoked.",	//IPDHCPSERVER_LEASE_REVOKED1
"Previous message repeated 1 time",	//LOG_PREV_MSG_REPEATED_1_TIME
"DHCP 서버 시작 ",	//GW_DHCPSERVER_START
"Administrator ",	//ADMIN
"HNAP DeletePortMapping %s:%d 가 %dth 가상 서버 엔트리 '%s' %v:%d<->%v:%d %S 를 %S 로 수정합니다.",	//GW_PURE_DELETEPORTMAPPING_MODIFY
"HNAP AddPortMapping  %dth 가상 서버 엔트리 '%s' %v:%d<->%v:%d %S 를 생성하였습니다.  ",	//GW_PURE_ADDPORTMAPPING_CREATE
"가상 서버",	//VIRTUAL_SERVERS
"UPnP deleted entry %v <-> %v%d %S",	//GW_UPNP_PORTMAP_DEL
"HNAP 리부팅 ",	//GW_PURE_REBOOT
"Unable to send email as \'%s\' is not a valid &quot; To&quot;  address",	//GW_SMTP_EMAIL_INVALID_TO_ADDRESS
"로그 메일 송신 실패 - %d 분 후에 다시 시도하십시오. ",	//GW_LOG_EMAIL_FAILED
"HNAP SetMACFilters2 ",	//GW_PURE_SETMACFILTERS2
"상기 메세지는 %d 번 반복되었습니다. ",	//LOG_PREV_MSG_REPEATED_N_TIMES
"%S filter server disconnected closed",	//BSECURE_LOG_FLTR_DISCONNECTED_CLOSED
"Lease expired %v - was reassigned because a client specifically requested this address",	//IPDHCPSERVER_LEASE_EXPIRED_SPECIFIC
"HNAP SetRouterLanSettings 이 RouterIPAddress %v, RouterSubnetMask %v, DHCPServerEnabled %s 을 설정합니다. ",	//GW_PURE_SETROUTERLANSETTINGS
"%S service authorization passed",	//BSECURE_LOG_AUTH_PASS
"%S service authorization failed auth server returned UNKNOWN error",	//BSECURE_LOG_AUTH_FAIL_UNKNW
"PAP sent authentication \'%s\' response to remote peer.",	//IPPPPPAP_AUTH_RESULT
"%S service authorization failed service needs renewal",	//BSECURE_LOG_AUTH_FAIL_RENEW
"게이트웨이 원격 관리를 포트 : %u 에 활성화하였습니다. ",	//GW_REMOTE_ADMINSTRATION
"Client %m wanted specific address (%v) but it is not available",	//IPDHCPSERVER_LEASE_DENIED
"Unable to send email (connection timed out)",	//GW_SMTP_EMAIL_TIMEOUT
"%S service authorization failed auth server returned DB error",	//BSECURE_LOG_AUTH_FAIL_DB
"DHCP Server Parameter %u was updated",	//IPDHCPSERVER_PARAM_DB_UPDATED
"Application Rules",	//APP_RULES
"Lease table full",	//IPDHCPSERVER_LEASE_POOL_FULL
"PAP authentication timed out - authentication failed.",	//IPPPPPAP_AUTH_TIMEOUT
"Advanced Networks",	//ADVANCED_NETWORKS
"Assigned new lease %v to client %m",	//IPDHCPSERVER_LEASE_ASSIGNED
"%S filter server connected",	//BSECURE_LOG_FLTR_CONNECTED
"%S auth server connected",	//BSECURE_LOG_AUTH_CONNECTED
"%S service authorization failed auth response packet corrupted",	//BSECURE_LOG_AUTH_FAIL_PKT
"SMTP client failed to connect to server %v",	//IPSMTPCLIENT_CONN_FAILED
"PAP authentication successful.",	//IPPPPPAP_AUTH_SUCCESS
"%s 로 인해 WCN 설정이 중단되었습니다. ",	//WCN_LOG_ABORT
"기타",	//MISC
"Latest firmware version retrieved from the server was %d.%d",	//GW_LOG_ON_LATEST_FIRMWARE_RETRIEVED
"Unable to send email (send status %u)",	//GW_SMTP_EMAIL_SEND_FAILURE
"Lease %v released by client %m",	//IPDHCPSERVER_LEASE_RELEASED
"PPPoE 를 통해 할당된 IP 주소가 LAN 구간의 IP 대역과 충돌합니다. 이 문제를 해결하기 위하여 LAN 구간의 IP 대역을 변경하지 않을 경우 인터넷 연결이 제한됩니다. ",	//GW_WAN_LAN_ADDRESS_CONFLICT_DHCP
"HNAP SetWLanSecurity 이 %s 활성화, 유형 %s 을 설정하였습니다. ",	//GW_PURE_SETWLANSECURITY
"HNAP DeletePortMapping %s:%d 가 %dth 가상 서버 엔트리 '%s' %v:%d<->%v:%d %S 를 삭제하였습니다. ",	//GW_PURE_DELETEPORTMAPPING_DELETE
"HNAP AddPortMapping %dth 가상 서버 엔트리를 %s' %v:%d<->%v:%d %S 에서 '%s' %v:%d<->%v:%d %S 로 수정하였습니다.  ",	//GW_PURE_ADDPORTMAPPING_MODIFY
"DHCP Server Parameter %u was added to the parameter database",	//IPDHCPSERVER_PARAM_DB_ADDED
"PAP issued an authentication request.",	//IPPPPPAP_AUTH_ISSUE
"UPnP added entry %v <-> %v%d <-> %v%d %S timeout%d '%s'",	//GW_UPNP_PORTMAP_ADD
"HNAP SetWLanSettings24 set Enabled %s, SSIDBroadcast %s, Channel %d ",	//GW_PURE_SETWLANSETTINGS24
"Unable to send email as server IP address is not known",	//GW_SMTP_EMAIL_NO_SERVER_IP_ADDRESS
"UPnP renew entry %v <-> %v%d <-> %v%d %S timeout%d '%s'",	//GW_UPNP_PORTMAP_REFRESH
"UPnP expired entry %v <-> %v%d <-> %v%d %S '%s'",	//GW_UPNP_PORTMAP_EXPIRE
"DHCP Server Parameter %u was removed from the parameter database",	//IPDHCPSERVER_PARAM_DB_REMOVED
"Lease was deleted from server pool %v",	//IPDHCPSERVER_LEASE_DELETED
"UPnP conflict with existing entry %v <-> %v%d <-> %v%d %S '%s'",	//GW_UPNP_PORTMAP_CONFLICT
"Not all of the needed components have been loaded; this page will refresh.",	//TA1
"is not a valid IP address",	//aa_alert_11
"IP 주소는 LAN 서브넷에 포함되어야 합니다. ",	//aa_alert_12
"This Access Control rule is already defined by the Policy  + data.access_ctrl_table[i].policy_name",	//aa_alert_1
"정책 명을 공백으로 두지 마십시오. ",	//aa_alert_9
"There are ' + unsaved_policies + ' unsaved policies, do you want to abandon these policies.",	//aa_sched_conf_3
"장비를 입력하십시오. ",	//aa_alert_10
"필터를 선택해 주십시오. ",	//aa_alert_13
"The Port Filter rule ' + data.access_ctrl_table[-1].port_filter_table[i].entry_name + ' is duplicated.",	//aa_alert_16
"Destination IP Start address for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+' should not be in LAN subnet ('+lan_subnet+')",	//aa_alert_2
"Destination IP End address for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+' should not be in LAN subnet ('+lan_subnet+')",	//aa_alert_3
"Invalid destination IP address range for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+'",	//aa_alert_4
"Invalid destination port range for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+' should be in range (1..65535)",	//aa_alert_5
"Destination start port for Port Filter = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+' should not be greater than destination end port",	//aa_alert_6
"Product Page",	//TA2
"하드웨어 버전",	//TA3
"Others",	//aa_AT_2
"Helpful Hints",	//TA5
"More",	//TA6
"Copyright &copy; 2004-2006 DLink, Inc.",	//_copyright
"The valid range for fragmentation threshold is 256..65535",	//aw_alert_1
"The valid range for RTS threshold is 1..65535",	//aw_alert_2
"The valid range for beacon period is 20..1000",	//aw_alert_3
"The valid range for DTIM interval is 1..255",	//aw_alert_4
"추가 무선 보호",	//aw_erpe
"DMZ address should be within LAN subnet (+lan_subnet+')",	//af_alert_1
"DMZ Address is not allowed",	//af_alert_2
"방화벽 기능으로 공유기 PC 한 대를 공유기 외부 네트워크에 두는 것처럼 설정할 수 있습니다. ",	//af_intro_x
"(automatically disabled if UPnP is enabled)",	//TA19
"DMZ 옵션은 마지막 수단으로 사용하십시오. 공유기에 연결되어 있는 PC 에서 응용프로그램 사용에 문제가 있는 경우 <a href='adv_virtual.asp' onclick='return jump_if();'>가상서버</a> 또는 <a href='adv_portforward.asp' onclick='return jump_if();'>포트 포워딩</a> 에서 응용프로그램과 관련된 포트를 열어 주시기 바랍니다. ",	//hhaf_dmz
"This '+ data.game_rules[j].entry_name + ' record is already present.",	//ag_alert_4
"This '+ data.game_rules[j].entry_name + ' record is duplicate of '' + data.game_rules[i].entry_name + ''.",	//ag_alert_5
"'TCP ports ['+data.game_rules[i].tcp_ports_to_open+'] conflicts with '+data.game_rules[j].entry_name+' TCP ports ['+data.game_rules[j].tcp_ports_to_open+']'",	//ag_conflict10
"'UDP ports ['+data.game_rules[i].udp_ports_to_open+'] conflicts with '+data.game_rules[j].entry_name+' UDP ports ['+data.game_rules[j].udp_ports_to_open+']'",	//ag_conflict20
"Please select a schedule for record ' + data.game_rules[i].entry_name + ''.'",	//ag_conflict21
"IP address for '+data.game_rules[i].entry_name+'' should be within LAN subnet ('+lan_subnet+')'",	//ag_alert_1
"IP Address for '+data.game_rules[i].entry_name+'' is not allowed'",	//ag_alert_3
"Both 'TCP Ports to Open' and 'UDP Ports to Open' fields can not be blank",	//ag_alert2
"TCP ports",	//_tcpports
"UDP ports",	//_udpports
"TCP ports[' + data.game_rules[i].tcp_ports_to_open + '] conflicts with Remote Management Port",	//ag_conflict4
"You can not change name of this entry because it is used on the '+used_page+' page.",	//tsc_alert_7
"Invalid source IP Range for '+data.ingress_rules[i].ingress_filter_name+'+' ('+data.ingress_rules[i].ip_range_table[j].ip_start+', +data.ingress_rules[i].ip_range_table[j].ip_end+)'",	//ai_alert_3
"Enable at least one Source IP Range for ''+ data.ingress_rules[i].ingress_filter_name",	//ai_alert_5
"The inbound filter range ' + data.ingress_rules[i].ip_range_table[k].ip_start + '-' + data.ingress_rules[i].ip_range_table[k].ip_end + '' is duplicated.'",	//ai_alert_7
"The inbound filter name '+(data.ingress_rules[i].ingress_filter_name)+'' is reserved and can not be used'",	//ai_alert_4
"The inbound filter rule '' + data.ingress_rules[-1].ingress_filter_name + '' is duplicated.'",	//ai_alert_6
"You can not delete this entry because it is used on the +x+ page.",	//tsc_alert_5
"Inbound Filter Rules",	//ai_title_2
"Edit",	//_edit
"Source IP Range",	//_srcip
"Source IP Start",	//ai_c2
"Source IP End",	//ai_c3
"아래의 규칙 목록에 있는 규칙을 저장하려면 <strong>추가</strong> 버튼을 클릭하십시오.",	//hhai_save
"The ' + saved_records[i].mac_addr + ' MAC address is duplicate.",	//amaf_alert_1
"Deny access to all except the machines in this list (subject to &quot; Filter Settings&quot; )",	//am_cMT_deny
"Allow access to all except the machines in this list (subject to &quot; Filter Settings&quot; )",	//am_cMT_Allow
"WAN Ping <a href='Inbound_Filter.asp' onclick='return jump_if();'>Inbound Filter</a>",	//bwn_IF
"자동 10/100/1000Mbps",	//anet_wp_2
"No routes information yet.",	//_sr_nriy
"This internal route is already used",	//ar_alert_1
"This Route is already Present",	//ar_alert_2
"Metric value should be in between (1..16).",	//ar_alert_3
"Next Hop not on the specified interface",	//ar_alert_4
"Invalid Netmask.",	//ar_alert_5
"The Routing option allows you to define fixed routes to defined destinations.",	//ar_RoutI
"Route",	//ar_Route
"Routes List",	//ar_RoutesList
"Delete",	//_delete
"Existing routes",	//ar_ERTable
"The Application Rules name ' + saved_records[i].entry_name + ' is duplicated.",	//ag_alert_duplicate_name
"The Application Rules name ' + saved_records[j].entry_name + ' is duplicate of ' + saved_records[i].entry_name + '",	//ag_alert_duplicate
"This Rule is already used",	//ag_inuse
"Trigger port range '+protocols[ae.thearray[-1].trigger_ports.protocol]+' ['+ae.thearray[-1].trigger_ports.port_range+'] conflicts with '+saved_records[i].entry_name+''+protocols[saved_records[i].trigger_ports.protocol]+' ['+saved_records[i].trigger_ports.port_range+']'",	//_specapps_alert_2
"Trigger port range",	//_specapps_tpr
"Input port range",	//_specapps_ipr
"Special Applications Rule",	//as_title_SAR
"Trigger Port Range",	//as_TPRange
"ex.",	//as_ex
"Trigger Protocol",	//as_TPR
"Input Port Range",	//as_IPR
"Input Protocol",	//as_IPrt
"Max transmission rate should be between 8 kbps and 100 Mbps, inclusive.",	//at_alert_1
"Name can not be blank.",	//at_alert_15
"Rule ''+data.qos_rules[i].entry_name+'' Priority '+data.qos_rules[i].priority+' should be between 1 and 255, inclusive.'",	//at_alert_16
"Rule ''+data.qos_rules[i].entry_name+'' Protocol can not be blank.'",	//at_alert_17
"Rule ''+data.qos_rules[i].entry_name+'' Source IP Range ''+data.qos_rules[i].source_ip_start+'' should be within LAN subnet ('+lan_subnet+').'",	//at_alert_2
"Rule ''+data.qos_rules[i].entry_name+'' Source IP Range ''+data.qos_rules[i].source_ip_start+'' is invalid.'",	//at_alert_18
"Rule ''+data.qos_rules[i].entry_name+'' Source IP Range ''+data.qos_rules[i].source_ip_end+'' should be within LAN subnet ('+lan_subnet+').'",	//at_alert_3
"Rule ''+data.qos_rules[i].entry_name+'' Source IP Range ''+data.qos_rules[i].source_ip_end+'' is invalid.'",	//at_alert_19
"Rule ''+data.qos_rules[i].entry_name+'' Source IP Range is invalid.'",	//at_alert_4
"Rule ''+data.qos_rules[i].entry_name+'' Destination IP Range ''+data.qos_rules[i].dest_ip_start+'' should not be within LAN subnet ('+lan_subnet+').'",	//at_alert_5
"Rule ''+data.qos_rules[i].entry_name+'' Destination IP Range ''+data.qos_rules[i].dest_ip_start+'' is invalid.'",	//at_alert_20
"Rule ''+data.qos_rules[i].entry_name+'' Destination IP Range ''+data.qos_rules[i].dest_ip_end+'' should not be within LAN subnet ('+lan_subnet+').'",	//at_alert_6
"Rule ''+data.qos_rules[i].entry_name+'' Destination IP Range ''+data.qos_rules[i].dest_ip_end+'' is invalid.'",	//at_alert_21
"Rule ''+data.qos_rules[i].entry_name+'' Destination IP Range is invalid.'",	//at_alert_8
"Rule ''+data.qos_rules[i].entry_name+'' Source Port Range should be between 0 and 65535, inclusive.'",	//at_alert_7
"Source Port start for rule ''+data.qos_rules[i].entry_name+'' should be less than Source Port end.'",	//at_alert_10
"Rule ''+data.qos_rules[i].entry_name+'' Destination Port Range should be between 0 and 65535, inclusive.'",	//at_alert_9
"Destination Port start for rule ''+data.qos_rules[i].entry_name+'' should be less than Destination Port end.'",	//at_alert_11
"Name ''+data.qos_rules[i].entry_name+'' is already used.'",	//at_alert_22
"Source/Destination IP Range for ''+data.qos_rules[j].entry_name+'' is overlapped with ''+data.qos_rules[i].entry_name+''.'",	//at_alert_23
"Source/Destination IP/Port Range for ''+data.qos_rules[j].entry_name+'' is overlapped with ''+data.qos_rules[i].entry_name+''.'",	//at_alert_24
"Protocol &quot; ANY&quot;  includes ICMP so port ranges are disabled. Select TCP or UDP if you want to configure port ranges.",	//at_alert_14
"StreamEngine&trade; 기술이 적용되는 디링크 QoS 엔진 기능을 설정하십시오. QoS 엔진 기능으로 FTP 또는 웹 같은 네트워크 트래픽 보다 온라인 게임에 우선 순위를 부여하여 온라인 게임을 즐길 수 있습니다. ",	//at_intro
"최적의 성능을 위하여 어플리케이션의 우선순위를 자동으로 설정되도록 자동 분류 옵션을 사용하십시오",	//at_intro_2
"QoS 엔진 설정 ",	//at_title_SESet
"QoS 엔진 설정",	//at_ESE
"검색된 xDSL 또는 프레임 릴레이 네트워크",	//at_DxDSL
"QoS 엔진 규칙",	//at_title_SERules
"(1..255) ",	//at_lowpriority
"ANY",	//at_Prot_0
"Source Port Range",	//_srcport
"Destination IP Range",	//at_DIPR
"Destination Port Range",	//at_DPR
"The record ' + data.virtual_servers[i].entry_name + ' is duplicated.",	//av_alert_11
"The record ' + data.virtual_servers[j].entry_name + ' is duplicate of ' + data.virtual_servers[i].entry_name + '.",	//av_alert_21
"Please select a schedule for record ' + data.virtual_servers[i].entry_name + '.",	//av_alert_24
"IP address for ' + data.virtual_servers[i].entry_name + ' should be within LAN subnet ('+lan_subnet+')",	//av_alert_1
"IP address for ' + data.virtual_servers[i].entry_name + ' is not allowed",	//av_alert_2
"Private port for ' + data.virtual_servers[i].entry_name + ' should be in range (1..65535)",	//av_alert_3
"Public port for ' + data.virtual_servers[i].entry_name + ' should be in range (1..65535)",	//av_alert_4
"Public port should not be same as Remote Management Port",	//av_alert_12
"Cannot create an entry for ICMP (protocol 1) as this will prevent the router from working correctly",	//av_alert_18
"Cannot create an entry for IGMP (protocol 2) as this will prevent the router from working correctly",	//av_alert_23
"Please select TCP instead of protocol 6 and specify port details",	//av_alert_19
"Please select UDP instead of protocol 17 and specify port details",	//av_alert_20
"Other protocol for ' + data.virtual_servers[i].entry_name + ' should be in range (3..5, 7..16 or 18..255)",	//av_alert_13
"Protocol for ' + data.virtual_servers[i].entry_name + ' is overlapped with ' + data.virtual_servers[j].entry_name+'",	//av_alert_17
"Ports for ' + data.virtual_servers[i].entry_name + ' are overlapped with ' + data.virtual_servers[j].entry_name+'",	//av_alert_5
"Private Port for ' + data.virtual_servers[i].entry_name + ' conflicts with ' + data.virtual_servers[j].entry_name+'",	//av_alert_6
"FTP ALG has been enabled",	//av_alert_7
"PPTP ALG has been enabled",	//av_alert_8
"Wake-On-LAN ALG has been enabled",	//av_alert_9
"H.323 ALG has been enabled",	//av_alert_10
"Public",	//_public
"Other",	//_other
"Private",	//_private
"가상 서버를 설정할 때 이 스케쥴을 선택하십시오. 스케쥴 리스트에 필요한 스케쥴이 없으면, <a href='tools_schedules.asp' onclick='return jump_if();'>도구 &rarr; 스케줄</a> 로 가서 새로운 스케쥴을 만드십시오.  ",	//hhav_sch
"등록한 클라이언트만 가상서버(virtual server)에 접속할 수 있도록 외부에 있는 클라이언트를 제한하는 필터를 선택하십시오. 필터 리스트에 필요한 필터가 없으면, <a href='Inbound_Filter.asp' onclick='return jump_if();'> 고급 -> 수신필터</a> 로 가서 새 필터를 생성하십시오.",	//hhav_filt
"Web Site",	//aa_WebSite
"https is not a supported protocol.",	//awf_alert_4
"The web site address ' + data.web_filter[i].url + ' already used.",	//awf_alert_5
"The web site addresses ' + invalid_wf_str + ' are invalid.",	//awf_alert_7
"The web site address ' + invalid_wf_str + ' is invalid.",	//awf_alert_8
"<a href='adv_access_control.asp' onclick='return jump_if();'>Advanced &rarr; AccessControl</a>를 사용하십시오. ",	//hhwf_xref
"Internet Connection Wizard",	//int_ConWz2
"If you would like to utilize our easy to use Web-based Wizards to assist you in connecting your new DLink Router to the Internet, as well as configure the Wireless settings, click on the Setup Wizard button below.",	//int_intro_ConWz
"Manual Internet Connection Options",	//int_WlsWz
"If you would like to configure the Internet settings of your new DLink Router manually, then click on the Manual Configure button below.",	//int_intro_WlsWz
"If you are new to networking and have never configured a router before, click on <strong>Setup Wizard</strong> and the router will guide you through a few simple steps to get your network up and running.",	//hhbi_wiz
"If you consider yourself an advanced user and have configured a router before, click <strong>Manual Configure</strong> to input all the settings manually.",	//hhbi_man
"No dynamic clients detected yet.",	//bd_noneyet
"The lease has been revoked",	//bd_revoked
"LAN IP 주소가 잘못되었습니다. ",	//bln_alert_2
"LAN subnet conflicts with WAN subnet",	//bln_alert_3
"The DHCP address range FROM is not in the LAN subnet.",	//bd_alert_10
"The DHCP address range TO is not in the LAN subnet.",	//bd_alert_11
"The DHCP FROM address does not contain a valid host starting value.",	//bd_alert_1
"The DHCP address range should go from a low address to a high address, not high to low",	//bd_alert_3
"The DHCP address range must not include the subnet broadcast address.",	//bd_alert_13
"The number of IP addresses in the range exceeds a limit of 256.",	//bd_alert_12
"DHCP Lease Time can not be 0",	//bd_alert_5
"Reserved IP address for this MAC address ('+ae.thearray[-1].mac_addr+') is already set",	//bd_alert_6
"Reserved IP address for this Computer Name ('+ae.thearray[-1].comp_name+') is already set",	//bd_alert_7
"A reservation cannot be the same as the configured LAN IP Address.",	//TA20
"Reserved IP address should be within the configured DHCP range.",	//bd_alert_8
"네트워크에 DHCP 서버가 이미 동작 중이거나 허브로 사용하실 경우에는 이 기능을 비활성화하기 위해 <strong>DHCP 서버 설정 </strong> 의 체크를 없애십시오.",	//TA7
"항상 고정 IP를 사용해야 하는 장비가 있는 경우, 각 장비에 <strong>DHCP Reservation </strong> 를 추가하십시오. ",	//TA8
"Must specify primary DNS server before supplying a secondary DNS server",	//bd_alert_22
"Invalid Primary dns IP address",	//bd_alert_23
"Invalid Secondary dns IP address",	//bd_alert_24
"Invalid WAN IP address",	//_badWANIP
"Invalid WAN subnet mask",	//bwn_alert_2
"The default gateway address is not in the WAN subnet",	//bwn_alert_3
"DNS are not configured. The clients will not be able to resolve domain names. Proceed ?",	//bwn_alert_4
"WAN subnet conflicts with LAN subnet",	//bwn_alert_5
"Please enter a user name and try again",	//_nousername
"The maximum idle time should be in the range 0..600",	//bwn_alert_8
"Invalid PPPoE IP address",	//bwn_alert_12
"Invalid PPTP IP address",	//_badPPTPip
"Invalid PPTP subnet mask",	//_badPPTPsub
"The PPTP gateway IP address is not in the PPTP subnet",	//_badPPTPipsub
"Invalid PPTP Server IP address",	//bwn_alert_11
"Invalid L2TP address",	//_badL2TP3
"Invalid L2TP subnet mask",	//_badL2TP
"The L2TP gateway IP address is not in the L2TP subnet",	//_badL2TP2
"Invalid L2TP Server IP address",	//bwn_alert_17
"The MTU should be in the range 128..30000",	//bwn_alert_21
"WEP Keys '+ wep_error_msg + ' are invalid.",	//bws_alert_15
"WEP Key '+ wep_error_msg + ' is invalid.",	//bws_alert_16
"Can not use 802.11b/g channel when the 802.11 mode is 802.11a",	//bwl_alert_2
"Can not use 802.11a channel when the 802.11 mode is 802.11b/g",	//bwl_alert_3
" RADIUS server Port field can not be blank.",	//bwl_alert_15
" RADIUS server Port ' + data.wireless.radius_server_port + ' should be in range (1..65535).",	//bwl_alert_16
"Can not use 802.11b transmit rates when the PHY mode is 802.11a",	//bwl_alert_4
"Can not use 802.11a/g transmit rates when the PHY mode is 802.11b",	//bwl_alert_5
"Static Turbo mode is not allowed with 802.11b",	//bwl_alert_6
"Dynamic Turbo mode is not allowed with 802.11b",	//bwl_alert_7
"For 11g Turbo mode, the channel should be set to 6",	//bwl_alert_8
"For 11a Static Turbo, channel should be set to one of 42,50,58,152, or 160.",	//bwl_alert_9
"For 11a Dynamic Turbo, channel should be set to one of 40,48,56,153 or 161.",	//bwl_alert_10
"Incorrect key length, should be 8 to 63 character long.",	//bws_alert_2
"WPA Group Key Update Interval should be between 30 and 65535 seconds.",	//bwl_alert_11
"IEEE 802.1X Authentication Timeout should be between 1 and 65535 minutes",	//bwl_alert_12
"WEP key' +(i+1)+' must be '+len+' characters long",	//bws_alert_3
"Uncheck &quot; Auto Channel Select&quot;  for WDS mode.",	//aw_alert_5_1
"The IP address ' + data.wireless.radius_server_address + ' is not valid.",	//bwl_alert_13
"The IP address ' + data.wireless.second_radius_server_address + ' is not valid.",	//bwl_alert_14
"802.11g only",	//bwl_Mode_2
"Mixed 802.11g and 802.11b",	//bwl_Mode_3
"802.11b only",	//bwl_Mode_1
"802.11n only",	//bwl_Mode_8
"Mixed 802.11n, 802.11g and 802.11b",	//bwl_Mode_11
"20 MHz",	//bwl_ht20
"Auto 20/40 MHz",	//bwl_ht2040
"Best (automatic)",	//bwl_TxR_0
"무선 보안의 세가지 무선 모드(WEP, WPA-Personal, WPA-Enterprise)를 지원합니다. WEP는 초기의 무선 암호화 표준이고, WPA는 WEP 보다 더 강력한 암호화를 지원합니다. WPA-Personal은 인증 서버가 필요 없지만, WPA-Enterprise는 외장 RADIUS 서버를 꼭 필요 합니다. ",	//bws_intro_WlsSec
"WEP 보안 옵션을 선택하면 WEP 보안 옵션을 선택하면 802.11B/G(11M/54M) 모드로만 동작합니다. Draft 11N 스펙은 WEP를 지원하기 않기 때문에 Draft 11N 속도가 지원되지 않습니다.",	//bws_msg_WEP_3
"WEP 은 무선 암호화 표준입니다. WEP 을 사용하기 위하여 공유기와 무선 클라이언트에 동일한 key 를 설정해야 합니다. 64bit key 는 10개의 16진수 숫자를 입력해야 하며 128bit key 는 26개의 16진수 숫자를 입력해야 합니다. 16진수는 0~9, A~Z 를 사용합니다. 보다 안전한 보안을 구현하기 위하여 WEP 을 사용할 때의 인증 방식은 &quot;Shared Key&quot; 로 설정합니다.",	//bws_msg_WEP_1
"WEP 키 박스안에 입력한 텍스트 문자열은 ASCII 값을 사용하여 HEX 값로 전환됩니다. 64bit 키는 일반 상용문자 5자를 입력해야 하며, 128btit 키는 일반 상용문자 13자를 입력해야 합니다. ",	//bws_msg_WEP_2
"WEP Key 길이",	//bws_WKL
"64 bit (10 hex digits) ",	//bws_WKL_0
"128 bit (26 hex digits) ",	//bws_WKL_1
"(모든 키에 적용되는 길이)",	//bws_length
"WEP Key 1 ",	//_wepkey1
"WEP Key 2 ",	//_wepkey2
"WEP Key 3 ",	//_wepkey3
"WEP Key 4 ",	//_wepkey4
"디폴트 WEP Key",	//bws_DWK
"오픈",	//_open
"Shared Key ",	//bws_Auth_2
"<strong>WPA 또는 WPA2</strong> 모드를 사용하시면 강력한 보안과 최적의 호환성을 이룰 수 있습니다. 이 모드에서 오래된 무선 클라이언트에서 사용하는 WPA를 사용하는 반면, WPA2을 인식할 수 있는 클라이언트에는 좀 더 높은 보안을 유지하는 WPA2를 사용합니다. 클라이언트가 지원하는 가장 강력한 암호화 방법이 사용됩니다. 최고의 보안을 위해, <strong>WPA2 Only</strong> 모드를 사용하십시오. 이 모드는 AES(CCMP) 암호화를 사용하는데 WPA2를 인식하지 못하는 무선 클라이언트에게는 허용되지 않습니다. 최대 호환성을 위해서는 <strong>WPA Only</strong> 를 사용하십시오. 이 모드는 TKIP 암호화 방법을 사용합니다. 일부 게임과 오래된 장비들은 이 모드에서만 동작합니다. ",	//bws_msg_WPA
"좋은 무선 성능을 위해, <strong>WPA2 Only</strong>  보안 모드를 사용하시기 바랍니다. ",	//bws_msg_WPA_2
"자동 (WPA or WPA2)",	//bws_WPAM_2
"WPA Only ",	//bws_WPAM_1
"Changing your Wireless Network Name is the first step in securing your wireless network. Change it to a familiar name that does not contain any personal information.",	//TA9
"Enable Auto Channel Scan so that the router can select the best possible channel for your wireless network to operate on.",	//TA11
"Setting Visibility Status to Invisible is another way to secure your network. With visibility disabled, no wireless clients will be able to see your wireless network when they scan to see what's available. For your wireless devices to connect to your router, you will need to manually enter the Wireless Network Name on each device.",	//TA12
"If you have enabled Wireless Security, make sure you write down the Passphrase that you have configured.",	//TA14
"You will need to enter this information on any wireless device that you connect to your wireless network.",	//TA15
"Wizard",	//_wizard
"The D-Link RangeBooster N&trade; 650 Router powered by QoS Engine&trade; technology meets the demands of individuals who demand powerful and reliable performance for the ultimate online gaming experience.",	//bwz_intro
"The following Web-based Setup Wizard is designed to assist you in connecting your new D-Link Router to the Internet. This Setup Wizard will guide you through step-by-step instructions on how to get your Internet connection up and running. Click the button below to begin.",	//bwz_intro_ConWz
"Launch Internet Connection Setup Wizard",	//bwz_LConWz
"Wireless Security Setup Wizard",	//bwz_WlsWz
"The following Web-based Setup Wizard is designed to assist you in your wireless network setup. This Setup Wizard will guide you through step-by-step instructions on how to set up your wireless network and how to make it secure.",	//bwz_intro_WlsWz
"Launch Wireless Security Setup Wizard",	//bwz_LWlsWz
"속도 측정이 완료되었습니다. 업로드 속도는 %u kbps 입니다. ",	//RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED
"속도 측정이 완료되었습니다. ",	//RATE_ESTIMATOR_RATE_COMPLETED
"스페셜 응용프로그램",	//_specapps
"게임",	//_gaming
"웹 필터 ",	//_webfilter
"Basic",	//_basic
"The rule name can not be empty.",	//ag_alert_empty_name
"The rule name ' + data.game_rules[j].entry_name + '' is duplicated.'",	//ag_alert_duplicate_name2
"&quot; MAC Address Filter allows no machines. This is not allowed because it locks out all machines.&quot; ",	//amaf_alert_2
"The rule name ' + saved_records[i].entry_name + '' is duplicated.'",	//specapps_alert_duplicate_name
"The rule ' + saved_records[j].entry_name + '' is duplicate of '' + saved_records[i].entry_name + ''.'",	//specapps_alert_duplicate1
"Trigger port range of '+saved_records[i].entry_name+'' '+protocols[saved_records[i].trigger_ports.protocol]+' ['+saved_records[i].trigger_ports.port_range+'] conflicts with ''+saved_records[j].entry_name+'' '+protocols[saved_records[j].trigger_ports.protocol]+' ['+saved_records[j].trigger_ports.port_range+'].'",	//specapps_alert_conflict1
"Please select a schedule for rule ' + data.port_trigger_rules[i].entry_name + ''.'",	//specapps_alert_empty_schedule
"Traffic Shaping Setup",	//at_title_TSSet
"트래픽 세이핑 설정",	//at_ETS
"Protocol ' + entry_1.user_protocol + ' of ' + entry_1.entry_name + ' conflicts with ' + entry_2.entry_name + '",	//av_alert_35
"The &quot; Name&quot;  field can not be blank",	//av_alert_empty_name
"Name ' + data.virtual_servers[j].entry_name + ' is already used.",	//av_alert_16
"Primary WINS IP address must be specified.",	//bln_alert_lannbpri
"Secondary WINS IP address is invalid.",	//bln_alert_lannbsec
"Primary DNS",	//lan_dns
"Secondary DNS",	//lan_dns2
"NetBIOS 알림",	//bd_NETBIOS
"WAN 에서 NetBIOS 정보 가져오기",	//bd_NETBIOS_WAN
"1차 WINS 서버 IP 주소",	//bd_NETBIOS_WINS_1
"2차 WINS 서버 IP 주소 ",	//bd_NETBIOS_WINS_2
"NetBIOS 범위",	//bd_NETBIOS_SCOPE
"NetBIOS 등록 모드",	//bd_NETBIOS_REG
"Hybrid (Point-to-Point then Broadcast)",	//bln_NetBIOSReg_H
"Mixed-mode (Broadcast then Point-to-Point)",	//bln_NetBIOSReg_M
"Point-to-Point (no broadcast)",	//bln_NetBIOSReg_P
"Broadcast only (use when no WINS servers configured)",	//bln_NetBIOSReg_B
"Mixed 802.11n and 802.11g",	//bwl_Mode_10
"Help",	//_help
"When this option is enabled, the router restricts the flow of outbound traffic so as not to exceed the WAN uplink bandwidth.",	//help81ets
"The NAT Endpoint Filtering options control how the router's NAT manages incoming connection requests to ports that are already being used.",	//af_EFT_h4
"Once a LAN-side application has created a connection through a specific port, the NAT will forward any incoming connection requests with the same port to the LAN-side application regardless of their origin. This is the least restrictive option, giving the best connectivity and allowing some applications (P2P applications in particular) to behave almost as if they are directly connected to the Internet.",	//af_EFT_h0
"The NAT forwards incoming connection requests to a LAN-side host only when they come from the same IP address with which a connection was established. This allows the remote application to send data back through a port different from the one used when the outgoing session was created.",	//af_EFT_h1
"The NAT does not forward any incoming connection requests with the same port address as an already establish connection.",	//af_EFT_h2
"Note that some of these options can interact with other port restrictions. Endpoint Independent Filtering takes priority over inbound filters or schedules, so it is possible for an incoming session request related to an outgoing session to enter through a port in spite of an active inbound filter on that port. However, packets will be rejected as expected when sent to blocked ports (whether blocked by schedule or by inbound filter) for which there are no active sessions. Port and Address Restricted Filtering ensures that inbound filters and schedules work precisely, but prevents some level of connectivity, and therefore might require the use of port triggers, virtual servers, or port forwarding to open the ports needed by the application. Address Restricted Filtering gives a compromise position, which avoids problems when communicating with certain other types of NAT router (symmetric NATs in particular) but leaves inbound filters and scheduled access working as expected.",	//af_EFT_h5
"Controls endpoint filtering for packets of the UDP protocol.",	//af_UEFT_h1
"Controls endpoint filtering for packets of the TCP protocol.",	//af_TEFT_h2
"이 옵션은 <span class='option'>802.11 Mode</span> 를  <span class='option'>802.11ng only</span> 로 설정한 경우에만 사용할 수 있습니다. ",	//aw_erpe_h2
"( <a href='wireless.asp'> Setup &rarr; Wireless Settings &rarr; Manual Wireless Network Setup</a> 페이지를 참고하십시오.)",	//aw_erpe_h3
"The subnet mask of the local area network.",	//help309A
"NetBIOS allow LAN hosts to discover all other computers within the network, e.g. within Network Neighbourhood.",	//help400_1
"Turn this setting off to configure manually.",	//help401_1
"WINS Servers store information regarding network hosts, allowing hosts to &quot; register&quot;  themselves as well as discover other available hosts, e.g. for use in Network Neighbourhood.",	//help402_1
"This setting has no effect if the &quot; Learn NetBIOS information from WAN&quot;  is activated.",	//help402_2
"H-Node, this indicates a Hybrid-State of operation. First WINS servers are tried, if any, followed by local network broadcast. This is generally the preferred mode if you have configured WINS servers.",	//help405_1
"M-Node (default), this indicates a Mixed-Mode of operation. First Broadcast operation is performed to register hosts and discover other hosts, if broadcast operation fails, WINS servers are tried, if any. This mode favours broadcast operation which may be preferred if WINS servers are reachable by a slow network link and the majority of network services such as servers and printers are local to the LAN.",	//help405_2
"P-Node, this indicates to use WINS servers ONLY. This setting is useful to force all NetBIOS operation to the configured WINS servers. You must have configured at least the primary WINS server IP to point to a working WINS server.",	//help405_3
"B-Node, this indicates to use local network broadcast ONLY. This setting is useful where there are no WINS servers available, however, it is preferred you try M-Node operation first.",	//help405_4
" Incorrectly configured - check logs",	//_sdi_s1a
"Invalid secure remote management port '+data.web_server_wan_port_https+', should be in range (1..65535)",	//ta_alert_3b
"Secure remote management port and remote management port may not be the same.",	//ta_alert_3c
"You must enable one method of management.",	//ta_alert_3d
"Invalid management port '+data.web_server_lan_port_http+', should be in range (1..65535)",	//ta_alert_3e
"Invalid secure management port '+data.web_server_lan_port_https+', should be in range (1..65535)",	//ta_alert_3f
"Secure management port and management port may not be the same.",	//ta_alert_3g
"Enable Management",	//ta_ELM
"Admin Port",	//ta_LMAP
"Failed Login",	//fb_FailLogin
"Access to this device is not allowed without a correct password.",	//fb_FailLogin_1
"Log emails",	//KR67
"목적지의 마지막 포트는 0과 65535 사이를 포함해야 합니다.",	//YM71
"출발지 IP 범위 '%v-%v' 가 중복되었습니다. ",	//GW_FIREWALL_RANGE_DUPLICATED_INVALID
"하드웨어 주소",	//LS422
"Windows Connect Now 를 사용하십시오 ",	//bwz_LWCNWz
"잘못된 WAN 게이트웨이 IP 주소: %v",	//GW_WAN_WAN_GATEWAY_IP_ADDRESS_INVALID
"무선 네트워크 설정 마법사에 설정을 저장하십시오.",	//ta_wcn
"PIN 번호는 현재 네트워크에 공유기를 추가시키거나 새로운 네트워크를 생성하는데 사용되는 유일한 번호입니다. 기본 PIN 번호는 공유기 바닥에 인쇄 되어 있습니다. 강력한 보안을 위해, 새 PIN 번호를 생성할 수 있습니다. 언제라도 기본 PIN 번호를 복구할 수 있습니다. 관리자(&quot; admin&quot;  계정) 만이 PIN 번호를 수정하거나 리셋할 수 있습니다.",	//LW57
"Hop ",	//tsc_pingt_msg109
"NetBIOS 노드 종류",	//bd_NETBIOS_REG_TYPE
"공유기의 설정을 계속하려면 아래 버튼을 클릭하십시오. ",	//ap_intro_cont
"유효한 PIN 번호가 될 수 있는 무작위 번호를 생성하십시오. 이것의 공유기의 PIN 번호가 될 것입니다. 생성후 이 PIN 번호를 registrar 인터페이스에 복사하십시오.",	//LW60
"복구 실패",	//_rs_failed
"Select this option if the device is connected to a local network downstream from another router. In this mode, the device functions as a bridge between the network on its WAN port and the devices on its LAN port and those connected to it wirelessly.",	//KR62
"NetBIOS 알림",	//bd_NETBIOS_ENABLE
"LAN 서브넷 마스크",	//KR77
"Super G with Dynamic Turbo ",	//help364
"Shopping ",	//_aa_bsecure_shopping
"공용 프록시",	//_aa_bsecure_public_proxies
"WEP Key 1 ",	//wepkey1
"인증 보내기/받기 ",	//ZM11
"시작 시간 ",	//tsc_start_time
"출발지의 마지막 포트는 0과 65535 사이를 포함해야 합니다.",	//YM69
"NetBIOS 광고가 설정되어 있는 경우, WINS 정보를 WAN 쪽에 있는 경우 WAN 쪽에서 알아하도록 하는 원인이 됩니다.",	//KR82
"관리자만이 이 기능에 접근할 수 있습니다. 버튼이 비활성화되어 있는 것은 관리자로 로그인 하지 않았기 때문입니다. ",	//LW39b
"스케쥴 이름 '%s' 는 예약되어 있으며 사용할 수 없습니다. ",	//GW_SCHEDULES_NAME_RESERVED_INVALID
"무선 스테이션 추가",	//LW12
"Windows Media Center ",	//YM75
"루트 게이트웨이 IP %v 가 잘못되었습니다.  ",	//GW_ROUTES_GATEWAY_IP_ADDRESS_INVALID
"WPA Group Key 갱신 주기는 30초에서 65535초 사이로 설정하여야 합니다.",	//GW_WLAN_WPA_REKEY_TIME_INVALID
"Enabling L2 (Layer 2) Isolation prevents associated wireless clients from communicating with each other.",	//KR58
"Gambling",	//_aa_bsecure_gambling
"브리지 모드",	//KR14
"설정한 FROM 주소 (%s) 가 잘못되었습니다. ",	//GW_SMTP_FROM_ADDRESS_INVALID
"네트워크 호스트가 NetBIOS 이름을 등록하거나 검색하는 방법을 나타냅니다.",	//KR89
"넷마스크: ",	//help106
"공유기를 이용하여 인터넷에 연결하려면 메뉴에서 정확한 <strong>내 인터넷 연결</strong> 을 설정해야 합니다. 어떤 옵션을 설정해야 할지 확실하지 않을 경우에는 <strong>인터넷 서비스 업체(ISP)</strong> 에 문의하시기 바랍니다. ",	//LW35
"음성 (가장 중요).",	//YM151
"변경된 설정이 저장되었습니다. 적용하려면 장비를 재부팅 해야 합니다. 지금 장비를 재부팅하거나 설정을 계속 한 후 나중에 재부팅하셔도 됩니다. ",	//YM2
"마법사가 실행되는 동안 알 수 없는 이유로 공유기의 설정이 변경되었습니다. \n마법사의 기능이 취소됩니다. 다시 시도하십시오. ",	//YM131
"HTTP 와 HTTPS 는 동일한 LAN 포트를 사용할 수 없습니다. ",	//GW_WEB_SERVER_SAME_PORT_LAN
"지금 재부팅",	//YM3
"<warn>생성한 가상 서버 엔트리에서 필요하기 때문에 Wake-On-LAN ALG 이 자동으로 활성화되었습니다.</warn>",	//GW_NAT_WOL_ALG_ACTIVATED_WARNING
"잘못된 포트 필터 목적지 IP 범위 ",	//YM20
"WISH로 트래픽의 우선 순위를 정하려면 이 옵션을 활성화하십시오.",	//YM141
"유효하지 않은 WAN MAC 주소: %m ",	//GW_WAN_MAC_ADDRESS_INVALID
"이메일 수신자 주소의 형식이 올바르지 않습니다. ",	//IPSMTPCLIENT_MSG_WRONG_RECEPIENT_ADDR_FORMAT
"WISH는 규칙들 간에 중복해서 사용할 수 있습니다. 특정 메시지 흐름에 대해 규칙이 한 가지 이상 중복되면, 우선 순위가 높은 것을 사용합니다.",	//YM146
"설정 경고 ",	//LS151
"이름은 공백으로 설정할 수 없습니다.",	//GW_QOS_RULES_NAME_INVALID
"이름은 공백으로 설정할 수 없습니다.",	//GW_WISH_RULES_NAME_INVALID
"무선 클라이언트 %m 추가 실패, 원인: %s, 오류_코드 %u",	//WIFISC_IR_REGISTRATION_FAIL
"루트 리스트",	//r_rlist
"8-63개의 알파벳 혹은 숫자의 비밀번호(pass-phrase)를 입력하십시오. ",	//KR18
"Originator ",	//sa_Originator
"포트 범위는 공란으로 설정할 수 없습니다.",	//GW_NAT_PORT_FORWARD_RANGE_BOTH_EMPTY_INVALID
"공유기 게이트웨이 IP 주소 %v 가 인터페이스 서브넷 범위에 없습니다. ",	//GW_ROUTES_GATEWAY_IP_ADDRESS_IN_SUBNET_INVALID
"무선 마법사",	//LW37
"This feature is disabled when logged in as User",	//tsc_pingdisallowed
"설정을 저장하려면, <strong>Save Configuration</strong> 버튼을 클릭하십시오. ",	//ZM20
"Cipher Type: ",	//help376
"도구->이메일 설정 페이지에서 이메일 알림은 설정되어 있지 않지만 새로운 펌웨어 버전의 알림 기능은 도구->펌웨어 페이지에 설정되어 있습니다. ",	//GW_FW_NOTIFY_EMAIL_DISABLED_INVALID
"유효하지 않은 WEP Key",	//YM122
"DMZ 주소 %v는 LAN IP 주소와 같아서는 안됩니다. ",	//GW_NAT_DMZ_CONFLICT_WITH_LAN_IP_INVALID
"시작 포트는 마지막 포트보다 작아야 합니다: %d-%d. ",	//GW_INET_ACL_START_PORT_INVALID
"전자메일 정보를 보내는데 실패했습니다.",	//IPSMTPCLIENT_DATA_FAILED
"M-Node(디폴트) 는 혼합 모드(Mixed-Mode)입니다. 호스트를 등록하고 다른 호스트를 검색하기 위해 처음 브로드캐스트를 해서 그 브로드캐스트가 실패하면, WINS 서버가 동작합니다. 이 모드는 속도가 느린 네트워크인 경우 WINS 서버와 통신해야 하는 경우 우선시됩니다. 서버나 프린터 같은 대부분의 네트워크 서비스들은 LAN 네트워크에 있습니다.",	//KR91
"Opinion ",	//_aa_bsecure_opinion
"공장 초기값으로 복구 ",	//tss_RestAll_b
"%s of '%s' [%s:%s]->%s 가 '%s' [%s:%s]->%s 와 충돌합니다. ",	//GW_NAT_PORT_TRIGGER_CONFLICT_INVALID
"프레임 사이즈가 프레그멘테이션 값보다 클 경우 프레그멘테이션이 적용됩니다.",	//LW54
"장비의 로컬 LAN IP 주소 ",	//KR74
"디폴트 WEP Key",	//bws_DFWK
"무선 네트워크 설정에 익숙하지 않거나 설정해 본 경험이 없다면 <strong>무선 네트워크 설정 마법사</strong> 를 이용하여 보다 쉽게 무선 공유기를 설정할 수 있습니다.",	//LW46
"SMTP (Email) 서버 %s 의 IP 주소는 %v 입니다.",	//IPSMTPCLIENT_RESOLVED_DNS
"Interface: ",	//help110
"유효하지 않은 PPTP 게이트웨이 IP 주소 ",	//YM107
"시간초과 설정값은 8760 보다 작아야 합니다. ",	//YM180
"유효하지 않은 WAN 서브넷 마스크 %v ",	//GW_WAN_WAN_SUBNET_INVALID
"<warn>LAN 서브넷이 변경되어 DMZ 가 비활성화 되었습니다.</warn>",	//GW_NAT_DMZ_DISABLED_WARNING
"DHCP 의 IP reservation 기능을 비활성화 하시겠습니까?",	//YM93
"<warn>생성한 가상 서버가 FTP ALG 기능을 자동으로 활성화 하였습니다.</warn>",	//GW_NAT_FTP_ALG_ACTIVATED_WARNING
"Free Host ",	//_aa_bsecure_free_host
"해당 경로에 대한 서브넷 마스크가 유효하지 않습니다.",	//_r_alert2
"유효하지 않은 MAC 주소 ",	//LS47
"LAN subnet mask leaves no addresses for DHCP server to use. ",	//GW_DHCP_SERVER_SUBNET_SIZE_INVALID
"MAC 주소 %m 를 새로 추가할 수 없습니다. MAC 주소는 다른 정책 설정 시 재사용할 수 있습니다.",	//GW_INET_ACCESS_POLICY_TOO_MANY_MAC_INVALID
"시작 IP 주소는 마지막 IP 주소 보다 작아야 합니다: %v-%v ",	//GW_FIREWALL_START_IP_ADDRESS_INVALID
"초.",	//YM8
"Travel ",	//_aa_bsecure_travel
"The route metric is a value from 1 to 16 that indicates the cost of using this route. A value of 1 is the lowest cost, and 15 is the highest cost. A value of 16 indicates that the route is not reachable from this router. When trying to reach a particular destination, computers on your network will select the best route, ignoring unreachable routes. ",	//help113
"BigPond Client ",	//ZM6
"The WCN ActiveX Control provides the necessary WCN link between the router and your PC via the browser. The browser will attempt to download the WCN ActiveX Control, if it is not already available on your PC. For this action to succeed, the WAN connection must be established, and the browser's internet security setting must be Medium or lower (select Tools &rarr; Internet Options &rarr; Security &rarr; Custom Level &rarr; Medium). ",	//help836
"유효한 설정 파일로 설정 복구를 재시도 하시기 바랍니다.",	//rs_intro_2
"IP 주소 %v 가 이미 사용 중입니다. ",	//GW_INET_ACL_IP_ADDRESS_DUPLICATION_INVALID
"이 기능을 사용하려면 관리자 계정으로 로그인해야 합니다.",	//KR7
"(UPnP 기능이 활성화 되면 자동으로 비활성화 됩니다) ",	//ZM1
"인터넷 연결 직접 설정 ",	//LW30
"유효하지 않은 L2TP 서브넷 마스크 ",	//YM110
"Point-to-Point (no broadcast) ",	//bd_NETBIOS_REG_TYPE_P
"LAN 서브넷 마스크가 유효하지 않습니다.",	//GW_LAN_SUBNET_MASK_INVALID
"더 이상의 예약 기능을 설정할 수 없습니다.",	//YM88
"유효하지 않은 1차 WINS IP 주소입니다.",	//GW_DHCP_SERVER_NETBIOS_PRIMARY_WINS_INVALID
"Name (if any) ",	//YM187
"%s' 의 %s name %s 이 지정되지 않았습니다. ",	//GW_NAT_NAME_UNDEFINED_INVALID
"무선 주파수가 채널 %d 로 검색되었습니다.",	//GW_WIRELESS_RADAR_DETECTED
"Pre-shared Key ",	//LW25
"복구가 잘못되었습니다. ",	//_rs_invalid
"유효하지 않은 1차 DNS 서버 IP 주소입니다.",	//YM113
"Wi-FI Protected 설정",	//LW65
"Select this option if your wireless device supports push button",	//KR41
"유효하지 않은 1차 DNS 서버 IP 주소: %v",	//GW_WAN_DNS_SERVER_PRIMARY_INVALID
"무선 장비의 PIN 이 유효하지 않습니다.",	//KR21
"Personals ",	//_aa_bsecure_personals
"The <span class='option'>Router IP Address</span> field below must be set to the IP address of this device. The <span class='option'>Gateway</span> must be set to the IP address of the upstream router. Both addresses must be within the LAN subnet as specified by <span class='option'>Subnet Mask</span>.",	//KR63
"아래의 웹기반 설정 마법사는 프린터 설정을 지원합니다. 설정 마법사가 프린터 설정 방법을 단계별로 안내할 것입니다.",	//LW31
"유효하지 않은 2차 DNS 서버 IP 주소: %v",	//GW_WAN_DNS_SERVER_SECONDARY_INVALID
"D-Link Systems 의 공유기를 직접 설정하려면 아래 버튼을 클릭하십시오.",	//LW29
"유효하지 않은 원격 종단 IP 주소 ",	//YM55
"For information on which configuration method your wireless device support, please refer to the adapters' documentation.",	//KR37
"DHCP 서버가 LAN 호스트에게 NetBIOS 설정을 제공하려면 이 상자를 체크하십시오.",	//KR80
"유효하지 않은 WAN 서브넷 마스크 ",	//YM100
"Wake-On-LAN ",	//_wakeonlan
"시스템 처리량이 너무 많아 제대로 수신하지 못했습니다. 저장을 다시 시도하십시오. 관리자 모드가 아닌 사용자 모드로 접속하여 저장이 안 될 수도 있습니다 - 관리자 많이 설정 파일을 저장할 수 있습니다. 시스템 오류 로그를 확인하십시오.",	//rs_intro_3
"PalTalk ",	//YM47
"로그인 페이지로 이동합니다.",	//YM7
"속도 향상을 위해 Super G with Dynamic Turbo 를 사용하지 않은 경우, 공유기가 동작할 수 있는 적절한 무선 네트워크의 채널을 스캔할 수 있도록 자동 채널 스캔을 설정하십시오. ",	//YM124g
"MAC 주소 %m 는 이미 사용 중입니다.",	//GW_INET_ACL_MAC_ADDRESS_DUPLICATION_INVALID
"유효하지 않은 목적지 시작  IP 주소.",	//YM66
"optional ",	//LT124
"Target ",	//sa_Target
"<warn>LAN 서브넷이 적절하지 않아 DHCP 서버가 다시 설정되고 있습니다. 서버의 설정이 정확한지 확인하십시오.</warn>",	//GW_DHCP_SERVER_RECONFIG_WARNING
"실패하였습니다. ",	//_wifisc_addfail
"무선 SSID 광고 주기는 20 에서 1000 사이를 입력하십시오.",	//GW_WLAN_BEACON_PERIOD_INVALID
"Best Effort (BE) ",	//YM79
"유효하지 않은 애그리게이션 최대 크기 ",	//YM32
"마이크로 소프트 윈도우즈 커넥터 나우 기술을 통해 공유기에서 컴퓨터로  현재 무선 설정을 저장하고 마이크로소프트 네트워크 설정 마법사를 통한 설정 전파도 가능합니다.  ",	//ta_intro_wcn
"Background (BK) ",	//YM78
"채널",	//sd_channel
"다른 컴퓨터들이 포트 포워딩 규칙을 공통으로 갖고 있는 컴퓨터들과 통신이 되지 않는 것에 주의하십시오. 이런 규칙이 서로 상반될 수 있습니다. ",	//KR53
"모든 무선 네트워크 장비를 설정한 후에 <strong>무선 보안 설정 잠금</strong> 하십시오. ",	//LW16
"TCP ",	//GW_NAT_TCP
"[CRIT] ",	//CRIT
"이 규칙은 다른 컴퓨터의 IP 주소가 여기에서 설정한 IP 범위에 해당하는 경우 메시지 흐름에 적용됩니다. ",	//YM154
"11g Turbo mode 를 사용하려면 채널은 6번으로 선택하십시오. ",	//GW_WLAN_11G_TURBO_INVALID
"Entertainment",	//_aa_bsecure_entertainment
"Inactive ",	//YM165
"Lifestyles ",	//_aa_bsecure_lifestyles
"DMZ 주소는 반드시 LAN 서브넷 (%v) 에 있어야 합니다. ",	//GW_NAT_DMZ_NOT_IN_SUBNET_INVALID
"Turbo Mode ",	//sd_TMode
"%s' 의 %s port range '%s' 가 잘못되었습니다. ",	//GW_NAT_PORT_FORWARD_PORT_RANGE_INVALID
"필터 선택하시기 바랍니다.",	//GW_INET_ACL_NO_FILTER_SELECTED_INVALID
"AES ",	//bws_CT_2
"<code>https://...</code>. URL을 사용하고 있는 보안 HTTP 프로토콜을 이용하는 사이트에는 접속통제가 가능하지 않음을 알려드립니다. ",	//_bsecure_parental_limits
"64 Kbytes ",	//aw_64
"Humor ",	//_aa_bsecure_humor
"P-Node는 WINS 서버의 사용을 지시합니다. 이 설정은 NetBIOS 작동이 WINS 서버를 설정하는것에 유용하게 사용됩니다. 1차 WINS 서버 IP를 동작중인 WINS 서버로 지정해야 합니다.",	//KR92
"공유기 모드",	//KR13
"정책명은 중복될 수 없습니다: %s",	//GW_INET_ACL_POLICY_NAME_DUPLICATE_INVALID
"NAT는 이미 연결된 것과 같은 포트로 요청되는 모든 수신 연결 요청을 전달하지 않습니다. ",	//YM136
"Super G without Turbo: ",	//help360
"Warnings",	//YM10
"유효하지 않은 PPTP 서버 IP 주소: %v",	//GW_WAN_PPTP_SERVER_IP_ADDRESS_INVALID
"Video. ",	//YM150
"IP 주소 %v는 현재 사용중 입니다. 리스를 취소하신 후 장비 사용을 위해 네트워크 설정을 리셋하시기 바랍니다. ",	//GW_DHCP_SERVER_RESERVATION_IN_USE
"방화벽 포트 ",	//GW_NAT_INPUT_PORT
"%s 에 의해 리붓되었습니다. ",	//WIFISC_AP_REBOOT_COMPLETE
"가장 최근 펌웨어 버전 ",	//YM182
"1000Mbps ",	//LW3
"WPA Personal Key는 최소 8자여야 합니다. ",	//YM116
"WEP Key ",	//LW22
"Open ",	//open
"WISH 세션",	//YM158
"보내기/받기 인스턴스 실패",	//ZM16
"연령별 카테고리를 선택하십시오. ",	//_aa_bsecure_select_age
"루트 목적지 IP %v가 잘못되었습니다. ",	//GW_ROUTES_DESTINATION_IP_ADDRESS_INVALID
"%s 에 의해 리셋이 완료되었습니다.",	//WIFISC_AP_RESET_COMPLETE
"LAN 게이트웨이 IP 주소가 유효하지 않습니다.",	//GW_LAN_GATEWAY_IP_ADDRESS_INVALID
"생성하였거나 수정한 스케쥴 규칙을 저장합니다. ",	//KR96
"설정 파일 불러오기에 성공하였습니다. ",	//GW_XML_CONFIG_GET_SUCCESS
"수정 사항이 없습니다. 그래도 저장하시겠습니까? ",	//_ask_nochange
"UPnP 갱신 엔트리 %v <-> %v:%d <-> %v:%d %s timeout:%d '%s' ",	//GW_UPNP_IGD_PORTMAP_REFRESH
"LAN IP 주소가 잘못되었습니다. ",	//GW_LAN_IP_ADDRESS_INVALID
"원격  시작 IP 주소",	//KR5
"스케쥴 이름 %s 이 정의되지 않았습니다.",	//GW_INET_ACL_SCHEDULE_NAME_INVALID
"%s' 의 IP 주소는 반드시 LAN 서브넷 (%v) 에 있어야 합니다. ",	//GW_NAT_IP_ADDRESS_INVALID
"무선 설정  ",	//LW38
"사용자 계정을 반드시 지정하십시오. ",	//GW_DYNDNS_USER_NAME_INVALID
"목적지 IP 주소는 도달하고 싶은 호스트 또는 네트워크의 IP 주소입니다. ",	//hhav_r_dest_ip
"원격지 관리 포트 번호가 잘못되었습니다. ",	//YM175
"Wi-Fi Protected 설정을 사용하여 PIN 또는 버튼을 눌러 쉽게 장비를 네트워크에 추가할 수 있습니다. 이 방법으로 설정하기 위해서 장비들이 반드시 Wi-Fi Protected 설정을 지원해야 합니다.",	//LY3
"UPnP %v <-> %v:%d <-> %v:%d %s 타임아웃:%d '%s' 엔트리를 추가하였습니다. ",	//GW_UPNP_IGD_PORTMAP_ADD
"현재 있는 UPnP 엔트리 %v <-> %v:%d <-> %v:%d %s '%s' 와 충돌됩니다. ",	//GW_UPNP_IGD_PORTMAP_CONFLICT
"메시지",	//KRA1
"포트",	//_vs_port
"<warn>LAN 서브넷이 변경되어 액세스 콘트롤 테이블을 다시 설정합니다.</warn>",	//GW_INET_ACL_RECONFIGURED_WARNING
"Enables the router to recognize certain audio and video streams generated by a Windows Media Center PC and to prioritize these above other traffic. Such streams are used by systems known as Windows Media Extenders, such as the Xbox 360. ",	//help80b
"대부분의 응용프로그램에서 우선 순위 분류는 정확한 우선 순위와 상세한 WISH 규칙을 요구하지 않습니다.  ",	//YM145
"Unset Selected Registrar",	//WIFISC_AP_UNSET_SELECTED_REGISTRAR
"1차 DNS를 지정하지 않으면 2차 DNS 또한 지정할 수 없습니다. ",	//GW_WAN_DNS_SERVER_SECONDARY_WITHOUT_PRIMARY_INVALID
"트리거 포트",	//GW_NAT_TRIGGER_PORT
"WISH (Wireless Intelligent Stream Handling) 는 다양한 무선 응용프로그램의 트래픽에 우선순위를 부여합니다. ",	//YM72
"유용한 도움말",	//_hints
"로컬 시작 IP 주소가 잘못되었습니다. ",	//YM52
"Chat ",	//_aa_bsecure_chat
"Destination IP: ",	//help104
"마이크로 소프트의 WCN 에서 이미 있는 프로파일 이름과 같은 프로파일의 무선 설정을 저장할 수 없습니다. 이런 제한 사항을 해결하기 위해서, 무선 설정을 변경할 때, 현재의 프로파일을 삭제하거나 SSID를 변경하십시오. 그리고 나서 새로운 설정을 저장하면 새로운 프로파일이 생성됩니다. ",	//help839
"잘못된 WAN IP 주소",	//YM99
"연령별",	//_aa_bsecure_byage
"이름 '%s' 이 이미 있습니다. ",	//GW_INET_ACL_NAME_DUPLICATE_INVALID
"LAN 서브넷 %v 에 있는 DHCP 서버 마지막 주소 %v 가 유효하지 않습니다. ",	//GW_DHCP_SERVER_POOL_TO_INVALID
"진행중",	//KR26
"DHCP Reservation IP 엔트리를 설정하시겠습니까?",	//YM92
"DHCP 보유 IP %v 가 잘못되었습니다. ",	//GW_DHCP_SERVER_RESERVED_IP_INVALID
"불안정함",	//_aa_bsecure_unstable
"보유 IP 주소 %v 는 설정되어 있는 DHCP 범위 내에 있어야 합니다. ",	//GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID
"사용중이므로 필터 규칙 '%s'를 삭제하거나 이름을 변경할 수 없습니다. ",	//GW_FIREWALL_FILTER_NAME_INVALID
"공유기를 기본 설정으로 복구할 경우 이 파일을 사용하십시오. ",	//ZM19
"Video (VI) ",	//YM80
"추가/업데이트 스크린을 초기화하여 추가/업데이트를 누르기 전의 변경 되었을 수도 있는 설정을 삭제하십시오. ",	//KR57
"액티브",	//YM164
"IP 주소가 허용되지 않습니다. ",	//_logsyslog_alert2
"Best Effort. ",	//YM149
"잘못된 DHCP 서버 갱신(lease) ",	//LT120
"Auto (WPA or WPA2) - Personal",	//KR48
"재 연결 주기가 잘못되었습니다. : %u(20 ~ 180) ",	//GW_WAN_RECONNECT_INTERVAL_INVALID
"TCP 프로토콜 패킷의 엔드포인트 필터링을 제어합니다. ",	//YM139
"원격지 시작 포트는 0 ~ 65535(포함) 입니다. ",	//YM61
"<warn>LAN 서브넷이 변경되어 가상 서버 테이블이 재구성됩니다. </warn>",	//GW_NAT_VIRTUAL_SERVER_TABLE_RECONFIGURED_WARNING
"리부팅이 필요합니다. ",	//YM1
"PIN 설정",	//LY5
"설정을 성공적으로 저장하였습니다. ",	//KR102
"PPTP IP 주소: %v 가 잘못되었습니다. ",	//GW_WAN_PPTP_IP_ADDRESS_INVALID
"Alcohol ",	//_aa_bsecure_alcohol
"포트 필터 규칙 이름을 중복해서 사용할 수 없습니다. ",	//YM14
"Dynamic Turbo mode는 802.11b 에서 사용되지 않습니다.  ",	//GW_WLAN_11B_DYNAMIC_TURBO_INVALID
"UPnP 엔트리 %v <-> %v:%d <-> %v%d %s '%s' 가 만료되었습니다. ",	//GW_UPNP_IGD_PORTMAP_EXPIRE
"One bits in the mask specify which bits of the IP address must match. ",	//help107
"잘못된 포터 필터의 목적지 시작 포트 ",	//YM21
"메시지 흐름의 우선순위를 여기에 입력하십시오. 네가지 우선순위가 지정됩니다: ",	//YM147
"When the log email option is set, log emails are sent to the Internet by way of the upstream router.",	//KR68
"마법사를 사용하여 무선 네트워크에 무선 장비를 추가하실 수 있습니다. ",	//LW61
"L2TP 서버 이름을 반드시 명시해 주십시오. ",	//GW_WAN_L2TP_USERNAME_INVALID
"잘못된 2차 WINS IP ",	//LT120z
"WPA/WPA2 ",	//KR97
"잘못된 L2TP 서브넷 마스크 %v ",	//GW_WAN_L2TP_SUBNET_INVALID
"로컬 하드 드라이버에 설정 저장 ",	//help_ts_ss
"Automobile ",	//_aa_bsecure_automobile
"시간 대역 ",	//sch_time
"PPPoE 비밀번호를 반드시 지정하십시오. ",	//GW_WAN_PPPOE_PASSWORD_INVALID
"Before you can use the router's WCN Wizard, you must first execute the Wireless Network Setup Wizard on your PC. If you have not already done so, go to the Windows Control Panel and select Wireless Network Setup Wizard. When the Wireless Network Setup Wizard gives you the choice to &quot;Use a USB flash drive&quot; or &quot;Set up a network manually&quot;, choose the latter. (In fact, you will not have to do the set-up manually; it will be done with the WCN ActiveX Control.) ",	//help211
"서브넷 마스크가 잘못되었습니다. ",	//LS202
"종료 시간 ",	//tsc_end_time
"무선 네트워크에 무선 장비 추가를 위해 단계별로 마법사를 따라 하십시오. ",	//KR34
"원격지 포트 범위 ",	//at_RePortR
"기타",	//_vs_other
"설정한 서버 IP 주소 (%s) 가 잘못되었습니다. ",	//GW_SMTP_SERVER_ADDRESS_INVALID
"L2TP 게이트웨이 IP 주소: %v 가 잘못되었습니다. ",	//GW_WAN_L2TP_GATEWAY_IP_ADDRESS_INVALID
"현재 공유기의 유효한 PIN을 보여 줍니다. ",	//LW58
"사용중인 Key",	//LW22usekey
"Static Turbo mode 는 802.11b 에서 사용할 수 없습니다. ",	//GW_WLAN_11B_STATIC_TURBO_INVALID
"목적지 마지막 IP 주소가 잘못되었습니다. ",	//YM67
"<warn>무선 보안 설정 변경으로 인해 Wi-Fi protected 설정이 제대로 동작하지 않을 수도 있습니다. </warn>",	//GW_WIFISC_CFG_CHANGED_WARNING
"DNS 쿼리 중에 다시 시작합니다. ",	//ZM10
"802.11a 모드일 경우 802.11b/g 채널을 사용할 수 없습니다. ",	//GW_WLAN_11A_CHANNEL_INVALID
"원격 관리 포트는 1 ~ 65535 입니다. ",	//YM176
"NetBIOS 프로토콜로 LAN 호스트는 같은 네트워크의 다른 PC 들을 검색할 수 있습니다. (PC의 내 네트워크 환경) ",	//KR81
"TCP 포트",	//GW_NAT_TCP_PORT
"여기에서 설정한 범위안의 있는 호스트 2의 포트 번호 메시지 흐름에 대한 규칙을 적용합니다. ",	//YM155
"This mode is backwards compatible with non-Turbo (legacy) devices. This mode should be enabled when some devices on the wireless network are not Turbo enabled but support other Super G features mentioned above. ",	//help365
"세션이 중단되었습니다. ",	//KR28
"애그리게이션 Num 패킷이 잘못되었습니다. ",	//YM33
"자동",	//YM76
"AP 설정 잠김 해제",	//WIFISC_AP_SETUP_UNLOCKED
"가상 서버 '%s' 는 공유기의 HTTPS WAN 관리 포트, %u 를 사용할 수 없습니다. ",	//GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
"해제 ",	//LS313
"Microsoft Windows Connect Now Wizard",	//bwz_WCNWz
"DNS Lookup 로그인 서버",	//ZM9
"이 MAC 주소 (%m)의 보유 IP 주소는 이미 사용중입니다. ",	//GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID
"PIN 설정",	//LW7
"대부분의 응용프로그램에서 우선 순위 분류는 우선 순위가 적절한지를 확인해 주고, 상세 WISH 규칙이 요구되지 않습니다. ",	//YM87
"WAN Ping 필터 이름 %s 이 존재하지 않습니다.",	//GW_NAT_WAN_PING_FILTER_INVALID
"If your PC's operating system is Windows XP Service Pack 2 (SP2) or later and you are using Windows Internet Explorer (IE) as your browser, you can use this option to save key parts of the router's current wireless security settings to your PC with Windows Connect Now (WCN) technology. The settings will then be available to propagate to other wireless devices. ",	//help835
"규칙 번호의 이름이 필요합니다. ",	//YM49
"새로운 IP 주소 %v 를 추가할 수 없습니다. 다른 정책의 IP 주소를 다시 사용하는 것만 가능합니다. ",	//GW_INET_ACCESS_POLICY_TOO_MANY_IP_INVALID
"잘못된 L2TP 서버 IP 주소",	//YM112
"H-Node는 Hybrid-State 동작을 나타냅니다. 1차 윈즈 서버가 시도에 따라 로컬 네트워크 브로드캐스트가 뒤따릅니다. 윈즈 서버가 구성되어 있는 경우, 일반적으로 이 모드를 사용하는 것이 좋습니다.",	//KR90
"Note that WCN only saves a few of the wireless security settings. When you use WCN to propagate settings to other wireless devices, you may have to make additional settings manually on those devices. ",	//help838
"WAN 포트 모드를 &quot;Bridge Mode&quot;로 설정 하면,  선택 내용들이 볼 수 있습니다. 이것은 장비가 다른 공유기에 연결되어 있는 네트워크과 브리지 모드로 동작하기 때문입니다.  ",	//KR73
"There are several levels of wireless security. The level you choose depends on the security features your wireless adapters support.",	//wwl_intro_s3_2
"잘못된 루트의 메트릭 값",	//_r_alert5
"<warn>The WAN Ping filter name %s 이 더 이상 존재 하지 않음, WAN PING 이 비활성화됩니다.</warn>",	//GW_NAT_WAN_PING_FILTER_WARNING
"잘못된 로컬 IP의 마지막 주소",	//YM53
"Note that WCN only sets a few of the wireless options. You will still need to go to the <a href='wireless.asp'>Wireless Settings</a> page to set other wireless options such as Super G Mode and transmission rate. ",	//help215
"WISH는 무선 지능 스트림 처리(Wireless Intelligent Stream Handling)의 약자로 여러 응용프로그램의 트래픽 우선 순위를 지정하여 무선 네트워크 데이터 처리를 향상 시키도록 개발한 기술입니다.",	//YM140
"네트워크 장비가 DHCP 서버 주소 %v 를 거부하였습니다. 네트워크 상에 IP 충돌을 발생시키는 DHCP 서버가 더 있는지를 확인하십시오. ",	//GW_DHCPSERVER_REJECTED
"공유기는 HTTP가 일반적인 오디오, 비디오 스트림을 전송하는것을 허용합니다. 이 트래픽들은 다른 트래픽에 우선합니다. 이런 스트림이 디지털 미디어 플레이어를 사용하는데 쓰이는 스트림입니다.",	//YM142
"비밀번호를 반드시 지정하시기 바랍니다. ",	//GW_DYNDNS_PASSWORD_INVALID
"이 규칙은 여기에서 설정한 범위 안에 해당하는 PC의 IP 주소에 대한 메시지 흐름에 적용됩니다. ",	//YM152
"DHCP 서버의 마지막 IP 주소가 잘못되었습니다. ",	//LT119a
"공유기를 통해 인터넷 접속에 문제가 있는 경우, 이 페이지에서 설정한 값을 다시 한번 더 확인하시고, 필요한 경우 가입하신 ISP와도 확인하십시오.",	//LW36
"The encryption algorithm used to secure the data communication. TKIP (Temporal Key Integrity Protocol) provides per-packet key generation and is based on WEP. AES (Advanced Encryption Standard) is a very secure block based encryption. With the &quot; TKIP and AES&quot;  option, the router negotiates the cipher type with the client, and uses AES when available. ",	//help377
"%s '%s' 가 잘못되었습니다. ",	//GW_NAT_PORT_TRIGGER_PORT_RANGE_INVALID
"잘못된 WEP Keys",	//YM121
"잘못된 프래그멘테이션 값",	//YM29
"WISH가 설정된 경우 공유기를 통과하는 액티브 로컬 무선 세션의 상세정보를 WISH 세션 페이지에서 확인할 수 있습니다. WISH 세션은 LAN 쪽 PC와 다른 쪽 PC가 무선으로 연결 되어 있는 경우 프로그램이나 응용프로그램간에 통신합니다.",	//YM159
"잘못된 포트 번호",	//YM120
"Wi-Fi Protected 설정 기능 활성화",	//LW55
"잘못된 PPTP 서브넷 마스크",	//YM106
"Block Unrated Sites",	//_aa_bsecure_block_unrated
"Big Pond 사용자 명을 반드시 지정하십시오.",	//GW_WAN_BIGPOND_USERNAME_INVALID
"예: 192.168.0.101.",	//KR76
"IP 주소 들이 모두 사용중이어서 DHCP 서버가 IP 주소를 더 이상 제공할 수 없습니다. DHCP 서버 설정에서 사용가능한 IP 주소를 늘려 주십시오. ",	//GW_DHCPSERVER_EXHAUSTED
"잘못된 L2TP 서버 IP 주소 : %v",	//GW_WAN_L2TP_SERVER_IP_ADDRESS_INVALID
"루트 서브넷 %v 이 잘못되었습니다. ",	//GW_ROUTES_SUBNET_INVALID
"Drugs ",	//_aa_bsecure_drugs
"IP 주소가 공유기의 LAN IP 주소와 같아서는 안됩니다. ",	//LW1
"PC의 'lease' %v 를 오랫동안 갱신되지 않아 해당 IP 주소를 사용할 수 없습니다. 해당 PC에서 계속 그 IP 주소를 사용하면, IP 충돌이 발생할 수 도 있습니다. ",	//GW_DHCPSERVER_EXPIRED
"IP 주소 %v 는 반드시 LAN 서브넷 (%v) 안에 있어야 합니다. ",	//GW_INET_ACL_IP_ADDRESS_IN_LAN_SUBNET_INVALID
"브로드캐스트 전용(WINS 서버가 설정되지 않은 경우) ",	//bd_NETBIOS_REG_TYPE_B
"Financial ",	//_aa_bsecure_financial
"NAT는 연결이 이루어진 것과 같은 IP 주소에서 오는 통신에만 수신 연결 요청을 LAN 쪽 호스트로 전달합니다. 이 기능으로 원격지 응용프로그램이 송신 세션이 생성되었을 때 사용되었던 포트와는 다른 포트를 통해 데이터를 다시 돌려 보낼 수 있습니다.",	//YM135
"DHCP 서버 IP 시작 범위가 잘못되었습니다. ",	//LT119
"공인",	//_vs_public
"B-Node는 로컬 네트워크에서 브로드캐스트 ONLY 로만 사용하는 것을 나타냅니다. 이 설정은 WINS 서버를 사용할 수 있는 경우 유용합니다. 그러나, M-Node를 먼저 동작시키는 것이 더 좋습니다.",	//KR93
"게이트웨이 원격 관리가 포트에 설정 되었습니다. : %u",	//GW_SECURE_REMOTE_ADMINSTRATION
"Employment ",	//_aa_bsecure_employment
"네트워크 연결을 시작한 PC의 IP 주소와 포트 번호 ",	//YM160
"IP 할당",	//LS423
"L2TP 게이트웨이 IP 주소 %v 는 반드시 WAN 서브넷에 있어야 합니다. ",	//GW_WAN_L2TP_GATEWAY_IN_SUBNET_INVALID
"사설",	//_vs_private
"WAN에서 NetBIOS 정보 가져오기' 가 활성화 되어 있으면 이 설정은 효과가 없습니다. ",	//KR86
"2차 WINS IP 주소",	//bd_NETBIOS_SEC_WINS
"시작 IP 주소는 반드시 마지막 IP 주소보다 적어야 합니다. : %v-%v",	//GW_INET_ACL_START_IP_ADDRESS_INVALID
"인증",	//auth
"5GHz ",	//KR17
"호스트 2 IP 범위",	//YM84
"이 옵션(기본 설정) 활성화하여 원격지 호스트에 단일 VPN 연결을 할 수 있습니다. (그러나, 여러개의 VPN 연결은 반드시 VPN ALG를 사용해야 합니다.) 이 옵션을 비활성화하면, VPN ALG 또한 비활성화 된 경우에만 VPN을 비활성화 시킬 수 있습니다.",	//LW50
"PPPoE IP 주소가 잘못되었습니다. ",	//YM103
"In bridge mode, the device still supports several features not available in ordinary bridges -- features that involve the WAN side of the upstream router.",	//KR64
"Performance enhancing features such as Packet Bursting, FastFrames, and Compression. ",	//help361
"Wi-Fi Protected 설정",	//LW4
"PIN",	//KR38
"11a Static Turbo 모드에서 채널은 반드시 다음중 한 채널을 선택하셔야 합니다. (42,50,58,152,160)",	//GW_WLAN_11A_STATIC_TURBO_INVALID
"권한이 없습니다. ",	//YM6
"카테고리 선택",	//_aa_bsecure_categ_select
"우선 순위는 1~255 입니다. ",	//YM58
"청소년 (13-17)",	//_aa_bsecure_age_youth
"Wi-Fi Protected 설정을 사용하기 위해서는 <strong>WPS 무선 장비 추가</strong> 를 눌러 무선 장치를 추가하십시오. ",	//LW17
"포트 필터의 목적지 IP 마지막 주소가 잘못되었습니다. ",	//YM18
"WPA2-PSK/AES (also known as WPA2 Personal)",	//LT210
"휴지(Idle) 시간이 잘못되었습니다. 허용된 범위는 %u 에서 %u 입니다. ",	//GW_WAN_IDLE_TIME_INVALID
"멀티캐스트 그룹 주소 ",	//YM186
"Sports ",	//_aa_bsecure_sports
"이름 '%s' 이 이미 사용중입니다. ",	//GW_QOS_RULES_NAME_ALREADY_USED
"다음 마법사는 마이크로소프트의 윈도우즈 커넥트 나우(Windows Connect Now) 기술을 사용하여 공유기의 무선을 자동으로 설정할 수 있습니다. 이 기능을 사용하기 전에 PC 상에 마이크로소프트사의 네트워크 무선 설정 마법사가 제대로 동작하는 지 먼저 확인하십시오.",	//bwz_intro_WCNWz
"DHCP 서버 풀 TO %v 이 LAN 서브넷 %v 에 없습니다. ",	//GW_DHCP_SERVER_POOL_TO_IN_SUBNET_INVALID
"<warn> 생성한 가상 서버 엔트리의 필요에 따라 H.323이 성공적으로 설정되었습니다.</warn>",	//GW_NAT_H323_ALG_ACTIVATED_WARNING
"1차 WINS IP 가 잘못되었습니다. ",	//LT120y
"Wi-Fi Protected 설정이 성공적으로 저장되었습니다. ",	//KR103
"Calista IP phone ",	//YM44
"공유기를 전에 설정해 보셨거나 고급 사용자라고 생각하시면, <strong>무선 네트워크 직접 설정</strong> 를 눌러 모든 설정으로 직접 입력하시기 바랍니다.",	//LW47
"설정 파일 .netfilt,네트워크 필터 ",	//GW_XML_CONFIG_GET_FAILED
"(%s)로 SetAPSettings 설정이 완료되었습니다.",	//WIFISC_AP_SET_APSETTINGS_COMPLETE
"공유기와의 통신에 실패하였습니다. ",	//YM168
"이름 '%s' 이 이미 사용중입니다. ",	//GW_NAT_NAME_USED_INVALID
"잘못된 서버 인덱스 값: %d",	//GW_DYNDNS_SERVER_INDEX_VALUE_INVALID
"[WARN] ",	//WARN
"엔터프라이즈",	//LW23
"PPTP 비밀번호를 반드시 지정하십시오. ",	//GW_WAN_PPTP_PASSWORD_INVALID
"공유기의 디폴트 PIN 을 복구하였습니다. ",	//LW59
"무선 보안을 설정한 경우 설정한 키(Key) 또는 비밀번호(Passphrase)를 적어 두십시오. 무선 네트워크에 연결되는 모든 무선 장치에 이 정보를 입력해야 할 것입니다.",	//YM126
"활성화/설정 ",	//LW66
"라우팅 인터페이스가 잘못되었습니다. ",	//_r_alert4
"무선 스테이션 추가 ",	//LY10
"DHCP 서버 시작 주소 %v 가 유효한 %v 서브넷에 없습니다. ",	//GW_DHCP_SERVER_POOL_FROM_INVALID
"AP 설정 잠금 ",	//WIFISC_AP_SETUP_LOCKED
"지금 하신 수정사항을 취소하시겠습니까?",	//YM91
"선택한 Registrar 설정 실패, 원인(%s), err_code (%u)",	//WIFISC_AP_SET_SELECTED_REGISTRAR_FAIL
"변경된 설정이 전혀 없습니다. 그래도 저장하시겠습니까? ",	//LS3
"Unknown ",	//GW_NAT_UNKNOWN
"11a Dynamic Turbo mode 에서는 반드시 다음 채널만 설정하십시오.(40,48,56,153,161)",	//GW_WLAN_11A_DYNAMIC_TURBO_INVALID
"NTP 서버가 설정된 경우라도 시간대를 선택해서 일광 절약 시간 변수를 설정하는 것에 주의하십시오. ",	//YM163
"이 기능을 사용하기 위해서는 반드시 드랍다운 메뉴에 있는 서비스 공급업체 중 한 회사의 DDNS 계정이 있어야 합니다.",	//YM181
"권한 부족 ",	//_cantapplysettings_1
"Warnings",	//YM11
"1차 WINS IP 주소",	//bd_NETBIOS_PRI_WINS
"Wireless Device PIN",	//KR44
"Obscene ",	//_aa_bsecure_obscene
"잘못된 서버 IP 주소 ",	//YM130
"DDNS 서버를 선택하십시오. ",	//KR99
"1차 WINS IP 주소와 2차 WINS IP 주소를 반드시 지정해 주십시오. ",	//GW_DHCP_SERVER_PRIMARY_AND_SECONDARY_WINS_IP_INVALID
"%s' 의 출발지 IP 주소 범위를 적어도 한 개 설정하십시오. ",	//GW_FIREWALL_NO_IP_RANGE_INVALID
"가상 서버 '%s' 프로토콜 번호, %d 는  0 또는 3 ~ 255 입니다. ",	//GW_NAT_VS_PROTOCOL_INVALID
"무선 네트워크를 직접 설정하시려면 이 옵션을 선택하십시오. ",	//KR52
"무선 장치 추가 마법사에 오신 것을 환영합니다. ",	//KR33
"이 설정을 하기 위해서는 반드시 '관리자' 으로 로그인 하시기 바랍니다. ",	//ZM23
"이 마법사는 공유기에 무선 장치를 연결할 수 있도록 도와 줍니다. 무선 장치를 공유기에 연결하는 방법을 단계별로 하나씩 안내해 드릴것입니다. 아래 버튼을 눌러 시작하십시오.",	//LW40
"무선 보안 설정 잠금",	//LY4
"공유기를 전에 설정해 보셨거나 고급 사용자라고 생각하시면, <strong>인터넷 연결  직접 설정</strong> 을 눌러 모든 설정을 직접 입력하시기 바랍니다. ",	//LW34
"정말로 삭제하시겠습니까? ",	//YM25
"잘못된 포트 필터 IP 목적지 시작 주소 ",	//YM15
"Super&trade;GMode ",	//bwl_SGM
"Radius 서버 주소가 잘못되었습니다. ",	//GW_WLAN_80211X_RADIUS_INVALID
"로그인",	//LS316
"사용자가 로그 아웃되었습니다. ",	//ZM15
"<warn>공유기 LAN IP 주소와의 충돌로 인해 DHCP 서버 IP 보유(reservation) 기능이 비활성화 되었습니다.</warn>",	//GW_DHCP_SERVER_RESERVATION_DISABLED_IN_CONFLICT_WARNING
"호스트는 반드시 지정되어야 합니다. ",	//GW_DYNDNS_HOST_NAME_INVALID
"수동 무선 네트워크 설정 ",	//LW42
"잘못된 PPTP 게이트웨 IP 주소 : %v",	//GW_WAN_PPTP_GATEWAY_IP_ADDRESS_INVALID
"선택하신 설정 파일로 업데이트가 성공적으로 완료 되었습니다. ",	//rs_intro_4
"N/A ",	//_NA
"공유기 IP 주소는 지정된 목적지로 가기 위한 게이트웨이 주소로 사용됩니다. ",	//hhav_r_gateway
"[INFO] ",	//INFO
"Metric: ",	//help112
"11N 사용자용 Short Slot 강제 설정",	//aw_igslot
"(맞는 정보가 없으면 디폴트입니다.)",	//ZM2
"이 설정을 할 권한이 없습니다. ",	//LT7
"선택된 Registrar 설정",	//WIFISC_AP_SET_SELECTED_REGISTRAR
"When the necessary preparations are complete, the WCN technology will propagate the wireless network settings from your PC to the router. Then you will have to reboot the router for the settings to take effect. ",	//help214
"Both ",	//at_Both
"요일",	//ZM22
"공장 초기 설정으로 복구",	//help_ts_rfd
"공유기의 무선 설정을 직접 할 경우, 아래에 있는 수동 무선 네트워크 설정 버튼을 누르십시오.",	//LW44
"If your PC's operating system is Windows XP Service Pack 2 (SP2) or later and you are using Windows Internet Explorer (IE) as your browser, you can use Windows Connect Now (WCN) technology to help configure the router's wireless security settings. ",	//help209
"목적지 시작 포트는 0 ~ 65535입니다. (65535 포함)",	//YM70
"UPnP VS 엔트리 %v <-> %v:%d <-> %v:%d %s 를 %s 로 변경합니다. ",	//GW_UPNP_IGD_PORTMAP_VS_CHANGE
"This mode is not backwards compatible with non-Turbo (legacy) devices. This mode should only be enabled when all devices on the wireless network are Static Turbo enabled. ",	//help363
"웹 뉴스그룹",	//_aa_bsecure_web_newsgroup
"1차 DNS 주소가 잘못 되었습니다. ",	//YM128
"%s' 의 %s 를 공백으로 두지 마십시오. ",	//GW_NAT_PORT_TRIGGER_PORT_RANGE_EMPTY_INVALID
"StreamEngine&trade; technology is applied to media streas that are passed between the WAN side of the upstream router and clients of the bridge.",	//KR72
"비밀 번호가 맞지 않습니다. 다시 입력해 주십시오.",	//YM177
"Host 1 IP 범위",	//YM82
"인증 타임 아웃이 잘못되었습니다. ",	//YM119
"The bridge still has the ability to analyze traffic on the WAN side of the upstream router so as to determine the speed of its WAN connection.",	//KR70
"PC의 IP 주소와 적절한 포트로 네트워크 연결이 이루어졌습니다. ",	//YM161
"DHCP 서버 범위(pool) 크기 제한을 넘었습니다.(256개의 주소 이하여야 합니다.)",	//GW_DHCP_SERVER_POOL_SIZE_INVALID
"연결되었습니다. ",	//_sdi_s4b
"DNS Lookup 인증 서버",	//ZM8
"2차 DNS 주소가 잘못되었습니다.",	//YM129
"무선 보안 설정을 잠금 상태로 만들면 PIN 을 사용하여 다른 외부 registrar에 의해 설정이 수정 되는 것을 방지할 수 있습니다. 무선 장비들은 Wi-Fi Protected 설정을 사용해서도 연결할 수 있습니다. <a href='wireless.asp' shape='rect'>Manual Wireless Network Setup</a>, <a href='wizard_wlan.asp' shape='rect'>Wireless Network Setup Wizard</a>, 현재 외부에 있는 WLAN Manager Registrar 설정으로 무선 네트워크를 설정할 수 있습니다. ",	//LY29
"설정 파일 저장 중 주의하십시오.: %s",	//GW_XML_CONFIG_WRITE_WARN
"이름 '%s' 은 이미 있습니다. ",	//GW_FIREWALL_NAME_INVALID
"연결",	//LS314
"트래픽 종류",	//_vs_traffictype
"타임 아웃 값은 8760를 넘을 수 없습니다. ",	//GW_DYNDNS_TIMEOUT_TOO_BIG_INVALID
"Please enter the PIN of your wireless device, then click on the Connect button below.",	//KR43
"Wi-Fi Protected 설정을 지원하는 무선 장비가 있으면 이 옵션을 선택하십시오. ",	//KR51
"PPTP 게이트웨이 IP 주소 %v 는 반드시 WAN 서브넷에  있어야 합니다. ",	//GW_WAN_PPTP_GATEWAY_IN_SUBNET_INVALID
"Click the <span class='button_ref'>Save to Windows Connect Now</span> button, and the WCN technology will capture the wireless network settings from your router and save them on your PC.",	//help837
"설정 방법(Configuration Method)을 선택하여 무선 네트워크를 설정하십시오. ",	//KR49
"뉴스",	//_aa_bsecure_news
"업데이트",	//YM34
"고급 무선",	//_advwls
"<warn>DHCP Reservation %v 이 DHCP pool 이 너무 적어서 비활성화 되었습니다. </warn>",	//GW_DHCP_SERVER_RESERVATION_DISABLED_OUT_OF_POOL_WARNING
"MAC 필터를 설정하면 모든 장비를 잠금 상태로 만듭니다. 이것은 허용되지 않습니다. ",	//GW_MAC_FILTER_ALL_LOCKED_OUT_INVALID
"선택가능",	//YM98
"검색 엔진",	//_aa_bsecure_search_engine
"WPA Only",	//KR47
"<warn>이메일 서버가 공유기의 LAN 주소와 충돌합니다. - 이메일이 비활성화 됩니다.</warn>",	//GW_SMTP_LAN_ADDRESS_CONFLICT_WARNING
"LAN IP 모드가 잘못되었습니다.",	//GW_LAN_IP_MODE_INVALID
"지정된 Big Pond 서버의 도메인명과 IP 주소가 적절하지 않습니다. ",	//GW_WAN_BIGPOND_SERVER_NOTSTD15
"공유기 설정이 제대로 되었으면, 바로 설정 값을 설정 파일에 저장할 수 있습니다. ",	//ZM18
"프레그멘테이션 설정 값은 256 ~ 2346  입니다. ",	//GW_WLAN_FRAGMENT_THRESHOLD_INVALID
"설정한 도메인명이 잘못되었습니다. ",	//GW_LAN_DOMAIN_NAME_INVALID
"세션 중첩이 감지되었습니다. ",	//_wifisc_overlap
"설정 마법사를 사용하여 무선 네트워크를 직접 설정할 수 있도록 안내해 드립니다. 장비가 Wi-Fi Protected 설정을 지원하고 설정 버튼이 있는 경우에 장비에 있는 설정 버튼을 눌러 네트워크에 추가할 수 있습니다.  장비가 성공적으로 네트워크에 추가되면 공유기의 LED 상태창이 3번 깜빡거립니다. ",	//LW62
"성인사이트",	//_aa_bsecure_pornography
"드라이버명을 공백으로 두어서는 안됩니다. ",	//GW_NAT_NAME_INVALID
"Spatial Stream 수",	//bwl_NSS
"PPTP 서버의 IP 주소가 잘못되었습니다. ",	//YM108
"목적지 마지막 IP 주소는 LAN 서브넷에 있어서는 안됩니다. ",	//YM19
"주소가 MAC (%m) 인 단말장치가 등록되었습니다. ",	//WIFISC_AP_PROXY_PROCESS_COMPLETE
"레코드 '%s' 와 '%s' 가 중복입니다. ",	//GW_NAT_ENTRY_DUPLICATED_INVALID
"사용하기 쉬운 웹기반 마법사를 사용하시려면 아래 버튼을 누르십시오. ",	//LW27
"업데이트 하시겠습니까?",	//YM38
"NTP 서버가 설정 되지 않았습니다. ",	//YM185
"Wi-Fi Protected 설정",	//LY2
"세션 종료",	//KR31
"초기화 실패 ",	//_init_fail
"출발지 시작 포트는 0 ~ 65535 입니다.(65535 포함)",	//YM68
"MAC 주소",	//sd_macaddr
"WAN 포트 종류",	//KR12
"AP 가 %s 를 통하여 Registrar (%s) 에 등록되었습니다. ",	//WIFISC_AP_REGISTRATION_COMPLETE
"TPC 최대 이득",	//aw_TPC
"WDS AP MAC 주소",	//aw_WDSMAC
"원격지 마지막 포트는  0 ~ 65535입니다.(65535 포함) ",	//YM62
"다시 연결 시도한 모드가 잘못되었습니다. ",	//GW_WAN_RECONNECT_MODE_INVALID
"(%s) 에 의한 DelAPSettings  설정 완료",	//WIFISC_AP_DEL_APSETTINGS_COMPLETE
"관리자만이 통계 값들을 지울 수 있습니다.  현재 관리자로 로긴하지 않았으면, Clear Statics 버튼이 비활성화 되어 있습니다. ",	//ss_intro_user
"공유기를 처음 설정해 보시는 분이거나, 네트워크에 익숙하지 않으면, 설치 전에  <strong>인터넷 연결 설정 마법사</strong> 로 쉽게 설치하실 수 있습니다. ",	//LW33
"성공.  아래에 있는 취소 버튼을 눌러 다른 장비를 추가하거나 무선 상태 버튼을 눌러 무선 상태를 확인합니다. ",	//KR27
"UDP 프로토콜 패킷의 엔드포인트 필터링 제어 ",	//YM138
"Step 5: 보호(Sentinel) 카테고리",	//_aa_wiz_s6_title
"WISH 규칙",	//YM77
"QoS 엔진",	//YM48
"DHCP 보유 IP 주소가 잘못 되었습니다. ",	//YM89
"Pre-Shared Key 길이가 64 자리 이면 모두 HEX 로 설정하십시오. ",	//GW_WLAN_WPA_PSK_HEX_STRING_INVALID
"WAN IP 주소: %v 가 잘못되었습니다. ",	//GW_WAN_WAN_IP_ADDRESS_INVALID
"이 페이지에서 하신 설정을 모두 지우시겠습니까? ",	//LS4
"지정한 Dynamic DNS 서비스 공급자는 지원되지 않습니다. ",	//KR98
"Background (least urgent). ",	//YM148
"If you would like to be notified when new firmware is released, place a checkmark in the box next to <span class='option'>Email Notification of Newer Firmware Version</span>. ",	//help877a
"추가/업데이트",	//KR56
"호스트명 ",	//LS424
"네트워크 장비에 의해 DHCP 서버 주소 %v 가 거부 되었습니다. - 네트워크 상에 IP 주소 충돌을 확인하십시오. ",	//GW_DHCPSERVER_DECLINED
"요일이 선택되지 않았습니다. ",	//GW_SCHEDULES_DAY_INVALID
"UDP ",	//GW_NAT_UDP
"이메일 서버로 연결할 수 없습니다. ",	//IPSMTPCLIENT_CANNOT_CREATE_CONNECTION
"모두 체크",	//_aa_check_all
"DHCP 보유 엔트리에서 만든 설정을 모두 취소하시겠습니까? ",	//YM94
"갱신",	//LS312
"IP 주소가 잘못되었습니다. ",	//KR2
"프로토콜",	//_vs_proto
"설정한 TO 주소 (%s)가 맞지 않습니다. ",	//GW_SMTP_TO_ADDRESS_INVALID
"이름 '%s'이 이미 사용중입니다. ",	//GW_WISH_RULES_NAME_ALREADY_USED
"UDP, TCP, ICMP 와는 다른 프로토콜을 사용하는 LAN 응용프로그램이 인터넷상으로 세션을 시작할 때, 공유기의 NAT 는 그 세션을 트랙합니다. 해당 프로토콜을 알지 못하는 경우라도 트랙 할 수 있습니다. 이 기능은 ALG 필요 없이 특정 응용프로그램 활성시 유용합니다.(대부분의 경우 원격지 호스트에 단일 VPN 연결 시) ",	//LW48
"원격지 시작 IP 주소가 잘못되었습니다. ",	//YM54
"현재 PIN",	//LW9
"무선 네트워크 설정을 도울 수 있도록 마법사를 만들었습니다. 마법사가 무선 네트워크를 단계별로 설정하는 방법과 보안을 설정하는 방법을 안내할 것입니다. ",	//LW41
"공유기가 가장 좋은 채널을 선택할 수 있도록 공유기의 무선 네트워크를 자동 채널 스캔으로 설정하십시오. ",	//YM124
"RTS 값은 0 ~ 2347 입니다. ",	//GW_WLAN_RTS_THRESHOLD_INVALID
"L2TP 비밀번호를 반드시 지정해 주십시오. ",	//GW_WAN_L2TP_PASSWORD_INVALID
"일부 설정 변경이 다른 시스템 설정에 영향을 줍니다. 이런 수정 사항이 통신에 나쁜 영향을 주어 경고를 발생시킬 수도 있습니다. 경고는 수정된 기능이나 비활성화된 기능등을 나타내어 새로운 동작 환경에 맞도록 해 줍니다. ",	//YM12
"사용자가 로그 아웃하였습니다. ",	//ZM14
"In this case the term &quot; port&quot;  refers to the &quot; .",	//KR60
"RTS 값이 잘못되었습니다. ",	//YM28
"스케쥴이 잘못되었습니다. ",	//YM184
"웹기반 마법사를 사용하여 쉽게 마이크로 소프트의 Windows Connect Now을 설정할 수 있습니다. 아래의 설정 마법사 버튼을 누르십시오. ",	//int_intro_WCNWz7
"복구한 설정 파일이 잘못되었습니다. 설정 파일이 장비에 맞지 않거나 손상되었을 수 있습니다. ",	//rs_intro_1
"Both ",	//GW_NAT_BOTH
"복구 성공 ",	//rs_success
"(GMT+01:00) Budapest, Vienna, Prague, Warsaw ",	//up_tz_29b
"Day ",	//day
"<warn>LAN 서브넷이 맞지 않아 DHCP 서버가 비활성화 되었습니다. </warn>",	//GW_DHCP_SERVER_DISABLED_WARNING
"비밀번호와 확인한 비밀번호가 맞지 않습니다. 관리자 비밀번호를 다시 확인해 주십시오. ",	//YM173
"MAC 주소 %m 가 잘못되었습니다. ",	//GW_INET_ACCESS_POLICY_MAC_INVALID
"Wi-Fi Protected 설정",	//LW2
"LAN 에서 사용가능한 IP 주소 중에서 사용되지 않은 IP 주소를 할당하십시오.",	//KR75
"설정 파일 저장에 실패하였습니다. : %s",	//GW_XML_CONFIG_WRITE_FAILED
"Enable: ",	//help102
"이름 '%s' 이 이미 사용중입니다. ",	//GW_WISH_RULES_NAME_USED_INVALID
"DHCP 서버 풀 범위가 LAN 서브넷 %v 범위를 넘었습니다. ",	//GW_DHCP_SERVER_POOL_SIZE_IN_SUBNET_INVALID
"최대 통합 크기  ",	//aw_AS
"로컬 네트워크의 모든 무선 클라이언트를 포함하는 액티브 통신 리스트입니다.",	//YM171
"보유중인 IP %v가 설정된 LAN IP 주소와 충돌합니다. ",	//GW_DHCP_SERVER_RESERVED_IP_NOT_LAN_IP_INVALID
"가상 서버 '%s' 는 공유기의 HTTP WAN 관리 포트 %u를 사용할 수 없습니다. ",	//GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT
"사용중인 목적지 IP 주소의 넷마스크 부분을 확인합니다. ",	//hhav_r_netmask
"가상 서버 리스트",	//vs_vslist
"이 옵션중의 일부는 다른 포트 제한과 같이 동작할 수 있습니다. 엔드포인트 독립 필터링(Endpoint Independent Filtering)이 수신 필터나 스케쥴에 우선합니다. 따라서, 해당 포트상의 액티브 수신 필터에도 불구하고 포트를 통해 들어가는 송신 세션과 관련된 수신 세션 요청이 가능합니다. 그러나, 예상대로 액티브 세션이 없는 차단된 포트(스케쥴에 의해 차단되었든지, 수신 필터로 차단되었든지) 로 패킷이 전송될 때 해당 패킷들은 차단 될 것입니다. 포트와 주소 제한 필터링(Address Restricted Filtering)을 사용하여 수신 필터와 스케쥴이 정확하게 동작할 수 있도록 해 줍니다. 그러나, 일부 연결을 제한 할 수 있어 응용프로그램에서 필요한 포트를 열기 위해 포트 트리거, 가상 서버, 포트 포워딩 사용이 필요할 수도 있습니다. 주소 제한 필터링은 공유기의 특정 NAT 종류(특히, symmetric NAT)와 통신 문제를 피할 수 있게 해주지만, 수신 필터와 스케쥴 접근은 예상대로 동작하도록 그냥 둡니다.",	//YM137
"우선 순위 분류",	//YM74
"시스템 로그 서버 IP 주소 %v가 LAN 서브넷에 없습니다. ",	//GW_SYSLOG_ADDRESS_IN_SUBNET_INVALID
"WISH를 허용하여 무선 순위 트래픽에 우선 순위를 주고 싶은 경우 이 옵션을 활성화하십시오. ",	//YM86
"MAC 주소가 이미 사용중입니다.: %m",	//GW_MAC_FILTER_MAC_UNIQUENESS_INVALID
"Push Button",	//KR40
"MAC 주소 필터의 MAC 주소를 반드시 입력해 주십시오: %m",	//GW_MAC_FILTER_NULL_MAC_INVALID
"32 Kbytes ",	//aw_32
"WAN 서브넷이 LAN 서브넷과 충돌됩니다. ",	//GW_WAN_LAN_SUBNET_CONFLICT_INVALID
"활성화/설정 되지 않음",	//LW67
"DelAPSettings by (%s) failed, reason (%s), err_code (%u) ",	//WIFISC_AP_DEL_APSETTINGS_FAIL
"WINS 서버는 클라이언트를 'register'에 허용하는 것과 내 네트워크 환경등에서 다른 클라이언트를 검색한 클라이언트 정보를 저장합니다.",	//KR85
"MTU 크기가 잘못되었습니다. ",	//YM115
"호스트 1 포트 범위",	//YM83
"무선 패킷 충돌 수가 너무 많이 발생하는 경우, RTS/CTS(Request to Send/Clear to Send) 프로토콜을 사용하여 무선 성능을 향상시킬 수 있습니다.",	//LW51
"숫자  0 ~ 8760 (8706 포함) 을 반드시 입력하십시오. ",	//YM178
"Cults",	//_aa_bsecure_cults
"금지",	//YM5
"Firmware update checks",	//KR65
"공유기 기능 향상이나 기능 추가를 위해 주기적으로 펌웨어를 업데이트합니다. 공유기의 특정 기능에 문제가 있을 경우, 업데이트 할 펌웨어가 있는 지를 확인하십시오.",	//ZM17
"Wi-Fi Protected 설정을 지원하는 로컬 네트워크에서 다른 무선 장비들을 포함시키려면  <strong>설정에 체크</strong> 하십시오. ",	//LW14
"Windows Connect Now 에 저장 ",	//ta_wcn_bv
"가상 서버 '%s' 에서 공유기의 IP 주소 %v를 사용할 수 없습니다. ",	//GW_NAT_VS_IP_ADDRESS_CAN_NOT_MATCH_ROUTER
"사용중이므로 스케쥴 '%s' 를 삭제하거나 이름을 바꿀 수 없습니다. ",	//GW_SCHEDULES_IN_USE_INVALID
"WEP Key 3 ",	//wepkey3
"Internet rate estimation",	//KR69
"AIM Talk ",	//YM43
"ICQ ",	//YM45
"사용자 이름이 잘못되었습니다. ",	//GW_SMTP_USERNAME_INVALID
"Super G with Static Turbo ",	//help362
"새로운 펌웨어 버전 이메일 알림 기능에 체크  표시를 하여 새로운 펌웨어가 나왔을 때 알림 서비스를 받을 수 있습니다.",	//tf_intro_FWChA
"원격 데스크탑 ",	//_remotedesktop
"Super G Turbo Modes must use channel 6 for communication. For Super G with Static Turbo, <span class='option'>802.11 Mode</span> must be set to 802.11g. For proper operation, RTS threshold and Fragmentation Threshold on the <a href='adv_wlan_perform.asp'>Advanced &rarr; Advanced Wireless</a> screen should both be set to their default values. ",	//help359
"선호 하는 WIN 서버 IP 주소를 설정하십시오. ",	//KR84
"DTIM은 1~ 255 입니다. ",	//YM30
"로컬 포트 범위",	//at_LoPortR
"DHCP 서버 풀의 FROM %v 이 LAN 서브넷 %v에 없습니다. ",	//GW_DHCP_SERVER_POOL_FROM_IN_SUBNET_INVALID
"MAC 주소 필터가 멀티캐스트 주소 형식: %m 이 될 수 없습니다. ",	//GW_MAC_FILTER_MULTICAST_MAC_INVALID
"<warn>이메일 초기화에 실패하였습니다.</warn>",	//GW_SMTP_INIT_FAILED_WARNING
"DHCP 서버가 중단되었습니다. ",	//GW_DHCPSERVER_STOP
"DMZ address %v is not allowed.",	//GW_NAT_DMZ_NOT_ALLOWED_INVALID
"설정 파일 GW_NAT_PORT_DUP_INVALID,%s '%s' 의 '%s' 는 중복된 수가 포함되어서는 안됩니다. ",	//GW_XML_CONFIG_SET_FAILED
"%s '%s' of '%s' should not contain duplicated numbers.",	//GW_NAT_PORT_DUP_INVALID
"seconds for your wireless device to be connected. If you want to stop the process, click on the Cancel button below.",	//KR46
"Step 1: 무선 네트워크 설정 방법을 선택하십시오.",	//KR35
"Big Pond 비밀번호를 반드시 지정하시기 바랍니다. ",	//GW_WAN_BIGPOND_PASSWORD_INVALID
"프로토콜을 반드시 지정하십시오. ",	//YM57
"새로운 설정을 적용하기 위해서는 반드시 공유기를 재시작하십시오. 바로 재시작하거나, 다른 것을 수정하고 나중에 재시작하셔도 됩니다. ",	//KR104
"송신 이메일 주소의 형식이 잘못되었습니다. ",	//IPSMTPCLIENT_MSG_WRONG_SENDER_ADDR_FORMAT
"로그아웃",	//LS317
"입력하신 비밀번호가 맞지 않습니다. ",	//YM102
"When WDS is enabled, this access point functions as a wireless repeater and is able to wirelessly communicate with other APs via WDS links. Note that WDS is incompatible with WPA -- both features cannot be used at the same time. A WDS link is bidirectional; so this AP must know the MAC Address (creates the WDS link) of the other AP, and the other AP must have a WDS link back to this AP. ",	//help188
"IP 주소가 잘못되었습니다. ",	//_logsyslog_alert1
"MAC 주소가 잘못되었습니다. ",	//KR3
"Hate ",	//_aa_bsecure_hate
"802.11 b/g 모드인 경우는 802.11a 채널을 사용할 수 없습니다.  ",	//GW_WLAN_11BG_CHANNEL_INVALID
"애그리게이션 제한",	//aw_aggr
"시작",	//_wifisc_addstart
"포트 필터의 목적지 마지막 포트가 잘못되었습니다. ",	//YM22
"WDS 에서는 멀티캐스트 MAC 주소를 사용할 수 없습니다. ",	//GW_WLAN_WDS_MAC_ADDR_INVALID
"PIN을 디폴트로 리셋하십시오. ",	//LW10
"<a href='wireless.asp'>Setup &rarr; Wireless Settings</a> 페이지에서 설정한 설정 값이 반영됩니다. <span class='option'>MAC Address</span> 는 무선 카드 제조사에서 할당한 주소입니다.",	//LT291
"여기에서 WISH 규칙을 정의할 수 있습니다. ",	//YM156
"청소년(9-12)",	//_aa_bsecure_age_ado
"LAN 쪽 응용프로그램이 특정 포트를 통해 연결이 이루어지면 바로,   패킷 출발지에 상관 없이 NAT가 LAN 쪽 응용프로그램과 같은 포트로 모든 수신 연결 요청을 포워드합니다. 이것은 최소 제한 옵션으로, 일부 응용프로그램(특히 P2P 응용프로그램) 을 허용해서 최고의 연결성을 제공하여 인터넷에 직접 연결되어 있는 것처럼 동작합니다. ",	//YM134
"웹메일",	//_aa_bsecure_web_mail
"Make sure the APs are configured with same channel number. ",	//help188b
"WAN 트래픽 세이핑",	//at_title_Traff
"Specifies one-half of the WDS link. The other AP must also have the MAC address of this AP to create the WDS link back to this AP. ",	//help189
"무선이 검색 되어 %d 을 변경합니다. ",	//GW_WIRELESS_SWITCH_CHANNEL
"Big Pond 서버를 반드시 명시하십시오. ",	//GW_WAN_BIGPOND_SERVER_INVALID
"설정 파일이 라인 %u char %u 주변의 에러를 검색합니다. ",	//GW_XML_CONFIG_SET_PARSE
"무선 네트워크 이름(SSID) 숨김(Hidden Mode) 설정으로 무선 네트워크에 보안을 제공합니다. 이 옵션을 설정하면, 무선 네트워크 클라이언트가 SSID 검색으로 찾는 것을 방지할 수 있습니다. 공유기에 연결하기 위해서 무선 클라이언트에서 직접 무선 네트워크 이름을 설정하시기 바랍니다. ",	//YM125
"<a href='wireless.asp'>Setup &rarr; Wireless Settings</a> 와 <a href='adv_wish.asp'>Advanced &rarr; WISH</a> page and the <a href='../Advanced/Protected_Setup.shtml'>Advanced &rarr; Wi-Fi Protected Setup</a> 페이지에서 설정한 내용이 여기에 반영됩니다.  <span class='option'>MAC Address</span> 는 제조사에서 할당한 무선 카드의 MAC 주소입니다. ",	//LT290wifisc
"방화벽 정책 명이 공백이어서는 안됩니다. ",	//GW_FIREWALL_RULE_NAME_INVALID
"스케쥴",	//GW_NAT_SCHEDULE
"RIP 모드가 잘못되었습니다. ",	//GW_LAN_RIP_MODE_INVALID
"데이터 프레임 크기가 RTS 값 보다 클 경우, 무선 송신 장치가 RTS 프레임을 보내기 시작하고 CTS 프레임을 기다립니다. ",	//LW52
"팝업",	//_aa_bsecure_popups
"WPA2 only 모드는 TKIP를 지원하지 않습니다. ",	//GW_WLAN_WPA_WPA2_TKIP_INVALID
"2.4GHz ",	//KR16
"가상 서버",	//_vs_title
"PPPoE 사용자 명을 반드시 지정하십시오. ",	//GW_WAN_PPPOE_USERNAME_INVALID
"PPTP 서브넷 마스크 %v 가 잘못되었습니다. ",	//GW_WAN_PPTP_SUBNET_INVALID
"NetBIOS 범위(scope)의 형식이 잘못되었습니다. ",	//GW_DHCP_SERVER_NETBIOS_SCOPE_INVALID
"고정 IP 모드는 항상 설정 상태입니다. 따라서 설정 버튼이 따로 없습니다. ",	//KR94
"WISH ",	//YM63
"Gateway: ",	//help108
"스케쥴이 '%s' 에서 이미 사용중입니다. ",	//GW_SCHEDULES_DUPLICATED_INVALID
"가상 서버용 공인 포트 범위는 1 ~  65535 입니다. ",	//KR11
"원격지 마지막 IP 주소",	//KR6
"NetBIOS 등록 종류가 잘못되었습니다. ",	//GW_DHCP_SERVER_NETBIOS_TYPE_INVALID
"게임",	//_aa_bsecure_games
"Select this option if you want to configure your wireless device manually",	//KR42
"휴지(Idle) 타임이 잘못되었습니다. ",	//YM104
"티켓",	//_aa_bsecure_tickets
"Select this option if your wireless device supports PIN",	//KR39
"혼합 모드 (Broadcast then Point-to-Point)",	//bd_NETBIOS_REG_TYPE_M
"Enter a MAC address for each of the other APs that you want to connect with WDS. ",	//help189a
"UPnP가  %v <-> %v:%d %s 를 삭제하였습니다. ",	//GW_UPNP_IGD_PORTMAP_DEL
"L2TP 게이트웨이 IP 주소가 잘못되었습니다. ",	//YM111
"연결이 끊겼습니다. ",	//LS315
"키(key) 길이가 잘못 되었습니다. 키 길이는 반드시 8 ~ 63 문자로 해 주십시오. ",	//GW_WLAN_WPA_PSK_LEN_INVALID
"Personal ",	//LW24
"액티브 세션 리스트를 받고 있습니다. 잠시만 기다려 주십시오. ",	//YM167
"Anarchy ",	//_aa_bsecure_anarchy
"나중에 재시작하십시오.",	//YM4
"Criminal Skills ",	//_aa_bsecure_criminal_skills
"설정 변경의 결과로 경고 메시지를 받았습니다. \n 지금 경고 메시지 리스트를 생성할 수 없습니다. 다시 시도해 주십시오.",	//YM188
"NAT 엔드포인트 필터링 옵션으로 공유기의 NAT 기능이 이미 사용중인 포트로 수신 연결 요청 하는 방법을 제어할 수 있습니다.",	//YM133
"로컬 시작 포트는 0 ~ 65535(포함) 입니다. ",	//YM59
"수동으로",	//_aa_bsecure_manually
"이메일 주소가 설정되지 않았습니다. ",	//YM169
"공유기의 내부 네트워크를 설정하십시오. 설정하신 IP 주소는 웹 관리 인터페이스로 접속하는데 사용됩니다. 여기에서 IP 주소를 변경하시면, 네트워크에 다시 접속하기 위해서 PC의 네트워크 설정을 변경하신 네트워크 주소에 맞추어 주시기 바랍니다. ",	//YM97
"어린이 (0-8)",	//_aa_bsecure_age_child
"웹사이트 주소 '%s' 가 유효하지 않습니다. ",	//GW_WEB_FILTER_WEBSITE_INVALID_INVALID
"주",	//ZM21
"인터넷 세션",	//YM157
"The WCN ActiveX Control provides the WCN link between your PC and the router via the browser that communicates wireless configuration data without a USB flash drive. The browser will attempt to download the WCN ActiveX Control, if it is not already available on your PC. For this action to succeed, you must already have a WAN connection, and the browser's internet security setting must be Medium or lower (select Tools &rarr; Internet Options &rarr; Security &rarr; Custom Level &rarr; Medium). ",	//help213
"활성화 또는 비활성화 하시겠습니까? ",	//YM24
"피어(peer) 구성 에러 %u ",	//WIFISC_AP_PEER_CFG_ERR
"무선 네트워크에 이미 Wi-Fi Protected 설정이 구성되어 있으면, 무선 네트워크의 수동 설정으로 현재 설정되어 있는 무선 네트워크가 없어집니다.",	//LW43
"보유 MAC 주소가 잘못되었습니다. ",	//YM90
"TKIP and AES ",	//bws_CT_3
"<warn>A DHCP Reservation %v 이 %v 로 설정되었습니다. 구성에필요한 사항들에 맞는지 확인하시기 바랍니다. </warn>",	//GW_DHCP_SERVER_RESERVATION_RECONFIG_WARNING
"게이트웨이 경로가 잘못되었습니다. ",	//_r_alert3
"RIP 메트릭이 잘못되었습니다. ",	//GW_LAN_RIP_METRIC_INVALID
"WPA 그룹 키 업데이트 주기는 30 ~ 65535 초 사이에 설정하십시오. ",	//YM118
"게이트웨이 주소가 잘못되었습니다. ",	//YM127
"StreamEngine",	//KR71
"WDS 설정",	//aw_WDSEn
"로컬",	//sa_Local
"휴지 타임(Idle time)을 0 으로 설정할 수 없습니다. ",	//GW_WEB_SERVER_IDLE_TIME
"This option controls how the device reacts to traffic on the WAN connector.",	//KR59
"WAN 게이트웨이 IP 주소 %v는 반드시 WAN 서브넷에 있어야 합니다.  ",	//GW_WAN_WAN_GATEWAY_IN_SUBNET_INVALID
"로컬 IP 범위",	//at_LoIPR
"보이스 (VO)",	//YM81
"애그리게이션 Num 패킷 ",	//aw_AP
"<a href='wireless.asp'>Setup &rarr; Wireless Settings</a> 페이지와 <a href='adv_wish.asp'>Advanced &rarr; WISH</a> 페이지에서 설정한 값이 여기에 반영됩니다. <span class='option'>MAC Address</span> 는 무선 랜카드 제조업체가 할당한 고유 주소입니다. ",	//LT290
"패킷에 설정한 우선순위는 WISH 로직에 의해 패킷을 전송합니다. 우선 순위는 다음과 같습니다 : ",	//YM162
"설정 파일 검색 에러 (MIME)",	//GW_XML_CONFIG_SET_PARSE_MIME
"UDP 포트",	//GW_NAT_UDP_PORT
"성공하였습니다. ",	//YM9
"MTU 크기가 잘못되었습니다.(허용되는 범위는 %u ~ %u 입니다.)",	//GW_WAN_MTU_INVALID
"장치 %s (%m) 가 성공적으로 추가 되었습니다. ",	//WIFISC_IR_REGISTRATION_SUCCESS
"The IP address of packets that will take this route. ",	//help105
"네트워크 장비에서 DHCP 서버 주소 %v 가 갱신되었습니다. - 네트워크 장비에서 더 이상 해당 IP 주소를 사용할 필요가 없습니다. ",	//GW_DHCPSERVER_RELEASED
"프린터 설정 마법사를 시작합니다. ",	//LW32
"SetAPSettings by (%s) failed, reason (%s), err_code (%u)",	//WIFISC_AP_SET_APSETTINGS_FAIL
"루트 IP 주소가 잘못되었습니다. ",	//KR8
"이름 항목에서 경로 확인을 할 수 있습니다.(예: Network2) ",	//hhav_r_name
"Hybrid (Point-to-Point then Broadcast) ",	//bd_NETBIOS_REG_TYPE_H
"완전하게 맞는 매핑이 없는 경우, 아래의 &quot;cone&quot; 분류와 &quot;endpoint filtering&quot; 해당하는 모드를 사용하십시오. 공유기에 엔드포인트 개별 필터링이 설정되면, full cone으로 동작합니다. 주소 제한 필터링(restricted filtering)은 restricted cone을 구현합니다. 포트 및 주소 restricted 필터링은 port restricted cone으로 동작합니다.",	//KR55
"PPPoE IP 주소 %v 와 LAN 서브넷이 충돌됩니다. ",	//GW_WAN_PPPOE_LAN_SUBNET_CONFLICT_INVALID
"설정 파일 불러오기에 성공하였습니다. ",	//GW_XML_CONFIG_SET_SUCCESS
"로컬 마지막 포트 넘버는 0 ~ 65535(포함) 입니다. ",	//YM60
"설정 저장에 실패하였습니다. ",	//KR100
"Select this option if the WAN port is connected to the Internet. The device functions as a NAT router.",	//KR61
"L2TP IP 주소가 잘못되었습니다. ",	//YM109
"Reset by %s failed, reason (%s), err_code (%u)",	//WIFISC_AP_RESET_FAIL
"로컬 하드 드라이버에서 설정 가져오기 ",	//help_ts_ls
"WAN 게이트웨이 IP 주소가 잘못되었습니다. ",	//YM101
"자동",	//KR50
"프로토콜은 반드시 숫자입니다. ",	//YM56
"웹사이트 URL/ 도메인",	//aa_WebSite_Domain
"최대 전송률은 8 kbps ~ 100Mbps(포함) 사이입니다. ",	//GW_QOS_RULES_MAX_TRANS
"HTTP 또는 HTTS 중 한 가지는 반드시 설정하셔야 합니다. ",	//GW_WEB_SERVER_NO_ACCESS
"2차 WINS 서버가 있는 경우 그  IP 주소를 설정하십시오. ",	//KR87
"목적지 시작 IP 주소는 LAN 서브넷에 있어서는 안됩니다. ",	//YM16
"%s' 이미 사용중입니다. ",	//GW_SCHEDULES_NAME_CONFLICT_INVALID
"WEP Key 4 ",	//wepkey4
"HTTP와 HTTPS는 같은 WAN 포트를 사용할 수 없습니다. ",	//GW_WEB_SERVER_SAME_PORT_WAN
"소스의 마지막 IP 주소가 잘못되었습니다. ",	//YM65
"네트워크 설정",	//bln_title
"MAC 주소가 (%m) 인 단말장치의 등록에 실패하였습니다. 원인 (%s), err_code (%u)",	//WIFISC_AP_PROXY_PROCESS_FAIL
"More ",	//_more
"송신/수신 로긴",	//ZM12
"Banner Ad ",	//_aa_bsecure_banner_ad
"무선 상태",	//LY23
"한 개 이상의 연속 스트림 선택으로 실제 처리량(throughput) 을 향상 시킬 수 있습니다. 그러나 어떤 경우는 신호 질을 감소시킬 수도 있습니다. ",	//bwl_NSS_h1
"정책 %s 에서 지정한 장치가 없습니다. ",	//GW_INET_ACL_NO_MACHINE_IN_LAN_SUBNET_INVALID
"각 마법사를 시작하기 전에,  제품 박스에 들어 있는 간단 설치 매뉴얼(QIG) 에서 강조한 단계를 모두 따라해 주시기 바랍니다. ",	//LW39c
"선택한 Registrar 설정이 완료되었습니다. ",	//WIFISC_AP_SET_SELECTED_REGISTRAR_COMPLETE
"DHCP 클라이언트 이름이 잘못되었습니다. ",	//GW_DHCP_CLIENT_CLIENT_NAME_INVALID
"액티브 세션 리스트 검색에 실패하였습니다. 다시 시도. ",	//YM166
"%s 실패로 재시작 되었습니다. 원인 (%s), err_code (%u)",	//WIFISC_AP_REBOOT_FAIL
"다음의 웹기반 마법사는 무선 네트워크 설정과 무선 장비 연결을 도와줍니다. ",	//LW39
"비밀번호와 비밀번호 확인이 맞지 않습니다. 사용자 비밀번호을 다시 확인하여 주십시오. ",	//YM174
"포트 필터 규칙이 공백일 수 없습니다. ",	//YM13
"이 사이트에 접속하기에는 웹브라우저 버전이 너무 낮습니다. 웹브라우저를 업그레이드 하십시오. ",	//YM172
"TPC 최대 이득(gain)이 잘못되었습니다. ",	//YM31
"필터하실 Sentinel 범위를 선택하십시오. ",	//_aa_wiz_s6_msg
"비밀번호가 잘못되었습니다. ",	//GW_SMTP_PASSWORD_INVALID
"Host 2 포트 범위",	//YM85
"Name' 항목을 공백으로 두지 마십시오. ",	//GW_SCHEDULES_NAME_INVALID
"게이트웨이가 잘못되었습니다. ",	//LS204
"16 Kbytes ",	//aw_16
"마법사를 시작하십시오. ",	//LW64
"Day(s) ",	//_days
"Specifies whether the entry will be enabled or disabled. ",	//help103
"- ",	//YM183
"그룹 키 업데이트 주기가 잘못되었습니다. ",	//YM117
"&quot;Full Cone&quot;, &quot;Restricted Cone&quot;, &quot;Port Restricted Cone&quot;, &quot;Symmetric&quot;이 라는 용어들은 NAT의 여러 가지 종류를 말합니다. 이런 용어만으로는 공유기의 NAT 동작을 충분히 설명하기 어려우므로 여기서는 상세히 설명하지 않습니다. ",	//KR54
"라우팅 설정으로 데이터가 이동하는 일반적인 경로를 설정할 수 있습니다.",	//av_intro_r
"각 경로에는 체크 박스가 있습니다.  해당 경로를 설정하고 싶으시면 그 박스에 체크하십시오. ",	//hhav_enable
"DNS 서버를 반드시 설정해 주십시오. ",	//GW_WAN_DNS_SERVERS_INVALID
"복구 되었습니다. ",	//_rs_succeeded
"PPTP 사용자명을 반드시 입력해 주십시오. ",	//GW_WAN_PPTP_USERNAME_INVALID
"L2TP IP 주소: %v 가 잘못되었습니다. ",	//GW_WAN_L2TP_IP_ADDRESS_INVALID
"이름란을 비워 두지 마십시오. ",	//GW_INET_ACL_NAME_INVALID
"일",	//days
"이 설정은 고급 설정으로 일반적으로 설정하지 않습니다.  동작하고 있는 네트워크 호스트 아래에서 NetBIOS 'domain' 이름을 설정할 수 있습니다.",	//KR88
"PPPoE IP 주소: %v 가 잘못되었습니다. ",	//GW_WAN_PPPOE_IP_ADDRESS_INVALID
"보안을 높이기 위해, 길이가 충분히 길어야 하고 일반적으로 사용되지 않는 것이어야 합니다. ",	//KR19
"비컨(Beacon) 주기가 잘못되었습니다. ",	//YM27
"<a href='wireless.asp'>Setup &rarr; Wireless Settings</a> 페이지와 the <a href='../Advanced/Protected_Setup.shtml'>Advanced &rarr; Wi-Fi Protected Setup</a> 페이지에서 설정한 값을 여기에서 확인할 수 있습니다.  <span class='option'>MAC Address</span> 주소는 제조업체에서 무선 랜카드에 부여한 고유한 ID 입니다. ",	//LT291wifisc
"포트 필터 이름",	//KR1
"Rule \' ",	//YM51
"송/수신 heartbeat",	//ZM13
"1차 DNS가 잘못되었습니다. ",	//GW_LAN_PRIMARY_DNS_INVALID
"11a 모드에서 Turbo를 사용할 수 없습니다. ",	//GW_WLAN_11A_DFS_TURBO_INVALID
"무선 네트워크 이름을 변경하는 것이 무선 네트워크 보호의 첫번째 단계입니다. 개인 정보를 제외한 것중에서 익숙한 이름으로 무선 네트워크 이름을 변경하십시오. ",	//YM123
"가상 서버의 IP 주소가 잘못되었습니다. ",	//KR9
"예: 192.168.0.1.",	//KR79
"성인 (18+)",	//_aa_bsecure_age_adult
"초기화되지 않았습니다. ",	//ZM7
"목적지 시작 포트는 포트 필터의 목적지 마지막 주소보다 반드시 커야 합니다. ",	//YM23
"WISH 설정",	//YM73
"기간만료",	//LS425
"새로운 PIN 을 생성합니다. ",	//LW11
"<warn>생성한 가상 서버 엔트리 때문에 PPTP ALG가 자동으로 설정되었습니다.</warn>",	//GW_NAT_PPTP_ALG_ACTIVATED_WARNING
"정말로 삭제 하시겠습니까? ",	//YM35
"요일 선택",	//tsc_sel_days
"설정을 복구하기 전에 반드시 공유기를 재시작해야 설정이 적용됩니다. 지금 다시 시작할 수도 있도, 다른 사항을 변경한 후에 나중에 다시 시작하셔도 됩니다.",	//sc_intro_rb4
"스케쥴 명: '%s' 시간이 잘못되었습니다. ",	//GW_SCHEDULES_TIME_INVALID
"갱신 시간이 잘못되었습니다. (1 ~65535)",	//GW_DHCP_SERVER_LEASE_TIME_INVALID
"서버 IP 주소를 확인할 수 없어 이메일을 보낼 수 없습니다. ",	//IPSMTPCLIENT_NO_SERVER_IP_ADDRESS
"가상 서버용 사설 포트 범위는 1..65535 입니다. ",	//KR10
"https 지원되지 않는 프로토콜입니다. ",	//GW_WEB_FILTER_HTTPS_NOT_SUPPORTED_INVALID
"The Wireless Device PIN should be either 4 or 8 digits",	//KR22
"Both ",	//_vs_both
"설정 하기 전에는 AP가 비활성화 되어서는 안됩니다. ",	//GW_WIFISC_LOCK_VERIFY_ERR
"RF 간섭이 있거나 RF 커버 영역에 제한이 있는 경우, 무선 프레임을 작은 단위로 나누어 성능을 향상 시킬 수 있습니다. ",	//LW53
"웹 사이트 '%s' 는 이미 사용중입니다. ",	//GW_WEB_FILTER_WEB_SITE_IS_USED_INVALID
"소스 시작 IP 주소가 잘못되었습니다. ",	//YM64
"루트 인터페이스가 유효하지 않습니다. ",	//GW_ROUTES_INTERFACE_INVALID
"2차 DNS가 잘못되었습니다. ",	//GW_LAN_SECONDARY_DNS_INVALID
"WAN NetBIOS",	//bd_NETBIOS_LEARN_FROM_WAN_ENABLE
"<warn>LAN 서브넷이 변경되었기 때문에 포트 포워딩 테이블이 다시 구성됩니다. </warn>",	//GW_NAT_PORT_FORWARDING_TABLE_RECONFIGURED_WARNING
"802.11 Band ",	//KR15
"AP Registrar (%s) through %s, unexpected (%s), at state (%s) 등록에 실패하였습니다. ",	//WIFISC_AP_REGISTRATION_UNEXPECTED_EVENT
"<warn>시스템 로그 IP 주소가 LAN 서브넷에 없습니다.  다시 설정해 주십시오. </warn>",	//GW_SYSLOG_ADDRESS_NOT_IN_SUBNET_WARNING
"2차 WINS IP 주소가 잘못되었습니다. ",	//GW_DHCP_SERVER_NETBIOS_SECONDARY_WINS_INVALID
"이 기능은 DMZ 호스트(설정 된 경우)에는 적용되지 않음을 알려드립니다. DMZ 호스트는 항상 이런 종류의 세션을 처리합니다. ",	//LW49
"추가/업데이트 스케쥴 규칙 ",	//KR95
"8 Kbytes ",	//aw_8
"2차 DNS 서버 IP 주소가 잘못되었습니다. ",	//YM114
"암호화 유형",	//bws_CT
"R 등급 ",	//_aa_bsecure_rrated
"무선 보안 설정 잠금 ",	//LW6
"IP 풀 주소는 FROM 이 TO 보다 항상 낮아야 합니다. ",	//GW_DHCP_SERVER_POOL_FROM_TO_ORIENTATION_INVALID
"TKIP ",	//bws_CT_1
"설정 데이터베이스 잠금에 실패하였습니다. help690,Session Initiation Protocol. A standard protocol for initiating a user session that involves multimedia content, such as voice or chat. ",	//GW_XML_CONFIG_SET_LOCK
"보유 IP 주소 %v 가 다른 IP 주소와 충돌합니다. ",	//GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID
"WEP Key 2 ",	//wepkey2
"수동 인터넷 연결 옵션 ",	//LW28
"직접 설정하기 위해 이 설정을 정지합니다. ",	//KR83
"시스템 로그 서버 IP 주소가 잘못되었습니다. ",	//GW_SYSLOG_ADDRESS_INVALID
"PPTP IP 주소가 잘못되었습니다. ",	//YM105
"DHCP 클라이언트",	//ZM5
"WCN ActiveX Control ",	//help212
"Please push button on your wireless device, then click on the Connect button below.",	//KR45
"Step 2: 무선 장비를 연결하십시오. ",	//KR36
"루트 메트릭 %u 가 잘못되었습니다. 메트릭 값은 1 ~ 16 입니다. ",	//GW_ROUTES_METRIC_INVALID
"SSID 항목은 반드시 입력하십시오. ",	//GW_WLAN_SSID_INVALID
"타임아웃 값이 0 이 될 수 없습니다. ",	//YM179
"The bridge checks the support site for updates by way of the upstream router.",	//KR66
"잡지",	//_aa_bsecure_magazine
"장비의 현재 처리량이 너무 많아서 수신한 명령을 처리하지 못할 수도 있습니다. 설정을 다시 저장해 주시기 바랍니다.  ",	//KR101
"WPA only mode는 AES를 지원하지 않습니다. ",	//GW_WLAN_WPA_WPA_AES_INVALID
"수신 필터",	//GW_NAT_INBOUND_FILTER
"정책 명을 비워두지 마십시오. ",	//GW_INET_ACL_POLICY_NAME_INVALID
"인터넷",	//sa_Internet
"규제에 따라,  무선 감지(radar detection) 설정 없이는 52 - 140 채널을 사용할 수 없습니다. ",	//GW_WLAN_11A_DFS_CHANNEL_INVALID
"호스트 1의 포트 메시지의 흐름에 적용하는 규칙은 여기에서 설정한 범위안에 있습니다. ",	//YM153
"원격지 IP 범위",	//at_ReIPR
"'관리자' 계정으로만 보안 설정을 변경할 수 있습니다.  ",	//LW15
"DTIM 값은 1 ~ 255 입니다. ",	//GW_WLAN_DTIM_INVALID
"WISH 규칙은 상세 메시지 흐름을 확인하고 그 흐름의 우선 순위를 할당합니다. ",	//YM144
"DNS 설정",	//wwa_dnsset
"이 마법사는 게스트 무선 장치를 무선 라우터로 연결시키는 작업을 돕도록 설정되어 있음. 각각의 단계를 통해 게스트 무선 장치를 연결시킬 수 있는지 알려 줌. 시작 하려면 버튼을 누르시기 바람.",	//wireless_gu
"WPS와 함께 게스트 무선 추가",	//add_gu_wps
"무선 대역",	//wwl_band
"대역",	//_band
"수동으로 5GHz 대역 네트워크 이름 설정",	//wwa_5G_nname
"게스트 영역 선택",	//guestzone_title_1
"게스트 영역 동작",	//guestzone_enable
"무선 포함",	//guestzone_inclw
"게스트",	//guest
"무선네트워크 보다 낮다",	//lower_wnt
"무선네트워크와 동일",	//equal_wnt
"최저",	//_lowest
"SSID 목록",	//ssid_lst
"게스트 유저는 게스트 SSID를 통해서 인터넷에 접속 가능함.",	//dlink_help150
"여러개의 SSID",	//mult_ssid
"각각의 무선카드에 하나 이상의 SSID를 할당할수 있음.",	//dlink_help155
"추가/편집 SSID",	//add_ed_ssid
"SSID는 설정 또는 해제 가능. SSID 설정시에는 다음의 요소에 영향을 미침.",	//dlink_help156
"이 네트워크는 SSID에 속함;동일한 네트워크에 속한 SSID 사용자는 서브넷을 통해 데이터를 전송할 수 있음.",	//dlink_help157
"WAN 핑 인바운드 필터",	//wpin_filter
"WAN 컴퓨터가 ping 특성을 사용할 수 있도록 제어하는 필터를 선택. 만약 목록에서 발견할 수 없다면, &quot;Advanced → Inbound Filter screen&quot;로 가서 새 필터를 만들어야 함.",	//dlink_help151
"게스트 네트워크 추가시 선택",	//S500
"USB 3.5G 설정",	//usb3g_titile
"APN 이름",	//usb3g_apn_name
"다이얼 번호",	//usb3g_dial_num
"재접속 모드(0:항상/1:요청/2:매뉴얼)",	//usb3g_reconnect_mode
"유휴시간",	//usb3g_max_idle_time
"USB 장비(0:3G 모뎀/1:K코드)",	//usb_device
"USB 3.5G 매뉴얼",	//usb3g_manual
"USB 3.5G 통계량",	//usb3g_stat_titile
"USB 지정",	//bln_title_usb
"WCN 설정",	//usb_wcn
"USB 포트를 설정할수 있다. Network USB, 3G USB 어댑터와 WCN 설정들을  여러가지로 지정할 수 있다.",	//bwn_intro_usb
"네트워크 USB",	//usb_network
"3G USB 어댑터",	//usb_3g
"다이얼 번호",	//wwan_dial_num
"WWAN 인터넷 접속 타입",	//bwn_wwanICT
"인증 프로토콜",	//wwan_auth_label
"자동(PAP+CHAP)",	//wwan_auth_auto
"PAP만 사용",	//wwan_auth_pap
"CHSP만 사용",	//wwan_auth_chap
"MS CHAP만 사용",	//wwan_auth_mschap
"여러 사용자가 사용하는 네트워크에  라우터 내부의 USB 포트에 연결되는 공유할 USB 프린터, 스캐너, 또는 저장장치를 지정.",	//usb_network_help
"장치 드라이버와 디링크 USB 네트워크 유틸리티가 사용할  각각의 컴퓨터에 인스톨이 되어 있어야 함",	//usb_network_support_help
"3G 어댑터를 이용하여 EV-DO 셀룰러 신호를 사용하는  인터넷을 접속할수 있게 3G USB 어뎁터 지정.  인터넷을 연결하기 위해 간단히 3G USB 어뎁터로 접속(써드 파트 EV-DO 동의와 유효한 신호가 필요)",	//usb_3g_help
"라우터를 통해서 인터넷 접속에 문제가 있을시에는 설정부분을 더블클릭하여 ISP 설정이 제대로 되었는지 확인 해야 함.",	//usb_3g_help_support_help
"윈도우즈 바로 접속(WCN)을 이용하여 무선 네트워크를 지정. WCN은 라우터에서 USB 플레쉬 드라이브로 무선네트워크 설정을 복사할수 있고,  해당 컴퓨터나 다른 WCN 장치에서도 자동적으로 무선 설정을 할수 있다.",	//usb_wcn_help
"내 연결할 USB 타입은",	//bwn_mici_usb
"네트워크 USB 인지 시간 간격을 설정하고, 라우터는  자동적으로 USB 장치를 인식함.",	//_info_netowrk
"네트워크 USB 자동인지 설정",	//_network_usb_auto
"네트워크 USB 인지 시간 간격",	//bwn_usb_time
"초(범위:3-600초.)",	//bwn_bytes_usb
"WPS가 동작상태일때는 공유키를 선택할수 없음",	//_wps_albert_1
"WPS가 동작상태일때는 WPA-Enterprisey를 선택할수 없음",	//_wps_albert_2
"WWAN 설정을 지정 할 것. 만일 설정이 정확하지 않다면 인터넷 서비스 프로바이더(ISP)에 문의 할 것.",	//usb_config1
"인터넷 접속 타입을 지정 할 것.  만일 설정이 정확하지  않다면 인터넷 서비스 프로바이더(ISP)에 문의 할 것.",	//usb_config2
"3G 인터넷 연결에 적합하지 않은 타입입니다.  3G 인터넷 접속을 지원하기 위해 WWAN 지정 할 것. ",	//usb_config3
"3G 인터넷 연결에 적합한 타입입니다. 다른 인터넷 접속 타입을 지정 할 것.",	//usb_config4
"3G 인터넷 연결에 적합한 타입을 지정하였습니다. USB 설정이 네트워크 USB/WCN에서 3G USB 어댑터로 변경됨.",	//usb_config5
"3G 인터넷 연결에 적절하지 않은 타입을 지정하였습니다. USB 설정이 3G USB 어댑터에서 네트워크 USB/WCN에서 변경됨.",	//usb_config6
"USB 포트에 삽입될 USB 장치 타입을 지정 할 것.",	//bwn_msg_usb
"만일 네트워크 USB 옵션을 사용한다면, 사용자는 컴퓨터에 네트워크 USB 유틸리티를 인스톨 해야 하고, 라우터를 통해서 USB 장치를 공유할 수 있음.  ",	//bwn_note_usb
"국가",	//_country
"해당국가선택",	//_select_country
"해당ISP선택",	//_select_ISP
"호주",	//country_1
"이태리",	//country_2
"포르투갈",	//country_3
"영국",	//country_4
"인도네시아",	//country_5
"말레이시아",	//country_6
"싱가폴",	//country_7
"필리핀",	//country_8
"남아프리카",	//country_9
"홍콩",	//country_10
"대만",	//country_11
"이집트",	//country_12
"도미니카 공화국",	//country_13
"엘살바도르",	//country_14
"브라질",	//country_15
"게스트 네트워크 추가시 선택",	//S500
"네트워크 타입",	//S496
"HTTPS Server 동작",	//LV2
"이메일 통보가 되지 않으므로 인해서 이메일 버튼 사용 불가 <a href='tools_email.asp' onclick='return jump_if();' shape='rect'>Tools &rarr; Email</a> screen.",	//logs_LW39b_email
"HTTPS 사용",	//LV3
"%s%s맥주소를 이용한 무선랜시스템 %m 보안과 연결",	//GW_WIRELESS_DEVICE_LINK_UP
"전체 로그 목록 삭제. ",	//LT248
"PPPoE 서버 확인중 %s PPPoE 연결",	//GW_PPPOE_EVENT_DISCOVERY_ATTEMPT
"5GHz 대역",	//GW_WLAN_RADIO_1_NAME
"SMTP 서버 포트",	//te_SMTPSv_Port
"SSID와 WEP 설정이 되어 있어서 802.11 모드에서 802.11n 으로 변경 불가.",	//GW_WLAN_CHANGING_PHY_MODE_TO_11NG_ONLY_INVALID
"무선네트워크 선택",	//S558
"설정을 원하는 무선 선택",	//KRL8
"이 선택은 게스트 영역 규모를 정의 하는데 도움을 준다.",	//LY30
"가상서버 '%s' 라우터의 HTTPS  관리자 WAN 포트를 사용할 수 없다, %u",	//GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
"보안 SSID의 '%s' WPA 설정으로 인해 Wi-Fi는 설정변경을 못하도록 한다.",	//GW_WIFISC_DISABLED_AUTOMATICALLY
"%s PPPoE 연결 제의 수락, 서비스 제의는 %s 로 부터 %s (%m)",	//GW_PPPOE_EVENT_OFFER
"2.4GHz 대역",	//GW_WLAN_RADIO_0_NAME
"%s PPPoE 연결 프로토콜 결함. 연결시도 실패.",	//GW_PPPOE_EVENT_DISCOVERY_REQUEST_ERROR
"PPPoE 연결 이름 %s 다른 연결 이름과 충돌",	//GW_WAN_PPPOE_SESSION_NAME_CONFLICT
"로그 수신 문제! 메모리 부족으로 로그 표현 불가  또는 연결에 문제 있음.",	//S525
"패스워드는 인쇄가능한 문자만 가능함.",	//S493
"경고메세지를 확인해야 함, 왜냐하면 일부 기능이 동작하지 않거나 수정될수 있음.",	//KR136
"종료 %s PPPoE 연결 ID %u",	//GW_PPPOE_EVENT_DISCONNECT
"향상된 IGMP 프록시",	//anet_multicast_enhanced
"이 기능은 호스트 영역과 게스트 영역간의 라우팅이 가능하게 하고, 이 기능을 사용하지 않으면 게스트 유저들은 호스트 유저의 데이타에 접근할 수 없음.",	//LY34
"%s무선 다운",	//GW_WIRELESS_SHUT_DOWN
"%s무선 재시작",	//GW_WIRELESS_RESTART
"관리자 유휴시간은 1 ~ 65535 범위안에 있어야 함.",	//S528
"포트 포워딩 ALG가 TCP 패킷을 %v:%u 에서 %v:%u로 할당하는데 실패함",	//GW_PORT_FORWARD_TCP_PACKET_ALLOC_FAILURE
"이 기능은 라우터에서 게스트 영역을 설정. 게스트가 인터넷에 접근할수 있도록 게스트 영역에 별도의 네트워크 영역 제공.",	//guestzone_Intro_1
"가상서버 '%s' 라우터의 HTTPS 관리자의 WAN 포트 사용할수 없다, %u",	//GW_NAT_VIRTUAL_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
"영역간 라우팅 가능",	//S473
"포트는 대역폭 (1..65535)안에 있어야 함.",	//te_SMTPSv_Port_alert
"%s무선을 시작하는데 실패",	//GW_WIRELESS_DEVICE_START_FAILED
"포트 포워딩 ALG이 UDP 패킷을 %v:%u 에서 %v:%u로 할당하는데 실패함.",	//GW_PORT_FORWARD_UDP_PACKET_ALLOC_FAILURE
"%s 모든 상태의 연결 중지",	//GW_WIRELESS_DEVICE_DISCONNECT_ALL
"%s PPPoE 연결제공을 위한 요청을 함",	//GW_PPPOE_EVENT_OFFER_REQUEST
"라우터 IP %v 는 반드시 유효한 호스트 주소를 가지고 있어야 함",	//GW_ROUTES_ROUTERS_IP_ADDRESS_INVALID
"포트 트리거 ALG는  UDP 패킷을 %v:%u 에서부터 %v:%u까지 할당하는데 실패함",	//GW_PORT_TRIGGER_UDP_PACKET_ALLOC_FAILURE
"802.11n의 SSID를 위한 WEP 보안을 설정할 수 없음",	//GW_WLAN_SETTING_SSID_SECURITY_TO_WEP_INVALID
"가상서버 '%s'는 관리자의의 HTTP 관리자 WAN 포트, %u를 사용할 수 없음",	//GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT
"시간초과, 작업이 완료되지 않았음",	//GW_WLAN_STATION_TIMEOUT
"가상서버 '%s' 는 공유기 IP 주소 %v 를 사용할 수 없음.",	//GW_NAT_VIRTUAL_SERVER_IP_ADDRESS_CAN_NOT_MATCH_ROUTER
"%s' [프로토콜:%u]->%v와 '%s'가 충돌함. [프로토콜:%u]->%v",	//GW_NAT_VIRTUAL_SERVER_PROTO_CONFLICT_INVALID
"게스트 영역이 작동가능한지 안한지를 알려줌.",	//LY28
"%s PPPoE 연결을 하려고 시도함",	//GW_PPPOE_EVENT_CONNECT
"통신주파수 대역. 2.4GHz는 긴 대역폭과 장비의 가시성 확보를 위해 필요하며 5GHz는 성능을 저해할 수 있는 간섭을 최소화 시켜줌.",	//KR971
"자동적으로 2.4GHz 와 5GHz 주파수를 할당함. (권장사항)",	//wwz_auto_assign_key3
"무선 게스트 네트워트 영역에 이름을 제공함.",	//LY292
"무선 네트워크의 보안은 무선 네트워크를 통해 전달되는 정보의 무결성을 보전하기 위해 매우 중요함. 라우터는 4가지 종류의 무선보안을 제공합니다 : WEP, WPA only, WPA2 only, and WPA/WPA2 (자동탐지).",	//LY293
"만약 WEP 보안 옵션을 선택하신다면, <strong>단지</strong> <strong>Legacy Wireless 모드(802.11B/G)</strong>에서만 작동됨.  이것은 WEP이 draft 11N의 성능을 지원할 수 없기에 11N 성능을 <strong>사용할 수 없음</strong>을 의미함.",	//bws_msg_WEP_4
"라우터 %v 의 인터페이스 %s 를 설정되지 않았음 - 해당 인터페이스의 게이트웨이를 통한 경로만 설정되어 있음",	//GW_ROUTES_ON_LINK_DATALINK_CHECK_INVALID
"MTU default = ",	//_308
"로컬 도메인 이름",	//_262
"이 항목은 옵션사항 입니다. 로컬 네트워크의 도메인 명을 입력하시기 바랍니다. AP의 DHCP 서버가 무선랜에 연결되어 있는 컴퓨터에 도메인 명을 할당할 것입니다. - 예를 들면 <code>mynetwork.net</code> 를 입력하면  <code>chris</code> 이름을 가진, <code>chris.mynetwork.net</code> 으로 무선 랩탑이 할당됩니다. ",	//_1044
"AP를 &quot;DHCP(동적)&quot; 주소로 설정한 경우, 공유기의 DHCP 서버가 AP에 도메인 이름을 할당하고 그 도메인 이름은 여기에 입력한 모든 이름보다 우선합니다. ",	//_1044a
"보유하고 싶은 LAN 주소 ",	//_1066
"사용되고 있는 펌웨어 파일을 다시 만드시겠습니까?",	//tf_really_FWF
"버튼을 눌러 새로운 접근 제어 정책을 생성하십시오. ",	//_501_12
"기타",	//at_Prot_1
"Expire Time",	//_223
"The gateway address is not in the LAN subnet",	//_225ap
"IP address or subnet mask is badly formatted",	//_226ap
"This entry is optional. Enter a domain name for the local network. Your LAN computer will assume this domain name when it gets an address from the <span>rou</span><span>ter</span>'s built in DHCP server. So, for example, if you enter <code>mynetwork.net</code> here, and you have a LAN side laptop with a name of <code>chris</code>, that laptop will be known as <code>chris.mynetwork.net</code>.",	//_1044wired
"Note, however, the entered domain name can be overridden by the one obtained from the <span>rou</span><span>ter</span>'s upstream DHCP server.",	//_1044awired
"WAN IPv6 어드레스 설정",	//IPV6_WAN_IP
"IPv6 주소",	//IPV6_TEXT0
"먼저 IPv6 WAN 프로토콜로 변경해 주세요.",	//IPV6_TEXT1
"부적절한 네트워크 키값!",	//IPV6_TEXT2
"영역별 라우팅 설정",	//IPV6_TEXT3
"SSID 설정",	//IPV6_TEXT4
"이 선택은 게스트 영역의 범위를 정의하는데 도움을 준다.",	//IPV6_TEXT5
"게스트 영역을 사용 또는 비사용으로 지정",	//IPV6_TEXT6
"게스트 영역 무선 네트워크 이름 제공",	//IPV6_TEXT7
"이 부분은 호스트 영역과 게스트 영역간에 라우팅을 동작시킴, 이 기능 없이는 게스트 클라이언트가 호스트 클라이언트 데이터에 접근 할수 없음.",	//IPV6_TEXT8
"정보의 무결성이 보장되고, 전달되어야 하는 무선 네트워크의 보안은 중요하다. 라우터는 WEP, WPA only, WPA2 only, WPA/WPA2(자동감지) 등 4가지의 무선 보안 기능을 갖고 있다.",	//IPV6_TEXT9
"WEP는 무선 보안 프로토콜이며, 무선 로컬영역 네트워크(WLAN)에 사용된다. WEP는 WLAN에 전달되는 데이터의 암호화를 제공한다.라우터는 64비트와 128비트의  두레벨의 암호화를 지원한다. WEP는 디폴트로 비사용이다. WEP 설정은 기존 무선 네트워크 또는 해당 네트워크에 적합하게 변경할수 있다",	//IPV6_TEXT10
"인증은 무선네트워크에 접속하려는 장비의 동일성에 대한 부분을 라우터가 검증하는 과정이다. WEP를 사용하는 두 종류의 인증 타입이 있다.",	//IPV6_TEXT11
"이 옵션은 모든 무선 장비가 라우터와 통신이 가능하게 하고, 네트워크 접속에 필요한 암호화 키 없이 접속을 가능하게 한다.",	//IPV6_TEXT12
"이 옵션은 DIR-615와 통신이 허용되기 이전에 무선장비가 라우터와 통신을 시도하는 과정에서 네트워크 접속에 필요한 암호화 키를 제공하게 한다.",	//IPV6_TEXT13
"해당 네트워크에 사용할 WEP 암호화 레벨을 지정. 64비트와 128 비트의 두 레벨이 제공됨. ",	//IPV6_TEXT14
"DIR-615에 지원되는 키값 타입으로는 HEX 와 ASCII 가 있다. 키 타입은 기존 무선 네트워크와 해당 네트워크에 적절하게 바꿀수 있다. ",	//IPV6_TEXT15
"키값",	//IPV6_TEXT16
"키값 1-4는 네트워크의 보안을 유지하기 위해 무선 설정을 쉽게 바꿀수 있다.  네트워크 무선 데이터를 암호화 하기 위해 특정한 키값을 지정할수 있다. ",	//IPV6_TEXT17
"키값 타입",	//IPV6_TEXT18
"WEP 암호화",	//IPV6_TEXT19
"Wi-Fi는 무선네트워트에 접속하는 권한과 인증사용자를 보호한다. WPA는 WEP 보다 강력한 보안을 사용하고, 키값을 바탕을로 정기적인 주기로 자동적으로 조절된다.",	//IPV6_TEXT20
"DIR615는 WPA를 사용할때 두가지 다른 암호화 타입을 제공한다.  이 두가기 옵션은 TKIP 과 AES 이다.",	//IPV6_TEXT21
"PSK/EAP",	//IPV6_TEXT22
"PSK를 선택하면, 무선 클라이언트는 인증을 위한 비밀 번호가 필요하게 된다. EAP를 선택하면 해당 네트워크에는 RADIUS 서버가 필요하고, 이 서버는 무선 클라이언트에 대한 인증 관리를 한다. ",	//IPV6_TEXT23
"비밀번호",	//IPV6_TEXT24
"PSK를 선택할때 해당 무선 클라이언트가 DIR-615와 통신하기 위해 이것이 필요하게 된다. 8~63 사이의 문자와 숫자의 조합을 입력하세요. 다른 네트워크 장비에 접속하기 위해서 이 비밀번호가 필요하므로 정확하게 입력해야 한다.",	//IPV6_TEXT25
"WPA 인증은 해당 네트워크에 존재하는 RADIUS 서버와의 접속을 의미한다. 사용하는 IP 어드레스, 포트, 공유키를 RADIUS에 설정하세요. 해당 네트워크가 두개인 경우 무선 클라이언트를 인증하기 위해서 두번째의 RADIUS서버에 해당정보를 입력할수 있는 옵션도 있다.  ",	//IPV6_TEXT26
"Wi-Fi는 무선네트워트에 접속하는 두개의 권한과 인증사용자를 보호한다. WPA2는 WEP 보다 강력한 보안을 사용하고, 키값을 바탕을로 정기적인 주기로 자동적으로 조절된다.",	//IPV6_TEXT27
"이 부분은 IPV6 접속 타입을 설정한다. 타입이 확실하지 않다면 인터넷 서비스 업체에 문의 할것.",	//IPV6_TEXT28
"IPv6 접속 타입",	//IPV6_TEXT29
"IPv6 접속 타입",	//IPV6_TEXT29a
"IPv6 인터넷을 사용할수 있는 라우터 모드를 선택.",	//IPV6_TEXT30
"나의 IPV6 접속은 ",	//IPV6_TEXT31
"정적 IPv6",	//IPV6_TEXT32
"DHCPv6",	//IPV6_TEXT33
"PPPoE",	//IPV6_TEXT34
"IPv6 in IPv4 터널",	//IPV6_TEXT35
"6 to 4",	//IPV6_TEXT36
"링크-로컬 only",	//IPV6_TEXT37
"IPv6 in IPv4 터널 설정",	//IPV6_TEXT38
"터널에 제공되는 IPv6 in IPv4 터널 정보 입력.",	//IPV6_TEXT39
"원격 IPv4 어드레스",	//IPV6_TEXT40
"원격 IPv6 어드레스",	//IPV6_TEXT41
"로컬 IPv4 어드레스",	//IPV6_TEXT42
"로컬 IPv6 어드레스",	//IPV6_TEXT43
"랜 IPv6 어드레스 설정",	//IPV6_TEXT44
"이 부분은 라우터의 내부 네트워크를 설정할 수 있음. 만일 랜 IPv6 어드레스를 바꿨으면, 네트워크 접속하기 위해 PC 네트워크 설정도 조정이 필요하다.",	//IPV6_TEXT45
"랜 IPv6 어드레스",	//IPV6_TEXT46
"랜 IPv6 링크-로컬 어드레스",	//IPV6_TEXT47
"어드레스 자동설정 세팅",	//IPV6_TEXT48
"이 부분은 IPv6 자동설정을 셋업 할 수 있고, 해당 네트워크의 컴퓨터에 IP 어드레스가 할당 된다.",	//IPV6_TEXT49
"자동설정 동작",	//IPV6_TEXT50
"자동설정 타입",	//IPV6_TEXT51
"상태가 없는(stateless)",	//IPV6_TEXT52
"상태가 있는(stateful)/(DHCPv6)",	//IPV6_TEXT53
"IPv6 어드레스 범위(시작)",	//IPV6_TEXT54
"IPv6 어드레스 범위(끝)",	//IPV6_TEXT55
"IPv6 어드레스 수명",	//IPV6_TEXT56
"라우터 광고 수명",	//IPV6_TEXT57
"IPv6 인터넷에 접속하기 위해 라우터를 설정할때 정확한 IPv6 접속 타입을 메뉴에서 선택해야 함. 만일 타입이 확실하지 않다면, 인터넷 서비스 제공업체에 문의 할 것.",	//IPV6_TEXT58
"라우터를 통한 IPv6 인터넷 접속에 문제가 있다면, 이 페이지에서 설정된 모든 설정을 더블클릭해서 체크를 해야하고, 필요하다면 서비스 제공업체에도 확인 해야 함.",	//IPV6_TEXT59
"6to4 설정",	//IPV6_TEXT60
"인터넷 제공 업체에서 제공된 IPv6 어드레스 정보 입력.",	//IPV6_TEXT61
"6to4 어드레스",	//IPV6_TEXT62
"IPv6 DNS 설정",	//IPV6_TEXT63
"자동으로 DNS 서버 어드레스 받기 또는 특정한 DNS 서버 어드레스 입력",	//IPV6_TEXT64
"자동으로 DNS 서버 어드레스 받기",	//IPV6_TEXT65
"다음에 있는 DNS 어드레스 사용",	//IPV6_TEXT66
"이 부분은 해당 라우터의 내부 네트워크를 설정하는데 사용된다.",	//IPV6_TEXT67
"어드레스 수명",	//IPV6_TEXT68
"광고 수명",	//IPV6_TEXT69
"어드레스 범위(start)",	//IPV6_TEXT70
"어드레스 범위(끝)",	//IPV6_TEXT71
"인터넷 제공 업체(ISP)에서 제공된 정보 입력",	//IPV6_TEXT72
"유휴 시간",	//IPV6_TEXT73
"서브넷 프리픽스 길이",	//IPV6_TEXT74
"디폴트 게이트 웨이",	//IPV6_TEXT75
"IPv6(인터넷 프로토콜 버전 6) 부분은 IPv6 접속 타입을 설정 할 수 있음.",	//IPV6_TEXT76
"링크-로컬, 정적 IPv6, DHCPv6, 상태가 없는(stateless) 자동설정, PPPoE, IPv6 in IPv4 터널과 6to4 등 여러가지 접속타입을 선택할 수 있다. 만일 접속방법이 확실하지 않다면, IPv6 인터넷서비스 제공업체에 문의 할 것. 만일 PPPoE 옵션을 사용한다면, 해당 컴퓨터에 PPPoE 클라이언트 소프트웨어가 제거 되거나 비활성 상태가 되어야 한다.",	//IPV6_TEXT77
"링크-로컬 모드",	//IPV6_TEXT78
"링크-로컬 어드레스는 노드나 라우터에 사용되고, 같은 링크에 인접 노드간 통신할때 사용된다. 이 모드는 IPv6가 지원되는 장비와 랜으로 연결된 각각의 장비와 통신이 가능하게 한다.",	//IPV6_TEXT79
"정적 IPv6 모드",	//IPV6_TEXT80
"ISP에서 제공된 IPv6 어드레드를 바꾸지 않고 사용시에 이 모드를 사용한다. IPv6 정보는 수동적으로 IPv6 설정 세팅에 입력된다. 반드시 IPv6 어드레스, 서브넷 프리픽스 길이, 디폴트 게이트 웨이, 1순위 DNS 서버, 2순위 DNS 서버를 입력해야 한다.  ISP 업체가 모든 정보를 제공한다.",	//IPV6_TEXT81
"DHCPv6 모드",	//IPV6_TEXT82
"이 것은 해당 라우터가 ISP의 서버를 요구할때 ISP가 할당한 IPv6 어드레스는 대한 접속 방법이다. 어떤 ISP는 해당 라우터가 IPv6 인터넷에 접속 할 수 있도록 설정을 요구한다.  ",	//IPV6_TEXT83
"상태가 없는(stateless) 자동설정 모드",	//IPV6_TEXT84
"이것은 해당 라우터가 디폴트 게이트웨이를 요구할때 ISP가 할당한 IPv6 어드래스에 대한 접속 방법이다. IPv6 어드레스 주소 설정 부분은 라우터 광고 메시지의 인수를 기반으로 한다.",	//IPV6_TEXT85
"ISP가 PPPoE를 이용하여 IPv6 인터넷 접속을 요구할때 이 옵션을 선택한다.  DSL 제공자도 일반적으로 이 옵션을 사용한다. 이 접속 방법은 IPv6 인터넷에 접속하기 위해 <strong>유저이름</strong> 그리고 <strong>패스워드</strong>(인터넷 서비스 업체에서 제공된 정보) 등이 필요로 한다.인증 프로토콜로는 PAP와 CHAP가 지원된다.",	//IPV6_TEXT86
"만일 ISP 서버가 라우터의 WAN IPv6 어드레스를 할당하고 접속할려면 이 옵션을 선택해야 한다. ",	//IPV6_TEXT87
"만일 ISP 업체가 고정된 IPv6 어드레스를 할당했으면 이 옵션을 선택. ISP 는  IPv6 어드레스의 value <SPAN class=option> 제공한다.",	//IPV6_TEXT88
"WAN 링크가 단절되기 전에 장비가 유휴되는 시간 간격이 있다. 최대 유휴시간 값은 &quot; On demand&quot;와 &quot;Manual&quot; 재접속 모드에서만 사용된다.",	//IPV6_TEXT89
"IPv6 in IPv4 터널 모드",	//IPV6_TEXT90
"터널링된 IPv4 패킷 안에 캡슐화된 IPv6 패킷이 있고, IPv6 패킷은 IPv4 기반안에서 전달된다.",	//IPV6_TEXT91
"6to4 모드",	//IPV6_TEXT92
"6to4는 할당된 IPv6 어드레스이고, 자동 터널링 기술은 IPv4 인터넷 구간을 통해 IPv6 사이트와 호스트간의 유니캐스트 IPv6 연결에 제공된다. ",	//IPV6_TEXT93
"프라이머리 DNS 서버, 세컨더리 DNS 서버 : DNS 서버에 IPv6 어드레스 입력. 세컨더리 서버를 사용하지 않은 다면 공백으로 둘 것.",	//IPV6_TEXT94
"라우터에 IPv6 인터페이스 LAN(로컬 영역 네트워크)설정이 있다. 라우터의 LAN IPv6 어드레스 설정은 ISP에서 부여한 IPv6 어드레스와 서브넷이 기초가 된다.(서브넷은 랜에서 프리픽스/64가 지원된다)",	//IPV6_TEXT95
"해당 네트워크 컴퓨터에 IPv6 어드레스를 할당하기 위해 IPv6 자동설정을 셋업하기 위한 부분이다. 상태가 없는(Stateless), 상태가 있는(Stateful) 자동설정 모드는 지원된다.",	//IPV6_TEXT96
"DHCPv6 서버를 이용해서 IPv6 어드레스의 두 가지 값(~ 부터 ~까지)의 범위를 지정하고, 해당 로컬 영역 네트워크에 DHCPv6 서버를 이용해 컴퓨터와 장비에 어드레스 할당한다.외부에 있는 이런 어드레스 범위는 DHCP 서버가 관리하지 않는다. 수동으로 장비를 설정하기도 하고 또는 어떤 장비들은 자동적으로 세부적인 네트워크 어드레스 받지 않도록 DHCPv6 사용하지 않는다.",	//IPV6_TEXT97
"상태가 있는(stateful)/(DHCPv6)를 지정한다면, 다음과 같은 옵션이 보인다.",	//IPV6_TEXT98
"해당 랜에 연결된 컴퓨터(다른장비)들은 TCP/IP 설정이 필요하고, &quot;DHCPv6&quot;  또는 자동으로 IPv6 어드레스를 받도록 설정해야 한다.",	//IPV6_TEXT99
"IPv6 어드레스 범위(DHCPv6)",	//IPV6_TEXT100
"D-Link 라우터가 적절하게 설정되면 이 옵션이 동작한다. 라우터는 로컬 영역 네트워크에 연결된 다른 장비와 컴퓨터의 IPv6 어드레스와 설정 정보를 관리한다.관리자가 직접 해야할 필요은 없다. ",	//IPV6_TEXT101
"컴퓨터와 장비는 이 범위안에 IPv6 어드레스를 갖도록 수동으로 설정 할수 있다",	//IPV6_TEXT102
"컴퓨터가 IPv6 어드레스를 새로 받기전에 소요되는 일정시간. ",	//IPV6_TEXT103
"D-Link 회사 | 무선 라우터 | 홈",	//TEXT000
"상태가 없는(stateless) 자동설정",	//TEXT001
"포트 포워딩 이름 + i +효력없는. 부적절한 문자 ',/,''",	//TEXT002
"규칙 이름 + i + 효력없는.부적절한 문자 ',/,''",	//TEXT003
"효력없는 호스트 이름.부적절한 문자 ',/,''",	//TEXT004
"효력없는 도메인 이름. 부적절한 문자 ',/,''",	//TEXT005
"규칙 이름 + i + 효력없는. 부적절한 문자 ',/,''",	//TEXT006
"포트 포워딩 이름 + i + 효력없는. 부적절한 문자 ',/,''",	//TEXT007
"규칙+i+ 같은 규칙으로 셋팅+j+.",	//TEXT008
"obj_word + 다른 일반 포트와 충돌.",	//TEXT009
"obj_word + 다른 개인 포트와 충돌.",	//TEXT010
"다른 프로토콜 타입은 부적절함",	//TEXT011
"wps와 함께 무선장비를 선택하세요!",	//TEXT012
"인바운드 필터는 반드시 작아야 한다 + rule_max_num",	//TEXT013
"이름을 설정할때 '전부 허용' 또는 '전부 비허용'과 같은 디폴트 인바운드 필터 이름과 같아서는 안된다.",	//TEXT014
"스케쥴 규칙 가득 찼음! 엔트리를 삭제하세요.",	//TEXT015
"첫 페이지",	//TEXT016
"마지막 페이지",	//TEXT017
"이전",	//TEXT018
"시스템 활동 상태",	//TEXT019
"디버그 정보",	//TEXT020
"공격",	//TEXT021
"드롭된 패킷",	//TEXT022
"공지",	//TEXT023
"WPS가 동작상태일때는 WEP 키 2,3,4를 선택할 수 없다!!",	//TEXT024
"WPS가 동작상태일때는 WPA-Personal/TKIP 또는 AES를 선택할 수 없다!!",	//TEXT025
"WPS가 동작상태일때는 WPA-Enterprise를 선택할 수 없다!!",	//TEXT026
"WPS가 동작상태일때는 공유키를 선택할 수 없다!!",	//TEXT027
"우선 무선을 동작시키세요.",	//TEXT028
"WPS 기능이 정지 중입니다. 동작시키려면 &quot;예&quot;를 또는 위저드를 나오시려면 &quot;아니오&quot;를 클릭하세요.",	//TEXT029
"%s는 루프백 IP 또는 멀티캐스트IP를 허용하지 않음 (127.x.x.x, 224.x.x.x ~ 239.x.x.x)범위.",	//TEXT030
"입력된 포트 %s는 부적절함..",	//TEXT031
"입력된 secret %s는 부적절함.",	//TEXT032
"보류된 IP 어드레스",	//TEXT033
"다른 이름을 입력하세요",	//TEXT034
"IP 어드레스 시작",	//TEXT035
"IP 어드레스 끝",	//TEXT036
"랜 IP 어드레스와 시작 IP 어드레스는 같은 서브넷이 아님",	//TEXT037
"랜 IP 어드레스와 끝 IP 어드레스는 같은 서브넷이 아님",	//TEXT038
"끝나는 IP 어드레스는 시작하는 IP 어드레스 보다 커야 함",	//TEXT039
"설정이 저장되었읍니다.",	//TEXT040
"키값 ' + i + ' 부적절함. 키값는 반드시 ' + wep_key_len + ' 문자 또는 ' + hex_len + ' hexadecimal number.",	//TEXT041
"키값  '+ i + ' 는 틀림, 유효한 문자는 0~9, A~F, or a~f.",	//TEXT042
"%s 게이트웨이 IP 어드레스 %s WAN 서브넷 안에 있어야 함.",	//TEXT043
"우선 컴퓨터 이름을 지정하세요",	//TEXT044
"펌웨어는 최신 버전입니다.",	//TEXT045
"서버 접속 실패. 인터넷 접속 상태를 확인하세요.",	//TEXT046
"WAN과 LAN IP 어드레스는 같은 서브넷을 사용할 수 없음.",	//TEXT047
"해당 무선 네트워크에 추가할려는 장비에 다음에 오는 설정을 입력하세요. 나중에 참고하기 위해 노트를 해 주세요. ",	//TEXT048
"해당 네트워크에 추가하려는 무선 장비는 등록되지 않았습니다. 아래의 버튼을 클릭하셔서 재 시도 하시길 바랍니다.",	//TEXT049
"IP 어드레스'+ res_ip +' 이미 사용되고 있습니다.",	//TEXT050
"재확인한 패스워드는 새로운 패스워드와 일치하지 앖습니다",	//TEXT051
"우선 어플리케이션 이름을 지정해 주세요",	//TEXT052
"ALSO CALLED WCN 2.0 IN WINDOW VISTA",	//TEXT053
"obj_word +  포워딩 포트와 충돌.",	//TEXT054
"obj_word +  어플리케이션 방화벽 포트와 충돌.",	//TEXT055
"obj_word +  버츄얼 서버 포트와 충돌.",	//TEXT056
"포트 충돌.",	//TEXT057
"TCP 포트 충돌.",	//TEXT058
"UDP 포트 충돌.",	//TEXT059
"포트 포워딩 이름은 이미 리스트에 있습니다.",	//TEXT060
"TCP 포트 이름 또는 UDP 포트 이름을 입력해 주십시요.",	//TEXT061
"IP 어드레스에 대한 DHCP 보류 엔트리를 동작하기를 원하시나요? ' + DataArray[idx].IP'",	//TEXT062
"이 규칙이 다른 규칙에 의해서 사용되고 있고, 삭제할 수 없습니다.",	//TEXT063
"부적절한 스케쥴 이름임. 적절한 문자는 0~9, A~Z, or a~z.",	//TEXT064
"스케쥴 이름은 디폴트 이름과 같습니다.",	//TEXT065
"스케쥴 이름이 이미 리스트에 있습니다.",	//TEXT066
"이 규칙이 다른 규칙에 의해서 사용되고 있고, 편집할 수 없습니다.",	//TEXT067
"IPv6 네트워크 정보",	//TEXT068
"해당되는 모든 IPv6 인터넷과 상세한 네트워크 접속 부분이 이 페이지에 나타 냄.",	//TEXT069
"IPv6 접속 정보",	//TEXT070
"WAN IPv6 어드레스",	//TEXT071
"랜 IPv6 컴퓨터",	//TEXT072
"Retry",	//TEXT073
"다음",	//TEXT074
"호스트 명 또는 Ipv6 주소=",	//TEXT075
"위에 정확한 암호를 입력하시고 아래보이는 그림의 문자를 입력하세요", //_authword
"재생성", //regenerate
"그림으로 나타낸 인증코드를 입력하세요", //li_alert_4
"그림으로 나타낸 인증 동작" //_graph_auth
	);
