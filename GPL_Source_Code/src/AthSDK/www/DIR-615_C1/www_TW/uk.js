var which_lang = new Array(
"WAN 介面速率測量完成",	//GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED
"WAN端介面速度測量沒有被啟動因為資源過低",	//GW_WAN_RATE_ESTIMATOR_RESOURCE_ERROR
"STA 與MAC (%m) 要求 (供WPS 註冊)",	//WIFISC_AP_PROXY_PROCESS_START
"同樣的設備。",	//aa_alert_7_new1
"MSCHAP  傳遞認證回覆 (失敗就不重試)",	//IPMSCHAP_AUTH_FAIL_AND_NO_RETRY
"請稍後… ",	//_please_wait
"檢查最新版本的韌體",	//tf_FWCheckInf
"如果新韌體已經可用時Email 通知我",	//tf_ENFA
"當它們沒有整合時,WAN端介面速度測量會被中止",	//GW_WAN_RATE_ESTIMATOR_CONVERGENCE_ERROR
"WAN 介面速率測量完成。上傳速率為 %u kbps。",	//GW_WAN_RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED
"MSCHAP 認證傳遞要求",	//IPMSCHAP_AUTH_SEND_CHALLENGE
"登記Email 線上通知服務，用以當有更新的韌體可供下載使用時接收Email 通知。",	//help890_1
"第六",	//tt_week_6
"目的地及通訊閘應該不再同一個子網路 %v範圍中 ",	//GW_ROUTES_GATEWAY_SUBNET_SAME
"現在檢查",	//tf_CKN
"WPS 內部註冊沒有從任何無線位置接收到要求 -兩分鐘後將被停止。",	//WIFISC_IR_REGISTRATION_FAIL_3
"MSCHAP 傳送認證回覆至同等位置",	//IPMSCHAP_AUTH_RESULT
"MSCHAP 認證細節已傳送至驗證端",	//IPMSCHAP_AUTH_SENT
"MSCHAP 認證要求接收(從同等位置)",	//IPMSCHAP_CHALLENGE_RECVD
"通訊閘位址 %v 不能與已存在的介面使用相同的位址",	//GW_ROUTES_GATEWAY_IP_ADDRESS_CONFLICTS
"要更新韌體，請按下&quot;瀏覽&quot;按鈕已載入位於本機硬碟中的韌體檔。當您確認韌體檔已經載入正確可用後，再按下下方的&quot;更新&quot;按鈕開始進行韌體更新。",	//tf_intro_FWChB
"現在檢查網際網路上最新韌體版本",	//tf_COLF
"WPS 內部註冊新增無線位置失敗 %m，原因: %s，錯誤碼 %u。",	//WIFISC_IR_REGISTRATION_FAIL_2
"網際網路存取控制丟棄封包從 %v:%u 到 %v:%u (通訊協定 %u)",	//GW_INET_ACCESS_DROP_ACCESS_CONTROL_WITH_PORT
"MSCHAP 認證失敗 -請檢查登入相關細節。",	//IPMSCHAP_AUTH_FAIL
"<warn>WINS/NetBIOS 設定在這個網際網路模式下無法從網際網路被學習 - WINS 將無法被預期的運作。</warn>",	//GW_DHCP_SERVER_WINS_INCOMPATIBILITY_WARNING
"因為已經在使用中，無法刪除或重新命名",	//GW_SCHEDULES_IN_USE_INVALID_s2
"可用的下載網站",	//tf_ADS
"STA MAC (%m) WPS 程序關閉",	//WIFISC_AP_PROXY_PROCESS_CLOSE
"用以增進機能及性能",	//tf_intro_FWU2
"WPS 內部註冊開始 %s 登記",	//WIFISC_IR_REGISTRATION_INPROGRESS
"MSCHAP 認證逾時 - 認證失敗。",	//IPMSCHAP_AUTH_TIMEOUT
"最終韌體日期",	//tf_LFWD
"WPS 內部註冊新增位置失敗，原因 %s",	//WIFISC_IR_REGISTRATION_FAIL_1
"網際網路存取通訊埠過濾器，丟棄封包從 %v:%u 到 %v:%u (通訊協定 %u)",	//GW_INET_ACCESS_DROP_PORT_FILTER_WITH_PORT
"WINS/NetBIOS 在這個模式下可能沒有生效給您的網際網路連線設定。",	//GW_DHCP_SERVER_WINS_MODE_INVALID
"MSCHAP 認證成功。",	//IPMSCHAP_AUTH_SUCCESS
"<warn>路由器通訊閘 IP %v 與現存介面位址相符的話，將被停用。</warn>",	//GW_ROUTES_GATEWAY_IP_ADDRESS_CONFLICTS_WARNING
"排程",	//GW_SCHEDULES_IN_USE_INVALID_s1
"UPnP 已刪除記錄 %v <-> %v:%d <-> %v%d %s '%s' (用戶端已釋放位址)",	//GW_UPNP_IGD_PORTMAP_RELEASE
"WPS STA結束，MAC (%m) on msg: %s",	//WIFISC_AP_PROXY_END_ON_MSG
"WPS 內部登錄偵測會談重疊，介於%m 與 %m",	//WIFISC_IR_REGISTRATION_SESSION_OVERLAP
"網路電腦 (%s)分派的IP 位址為 %v.",	//GW_DHCPSERVER_NEW_ASSIGNMENT
"那裡也許有新韌體可以讓您下載",	//tf_intro_FWU1
"PPTP 傳送窗口為 %u",	//PPTP_EVENT_REMOTE_WINDOW_SIZE
"動態PPPoE",	//Dynamic_PPPoE
"固定PPPoE",	//static_PPPoE
"新增無線裝置",	//add_wireless_device
"開啟 gw_wireless_schedule",	//GW_WLS_SCHEDULE_START
"只允許電腦對這些網站進行存取",	//dlink_wf_op_1
"此區域列出目前拒絕或允許的網站",	//dlink_help148
"對無線網路設定進行排程",	//dlink_1_bwl_schld
"網站過濾器功能允許您建立您想允許或拒絕透過網路的一個網站清單. 要使用此功能, 您必須在存取控制裡選擇&quot;套用到網站過濾器&quot;.",	//dlink_awf_intro_WF
"停用 gw_wireless_schedule",	//GW_WLS_SCHEDULE_STOP
"初始 gw_wireless_schedule",	//GW_WLS_SCHEDULE_INIT
"當無線網路被啟用, 排程選項的預設值為&quot;永遠&quot;. 使用者在&quot;排程&quot;頁裡定義一排程後, 將可在下拉的選單裡取得其他排程的選項, 當無線網路停用時, 這個功能也將被停用.",	//dlink_1_bw1_schld_help
"建立您想拒絕或允許透過網路的一個網路清單",	//dlink_hhwf_intro
"輸入您想允許或拒絕的網站URL (網址); 例如: <code>google.com</code>. 不要在URL前面輸入 <code>http://</code>. 輸入最主要的網域; 例如：dlink.com，那麼www.dlink.com和 support.dlink.com 都可以被允許存取。",	//dlink_help145
"許多的網站構成頁面包含了圖形及連結了其他網站.例如,要存取 <code>my.yahoo.com</code> 的話,您還需要點選允許並存取 <code>yahoo.com</code>、<code>yimg.com</code> 及 <code>doubleclick.net</code>.",	//dlink_help146
"新增",	//dlink_1_add_new
"拒絕電腦對這些網站進行存取",	//dlink_wf_op_0
"在下方設定網站過濾器",	//dlink_wf_intro
"目的埠和起始埠的服務埠過濾器值不應為0",	//dlink_1_YM23
"<warn>  %s 與現行的連結相牴觸 (%v:%u (公用 %v:%u)--->%v:%u).這個的網路連結到連線結束為止都有可能發生影響.(</warn>).",	//GW_NAT_CONFLICTING_CONNECTIONS_WARNING
"路由器現在正在使用上傳的韌體進行更新中.請稍後約 <span id='show_sec'></span>&nbsp;秒以完成這個程序.之後您可以需要重新登入管理頁面一次.請注意不要在更新過程中按下重新整理或回到上一頁按鈕,以免造成更新動作程序失敗.",	//_upgintro
"存取Web 網站 %S 藉由 %v ",	//WEB_FILTER_LOG_URL_ACCESSED
"韌體更新伺服器 %s 在IP位址 %v",	//GW_FW_NOTIFY_RESOLVED_DNS
"DHCP位址 %v 被使用者釋放",	//DHCP_CLIENT_RELEASED_LEASE
"PPTP連線到伺服器&quot;%s&quot;使用ID 0x%04X ",	//PPTP_EVENT_TUNNEL_CONNECTED
"(ICMP類型%u)阻擋從%v到%v流入ICMP錯誤訊息 因為在%v:%u和 %v:%u間沒有TCP連線活動. ",	//IPNAT_TCP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
"(ICMP 類型%u)阻擋從%v到 %v流入ICMP錯誤訊息 因為沒有通訊協定%u 會談(session)活動在%v和%v之間 ",	//IPNAT_BLOCKED_INGRESS_ICMP_ERROR_PACKET
"(ICMP類型%u)阻擋從 %v到%v進來的ICMP封包 ",	//IPNAT_ICMP_BLOCKED_INGRESS_PACKET
"RTSP ALG從 %v:%u到 %v:%u 用舊 RTP服務埠 %u 拒絕封包 ",	//IPRTSPALG_REJECTED_ODD_RTP_PACKET
"通訊埠轉送 ALG 分配從%v:%u到 %v:%u的TCP封包會談(session)失敗. ",	//IPPORTFORWARDALG_TCP_PACKET_ALLOC_FAILURE
"無法處理封包標題時, 中止從%v到%v的UDP封包. ",	//IPNAT_UDP_UNABLE_TO_HANDLE_HEADER
"(ICMP type %u)在%v 和 %v之間沒有活躍的ICMP 會談(session)時, 阻擋從 %v 到 %v流入的ICMP錯誤訊息.",	//IPNAT_ICMP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
"注意: 參考<a href='../Help/Tools.shtml#wcn' onclick='return jump_if();' style='white-space nowrap;'>幫助 &rarr; 工具 尋找此功能合適的限制,",	//ta_wcn_note
"從電腦使用共用印表機,跟著<a href='../Help/Basic.shtml#PS' onclick='return jump_if();' style='white-space nowrap;'>幫助 &rarr; 主頁 &rarr; 印表機精靈 的設定步驟.",	//tps_intro5
"租約 %v 取消",	//IPDHCPSERVER_LEASE_REVOKED2
"保留的租約時間 %v 已刪除",	//IPDHCPSERVER_LEASE_RESERVATION_DELETED
"租約時間%v已更新,用戶端%m",	//IPDHCPSERVER_LEASE_RENEW
"起始IP 位址 (%v)在 '%s' 中 不在LAN 端子網路 (%v) 的範圍之中。",	//GW_INET_ACL_START_IP_ADDRESS_IN_LAN_SUBNET_INVALID
"存取Web 網站 %S, 從 %s ",	//WEB_FILTER_LOG_URL_ACCESSED_MAC
"%S網站已被%s封鎖",	//WEB_FILTER_LOG_URL_BLOCKED_MAC
"網路存取控制從%v:%u[%s]到 %v:%u (協定 %u)丟棄封包",	//GW_INET_ACCESS_DROP_ACCESS_CONTROL_MAC
"網路存取服務埠過濾器已阻絕從%v:%u[%s] 到 %v:%u (通訊協定 %u)的封包",	//GW_INET_ACCESS_DROP_PORT_FILTER_MAC
"RAW列印協定使用固定IP位址和TCP埠和印表機溝通.",	//tps_raw1
"(GMT+06:30) 仰光",	//up_tz_52
"相同的目的地IP位址",	//_r_alert_new1
"WEP",	//LS321
"Email設定",	//te_EmSt
"十一月",	//tt_Nov
"阻擋從 %v到%v (IP協定 %u)出去的封包",	//IPNAT_BLOCKED_EGRESS
"遠端喚醒",	//help738
"無線安全模式",	//bws_WSMode
"無線區域網路",	//help759
"區域網路連線最廣泛使用的技術.",	//help517
"Pings 丟失:",	//tsc_pingt_msg102
"給一個有意義的名稱,例如<code>遊戲伺服器</code>.您也可從大眾化遊戲的清單裏選擇一個,許多尚待設定的數值將會相對應地填寫在欄位裡.您應該檢查通訊埠的值是否已變更,並自己填寫IP位址的欄位.",	//help65
"UPnP",	//ta_upnp
"傳輸速率",	//bwl_TxR
"平均ping時間值(毫秒):",	//tsc_pingt_msg106
"整天",	//tsc_AllDay
"Tiger Woods 2K4",	//gw_gm_53
"租約遺失的IP位址",	//DHCP_CLIENT_LOST_LEASE
"認證逾時:",	//help385
"選擇套用到此的排程.",	//_aa_wiz_s3_msg
"準時對於準確的系統記錄和有設定排程的防火牆很重要.",	//hhtt_intro
"每秒位元數",	//help443
"A-Z和0-9的字元",	//help414
"手動設定日期和時間",	//tt_StDT
"認證伺服器的IP位址.",	//help388
"Final Fantasy XI (PC) ",	//gw_gm_20
"OK",	//_ok
"狀態",	//_status
"乙太網路的點對點協定是用來連接多台電腦到遠端伺服器",	//help656
"Out",	//_Out
"What to View",	//sl_WtV
"當您在搜尋可用的無線網路時, 此名稱會出現在清單裡(除非狀態設定為隱藏, 如下).此名稱也與SSID相關. 為了安全性目的, 強烈建議您更改預設的網路名稱.",	//help352
"安裝設定精靈無法與印表機溝通. ",	//wprn_nopr2
"網路名稱 (SSID)",	//wwz_wwl_wnn
"IP 位址",	//_ipaddr
"對話的初始方向:",	//help820
"(GMT+07:00) 克拉斯諾亞爾斯克",	//up_tz_54
"如果LAN端電腦成功地從Router的DHCP伺服器取得IP位址,此選項可以保持停用.然而,如果其中一台電腦無法取得IP位址,可能有一個舊的DHCP用戶端錯誤地關閉DHCP封包的廣播標誌.啟用此選項會造成router永遠廣播它的回應給用戶端,因此在此問題下運作,會增加LAN端廣播流量的成本.",	//help326
"注意:有些瀏覽器限制不能更新WAN端顯示狀態,有些瀏覽器需要你手動更新顯示以取得新的狀態.有些瀏覽器會報告在嘗試取得WAN端狀態時的錯誤狀況.",	//help773
"MAC 過濾",	//am_MACFILT
"較舊的設備或技術",	//help600
"每個網路設備都有自己獨特的由硬體製造廠商所定義的MAC位址. 有些ISP業者會檢查電腦的MAC位址. 有些ISP會記錄第一個接上數據機的電腦或路由器內的網卡MAC位址. ISP只會同意准許有特定MAC位址的電腦或路由器的要求來存取網路.路由器和初始連上ISP的電腦或路由器有不同的MAC位址.",	//help302
"此處顯示您已指派特定的DHCP位址用戶端.請點選編輯按鈕來修改設定, 或按下刪除按鈕. 當您按下編輯按鈕時,項目會變成反白的, &quot;編輯DHCP 保留位址&quot;區塊已啟動編輯.",	//help348
"存取控制功能用來控制存取對內對外的網路. 使用此功能同意電腦只能存取認可的網站, 透過日期或時間限制存取網站, 阻擋像P2P應用程式或遊戲等網路應用程式. ",	//aa_intro
"預設",	//help486
"PainKiller",	//gw_gm_35
"資訊性",	//sl_Infrml
"無線",	//_wireless
"RADIUS伺服器 IP位址",	//bws_RIPA
"啟用無線分割阻止相關聯的無線用戶端互相溝通.",	//KR58_ww
"如果停用自動偵測上傳速度, 您可在此項目手動設定上傳速度. 上傳速度是指資料從路由器傳送到上端ISP的速度. 這是取決於您的ISP. ISP通常會指定一對下載/上傳速度; 例如, 1.5Mbps/284kbps. 以這個速度為例, 要輸入&quot;284&quot;. 或者, 您可以到<a href='http://www.dslreports.com'>www.dslreports.com</a>提供測試上傳速度的服務.  請注意這些DSL Reports網站, 因為它們不會額外考慮到任何網路協定, 所以一般來說速度會比測量出來的上傳速度稍微低一點.",	//help83
"如果<strong>測量上傳速度</strong>是不正確的,停用<strong>自動偵測上傳速度</strong>並輸入<strong>手動設定上傳速度</strong>. 有些經驗和效能的測量可能需要整合理想值.",	//hhase_intro
"從非揮發性記憶體載入設定時發生錯誤(Magic number不匹配).將設定回複至出廠預設值.",	//RUNTIME_CONFIG_MAGIC_NUM_ERROR
"星期六",	//_Sat
"網站過濾",	//awf_title_WSFR
"您可以在&quot;電腦名稱&quot;的下拉式DHCP用戶端清單裡選擇一台電腦, 或是手動輸入伺服器電腦的IP位址.",	//help18_a
"Far Cry ",	//gw_gm_18
"Call of Duty ",	//gw_gm_7
"DSL",	//help503
"找到USB儲存裝置與子集合 %u 協定 %u",	//USB_LOG_STORAGE_TYPE
"遊戲伺服器",	//help346
"將會造成目前所有設定遺失.",	//up_rb_5
"WEP",	//_WEP
"您應該檢查這些警告表示有些功能已被停用.",	//KR112
"SWAT 4 ",	//gw_gm_82
"支援的認證協定有PAP和CHAP.",	//bw_sap
"網路連線似乎已經中斷. 按下'Ok'重試.",	//li_alert_2
"數位和類比訊號長度的衰減. 訊號傳輸到較遠距離時衰減會更大.",	//help426
"輸入您的網際網路服務供應商(ISP)提供的固定IP位址資訊.",	//bwn_msg_SWM
"停用存取控制, LAN端所有裝置將不被限制存取網際網路. 然而, 如果您啟用存取控制, 有設定的設備將被限制存取網路. 其他裝置則不被限制存取網路. ",	//help120
"由於系統資源過低, IGMP 主機已拒絕group %v.",	//IGMP_HOST_LOW_RESOURCES
"- 輸入恰好0-9和A-F的10或26個字元",	//wwl_s4_intro_z3
"頻寬",	//help432
"如果您想要傳送系統記錄訊息到LAN端目前正在使用的syslog伺服器, 啟用此功能",	//help858
"Windows 2000",	//help339
"啟用記錄到Syslog伺服器",	//help857
"輸入網際網路流量所要打開的通訊埠範圍 (例如<code>6000-6200</code>).",	//help51
"透過PPPoE取得的網際網路端分配位址和LAN端選擇的定址衝突. 網際網路將被停用直到您變更LAN端分配位址以解決此問題.",	//GW_WAN_LAN_ADDRESS_CONFLICT_PPP
"錯誤",	//ss_Errors
"如果動態DNS更新失敗(例如, 輸入不正確的參數), 路由器將會自動停用動態DNS功能並在系統記錄留下失敗紀錄.",	//help899
"分散資料成小片的使它容易儲存.",	//help527
"請輸入無線網路PIN碼並按下方&quot;連線&quot;按鈕",	//wps_p3_4
"DMZ功能只是其中一種方法允許對NAT的未經授權請求能連進來. 一般來說, DMZ主機只有在沒有其他方式下才使用, 因為它比其他LAN端系統更容易受到網路駭客攻擊. 最好是用其他的設定取代: 虛擬伺服器, 通訊埠轉送, 或通訊埠觸發. 虛擬伺服器為特定應用程式進來的會談(session)打開通訊埠(也允許通訊埠重新導向和ALGs的使用). 通訊埠轉送比較像是有選擇性的DMZ, 將進來的流量導向經由一個或多個通訊埠到特定的LAN端主機(所以不像DMZ是開放全部的通訊埠). 通訊埠觸發是通訊埠轉送的特殊形式, 藉由對外的流量來啟動,通訊埠是在觸發埠啟動時才會轉送. ",	//haf_dmz_40
"網頁過濾功能可以設定一個允許的網站清單讓多數使用者連結. 啟用網頁過濾時, 不在清單內的網站將被封鎖. 要使用此功能, 您必須在存取控制裡選擇&quot;套用到網站過濾器&quot;.",	//awf_intro_WF
"點選<strong>編輯</strong> 按鈕變更現有的排程.",	//hhts_edit
"無線網路名稱 (SSID)",	//wwl_wnn
"啟用WMM",	//aw_WE
"設定協助",	//help201a
"啟用免費30天試用",	//_bsecure_activate_trial
"輸入您的服務提供者設定的密碼或金鑰. 如果動態DNS供應商只提供一組金鑰, 請在三個欄位輸入相同金鑰.",	//help896
"用來對話的溝通協定.",	//help815
"遮罩",	//_netmask
"POP3用來接收email",	//help652
"重複這些步驟來新增每一筆虛擬伺服器. 完成清單後, 按下網頁上方的 <span class='button_ref'>儲存設定</span> .",	//help12
"MAC(媒體存取控制器)位址過濾使用網卡的MAC位址來控制網路存取. MAC位址是由網卡製造商所指派的一個獨特的ID . 此功能可以設定允許或拒絕網路存取. ",	//am_intro_1
"LCP 設定本機驗證: %04x ",	//IPPPPLCP_SET_LOCAL_AUTH
"Crimson Skies ",	//gw_gm_11
"CardBus",	//help456
"不要儲存設定",	//_dontsavesettings
"WPA (Wi-Fi 保護存取)金鑰必須符合其中一項指導方針:",	//wwl_s4_intro_za1
"MAC",	//aa_AT_1
"L2TP 本地通道 0x%04X 中止",	//IPL2TP_TUNNEL_ABORTING
"新增/編輯 DHCP 保留位址",	//help330
"4 am ",	//tt_time_5
"L2TP 用戶端.",	//wwa_msg_l2tp
"輸入LAN端機器的IP位址 (例如: <code>192.168.0.50</code>)",	//help6
"時間",	//_time
"通常設定成 &quot;自動&quot;. 如果您在連線到WAN端時發生問題, 試著變更其他設定. ",	//help296
"步驟 2: 啟動電腦可執行的設定",	//wprn_intro4
"xDSL 或 其他訊框傳輸網路",	//at_xDSL
"區域網路",	//_LAN
"Warcraft III ",	//gw_gm_60
"圖形化使用者介面",	//help539
"64 位元",	//wwl_64bits
"選擇要套用此的機器.",	//_aa_wiz_s4_msg
"磁碟已滿",	//IPFAT_DISK_FULL
"您的D-Link 路由器包含整合的列印伺服器分享給區網的多台電腦列印. 此網頁顯示列印伺服器和任何偵測到的印表機的相關資訊和狀態.",	//sps_intro3
"到開始的目錄, 選擇程式集, 選擇附屬應用程式, 再選擇命令提示字元. 在命令提示字元模式下輸入 <code>ipconfig /all</code> 按下Enter. 顯示的實體位址就是連接到路由器的網卡MAC位址. ",	//help341
"資料庫",	//help472
"按下'Ok' 放棄變更並顯示排程頁面. ",	//aa_sched_conf_2
"時間同步化失敗 (狀態 %d)",	//NET_RTC_SYNCHRONIZATION_FAILED
"嘗試啟動L2TP本地會談(session) 0x%04X",	//IPL2TP_SESSION_CONNECTING
"檔案伺服器",	//help520
"自動線上檢查最新版韌體",	//tf_AutoCh
"印表機製造廠商和/或型號無法判定, 可能是由於印表機提供無效的硬體ID. 安裝精靈沒有這些資訊無法繼續執行. ",	//wprn_iderr2
"這兩個IP數值(<i>從</i> 和 <i>到</i>)定義DHCP伺服器在分配位址給區域網路的電腦和設備時使用的IP位址範圍. 在這個範圍之外的任何位址不受DHCP伺服器的管理; 所以, 用在手動設定位址的設備或無法透過DHCP自動取得網路位址的設備. ",	//help319
"按下按鈕更新系統記錄紀錄顯示. 從上次您存取系統記錄之後可能有更新的事件.",	//help800
"<b>注意:</b> 設置DMZ可能會使電腦暴露在大量安全性風險中. 建議您只在必要時使用此功能.",	//af_intro_2
"設備資訊",	//sd_title_Dev_Info
"網路存取服務埠過濾器已阻絕從%v:%u 到 %v:%u (通訊協定 %u)的封包",	//GW_INET_ACCESS_DROP_PORT_FILTER
"Windows 正在連接",	//_connow
"SIP ALG 拒絕從%v:%u 到 %v:%urejected的封包",	//IPSIPALG_REJECTED_PACKET
"當無法修改標題項目時阻絕從%v:%u 到 %v:%u 的TCP封包",	//IPNAT_TCP_UNABLE_TO_MODIFY_OPTIONS
"選擇NTP 伺服器",	//tt_SelNTPSrv
"VoIP",	//help737
"使用者",	//_user
"有雜訊的無線電波頻率環境會引起無線網路連線高度錯誤速率.",	//help812
"(GMT+08:00) 台北",	//up_tz_59
"特殊應用程式",	//SPECIAL_APP
"無",	//wwl_NONE
"啟動WAN端服務",	//GW_WAN_SERVICES_STARTED
"禁止網頁存取",	//fb_FbWbAc
"您必須打開網頁管理介面,當您隨時想要存取網路時手動按下連線按鈕.",	//help275
"OSI模型的第一層. 提供硬體在資料載波上傳送電子訊號的方法",	//help646
"沒有偵測到印表機",	//wprn_nopr
"時區",	//tt_TimeZ
"除錯方法",	//wprn_tt
"從下拉目錄裡選擇您的本地時區",	//help841
"定義一個新排程",	//aa_sched_new
"1 pm ",	//tt_time_14
"SysLog 設定",	//tsl_SLSt
"HTTP",	//gw_vs_1
"H.323 ALG 拒絕從 %v:%u 到 %v:%u的封包",	//IPH323ALG_REJECTED_PACKET
"步驟 4 - 選擇過濾方式",	//aa_wiz_s1_msg4
"Windows 98",	//help336
"系統名稱",	//ta_sn
"取決於您目前是否登入到BigPond, 您可以按下<span class='button_ref'>登入BigPond</span>來建立WAN端連線, 或是按下<span class='button_ref'>登出BigPond </span>來中斷連線.",	//help780
"網頁瀏覽器",	//help745
"用來同步網域內設備之間的互相溝通時間",	//help659
"介面",	//_interface
"%S網站已被%v封鎖",	//WEB_FILTER_LOG_URL_BLOCKED
"遠端管理者通訊埠和虛擬伺服器衝突",	//vs_http_port
"(GMT-06:00) 中美洲",	//up_tz_07
"路由器利用NAT的優勢提供嚴密的防火牆. 除非您設定反向防火牆, NAT不會回應從任何通訊埠進來未經授權的請求, 所以使區域網路隱形於網際網路的駭客. 然後, 某些網路應用程式無法在防火牆下執行. 那些應用程式需要選擇性的在防火牆打開通訊埠才能正常運作. 此頁面的項目控制多種打開防火牆給特定類型應用程式的方法. ",	//haf_intro_1
"通訊閘位址",	//wwa_gw
"如果您不熟悉這些進階無線網路設定, 請在嘗試修改設定前參閱幫助.",	//aw_intro
"標記服務",	//_sentinel_serv
"USB",	//help727
"若您的網際網路服務供應商提供您必須手動設定的IP位址資訊, 請選擇此項.",	//wwa_msg_sipa
"無線 ISP",	//help753
"在網路上從一台電腦傳輸資料到另一台電腦的方式",	//help574
"遇到無法處理的封包標題時, 中止從%v到%v的TCP封包",	//IPNAT_TCP_UNABLE_TO_HANDLE_HEADER
"少數應用程式真正需要使用DMZ主機. 下列為可能會需要用到DMZ主機的範例:",	//haf_dmz_50
"您可以在&quot;電腦名稱&quot;的下拉式DHCP用戶端清單裡選擇一台電腦, 或是手動輸入您要打開特定通訊埠的電腦IP位址.",	//hhav_ip
"%s停止; MAC位址 %m 對網際網路的存取已變更: %s",	//GW_INET_ACCESS_POLICY_END_MAC
"排程設定功能是用來管理不同的防火牆和家長控制器功能的排程.",	//tsc_intro_Sch
"MAC位址 %m對無線網路系統的存取被拒絕",	//GW_WLAN_ACCESS_DENIED
"此功能預設為啟用, 路由器將會自動偵測哪個程式應該有網路優先權.",	//help79
"BigPond 設定不正確",	//GW_BIGPOND_CONFIG
"建立中 (請稍候…)",	//_sdi_s3
"高",	//aw_TP_0
"Ping Test",	//tsc_pingt
"WPA-個人級",	//_WPApersonal
"EMail 設定",	//_email
"PPPoE 確認提供的會談(session)",	//PPPOE_EVENT_DISCOVERY_REQUEST
"固定IP位址連線",	//wwa_wanmode_sipa
"防火牆",	//_firewall
"系統檢查",	//_syscheck
"用戶端的LAN端IP位址.",	//help784
"遠端驗證撥號使用者服務允許遠端使用者為了在網路存取資源,撥號到中央伺服器並認證.",	//help663
"未知",	//UNKNOWN
"D-Link路由器使用192.168.0.1的IP位址. 您已指派192.168.0.3的固定IP給設定網頁伺服器的電腦. 您已指派192.168.0.4的固定IP給另一台設定FTP伺服器的電腦. 所以DHCP的起始IP範圍必須在192.168.0.5以後.",	//help322
"UPnP 是Universal Plug and Play的縮寫, 一種網路結構提供介於不同的網路設備, 軟體,和週邊裝置的相容性. 路由器有選擇性的UPnP能力, 且可以和其他支援UPnP的設備和軟體運作.",	//help_upnp_1
"Wolfenstein: Enemy Territory",	//gw_gm_61
"Wi-Fi",	//help748
"設定太低的分裂化數值可能會導致效能變差.",	//help181
"(非必要)",	//_optional
"新增您想要允許網路內設備對外存取的網站清單.",	//hhwf_intro
"網際網路",	//help569
"如果您不熟悉這些進階網路設定, 請在嘗試修改設定前參閱幫助.",	//anet_intro
"輸入要寄送email的位址.",	//help862
" 阻擋從%v:%u到%v:%u出去的TCP封包, 當已接收%s但是沒有活躍的連線時",	//IPNAT_TCP_BLOCKED_EGRESS_NOT_SYN
"通訊閘名稱",	//ta_GWN
"如果您沒有權限修改路由器的設定, 請和路由器管理者連絡. ",	//wprn_tt3
"MTU:",	//help293
"如果您的ISP已經指派固定IP位址, 選擇此項. 下列欄位為ISP提供的資訊: ",	//help265_2
"無法建立新的會談(session)時, 中斷從%v到%v (IP通訊協定 %u)的封包.",	//IPNAT_UNABLE_TO_CREATE_CONNECTION
"永遠連線: ",	//help270
"進階無線網路設定",	//aw_title_2
"防火牆設定",	//_firewalls
"由於各國使用的射頻頻譜不同,802.11d主要解決在不同區域或國家透過此漫遊機制標準,告知系統用什麼頻率來傳送資料,以確保資料傳輸無誤,根據各國無線電規定做調整. 目前的802.11標準僅適用於某些國家,特別針對MAC層做修正. 這些補充(channelization, hopping patterns, new values for current MIB attributes)加了一些要求和定義才能讓802.11 WLAN設備在那些沒有在現有標準的市場操作.啟用此項目,如果您是在這些&quot;另外的管理領域&quot;.",	//help186
"PPPoE 會談(session) 0x%04X 已建立",	//PPPOE_EVENT_UP
"通訊協定",	//_protocol
"WPA-個人級 和 WPA-企業級",	//help372
"(GMT+02:00) 布加勒斯特",	//up_tz_32
"kbps 每秒千位",	//at_kbps
"Cable 或 其他寬頻網路",	//at_Cable
"<warn>不是所有工作站都能夠在100-140的頻道下運作. 如果連線失敗請變更頻道. </warn>",	//GW_WLAN_11A_CH_MID_BAND_WARN
"100Mbps",	//anet_wp_1
"指派給虛擬伺服器一個有意義的名稱, 例如<code>網頁伺服器</code>. 數個眾知的虛擬伺服器類型可以從 &quot;應用程式名稱&quot;下拉清單取得.  ",	//help17
"預設值沒有設定密碼. 強烈建議您建立密碼以確保路由器安全性. ",	//ta_intro_Adm2
", 請檢查",	//tool_admin_check
"發光二極體(LED)",	//help598
"xDSL",	//help761
"IP未指示由DHCP指派並且可能會變動. Cable 網路提供者通常使用此方式來配發IP給客戶. ",	//help510
"停止",	//_stop
"Syslog 伺服器 IP位址 %v",	//GW_SYSLOG_STATUS
"DHCP伺服器設定",	//bd_title_DHCPSSt
"路由器名稱可以變更.",	//help827
"韌體資訊 ",	//tf_FWInf
"每條可以控制到八個WAN IP位址. 每個IP範圍的檢查框可以用來停止已經定義的範圍.",	//hhai_ipr
"建議您把這些參數使用預設值. 調整參數可能會限制無線網路的效能. ",	//hhaw_1
"啟用NTP伺服器",	//tt_EnNTP
"允許多個VPN用戶端使用IPSec連接到公司網路. 有些VPN用戶端支援能跨越NAT的IPSec. 此項目可能會干擾這些VPN用戶端的運作. 如果您在連接到公司網路發生問題, 可以試著停用此項目. ",	//help34
"區域網路內路由器的子網路遮罩.  ",	//help309
"您不能加入新的MAC位址. 您只能從其他重複使用MAC位址. ",	//aa_alert_15
"儲存設定",	//_savesettings
"給排程一個有意義的名稱, 例如 &quot;平日&quot;. ",	//help193
"虛擬伺服器參數",	//help14_p
"Need for Speed: Hot Pursuit 2 ",	//gw_gm_32
"阻擋從%v:%u到%v:%u流入的TCP連線要求",	//IPNAT_TCP_BLOCKED_INGRESS_SYN
"如果您啟用此功能, 路由器的WAN埠將會回應從網路上發出對WAN IP位址ping的要求.",	//anet_msg_wan_ping
"L2TP 子網路遮罩",	//help285
"流入封包過濾器可以用來限制存取網路上的伺服器到系統或系統群組. ",	//ai_intro_2
"區域網路流量統計",	//ss_LANStats
"IPsec",	//help584
"還原已經在處理中.",	//ta_alert_4
"複製電腦端的MAC位址",	//_clone
"Diablo I and II ",	//gw_gm_14
"無法處理封包標題時, 停止從%v到%v的GRE封包",	//PPTP_ALG_GRE_UNABLE_TO_HANDLE_HEADER
"工具程式會顯示介於電腦和特定目的地之間的路由器",	//help716
"阻擋某些存取",	//_aa_block_some
"11 pm ",	//tt_time_24
"已建立 -- 連線正在傳輸資料.",	//help819_3
"通常email會在排程定義好的啟始時間發送, 不會用到排程結束時間. 然而, 在排程時間內重新啟動路由器會造成發送額外的email.",	//help873
"碰撞",	//ss_Collisions
"輸入用來傳送email的SMTP伺服器位址.",	//help863
"此項目啟用選擇性的次要RADIUS伺服器設定. 次要的RADIUS伺服器可以當成主要RADIUS伺服器的備份. 次要的RADIUS伺服器只會在主要伺服器無法使用或沒有回應才會採用. <span class='option'>次要RADIUS伺服器IP位址</span>, <span class='option'>RADIUS伺服器通訊埠</span>,<span class='option'>次要RADIUS伺服器共用金鑰</span>, <span class='option'>次要MAC位址驗證</span>, 這些欄位提供次要RADIUS伺服器相對應的參數. ",	//help397
"虛擬伺服器列表",	//av_title_VSL
"關閉",	//_off
"啟用anti-spoof checking",	//KR106
"由於虛擬伺服器entry, 所有走8888埠的網際網路流量會被導到內部IP位址192.168.0.50使用80埠的網頁伺服器. ",	//help13
"步驟 3: 設定您的網際網路連線",	//wwa_title_s3
"BigPond",	//wwa_wanmode_bigpond
"位元傳輸速率",	//help440
"WAN(廣域網路)的部分是設定網路連線類類型的地方.",	//help254
"為了處理使用除了ICMP, TCP, UDP, 和IGMP的通訊協定而流入的連線( 也包含GRE和ESP, 當這些通訊協定被PPTP和IPSec ALGs啟用時).",	//haf_dmz_70
"附加排程%s時發生系統錯誤.",	//GW_SCHED_ATTACH_FAILED
"SSID 欄位不可以是空白",	//_badssid
"設定儲存到非揮發性記憶體(NV-RAM)",	//RUNTIME_CONFIG_STORING_CONFIG_IN_NVRAM
"非對稱數位用戶專線(ADSL)",	//help410
"可用的韌體更新",	//FW_UPDATE_AVAILABLE
"動態DNS功能可以把動態指派IP位址的伺服器(Web, FTP, Game Server,等)使用在您購買的網域名稱 (www.whateveryournameis.com). 大部分的寬頻ISP分配動態(浮動)IP位址. 當您使用動態DNS服務, 不管IP位址是多少, 您的朋友都可以輸入主機名稱連接到伺服器. ",	//help891
"PPPoE, PPTP, L2TP 連線",	//help777
"dBi",	//help480
"MAC 位址驗證:",	//help393
"網路連線類型",	//bwn_ict
"IEEE",	//help559
"六月",	//tt_Jun
"L2TP 本地通道 0x%04X 已經連接到 &quot;%s&quot;",	//IPL2TP_TUNNEL_CONNECTED
"Command and Conquer Zero Hour ",	//gw_gm_9
"乙太網路",	//help516
"Aliens vs. Predator ",	//gw_gm_2
"無線網路設定精靈",	//wwl_wl_wiz
"DHCP 範圍無效, 起始值不能大於結束值",	//network_dhcp_range
"步驟 4: 列印測試頁",	//wprn_intro6
"BigPond失敗, 狀態=%d 錯誤=%d, 伺服器回應=%s",	//GW_BIGPOND_FAIL
"限制的位址",	//af_EFT_1
"使用單點廣播 (Unicasting)",	//_use_unicasting
"網路狀態",	//_networkstate
"年",	//tt_Year
"連接到USB裝置失敗",	//IPASYNCFILEUSB_MOUNT_FAILED
"UDP 結點過濾",	//af_UEFT
"文數(字母與數字)",	//help413
"預設值為選擇能到達最快速的傳輸率. 您可以在需要時自由選擇速度.",	//help356
"預先共用金鑰(Pre-Shared Key):",	//help381
"流入封包過濾器",	//_inboundfilter
"機器保護預防從spoof或偽造的IP位址的活動, 主要的阻擋在邏輯上不可能出現的介面和方向的封包. ",	//KR108
"套用進階通訊埠過濾器",	//_aa_apply_port_filter
"最高的傳輸單位是說在以封包為主的網路上能傳送的最大封包值.",	//help619
"目的地<br />通訊埠<br />結束 ",	//aa_FPR_c7
"Jedi Knight III: Jedi Academy ",	//gw_gm_27
"BigPond 設定不正確",	//BIGPOND_NOT_PROPERLY_CFGD
"(GMT+08:00) 伯斯",	//up_tz_58
"替代方式, 您可以依據下列步驟在特定的作業系統裡設置一組MAC位址:",	//help335
"從不",	//_never
"點選此按鈕清除所有系統記錄.",	//help801
"網路上的電腦儲存資料, 所以其他的電腦也可以存取資料.",	//help521
"最長的ping時間 (毫秒):",	//tsc_pingt_msg105
"警告: 瀏覽器沒有啟用JavaScript!",	//li_WJS
"收件 Email位址 ",	//te_ToEm
"12 am ",	//tt_time_1
"訊號",	//help787
"使用DHCP取得IP位址. IP位址是 %v.",	//DHCP_CLIENT_GOT_LEASE
"通訊閘系統紀錄",	//GW_EMAIL_SUBJ
"ALG觸發埠從%v:%u到%v:%u的UDP封包分派會談(session)失敗.",	//IPPORTTRIGGERALG_UDP_PACKET_ALLOC_FAILURE
"DSSS: 無線網路設備所使用的調變技術",	//help494
"網域名稱系統: 將網域名稱轉換成IP位址",	//help498
"如果您是網路新手而且沒有設定過路由器, 按下<span class='button_ref'>設定精靈</span> 路由器將會引導您經由幾個簡單步驟設定好網路連線.",	//bi_wiz
"Out ",	//EGRESS
"網路介面卡",	//help628
"兩台電腦之間每次溝通時所產生的加密和解密金鑰",	//help683
"DHCP 連線 (動態IP位址)",	//_dhcpconn
"路由器設定",	//bln_title_Rtrset
"檢查預先定義好之應用程式清單裡的<strong>應用程式名稱</strong>",	//hhpt_app
"列印伺服器",	//_ps
"如果您的無線網卡支援WPA2則選擇此項目",	//wwl_text_best
"PPTP 伺服器IP位址 (可以和通訊閘位址相同)",	//wwa_pptp_svraddr
"您可以把email設定成和那些email用戶端程式相同.",	//hhte_intro
"LAN端電腦",	//_LANComputers
"設定精靈",	//wwa_setupwiz
"H.323 (Netmeeting)",	//as_NM
"和",	//help264
"(某些DHCP伺服器的相容性)",	//bw_WDUU_note
"%s和現存的連線衝突 (%v:%u (public %v:%u)--->%v:%u).   此的連接會受影響直到連線結束. ",	//GW_NAT_CONFLICTING_CONNECTIONS_LOG
"MMS ",	//as_MMS
"此適用於LAN端IP位址落在此處設定範圍裡的大量訊息 .",	//help93
"服務名稱",	//_srvname
"分鐘",	//tt_Minute
"狀態",	//sa_State
"主機名稱或IP位址",	//tsc_pingt_h
"啟用 802.11d",	//aw_dE
"無線網路流量統計",	//ss_WStats
"歡迎使用D-Link印表機設定精靈",	//wprn_intro1
"每秒十億位元組",	//help535
"啟用此項目時, 路由器會定期線上檢查是否有可用的新版韌體.",	//help889
"通訊埠轉送項目",	//tool_admin_pfname
"H.323 (NetMeeting) ",	//as_H323
"會談(session)已經存在時,停止從%v 到 %v (通訊協定 %u) 的封包",	//IPNAT_SESSION_ALREADY_EXISTS
"設定 BigPond Cable 連線",	//wwa_title_set_bigpond
"(GMT-04:00) 聖地牙哥",	//up_tz_16
"BigPond 狀態已變更, 新的狀態=%d",	//GW_BIGPOND_STATUS
"啟用認證功能",	//te_EnAuth
"設定連線時您會需要ISP廠商提供的使用者名稱和密碼. 您也需要BigPond 伺服器IP位址. 如果您沒有這些資訊, 請與ISP廠商連絡.",	//wwa_msg_set_bigpond
"如果您要將路由器時鐘透過網路和網路時間伺服器同步, 請選擇此項目. 若您有在使用排程或系統記錄, 這是確保排程和系統記錄保持準確的最好方法.",	//help848
"SPI ",	//help695
"Return to Castle Wolfenstein ",	//gw_gm_41
"精靈 ",	//_aa_pol_wiz
"IP過濾器",	//IP_FILTERS
"Starsiege Tribes ",	//gw_gm_50
"無法偵測到您的網際網路連線, 請從下列清單裡選擇網際網路服務提供者(ISP). 若您的ISP不在清單裡; 選擇&quot;沒有列出或未知&quot;來手動設定連線.",	//wwa_intro_s3
"廣域網路",	//help740
"從%v到%v嘗試連線已經未決時, 停止從%v來的ESP封包",	//IPSEC_ALG_ESP_ESTABLISH_ALREADY_PENDING
"獨立的 (80, 68, 888)",	//help59
"您確定要將設備還原至預設值?",	//wps_reboot_need
"動態分裂",	//at_DF
"DST 結束月份必須和DST啟始月份不同",	//tt_alert_dstchkmonth
"(GMT-01:00) 維德角群島 ",	//up_tz_23
"如果ISP伺服器在建立連線以後指派IP位址給路由器, 選擇此項目.",	//help265_7
"進階設定",	//_advanced
"靜態IP位址",	//STATIC_IP_ADDRESS
"這個清單是目前所有連接到路由器的無線網路用戶端.",	//hhsw_intro
"步驟 2: 加強無線網路的安全性",	//wwl_title_s3
"功能表",	//ish_menu
"(GMT+02:00) 開羅 ",	//up_tz_33
"檢查新韌體失敗",	//GW_FW_NOTIFY_FIRMWARE_ERROR
"更多資訊…",	//_bsecure_more_info
"第二 ",	//tt_week_2
"目前韌體版本",	//tf_CFWV
"範例:",	//help3
"創造者 ",	//_creator
"DNS 中繼轉發",	//bln_title_DNSRly
"用來同步網路上所有電腦的時間.",	//help633
"詞彙表",	//ish_glossary
"較長的WEP金鑰比短的金鑰安全",	//wwl_s4_intro_z4
"ISP提供個人或公司對網際網路的存取",	//help578
"Beacon ",	//help438
"廠商提供的動態DNS 可允許使用者取得永久的網域名稱對應到浮動的IP位址. 每當IP位址變動時, 是由電腦上的用戶端軟體或路由器提供的DDNS功能來做更新.",	//help508
"ASCII ",	//help423
"預設值的存取控制功能是停用的. 若您要設定存取控制, 檢查這個項目.",	//help118
"Shareaza ",	//gw_gm_66
"啟用DNS Relay時, 路由器扮演DNS伺服器的角色. 發送到路由器的DNS要求被轉送到ISP的DNS伺服器. 它提供不變的DNS位址讓區域網路的電腦使用, 即使當路由器在重新建立WAN端連線時, 從ISP取得的是不同的伺服器位址. 若您在虛擬伺服器有設定DNS伺服器, 應該停用此功能.",	//help312dr2
"整天 - 24 小時",	//tsc_24hrs
"選擇 <strong>應用程式名稱</strong> 在下拉功能表選單中表列的已預先定義應用程式名稱.如果您選擇了一個已預先定義應用程式名稱,相對應的欄位內容將被自動填滿.",	//hhag_10
"有些ISP 也許會檢查您的電腦主機名稱.ISP 伺服器將透過主機名稱以識別您的系統.這個方法ISP可以知道您的電腦是否可符合ISP 規定以取得IP 位址.以另一個說法來講,ISP透過這樣的方法知道您有購買他們的網路服務.",	//help261
"觸發流量類型",	//as_TPrt
"如果您有為這個端設備定義了存取控制,這將發生.",	//help28
"11 am ",	//tt_time_12
"重新整理統計資料",	//ss_reload
"封包接收時,透過DMZ 主機功能將來自WAN 端的IP 位址轉送到路由器的LAN 端DMZ 主機IP位址.不管如何,傳送/接收的通訊埠並不會被轉換；所以在DMZ 主機上所執行的應用程式可以信賴的使用特定的通訊埠,而不會被置換.",	//haf_dmz_30
"下面的 <span id='status_text'>印表機為</span> 已連接至您的路由器.",	//sps_fp
"如果您的網際網路連線會自動配發IP 位址給您的話,請選擇這個項目.大部分的Cable Modem 業者都使用這種連線類型.",	//wwa_msg_dhcp
"Unreal Tournament 2004",	//gw_gm_57
"步驟 1 -  選擇一個唯一的名稱供這個使用.",	//aa_wiz_s1_msg1
"NetBIOS",	//help625
"伺服器",	//help680
"您必須使用 &quot;管理者&quot;身分登入,以執行這個項目.",	//MUST_BE_LOGGED_IN_AS_ADMIN
"(GMT+09:30) 達爾文",	//up_tz_64
"Wake-on-LAN ALG 拒絕封包從 %v:%u 到 %v:%u",	//IPWOLALG_REJECTED_PACKET
"更新裝置至wsetting.wfc",	//WCN_LOG_UPDATE
"以無線網路而言,這是當無線用戶端透過一個無線存取點以獲得網路的存取",	//help568
"當您的網際網路上傳較慢時,這個選項應該被啟用.這對於優先等級較低的網路封包能以更緊急的方式,將較大的封包分割成幾個較小的封包傳輸時,減少其影響時有所幫助.",	//help80
"您可以新增流入封包過濾至下面的清單中,或是編輯以存在的記錄.",	//help171
"星期一",	//_Mon
"(GMT+10:00) 坎培拉, 墨爾本, 雪梨",	//up_tz_66
"步驟 2 : 設定您的無線安全密碼.",	//wwl_title_s4_2
"多點廣播",	//help620
"如果您不要使用每天這個選項,請在這邊輸入時間.起始時間請輸入在兩個欄位中.第一個欄位是輸入小時,第二個欄位是輸入分鐘.事件通知Email只有在起始時間到達時才會正常觸發進行.",	//help196
"PPPoE 會談(session)發生錯誤.連接嘗試失敗.",	//PPPOE_EVENT_DISCOVERY_REQUEST_ERROR
"蘋果電腦(Apple’s)的UPnP版本,允許去發現另一方的其他及有關連的位於網路上的裝置,而不需要去進行任何的設定",	//help667
"由電器電子工程師協會(IEEE)工作群組團隊所制定定義並詳細載明的無線區域網路(WLANs)先進標準.",	//help766
"登入",	//li_Log_In
"預設閘道",	//_defgw
"非LAN端 UDP/TCP/ICMP 會談(session)",	//af_gss
"慣用NTP 伺服器",	//tt_NTPSrvU
"輸入公用通訊埠為  [8888]",	//help8
"您的ISP 業者將提供您所有有關的資訊.",	//help258
"PPPoE 會談(session) 0x%04X 受限於存取集中器",	//PPPOE_EVENT_TERMINATED
"您確定要將裝置重新啟動嗎?",	//up_rb_1
"請勾選左側的檢查框,以啟用或停用以完成設定的虛擬伺服器記錄.",	//help25_b
"儲存系統記錄",	//sl_saveLog
"使用這個選項以查看路由器系統記錄.您可以定義您想要觀看的告警種類以及告警等級.路由器還可以支援內部的Syslog 伺服器,所以您可以透過此功能傳送系統記錄到在您的網路上已安裝Syslog 工具程式的電腦中.",	//sl_intro
"定義一個裝置的IP 或MAC 位址,或是選擇 &quot;其他裝置&quot;以供沒有定義的裝置使用.",	//_aa_wiz_s4_help
"WNA 端介面網路線已中斷連結",	//GW_WAN_CARRIER_LOST
"(bytes)",	//bwn_bytes
"BigPond 連接",	//help779
"MAC 位址",	//_macaddr
"重置或關閉TCP 連線會談.連線會談沒有被馬上關閉的狀況下,這個被拖延的封包可以直接通過或連線會談可以被重新建立.",	//help823_13
"啟用多點廣播串流",	//anet_multicast_enable
"下一次動態DNS 更新排定時間為%s",	//GW_DYNDNS_UPDATE_NEXT
"輸入相應於帳號的會員密碼.",	//help866
"路由器狀態",	//sl_RStat
"RADIUS",	//help662
"Roger Wilco",	//gw_gm_78
"新增一個對您有意義的名稱,以辨識這條.",	//help90
"PPTP 通道識別 0x%04X 已經關閉",	//PPTP_EVENT_TUNNEL_DOWN
"靜態 WAN 模式",	//bwn_SWM
"網頁過濾拒絕封包從 %v:%u 到 %v:%u",	//IPWEBFILTER_REJECTED_PACKET
"無效的韌體更新映像檔上傳 - 將被丟棄 ",	//GW_UPGRADE_FAILED
"這個選項可以用來開啟多個通訊埠或一個範圍的通訊埠,好讓路由器重新定向從WAN 到LAN 的資料穿過這些通訊埠至位於區域網路中的單一特定電腦中.這個功能允許您輸入不同的通訊埠號.例如:通訊埠範圍 (100-150), 個別的通訊埠 (80, 68, 888), 或混合的 (1020-5000, 689).",	//ag_intro
"管理選項用來設定存取以裝置網頁為基礎的管理畫面登入密碼.裝置預設密碼是沒有被設定的.我們強烈的建議您新增一個密碼保持您的新路由器是安全的.",	//ta_intro_Adm
"L2TP 伺服器IP 位址",	//bwn_L2TPSIPA
"沒有使用中的網際網路存取.所有人都允許使用不受限制的網際網路存取.",	//GW_INET_ACCESS_UNRESTRICTED
"(GMT-05:00) 波哥大, 利馬, 基多",	//up_tz_11
"停用",	//_disabled
"當系統記錄空間滿時,寄送系統記錄Email",	//GW_LOG_EMAIL_ON_LOG_FULL
"7 am ",	//tt_time_8
"連接中",	//ddns_connecting
"要允許Windows Media Player,請使用MMS 通訊協定,以從網際網路端接收串流媒體內容.",	//help43
"狀態檢查",	//help701
"典型的PPTP 連結是不會永遠啟用的.但D-Link 路由器可以協助您設定不同的重新連線模式.這個設定在:",	//help282
"啟用存取控制",	//aa_EAC
"當系統記錄空間滿時",	//te_OnFull
"四月 ",	//tt_Apr
"無效的日期或時間",	//tt_alert_invlddt
"半雙工(Half-duplex)",	//help542
"(Mbit/s)",	//bwl_MS
"安裝設定精靈將會引導您一步一步的設定您的新 D-Link 路由器及連接至網際網路.",	//wwa_intro_wel
"一個以全世界為範圍的網路系統.透過使用TCP/IP 協定以讓位於世界任一個角落的電腦允許存取取得資源.",	//help570
"DMZ:單一或一個可供網際網路及位於區域網路端的存取的群組電腦(伺服器).但位於DMZ 區的電腦會遭受一些網路安全問題且不受保護.",	//help489
"遠端管理通訊埠發生衝突,與",	//tool_admin_portconflict
"應用程式名稱",	//gw_SelVS
"用以安裝更新版本的軟體或韌體產品",	//help723
"永遠開啟",	//bwn_RM_0
"按下在清單中的 <strong>編輯</strong> 圖示 ,以變更內容.",	//hhai_edit
"來源Email 位址",	//te_FromEm
"請求時間從 %v",	//NET_RTC_REQUEST_TIME
"輸入一個使用者&quot;admin&quot;的密碼,此使用者將擁有完整的裝置網頁管理界面存取權限.",	//help824
"N/A",	//N_A
"PPTP 子網路遮罩",	//help279
"Kilobyte",	//help593
"一個當有時候因為程序變慢或停止所有工作時的工作時間程序",	//help447
"無法辨識",	//bwl_VS_1
"Soldier of Fortune II: Double Helix",	//gw_gm_48
"在裝置狀態頁面中,確認更新後的韌體版本.",	//help882
"(GMT+03:00) 德黑蘭",	//up_tz_41
"載入設定從非揮發性記憶體(NVRAM)",	//RUNTIME_CONFIG_LOADED_CONFIG_FROM_NVRAM
"會談(session)已超過時間,請重試一次.",	//li_alert_1
"您的路由器的本地網路端IP 位址.您的本地端網路設定將以此處指定的IP位址為基礎.例如:192.168.0.1.",	//help307
"系統記錄器 -- 一個用以收集從不同來源端系統記錄到另一個地點的分散式記錄介面.起初這樣的程式是撰寫在UNIX 系統上使用,現在已經可以在其他的作業系統上使用,包含Windows 作業系統.",	//help705
"以802.11 無線標準為基礎連接至本地端網路",	//help755
"對網際網路連線已按需求設定.",	//help273
"PlayStation2",	//gw_gm_81
"您確定您要將裝置重置嗎? 這將造成裝置設定被回復為出廠預設值.",	//up_rb_4
"更新版本的韌體,版本%d.%d 可供您的 %s %s 路由器使用.",	//NEWER_FW_VERSION
"PPTP 網際網路連線類型",	//bwn_PPTPICT
"韌體更新映像檔上傳完成-安裝中",	//GW_UPGRADE_SUCCEEDED
"H.323 ",	//_H323
"適用於一個訊息的傳遞,WAN 端通訊埠範圍在此處設定.",	//help96
"(也叫做SSID)",	//bwl_AS
"無線頻道",	//_wchannel
"手動分派網路金鑰",	//wwz_manual_key
"請按下位於無線裝置的&quot;Push 按鈕&quot;,並在120秒內按下下方的&quot;連線&quot;按鈕.",	//wps_p3_5
"啟用 LPD/LPR 列印",	//tps_enlpd
"要提供相關的憑證,例如一個密碼,以供確認使用者或裝置確實實際上的使用權利.",	//help427
"L2TP",	//_L2TP
"DHPC IP 位址範圍",	//bd_DIPAR
"統計資料",	//_stats
"- 介於8~63 個字元 (較長的WPA 金鑰比較短的金鑰更安全) ",	//wwl_s4_intro_za2
"L2TP 本地端會談(session) 0x%04X 已停止",	//IPL2TP_SESSION_DOWN
"用以將訊息轉譯成密碼後再回復成原來的標準文字內容.",	//help485
"至開始選單,選擇執行,輸入 <code>winipcfg</code> 指令,並按下 Enter.接下會有一個視窗出現,在下拉選單中選擇合適的網路卡型號,接著您就可以看到網路卡位址.這個就是裝置的MAC位址.",	//help338
"動態 IP (DHCP) 網際網路連線類型",	//bwn_DIAICT
"輸入位於LAN 端的Syslog 伺服器IP 位址.",	//help859
"動態主機配置設定協定(DHCP):用以從預先定義的位址範圍中,自動分配IP 位址給有要求的電腦主機或網路裝置.",	//help490
"新增",	//_add
"存取控制",	//_acccon
"無效的設定,請確認這個名稱是正確的.",	//tsc_pingt_msg4
"中斷連線",	//ddns_disconnect
"確認密碼",	//_verifypw
"設定MAC 位址過濾",	//am_intro_2
"新增",	//_aa_pol_add
"按下 <span class='button_ref'>儲存</span> 按鈕,以新增這個設定至虛擬伺服器清單",	//help11
"Warcraft II",	//gw_gm_59
"基於SSL加密的HTTP 為透過使用加密/解密技術的HTTP資料傳送.",	//help555
"系統",	//_system
"這個選項通常為關閉,當WAN端的DHCP伺服器會正確的提供IP位址給路由器的時候這選項也應該保持為關閉.如果路由器無法從DHCP伺服器取得一個IP位址的時候,也許單點廣播(unicast)回應對DHCP 伺服器工作來說會更好.以這個狀況來說,這時候將單點廣播選項開啟,並且注意到路由器是否有正確取得IP位址.在這個模式下,路由器會接受由DHCP 伺服器所發送的單點廣播回應,以替代廣播(broadcast)回應.",	//help261a
"警告,由於裝置設定變更,可能影響其他設定.",	//KR111
"透過 &quot;Ping&quot;指令來檢查位於網際網路上的任一台電腦是否有開啟及回應. ",	//hhtsc_pingt_intro
"(GMT-10:00) 夏威夷",	//up_tz_02
"虛擬伺服器名稱 (例如: <code>Web Server</code>)",	//help5
"支援選單",	//help767s
"Splinter Cell: Pandora Tomorrow",	//gw_gm_45
"使用者名稱 / 密碼 連線(PPPoE)",	//wwa_wanmode_pppoe
"碰撞",	//help462
"當主機需要支援使用數個重疊(重複)的流入通訊埠的應用程式,因為這些通訊埠互相重疊衝突的關係,這導致兩條通訊埠轉送將無法使用.",	//haf_dmz_60
"Email功能可以被用來寄送系統記錄檔案、路由器警戒訊息以及韌體更新通知到您的Email地址.",	//te_intro_Em
"VPN: 一個透過網際網路連結遠端辦公室或使用者至公司總部的安全通道",	//help732
"如果您不想啟用任一安全功能的話,請選擇這個項目",	//wwl_text_none
"輸入由服務提供者所提供的使用者名稱或登入名稱.如果DDNS 服務提供者只提供您一個登入名稱或登入值的話,請將其全部輸入於三個欄位中.",	//help895
"典型的PPPoE 連結並非總是啟用連結.不過D-Link路由器允許您設定不同的重新連結模式.設定為:",	//help269
"Kbyte",	//help592
"嘗試以有流量時重新連接 WAN 端連結",	//GW_WAN_RECONNECT_ON_ACTIVE
"一個允許您透過同軸電纜連結Cable 服務提供者及透過乙太網路連結電腦,用以存取傳送/接收網際網路資料的裝置.",	//help455
"裝置",	//aa_Machine
"OSI模型第五層定義了應用程式連結及資料傳遞兩者之間的起始、結束協調.",	//help685
"星期三",	//_Wed
"7 pm ",	//tt_time_20
"目的地 IP<br />起始位址",	//aa_FPR_c3
"輸入欲開啟的TCP 通訊埠(例如: <code>6159-6180, 99</code>).",	//help68
"帳戶名稱",	//te_Acct
"這對於防止未經授權的無線裝置要來連結您的網路時,有相當大的幫助.",	//help150
"許多的網站構成頁面包含了圖形及連結了其他網站.如果您沒有啟用所有的這些包含構成的網站的話,可能無法順利存取.舉例還說,要存取 <code>my.yahoo.com</code> 的話,您還需要啟用存取 <code>yahoo.com</code>、<code>yimg.com</code> 及 <code>doubleclick.net</code>.",	//help146
"SMTP 用戶端 email 寄送成功",	//IPSMTPCLIENT_MSG_SENT
"Quake 3",	//gw_gm_38
"1 am ",	//tt_time_2
"這個選項用以搭配RADIUS 伺服器驗證無線用戶端時使用.無線用戶端在試圖透過這個通訊閘與伺服器驗證身分時,應該有已建立的必須驗證身分憑證.此外,還必須設定RADIUS 伺服器允許這個通訊閘以驗證使用者.",	//help384
"自動上傳連結速度",	//at_AUS
"按下 <strong>刪除</strong> 圖示,以永久的刪除時間排程設定.",	//hhts_del
"QOS Engine技術所提供的會談流出封包參數設定,越小的數值代表越高的優先權.",	//help818
"韌體更新不能從無線裝置端順利完成.要順利地完成更新,請確定您使用有線電腦進行韌體更新動作.",	//help886
"點對點協定使用在兩台電腦透過序列介面連結完成通訊動作,例如電話線路.",	//help655
"一種一個位於Wi-Fi無線網路上的存取點,週期性的廣播無線網路控制資料給其他無線存取點的資訊訊框.",	//help439
"選擇一個唯一的名稱以供這個這使用.",	//_aa_wiz_s2_msg
"選擇一個通訊協定,使用於網際網路流量回到路由器通過時要開啟的通訊埠範圍 (例如: <code>兩者</code>或TCP或UDP).",	//help52
"秒 …",	//wps_KR46
"為您的網路命名一個名稱,最多輸入32 個字元.",	//wwz_wwl_intro_s3_1
"DDND 功能允許您的伺服器主機(例如:Web,FTP,遊戲伺服器)使用一個對應您的動態分配IP位址的您所購買或註冊的網域名稱(www.whateveryournameis.com).大多數的寬頻網際網路服務提供業者(ISP)都只分配了動態(會變更)的IP位址.使用透過DDNS 服務提供者所提供的DDNS服務,您的朋友可以輸入您的主機(網域)名稱以連結至您的遊戲伺服器而不須要知道該伺服器的動態IP位址.",	//td_intro_DDNS
"Ghost Recon",	//gw_gm_19
"(GMT+07:00) 曼谷,河內,雅加達",	//up_tz_53
"DST 起始及 DST 結束",	//help845
"使用於傳送及接收RF 訊號.",	//help416
"(GMT+06:00) 斯里蘭卡",	//up_tz_51
"選擇其中一個,您可以指向位於您的電腦本機的設定執行目錄,其中包含您從印表機廠商網站上所下載的印表機驅動程式.",	//wprn_s3d
"CHAP 驗證失敗 - 請檢查登入資訊細節.",	//IPPPPCHAP_AUTH_FAIL
"系統記錄項目",	//KR109
"Tiberian Sun",	//gw_gm_52
"一致資源定址器(URL),透過一個唯一的URL位址,使的網際網路上的伺服器名稱更容易記憶.",	//help726
"阻擋 TCP 封包,從 %v:%u 至 %v:%u 依照控制 %s 為無效",	//IPNAT_TCP_BAD_FLAGS
"名稱",	//_name
"輸入系統伺服器區域網路端 IP 位址,例如 <code>192.168.0.50</code>.",	//help66
"阻擋流入 ICMP 錯誤訊息 (ICMP 種類 %u) 從 %v 到 %v 無活動中的UDP 會談(session)介於 %v:%u 及 %v:%u之間",	//IPNAT_UDP_BLOCKED_INGRESS_ICMP_ERROR_PACKET
"FTP ALG 丟棄封包 從%v:%u 到 %v:%u",	//IPFTPALG_REJECTED_PACKET
"SNMP",	//help692
"這個電腦不被允許存取此網站.",	//fb_p_1
"連線類型",	//_contype
"這個通訊埠為您要使用從網際網路端進入設備管理介面的位址.例如,如果您這邊定義的通訊埠為1080,然後要從網際網路端存取路由器管理介面,您比需使用的連結URL從 <code>http://my.domain.com:1080/</code>.",	//help829
"應用程式",	//_specappsr
"隱藏功能允許您將您的無線網路隱藏起來.當這個功能被設定為可見時,您的無線網路名稱將在訊號可及的範圍中被廣播出來.如果您沒有使用無線加密的話,這代表任意的使用者都可以使用您的無線網路.當隱藏模式被啟用,您必須在無線用戶端手動輸入無線網路名稱(SSID)才可以連結無線網路.",	//help353
"Halo: Combat Evolved",	//gw_gm_23
"總是廣播",	//help325
"主機",	//help550
"重新連線模式",	//bwn_RM
"系統記錄選項",	//sl_LogOps
"所有的網際網路及網路連線詳情都將顯示在裝置狀態頁面中.韌體版本也會顯示在此.",	//help772
"系統記錄詳情",	//sl_LogDet
"方式",	//_aa_method
"這是用以測量相對無線網路訊號品質.數值以百分比表示最佳訊號理論品質.訊號品質會因距離的遠近、其他無線裝置訊源的干擾(例如2.4G無線電話或鄰近的無線裝置)、無線裝置與路由器之間的障礙物而有所增減影響.",	//help788
"繼續",	//_continue
"轉發無線存取點訊號以延伸涵蓋的範圍",	//help669
"無線選項用以對您的D-Link 路由器進行無線網路相關設定.請注意變更此處的設定後,有可能無線用戶端必須使用與此處同樣的設定才可以連結您的無線網路.",	//help349
"統計資料頁面顯示所有來自LAN、WAN及無線端的傳送/接收封包統計資料.",	//help804
"裝置狀態",	//_devinfo
"是",	//_yes
"無線網路名稱(SSID)",	//help699
"(GMT+09:00) 亞庫次克",	//up_tz_62
"在這個項目下,您可以新增排程至下面的清單中,或是編輯已存在的.",	//help192
"啟用 DMZ ",	//af_ED
"Need for Speed",	//gw_gm_31
"永遠保持網際網路連線中",	//help271
"允許位於LAN 端的多台電腦使用PPTP 通訊協定連結他們的公司網路.",	//help33
"阻擋流入 TCP 封包從 %v:%u 到 %v:%u 與意外的認可 %lu (預計 %lu 到 %lu)",	//IPNAT_TCP_BLOCKED_INGRESS_BAD_ACK
"開始對定義的主機 Ping.",	//htsc_pingt_p
"資料統計資訊這可以被傳送在特定的期間範圍內",	//help714
"印表機狀態檢查",	//wprn_cps
"(GMT+05:00) 伊卡特林堡",	//up_tz_45
"以設備的預設值來說,路由器會自動的決定目前現行的連結類型為xDSL/Frame-relay 網路或其他的連結類型(例如Cable Modem 或乙太網路).這邊會顯示出例如這樣的結果,<span class='option'>偵測到 xDSL or Frame Relay 網路</span>.如果您使用一個非常見的網路類型,且實體的連結為xDSL,但您所做的WAN設定為”固定IP”或”動態取得IP(DHCP).請將這個選項設定為 <span class='option'> xDSL or 其他Frame Relay 網路</span>,以確定路由器可以識別出需要進行流量控制的差異變化以取得最佳傳輸效能.",	//help84
"有效的最新的韌體版本為  %d.%02d ",	//GW_FW_NOTIFY_FIRMWARE_AVAIL
"RX 丟棄封包",	//ss_RXPD
"通訊埠觸發 ALG 分配TCP 封包會談(session)失敗,從%v:%u 到 %v:%u",	//IPPORTTRIGGERALG_TCP_PACKET_ALLOC_FAILURE
"備註:您有可能需要輸入主機名稱.如果您沒有或不知道這樣的資訊的話,請聯絡您的ISP.",	//wwa_note_hostname
"數位用戶迴路(DSL),把高頻寬的資訊透過普通電話銅線傳送到住宅或小型企業的技術.",	//help504
"活動",	//ai_Action
"重置設定為出廠預設",	//RUNTIME_CONFIG_RESET_CONFIG_TO_FACTORY_DEFAULTS
"沒有偵測到印表機",	//sps_nopr
"星期五",	//_Fri
"小時",	//gw_hours
"LPD/LPR 列印",	//tps_lpd
"韌體更新",	//tf_FWUg
"Battlefield 1942",	//gw_gm_4
"10Mbps",	//anet_wp_0
"使用一個任意挑選的56位元金鑰,當資料交換的時候,傳送端與接收端都必須知道這個金鑰內容.",	//help469
"Wi-Fi 保護存取機制 (WPA)這兩個選項有不同的版本 – 這個安全標準由Wi-Fi聯盟所制定公佈.",	//help373
"日光節約時間補償",	//tt_dsoffs
"一個安裝於電腦中的界面卡,或是已內建於主機板上以允許電腦連結至網路",	//help629
"自動分配網路金鑰 (建議使用)",	//wwz_auto_assign_key
"要知道您的無線網路卡支援哪些安全功能,請參考無線網路卡的相關文件.",	//wwl_s3_note_1
"Doom 3",	//gw_gm_15
"按下 <strong>儲存</strong> 以新增排程至下面的清單中.",	//hhts_save
"自動偵測",	//at_Auto
"LED",	//help597
"在方塊內勾選想要的時間或選擇整週的按鈕來選擇一星期七天",	//help194
"一個允許您觀看位於全球資訊網(WWW,Internet)的內容及與資訊相關內容的工具.",	//help746
"位址類型",	//aa_AT
"Ubi.com ",	//gw_gm_71
"BigPond 失敗,詳細請查看系統記錄內容",	//BIGPOND_FAILED
"步驟 3 - 選擇一個要套用這個的設備",	//aa_wiz_s1_msg3
"更新資訊至動態DNS的週期時間.",	//help898
"PPTP 伺服器IP 位址",	//bwn_PPTPSIPA
"Wireless Fidelity",	//help749
"路由",	//_routing
"新增一個MAC 位址清單,以供您要進行允許或拒絕存取您的網路設定時使用.",	//hham_intro
"OSI 模型第二層.控制資料在網路實體連結中的傳遞方式.",	//help471
"流入封包過濾功能提供一個控制資料從網際網路端接收的進階方式.透過這個功能您可以設定以一個IP位址範圍為基礎的流入封包過濾以控制資料接收.",	//ai_intro_1
"(GMT+10:00) 海參威 ",	//up_tz_69
"步驟 2: 選擇您的時區",	//wwa_title_s2
"HNAP 設定存取點模式 %s 返回 %s, %s",	//GW_PURE_SETACCESSPOINTMODE
"現行的系統設定值可以被儲存至本機端硬碟中.而且儲存的檔案也可以從本機硬碟中被回存回設備.",	//tss_intro2
"基於網際網路傳送語音資訊,而不透過傳統PSTN線路",	//help736
"(GMT-03:00) 布宜諾斯艾利斯, 喬治城 ",	//up_tz_19
"如果您選擇了這個選項,路由器將自動地找尋一個最少干擾的頻道供無線網路使用.如果您停用了這個選項,路由器將使用您在下面 <span class='option'>無線頻道</span> 選項中所定義的頻道設定.",	//help354
"記錄封包取得從網路上的一點到別處的時間統計.也包含了延遲時間.",	//help596
"您必須在設定檔案之前先輸入名稱.",	//ta_alert_5
"總是廣播",	//bd_DAB
"WPA-企業級",	//_WPAenterprise
"(GMT+02:00) 赫爾辛基,普利托里亞 ",	//up_tz_34
"印表機",	//sps_pr
"傳輸控制協定",	//help706
"預先共用金鑰",	//_psk
"動態DNS (DDNS)",	//_dyndns
"拒絕",	//_deny
"重新啟動",	//help664
"阻擋流入 TCP 封包從%v:%u 到 %v:%u 隨著 %s 在狀態中不被允許 %s",	//IPNAT_TCP_BLOCKED_INGRESS_UNEXP_FLAGS
"最大閒置時間:",	//help276
"到",	//_to
"IP",	//aa_AT_0
"十二月",	//tt_Dec
"(GMT+12:00) 斐濟, 堪察加半島, 馬紹爾群島",	//up_tz_72
"按下 <span class='button_ref'>瀏覽</span> 按鈕,以檢視載入在電腦中的相關更新上傳檔案.",	//help879
" %s 已起始; 所有沒有定義的系統網際網路存取變更為: %s",	//GW_INET_ACCESS_POLICY_START_OTHERS
"防火牆功能用以監控流出及流入封包流量已確保只有符合允許條件的流出要求封包流量有所回應以通過防火牆.",	//help702
"主機沒有回應,重新嘗試…",	//tsc_pingt_msg11
"您確定要刪除這個記錄?",	//up_ae_de_1
"這個區域會不停地更新顯示出所有位於路由器LAN端啟用DHCP 功能的電腦或裝置.但顯示的範圍受限於DHCP 伺服器所設定的發放位址範圍.",	//help781
"輸入您所需求的MAC 位址.",	//help161_2
"6 pm",	//tt_time_19
"在下方設定MAC 過濾:",	//am_intro
"傳送數值失敗,原因為封包遺失.",	//help811
"適中",	//aw_TP_1
"(GMT) 卡薩布蘭卡市, 蒙羅維亞",	//up_tz_24
"WISP",	//help756
"使用這個選項,以觀看連結至您的無線路由器的無線用戶端資訊.",	//sw_intro
"LPD/LPR 列印協定使用靜態的IP位址及一個佇列名稱來與您的印表機傳遞列印資訊.",	//tps_lpd1
"及",	//help257
"已關閉 – 一個連線不會長期的被啟用,但這個連線會談(session)將被持續抱持著,這些任一的轉譯封包都持續著,直到連線結束為止.",	//help819_8
"(秒)",	//bws_secs
"通訊埠轉送",	//PORT_FORWARDING
"阻擋流出ICMP 封包 (ICMP 種類 %u) 從 %v 到 %v",	//IPNAT_ICMP_BLOCKED_EGRESS_PACKET
"網際網路協定",	//help573
"一個在建築物中的電腦群組,通常從伺服器存取檔案.",	//help601
"小時",	//tt_Hour
"動態 IP (DHCP)",	//bwn_Mode_DHCP
"輸入DNS 伺服器的IP 位址.如果次要伺服器沒有被使用的話,該欄位請保持空白.",	//help290a
"BigPond 登出中",	//BIGPOND_LOGGING_OUT
"DMZ(非軍事區域) 功能讓您設定一台位於路由器LAN端網路上的單一電腦.如果您有一台電腦在路由器下無法順利執行網際網路應用程式的話,您可以將這台電腦設定於DMZ功能中,使其不受限制的供網際網路端使用者存取它.",	//af_intro_1
"主要DNS 伺服器",	//_dns1
"如果您有從網際網路端接收多點廣播串流資訊問題時,請卻定多點廣播串流選項有被啟用.",	//hhan_mc
"工具",	//_tools
"中斷連線",	//_sdi_s2
"USB 埠",	//sps_usbport
"當分配排程 %s 時,系統發生錯誤",	//GW_SCHED_ALLOC_FAILED
"阻止所有的WAN端使用者有存取相關的能力.(但LAN端使用者則不受流入封包過濾的限制)",	//help179
"啟用日光節約時間",	//tt_dsen2
"允許",	//_allow
"十月",	//tt_Oct
"選擇您想要觀看的事件等級.",	//help798
"WAN 埠實體連結速度",	//anet_wan_phyrate
"備註",	//_note
"目的地<br />通訊埠<br />起始",	//aa_FPR_c6
"欲開啟的UDP 通訊埠",	//help69
"DHCP 更新時間",	//bd_DLT
"歡迎使用D-Link 網際網路連線設定精靈",	//wwa_title_wel
"LAN 實體界面已連結",	//GW_LAN_INTERFACE_UP
"流入封包過濾清單",	//ai_title_IFRL
"系統記錄",	//_logs
"管理者要求之後寄送系統記錄Email",	//GW_LOG_EMAIL_ON_USER_REQUEST
"關閉MAC 位址過濾",	//am_FM_2
"這個通訊埠將由網際網路端被存取.",	//help21
"802.11 模式",	//bwl_Mode
"位址模式",	//bwn_AM
"BigPond 伺服器",	//bwn_BPS
"輸入由您的網際網路服務提供業者(ISP)所提供的相關資訊.",	//_ispinfo
"速率",	//_rate
"您的D-Link路由器預設的設備LAN 端靜態固定IP 位址為192.168.0.1；這代表IP位址192.168.0.2 到 192.168.0.254可以被DHCP 伺服器用來指派使用.",	//help321
"(GMT-07:00) 山地時間 (美國/加拿大)",	//up_tz_06
"家長控制標記服務",	//_bsecure_parental_serv
"完成",	//_success
"設定使用者名稱與密碼連線 (L2TP)",	//wwa_set_l2tp_title
"步驟 1:歡迎使用D-Link 無線安全設定精靈",	//wwz_wwl_title_s3
"Mac OS X",	//help342
"如果您的ISP 要求您輸入使用PPPoE (基於乙太網路的點對點通信協定)連線,請選擇這個項目.大多數的DSL提供者都選擇這個項目.這個連線方式要求您輸入一個 <span class='option'>PPPoE連線使用者名稱</span> 及<span class='option'>PPPoE 連線密碼</span> (由您的ISP所提供給您),以取得存取網際網路的能力.",	//help265
"Ping 接收:",	//tsc_pingt_msg101
"SMTP (Email)伺服器 %s IP 位址為 %v",	//GW_SMTP_EMAIL_RESOLVED_DNS
"RADIUS 伺服器通訊埠",	//bws_RSP
"會談(session)層",	//help684
"嘗試建立PPPoE 連結",	//PPPOE_EVENT_CONNECT
"自動時間設定",	//tt_auto
"RSA",	//help678
"PPTP子系統資源不足.連結可能受到影響.",	//PPTP_EVENT_LOW_RESOURCES_TO_QUEUE
"L2TP本地端通道 0x%04X 接收到不可預期的控制訊息(不理會)",	//IPL2TP_TUNNEL_UNEXPECTED_MESSAGE
"Neverwinter Nights",	//gw_gm_34
"第五",	//tt_week_5
"Wi-Fi保護存取(WPA),一個Wi-Fi 安全進階加密保護技術,提供相較於WEP更安全的資料加密方式.",	//help760
"下面是您的無線網路安全設定的詳細一覽.請將此頁面列印出來,或在紙上記下此處的資訊,以供您在設定無線用戶端的無線網路卡時使用.",	//wwl_intro_end
"規則表",	//aa_Policy_Table
"時間配置設定",	//tt_TimeConf
"無",	//_none
"裝置將防護未經授權的外部使用者使用區域網路端的資源.",	//help524
"超高速乙太網路",	//help536
"步驟 2:選擇排程",	//_aa_wiz_s3_title
"通行驗證碼必須與驗證伺服器上所設定相同.",	//help392
"按預定時間寄送系統記錄Email",	//GW_LOG_EMAIL_ON_SCHEDULE
"網域名稱",	//help499
"網際網路群組管理協定(IGMP),用以使用確定這個電腦可以回應其他的同一多點廣播群組的成員至鄰近的路由器.",	//help562
"選擇一個適合您所在區域的時區.這個資訊在設定以時間為基礎的路由器相關設定時需要用到.",	//wwa_intro_s2
"PPTP 通訊閘IP 位址",	//_PPTPgw
"MMS ALG 拒絕封包從 %v:%u 到 %v:%u",	//IPMMSALG_REJECTED_PACKET
"無線設定",	//_wirelesst
"這邊有兩種設定您網際網路的連線方式: 您可以使用以網頁為基礎的網際網路連線設定精靈,或是您也可以手動設定連線.",	//int_intro
"WCN",	//help741
"一個提供語音/視訊傳輸以及視訊會議系統裝置兼容的一致性標準.",	//help541
"至LAN 端系統存取拒絕,MAC 位址 %m",	//GW_LAN_ACCESS_DENIED
"阻擋封包從 %v 到 %v,從錯誤的網路界面接收到該封包(IP 位址欺偽)",	//GW_NAT_REJECTED_SPOOFED_PACKET
"使用者資料包協定",	//help717
"阻擋流入GRE 封包,從 %v 到 %v",	//PPTP_ALG_GRE_BLOCKED_INGRESS
"Jedi Knight II: Jedi Outcast",	//gw_gm_26
"(GMT+01:00) 巴黎,柏林,阿姆斯特丹",	//up_tz_30
"排程",	//_sched
"Starcraft",	//gw_gm_49
"設置FAT 裝置失敗",	//IPFAT_MOUNT_FAILED
"此處顯示現行安裝在路由器的韌體版本以及最新可用的更新版本資訊.",	//help883
"KALI",	//gw_gm_75
"第二層通道協定",	//help604
"請稍後,上傳設定檔至裝置.",	//ta_alert_6
" %s 以起始; 網際網路存取IP位址 %v 變更為: %s",	//GW_INET_ACCESS_POLICY_START_IP
"10 pm ",	//tt_time_23
"顯示目前路由器的時間.如果時間不正確的話,請使用下面的功能選項以校正時間為正確.",	//help841a
"通訊埠轉送",	//ag_title_4
"單點廣播",	//help718
"網路內的電腦",	//help551
"阻擋流出TCP封包從%v:%u 到 %v:%u 因為%s在狀態 %s內沒有被允許 ",	//IPNAT_TCP_BLOCKED_EGRESS_UNEXP_FLAGS
"WinMX ",	//gw_gm_68
"網際網路服務提供者(ISP)",	//help577
"主機名稱",	//help260
"FIN等待 -- 用戶端系統已要求停止連線",	//help819_4
"若您想要和此路由器連線的所有無線裝置可以用相同的傳輸模式連線,您可以透過選擇適當的&quot;僅有&quot;模式來稍微改善效能.若您有些裝置使用不同的傳輸模式,選擇適當的&quot;混合&quot;模式.",	//help357
"TCP",	//_TCP
"轉換資料成密碼則不容易被讀取",	//help515
"通用隨插即用服務(UPnP) 在網路裝置上支援點對點隨插即用功能",	//anet_msg_upnp
"請選擇自動或手動其中一個的時間設定,不是兩者皆可",	//tt_alert_1only
"點選<span class='button_ref'>DHCP釋放 </span>按鈕來不指派路由器的IP位址.路由器不會回應從WAN端來的IP訊息直到您點選<span class='button_ref'>DHCP更新</span> 按鈕或重新啟動路由器.點選<span class='button_ref'>DHCP更新</span>按鈕使路由器從ISP的伺服器取得一個新的IP位址.",	//help776
"在此處您可以啟用或停用ALGs. 有些通訊協定和應用程式要求IP載量的特別幫助來讓他們在NAT(network address translation)上有作用. 每個ALG提供特別的幫助給一個特定的通訊協定或應用程式.一些常用應用程式的ALGs預設是啟用的 .",	//help32
"Asheron's Call",	//gw_gm_3
"閒置時間直到路由器認為會談(session)終止的時間秒數.",	//help823
"L2TP IP位址 ",	//_L2TPip
"重新啟動裝置",	//_reboot
"有兩種方式來新增無線裝置到您的無線網路:",	//wps_p3_1
"RJ-45 ",	//help674
"步驟 3: 若有需要請插入印表機驅動程式的光碟",	//wprn_intro5
"監控安全服務 ",	//_bsecure_security_serv
"從一個裝置傳送資料到網路中的很多裝置",	//help621
"AES國家加密標準 ",	//help412
"接收",	//tsc_pingt_msg8
"典型的L2TP連線不是永遠連線的,D-Link路由器允許您設定重新連線模式,設定為: ",	//help286
"Unreal Tournament",	//gw_gm_56
"韌體更新區域可用於更新最新韌體來改善功能性與效能. ",	//tf_intro_FWU
"(GMT+08:00) 吉隆坡, 新加坡 ",	//up_tz_57
"(GMT-12:00) 埃尼威托克島, 瓜加林島",	//up_tz_00
"服務埠和位址限制",	//af_EFT_2
"排程功能用於對應某些功能時,可以在時間設定內啟用這些功能.",	//hhts_intro
"輸出量(Throughput)",	//help713
"證明 ",	//_auth
"重新登入後時間校正失敗…放棄 ",	//NET_RTC_SYNCHRONIZATION_FAILED_AFTER_RETRIES
"L2TP區端通道 0x%04X正在斷線中 ",	//IPL2TP_TUNNEL_DISCONNECTING
"排程清單",	//tsc_SchRuLs
"韌體版本",	//sd_FWV
"啟用WMM可以協助用無線連線傳輸多媒體內容時控制潛在因素和不安 .",	//help188_wmm
"用來寄送或接收Email",	//help687
"無線基礎點模式 ",	//help567
"選擇性的備用RADIUS伺服器",	//help396
"儲存設定",	//ta_SavConf
"微軟點對點加密是用於透過PPTP連線時使資料傳輸安全.",	//help618
"此項目會回復所有設定至出廠時的設定,任何沒有儲存的的設定將會遺失,若您想要儲存您路由器的設定,請使用上方儲存設定的選項. ",	//help876
"此項目使用WPA-PSK",	//help380
"次要DNS位址",	//wwa_sdns
"在給予的時間內通過位元的數量",	//help441
"網路過濾器",	//_netfilt
"資料",	//help466
"登入",	//li_Login
"日",	//gw_days
"WAN端已連線",	//WAN_ALREADY_CONNECTED
"SMTP ",	//gw_vs_5
"WPA2 Only  ",	//bws_WPAM_3
"DMZ ",	//help488
"密碼或金鑰",	//td_PWK
"虛擬伺服器項目 ",	//tool_admin_vsname
"(GMT+06:00) 阿斯塔那,達卡",	//up_tz_50
"起始時間",	//tsc_StrTime
"最短 ping時間 (毫秒): ",	//tsc_pingt_msg104
"每秒千位元 ",	//help591
"印表機裝置識別碼錯誤 ",	//wprn_iderr
"選擇此項目將會顯示目前無線網路設定來讓您手動配置無線裝置 ",	//wps_KR42
"逾時",	//td_Timeout
"無線存取點,AP.裝置允許無線用戶端連線到它且透過AP存取實體網路",	//help402
"執行web過濾",	//_aa_apply_web_filter
"服務品質",	//help661
"回復至未設定狀態",	//resetUnconfiged
"Gaming ",	//GAMING
"8 am ",	//tt_time_9
"DMZ ",	//help495
"WAN介面已作用,網路用IP位址%v和預設閘道%v建立連線",	//GW_WAN_INTERFACE_UP
"阻擋從 %v到%v 流入的封包(IP通訊協定 %u) ",	//IPNAT_BLOCKED_INGRESS
"路由器IP位址",	//_ripaddr
"逾時",	//sa_TimeOut
"阻擋流出TCP 封包, 從 %v:%u 到 %v:%u 與不可預期的連續 %lu (預期 %lu 到 %lu)",	//IPNAT_TCP_BLOCKED_EGRESS_BAD_SEQ
"ISP ",	//help587
"LAN 實體介面已中斷",	//GW_LAN_INTERFACE_DOWN
"依WAN端連線目前是否建立而定,您可以點選<span class='button_ref'>連線</span>來嘗試建立WAN端連線 或是 <span class='button_ref'>斷線t</span>來中斷WAN端連線 . ",	//help778
"佇列名稱",	//sps_qname
"前言 ",	//help658
"秒",	//_seconds
"系統記錄被IP位址%v清除 ",	//GW_LOGS_CLEARED
"警告",	//sl_Warning
"若您的無線裝置支援 WPS(Wi-Fi Protected Setup)請選擇此項目  ",	//wps_KR51
"MAC位址",	//aa_MAC
"手動:",	//help274
"利用一個短的 (400ns) 監看間隔可以增加throughput.然而,他也會增加某些安裝的錯誤率,因為射頻頻譜反應敏感度增加 . ",	//aw_sgi_h1
"阻擋來源路徑封包,從 %v 到 %v",	//IPSTACK_REJECTED_SOURCE_ROUTED_PACKET
"升級",	//help722
"利用此選項來回復之前儲存在路由器的設定.",	//help834
"主要DNS位址",	//wwa_pdns
"星期日",	//_Sun
"動態DHCP用戶端數量",	//bd_title_clients
"為了防止外面使用者存取您的網路,路由器將會自動指派一個安全機制(也稱為WEP或WPA金鑰)到您的網路. ",	//wwz_auto_assign_key2
"無線用戶端數量",	//sw_title_list
"(GMT-04:00) 卡拉卡斯, 拉巴斯 ",	//up_tz_15
"分貝相對一毫瓦,Decibels relative to one milliwatt (dbm) ",	//help483
"當您的D-Link路由器已適當的設定好且此選項已啟用,DHCP伺服器將會管理,配發IP位址及其他網路設定資訊給連結至區域網路端的電腦或其他網路裝置,而不須要它自己做相關的設定.",	//help316
"嘗試連線到L2TP伺服器",	//IPL2TP_TUNNEL_CONNECTING
"時間同步",	//NET_RTC_SYNCHRONIZED
"啟動SPI模式",	//af_ES
"(GMT-06:00) 薩克斯其萬省 ",	//up_tz_10
"有流量時連線 ",	//bwn_RM_1
"阻擋從%v到%v進入GRE封包 ",	//IPSEC_ALG_ESP_BLOCKED_INGRESS
"您尚未登入,請重新整理網頁",	//NOT_LOGGED_IN_PLEASE_REFRESH
"繼續",	//ub_continue
"使用者名稱或金鑰",	//td_UNK
"架設 PV%d裝置失敗 ",	//IPPMVM_MOUNT_FAILED
"Rise of Nations ",	//gw_gm_42
"整週",	//tsc_AllWk
"虛擬伺服器",	//_virtserv
"虛擬伺服器的選項給網路使用者存取在您LAN端的服務,此功能對於線上服務,像是FTP, Web或遊戲伺服器是很實用的.針對每個虛擬伺服器,您要在您的路由器上定義一個公用服務埠來重新導向一個內部的LAN IP位址和LAN服務埠.",	//help2
"若您想當系統記錄空間已滿時以Email方式寄送系統記錄時請選擇此項目",	//help869
"RIP ",	//help670
"LCP設定區端選項: ACCM: %lx, ACFC: %u, PFC: %u, MRU: %u ",	//IPPPPLCP_SET_LOCAL_OPTIONS
"WPA",	//help750
"重新啟動裝置",	//ts_rd
"瀏覽器",	//help452
"IPSec ALG從%v:%u 到%v:%u 拒絕封包 ",	//IPSEC_ALG_REJECTED_PACKET
"請稍侯,解決中",	//tsc_pingt_msg3
"MAC 位址 %m 的無線系統斷線原因是: %s ",	//GW_WIRELESS_DEVICE_DISCONNECTED
"要在您的系統輸入MAC位址,您可手動輸入它或從系統連線到D-Link路由器的網頁管理畫面且點選<span class='button_ref'>複製您電腦的MAC位址 </span>按鈕.",	//help333
"無線廣播",	//sd_WRadio
"允許, 網站 - %s%s, 服務埠- %s ",	//ALLOWED_WEB_SITES
"BitTorrent ",	//gw_sa_1
"狀態封包檢查,Stateful Packet Inspection(SPI) ",	//help696
"UDP ",	//_UDP
"將一台電腦設定在DMZ可能會讓它曝露在一些安全的風險中,只有在最後不得已時才建議使用此項目. ",	//help166
"此存取控制的區域允許您在您的網路控制存取對內和對外的流量.使用此功能像是家長控制器只准許存取被認可的網站,基於時間和日期來限制網頁存取,或由應用程式,如ptp程式或遊戲來阻擋存取.",	//help117
"路由器會自動地記錄它可能感興趣的事件在他內部記憶體內.若內部記憶體沒有足夠的空間來放所有的事件,較舊的記錄檔會被刪除,只有最新的事件會被保留.記錄檔選項允許您去瀏覽路由器的記錄,您可以定義哪些事件的類型和事件的層級您想瀏覽.此路由器也有內部Syslog伺服器支援所以您可以寄送記錄檔到您網路內的電腦.",	//help795
"L2TP網路連線類型",	//bwn_L2TPICT
"不是",	//_no
"(GMT+09:30) 阿德萊德 ",	//up_tz_63
"您必須先輸入韌體檔案的名稱",	//tf_FWF1
"(GMT+10:00) 布里斯本",	//up_tz_65
"優先權",	//_priority
"WAN端已經斷線",	//WAN_ALREADY_DISCONNECTED
"此頁面有尚未儲存的資料,您確定要放棄嗎?",	//up_jt_1
"網路存取所有不特定系統設定在: %s ",	//GW_INET_ACCESS_INITIAL_OTHERS
"起始IP位址和結束IP位址是WAN端IP位址",	//hhai_ip
"此選項用來當路由器感應到資料由一個觸發埠或服務埠範圍傳送到網路時在您的路由器上開啟單一或多個服務埠,特殊應用程式執行在您內部網路的所有電腦上. ",	//as_intro_SA
"Ping WAN端實體IP位址是駭客常用來測試您的WAN端IP位址是否有效的方式.  ",	//anet_wan_ping_1
"(GMT+04:30) 喀布爾 ",	//up_tz_44
"您可能在LAN端設備使用它的公開識別資料(WAN端閘道器的IP位址或它的動態DNS名稱)來存取虛擬伺服器時發生問題,您的要求可能沒有被返回或您可能被限制到&quot;被禁止&quot;的頁面.",	//help27
"IPSec (VPN) ",	//as_IPSec
"管理者",	//_admin
"阻擋",	//BLOCKED
"eDonkey ",	//gw_gm_65
"BigPond Cable (澳洲使用者) ",	//wwa_msg_bigpond
"啟用記錄到Syslog伺服器 ",	//tsl_EnLog
"中繼站",	//help668
"關閉等待 -- 伺服器系統已經要求停止連線",	//help819_5
"低",	//aw_TP_2
"每秒最大位元或位元組數可以從一個網路裝置且被傳送 ",	//help433
"驗證逾時",	//bwsAT_
"設定完成!",	//_setupdone
"登入路由器",	//li_intro
"SMTP用戶端寄送郵件失敗 ",	//IPSMTPCLIENT_MSG_FAILED
"在啟動這些精靈之前,請確認您已經遵循在包裝內快速安裝手冊上列出的所有步驟操作過",	//bwz_note_ConWz
"Gnutella ",	//gw_gm_64
"重新連線模式: ",	//help268
"在網路上的一台電腦提供服務和資源給其他在網路上的電腦 ",	//help681
"未阻擋",	//NONE_BLOCKED
"五月",	//tt_May
"Big Pond 網路連線類型 ",	//bwn_BPICT
"2 pm ",	//tt_time_15
"星期二",	//_Tue
"清除記錄",	//ss_clear_stats
"NTP協定(Network Time Protoco使網路上的電腦時間能夠同步的協定)  ",	//help632
"ADSL ",	//help409
"結束時間用相同於起始時間的格式輸入,第一個框格為小時而第二個框格為分鐘.結束時間大部分用於其他的,但不常用於寄送事件.",	//help197
"802.11 ",	//help765
"WAN端連線閒置太久所以嘗試中斷連線 ",	//GW_WAN_DISCONNECT_ON_INACTIVE
"過濾器可以與虛擬伺服器,通訊埠轉送,遠端管理功能一起使用 ",	//ai_intro_3
"設定固定IP位址連線",	//wwa_set_sipa_title
"應用層",	//help421
"URL ",	//help725
"(GMT+12:00) 奧克蘭, 威靈頓 ",	//up_tz_71
"ALGs提供IP載量的特別協助給某些通訊協定和應用程式來讓他們可以在NAT上運作.若您在使用任何這些應用程式有問題時,請嘗試將對應的ALG停用和啟用.",	//hhaf_alg
"若您所在位置有日光節約時間請勾選此項目",	//help843
"QoS ",	//help660
"偵測到有一台印表機連接至路由器的USB埠",	//wprn_tt11
"流量統計",	//_tstats
"LCP設定遠端項目: ACCM: %lx, ACFC: %u, PFC: %u, MRU: %u ",	//IPPPPLCP_SET_REMOTE_OPTIONS
"三月",	//tt_Mar
"(GMT+01:00) 布魯塞爾, 哥本哈根,馬德里, 巴黎 ",	//up_tz_28
"Ipsec提供網路通訊時封包處理層的安全性",	//help576
"僅記錄網頁存取 ",	//_aa_allow_all
"使用者名稱 / 密碼連線 (L2TP) ",	//wwa_wanmode_l2tp
"DMZ主機 ",	//_dmzh
"時間伺服器%s在IP位址%v ",	//GW_TIME_RESOLVED_DNS
"EAP (802.1x) ",	//bws_EAPx
"規則名稱",	//aa_PolName
"無線網路安全性的更新版本提供加密一樣的驗證 ",	//help751
"透過IP傳送聲音,Voice over IP(VoIP)",	//help735
"要設定這個連線您需要由您的網路服務提供者提供一個完整的IP資料,若您有一個固定IP 連線且沒有此資料請聯絡您的網路服務提供者. ",	//wwa_set_sipa_msg
"沒有WCN相容的USB儲存介面被找到 ",	//USB_LOG_STORAGE_NOT_FOUND
"步驟 1: 選擇名稱 ",	//_aa_wiz_s2_title
"裝置已初始化 ",	//GW_INIT_DONE
"動態取得IP",	//carriertype_ct_0
"這些是給路由器LAN端(區域網路)介面的設定.路由器的區域網路(LAN)設定是以在此區域內指派的IP位址和子網路遮罩為基礎,此IP位址也用是用來存取網頁管理畫面的.",	//help305
"Raw TCP埠列印 ",	//tps_raw
"公用通訊埠",	//av_PubP
"WPA模式: ",	//help374
"PPTP收到一個從應用程式來的tunnel清除需求, tunnel將會被關閉.",	//PPTP_EVENT_TUNNEL_CLEAR_DOWN_REQUEST
"點選<strong>刪除</strong> 圖示來永遠移除 ",	//hhac_delete
"存取點(AP)",	//help401
"L2TP區域端會談(session) 0x%04X 正在終止 ",	//IPL2TP_SESSION_CLEAR_DOWN_REQUEST
"規則",	//aa_ACR_c2
"若網路存取在存取時被阻擋則從LAN端設備的需求將會被返回.若要解決此問題,請用它在LAN端的識別資料來存取LAN端設備.",	//help29
"(GMT-11:00) 中途島, 薩摩亞 ",	//up_tz_01
"應用程式",	//_app
"無效的LAN端子網路遮罩",	//bln_alert_1
"WAN端估計速度 ",	//GW_WAN_RATE_ESTIMATOR_STARTED_ON_WAN
"防火牆 &amp; 安全性 ",	//sl_FWandSec
"為了增加安全性,建議您停用ping WAN端回應的選項.Ping指令常被網路上惡意的使用者用來找出有活動的網路或電腦.",	//hhan_ping
"NAT ",	//sa_NAT
"啟用遠端管理功能,允許您或其他人從internet上的電腦來變更路由器的設定.",	//hhta_en
"SMTP(Emsil)伺服器%s無法找到DNS記錄 ",	//GW_SMTP_EMAIL_FAILED_DNS
"有些封包被丟棄是因為乙太網路碰撞(兩個或更多裝置企圖去同時使用乙太網路繞行)",	//help810
"網路喚醒(Wake-On-LAN) ",	//_WOL
"視需求連線: ",	//help272
"無 -- 此項目被用在未來可能會發生的連線",	//help819_1
"(GMT-04:00) 大西洋時間 (加拿大) ",	//up_tz_14
"POP3 ",	//gw_vs_6
"Star Trek: Elite Force II ",	//gw_gm_51
"伺服器位址",	//td_SvAd
"您可以用多種格式輸入服務埠: ",	//hhag_40
"流入封包過濾器可以用來限制存取您網路上的伺服器到一個系統或一群系統.過濾器可以和虛擬伺服器、Gaming或遠端管理功能一起使用.每個過濾器可以用於多個功能,舉例來說,一個  &quot;Game Clan&quot;過濾器可能允許一個特定gaming群組的所有成員去玩那些已被建立gaming項目的數個不同遊戲.在同時間一個 &quot;Admin&quot;過濾器可能只允許您辦公網路的系統去存取您在家使用的WAN端管理頁面和FTP伺服器.若您在過濾器新增一個IP位址,則變更會在所有過濾器使用的地方生效. ",	//help169
"電腦在他要求更新租約前可能有一組IP位址的時間,租約功能就像是承租一個公寓一般,初始租約指派在租約到期以前的時間.若承租人在租約到期時想要保持位址則一個新租約會被建立.若租約到期且位址不再需要則另一個承租人可能會使用此位址.",	//help324
"&quot;Ping&quot;是一個用送出一串簡短訊息到一台目標電腦和報告結果的網路通用功能.您可以使用它來測試一台電腦是否在運作,且以回應速度為基礎對連線到那台電腦的品質有個認知.",	//htsc_intro
"WLAN 區隔功能 ",	//KR4_ww
"電腦(和其他裝置)連線到您的LAN端也需要在他們的TCP/IP內容設定為&quot;DHCP&quot;或&quot;自動取得IP位址&quot;. ",	//help317
"多點廣播串流 ",	//anet_multicast
"數位憑證: ",	//help491
"Last ACK -- 在一個連線是在關閉等待完全被關閉時等待一段短時間 ",	//help819_7
"L2TP 區端 tunnel 0x%04X RTE 模組已被關閉 ",	//IPL2TP_SHUTDOWN_COMPLETE
"建立新規則",	//_aa_wiz_s1_title
"當在接收時封包被丟棄的數量,因為錯誤,碰撞或路由器資源有限. ",	//help809
"選擇通訊協定 (例如 <code>TCP</code>). ",	//help9
"您確定要清空所有記錄檔的項目嗎? ",	//sl_alert_1
"LAN Ethernet Carrier Detected ",	//GW_LAN_CARRIER_DETECTED
"觸發通訊埠",	//as_TPRange_b
"第一",	//tt_week_1
"若是,請按下OK",	//up_jt_3
"寬頻",	//help448
"清除",	//_clear
"終止PPPoE 會談(session) 0x%04X ",	//PPPOE_EVENT_DISCONNECT
"固定IP",	//_sdi_staticip
"網路交換金鑰是用於確保VPN連線的安全性",	//help566
"協助詞彙表 ",	//help398
"為了設定此連線,請確認您的本來連接到您寬頻連線的電腦已經連接至D-Link路由器,若您已接好,請點選複製MAC位址按鈕來複製您電腦的MAC位址到D-Link路由器. ",	//wwa_msg_set_dhcp
"給每個排程對您來說有意義的名稱,舉例來說,一個排程指定為星期一到星期五的下午3點到晚上9點,可能稱為「放學後」.",	//hhts_name
"給使用者帳戶的使用者輸入一個密碼,他將僅有唯讀的權限去存取網頁管理介面. ",	//help825
"WAN ",	//WAN
"IPX(Internetwork Packet Exchange)是由Novel發展出來的一個網路通訊協定來讓他們Netware用戶端和伺服器去溝通. ",	//help586
"從DHCP伺服器取得IP位址的電腦將會在DHCP用戶清單內.從下拉式選單內選擇一個裝置,再點選箭頭來新增那個裝置的MAC位址到清單內. ",	//hham_add
"WAN端流量統計",	//ss_WANStats
"嘗試以有流量時連線來開始WAN端連線 ",	//GW_WAN_CONNECT_ON_ACTIVE
"為了定義一個新的排程您必須捨棄您所有的變更. ",	//aa_sched_conf_1
"%s停止;所有不特定系統網路存取變更為 : %s ",	//GW_INET_ACCESS_POLICY_END_OTHERS
"DHCP保留位址清單",	//bd_title_list
"網頁存取登入中 ",	//_aa_logging
"使用者名稱",	//_username
"TCP/IP通訊協定用來做印表機資料的傳輸 stream ",	//help710
"啟用",	//_enable
"時間伺服器 %s無法找到DNS記錄",	//GW_TIME_FAILED_DNS
"參考與您路由器一起來特定對您作業系統的印表機設定指示文件. ",	//wprn_tt1
"9 pm ",	//tt_time_22
"IP位址",	//help256
"IP位址 %v 網路存取無法被設定",	//GW_INET_ACCESS_INITIAL_IP_FAIL
"詳細資料",	//_aa_details
"允許使用RTSP的應用程式從網路上接收多媒體.QuickTime和Real Player是使用此通訊定的常用應用程式. ",	//help36
"LAN端應用程式的服務埠數被WAN端應用程式瀏覽 ",	//help817
"PPPoE (使用者名稱 / 密碼) ",	//bwn_Mode_PPPoE
"簡單信件傳輸協定,Simple Mail Transfer Protocol(SMTP) ",	//help686
"允許全部",	//_allowall
"清空以下清單",	//awf_clearlist
"字元0-9和A-F",	//help547
"路由器在之前頁面設定儲存前必須重新啟動才會生效,您可以下方使用&quot;重新啟動&quot;按鈕來重新啟動路由器,或按下&quot;繼續&quot;按鈕來做其他變更.",	//sc_intro_rb3
"要開啟的TCP服務埠 ",	//help67
"傳輸技術提供一個每秒十億位元的資料速率",	//help537
"Quake 2 ",	//gw_gm_37
"否則的話請按下「取消」",	//up_ae_wic_3
"步驟 1: 設定您的密碼",	//wwa_title_s1
"複製您電腦的時間設定",	//tt_CopyTime
"驅動程式名稱",	//tps_drname
"L2TP 會談(session)伺服器開始傳送連續數目給區域端會談(session) 0x%04X ",	//IPL2TP_SEQUENCING_ACTIVATED
"保留位址",	//bd_Reserve
"MSN Messenger ALG從%v:%u 到%v:%u拒絕封包 ",	//IPMSNMESSENGERALG_REJECTED_PACKET
"無線網路區域允許您瀏覽連線至您無線路由器的無線用戶端 ",	//help782
"Dungeon Siege ",	//gw_gm_16
"通訊埠轉送 ALG從%v:%u到 %v:%u 指派會談(session)失敗給UDP封包 ",	//IPPORTFORWARDALG_UDP_PACKET_ALLOC_FAILURE
"模型",	//wprn_mod
"注意: ",	//help119
"Silent Hunter II ",	//gw_gm_46
"啟動MAC過濾啟用和允許被列出的電腦去存取網路",	//am_FM_3
"利用這個資料來設定您電腦以LPD/LPR列印 ",	//sps_lpd1
"系統設定",	//tss_SysSt
"從檔案重置設定",	//ta_ResConf
"更新快閃記憶體至無線網路設定 ",	//WCN_LOG_SAVE
"UDP連線",	//help823_11
"防火牆流量類型 ",	//as_FPrt
"每天",	//tsc_EvDay
"點選<span class='button_ref'>清除</span> 按鈕來從MAC位址過濾清單中移除MAC位址",	//ham_del
"PPPoE ",	//_PPPoE
"它代表您已經成功地連線至您的新路由器至網際網路 ",	//wwa_intro_online1
"DST結束 ",	//tt_dstend
"排程規則 ",	//tsc_SchRu
"PPP ",	//help654
"IP位址%v嘗試設定驗證失敗",	//GW_AUTH_FAILED
"排程",	//_scheds
"(GMT+08:00) 伊爾庫次克, 烏蘭巴圖 ",	//up_tz_56
"TCP/IP(Transmission Control Protocol/Internet Protocol) ",	//help708
"次要的DNS伺服器",	//_dns2
"您必須輸入一個主機名稱或IP位址",	//tsc_pingt_msg2
"這些設定是自動設定好的,且應該只有由進階使用者來修改",	//tps_apc1
"(GMT+05:45) 加德滿都 ",	//up_tz_48
"管理者密碼",	//_password_admin
"利用此區域來設定內建DHCP伺服器來指派IP位址給您網路中的電腦. ",	//bd_intro_
"RADIUS伺服器IP位址: ",	//help387
"由 %v IP位址允許設定驗證",	//GW_AUTH_SUCCEEDED
"家長控制服務是一個簡單有效的方式來限制存取到噁心,不合法或討厭的網站.此服務涵蓋所有在您路由器下電腦或Apple電腦 且永遠即時自動更新(不需要由您去下載或手動輸入).此服務是快速且將不會讓您的網路變慢.",	//_bsecure_parental_blurb
"CHAP 驗證詳細資料寄送給同等的人. ",	//IPPPPCHAP_AUTH_SENT
"American Standard Code for Information Interchange. This system of characters is most commonly used for text files ",	//help424
"此精靈將會透過以下步驟來引導您去新增一個存取控制的新",	//_aa_wiz_s1_msg
"路由器收到封包的數量",	//help807
"(GMT+09:00) 首爾 ",	//up_tz_61
"L2TP通訊閘IP位址 ",	//_L2TPgw
"進階設定: ",	//help395
"一旦發現可用的檔案,點選下方<span class='button_ref'>上傳</span>按鈕來開始韌體更新的程序,這將會花費一點時間 . ",	//help880
"Medal of Honor: Games ",	//gw_gm_29
"適用於WAN端IP位址落在此設定的範圍內一個訊息的流動 ",	//help95
"Beacon期間 ",	//aw_BP
"停止WAN服務 ",	//GW_WAN_SERVICES_STOPPED
"TeamSpeak ",	//gw_gm_79
"選擇一個網路時間伺服器來同步,您可以輸入一個時間伺服器的位址或在清單內選擇一個,若您使用一個伺服器有問題,選擇另一個.",	//help850
"雙工 ",	//help505
"您在電腦上有一個LAN IP位址為192.168.0.50的Web Server 且您的網路服務提供者阻擋服務埠80 ",	//help4
"(GMT-03:00) 巴西利亞 ",	//up_tz_18
"若您使用虛擬伺服器,通訊埠轉送,或遠端管理功能開啟特定服務埠來與網路通訊,則你可能增加您LAN端在網路上的曝露.",	//help168a
"一個32位元數字, 當提到IPv4時,那可識別每台在網路上或在內部網路電腦 ",	//help583
"PPTP ALG從%v:%u到%v:%u拒絕封包 ",	//PPTP_ALG_REJECTED_PACKET
"SMTP伺服器位址 ",	//te_SMTPSv
"MAC位址通常位於一個網路裝置底部的貼紙上,MAC位址是由12個字元所構成,每組字元通常由破折號或冒號分開,像是00-0D-88-11-22-33或是 00:0D:88:11:22:33,若您的網路裝置是一台電腦和網路卡的話已經位於電腦的內部,您可以從電腦連線到D-Link路由器並點選<span class='button_ref'>複製您電腦的MAC位址</span> 按鈕來輸入MAC位址. ",	//help334
"L2TP區端tunnel 0x%04X RTE 模組資源很少",	//IPL2TP_LOW_RESOURCES
"Battlefield 2 ",	//gw_gm_84
"點選 <strong>新增</strong>來開始建立一個的程序,您可以在任何時間取消此程序,當您完成新增時它將會被新增至以下 <strong>規則表</strong>. ",	//hhac_add
"RTSP ",	//as_RTSP
"自動偵測連線速率 10/100Mbps ",	//anet_wp_auto2
"驗證&amp; 安全性 ",	//_authsecmodel
"MTU ",	//bwn_MTU
"Steam ",	//gw_gm_72
"WAN ",	//_WAN
"確認排程是設定到 <code>永遠</code> ",	//help10
"向下相容 ",	//help430
"解密 ",	//help484
"Command and Conquer Generals ",	//gw_gm_8
"WPA ",	//_WPA
"Cable modem ",	//help454
"重新輸入由您的服務提供者提供的密碼或金鑰,若動態DNS提供者只有提供一個金鑰,在所有三個欄位內輸入此金鑰.",	//help897
"回應從",	//tsc_pingt_msg7
"阻擋流入TCP 封包,從 %v:%u 到 %v:%u 與不可預期的連續 %lu (預計 %lu 到 %lu) ",	//IPNAT_TCP_BLOCKED_INGRESS_BAD_SEQ
"一月",	//tt_Jan
"Battlefield: Vietnam ",	//gw_gm_5
"進階無線網路",	//_adwwls
"Pings 送出: ",	//tsc_pingt_msg100
"Unreal ",	//gw_gm_55
"您的D-Link路由器預設沒有設定管理者密碼去存取設定網頁,要使您的網路裝置安全請在下方設定且確認一個密碼 : ",	//wwa_intro_s1
"集線器(HUB)",	//help556
"WAN 端 Ping ",	//anet_wan_ping
"MAC位址驗證 ",	//bws_RMAA
"步驟 2 - 選擇一個排程 ",	//aa_wiz_s1_msg2
"資料連結層 ",	//help470
"6 am ",	//tt_time_7
"從WAN到LAN開始實行 ",	//help822a
"America's Army ",	//gw_gm_1
"訊息",	//KR110
"(GMT+03:00) 巴格達 ",	//up_tz_37
"安全模式",	//bws_SM
"支配管理且監視網路裝置 ",	//help689
"Cookie ",	//help464
"一個程式或使用者從伺服器要求資料",	//help461
"(GMT+10:00) 霍巴特 ",	//up_tz_68
"- 確定64 個字元, 使用A-F,0-9",	//wwl_s4_intro_za3
"前一個",	//_prev
"啟用無線網路",	//bwl_EW
"列印設定精靈要求 raw TCP通訊埠列印通訊協定,此通訊協定目前在您的路由器上已停用. ",	//wprn_foo1
"一個無線網路利用在無線頻譜的特定頻道來處理用戶端間的溝通.有些頻道在您的區域內可能會因其他電子裝置而有干擾,選擇最無障礙的頻道來協助效能更好且涵蓋您的無線網路. ",	//help355
"已登入",	//aa_ACR_c6
"次要RADIUS伺服器分享訣竅: ",	//bws_2RSSS
"RADIUS伺服器分享訣竅: ",	//help391
"NTP ",	//help635
"追蹤路由 ",	//help715
"PM ",	//_PM
"網路位址轉譯允許許多私人IP位址連線到網際網路,或另一個網路,透過一個IP位址rough one IP address ",	//help622
"定義這個要執行的網路位址範圍.針對一個單一IP位址,在 <span class='option'>起始</span>和<span class='option'>結束</span>方塊內皆輸入相同的位址.最多有八個範圍可被輸入.<span class='option'>啟用</span> 勾選方塊允許您開啟或停用在清單內特定範圍項目.",	//help174
"PPPoE等候連線逾時,連線失敗",	//PPPOE_EVENT_DISCOVERY_TIMEOUT
"裝置%s, wsetting.wfc:沒有找到檔案 ",	//WCN_LOG_NO_WSETTING
"虛擬私人網路(VPN)",	//help731
"應用程式參數",	//haar_p
"若您不勾選此項目,您會使路由器忽略路由器公用WAN端IP位址<code>ping</code> 指令 ",	//anet_wan_ping_2
"要更新韌體,請依照這些步驟:",	//help878
"已登入",	//LOGGED
"ARP. 用來記憶MAC位址到IP位址所以兩個方向皆可來溝通.",	//help408
"手動設定",	//bwn_RM_2
"RADIUS伺服器分享訣竅 ",	//bws_RSSs
"(GMT+04:00) 巴庫, 第比利斯, 葉里溫",	//up_tz_43
"RTSP ALG 從%v:%u到%v:%u拒絕封包",	//IPRTSPALG_REJECTED_PACKET
"進階協助",	//help1
"SNMP(Simple Network Management Protocol) ",	//help688
"MSN Game Zone ",	//gw_gm_73
"點選任何這些連結或按鈕來帶您至另一個進一步資訊的網站 ",	//hhtsn_intro
"Ping結果 ",	//tsc_pingr
"手動設定上傳(Uplink)速度 ",	//at_UpSp
"有給您電腦cookies偏好的網站資料被存在您電腦上的硬碟 ",	//help465
"子網路遮罩",	//help703
"SSH ",	//help697
"步驟 6 -設定網頁存取登入 ",	//aa_wiz_s1_msg6
"PPTP IP位址 ",	//_PPTPip
"在變更記錄檔後點選此按鈕來讓他們生效且固定.",	//help799
"DTIM是一個倒數計秒的作業,用以告知下一個要接收廣播及多重廣播訊息的用戶端窗口.當無線網路基地台已經為相關的用戶端緩衝儲存了一些廣播流量或是多重廣播訊息時,它就會傳送夾帶有一下DTIM間隔值的DTIM.預設值為1,可設定介於1-255的有效值.  ",	//help185
"(GMT-03:30) 紐芬蘭 ",	//up_tz_17
"您所有的網際網路和網路連線詳細資料會顯示在此頁面,韌體版本也會顯示在此.",	//sd_intro
"上傳",	//tf_Upload
"MAC位址 ",	//help605
"秒",	//tt_Second
"從一個路由器到另一個路由器封包被傳送的行為 ",	//help549
"同時送出和接收資料傳輸",	//help506
"這將會遺失使所有無線設定 ",	//wps_lost
"注意: ",	//help26
"(GMT+02:00) 赫爾辛基, 里加, 塔林 ",	//up_tz_35
"一連串的字元用來認證在網路上對資源的要求",	//help642
"利用此區域來設定您的網路連線類型.有多個連線類型可供選擇: 固定IP, DHCP, PPPoE, PPTP, L2TP. 若您不確定您的連線方式,請聯絡您的網路服務提供者.",	//bwn_intro_ICS
"當啟用時, 此選項會使路由器在每次WAN端介面重新建立時(例如在重新啟動後)自動地測量有用的上行頻寬.",	//help81
"此項目允許您儲存路由器的設定成一個檔案到您的電腦,在執行韌體更新之前請確定已儲存設定. ",	//help833
"您的D-Link路由器包含一個列印伺服器在您的網路允許在多台電腦之間分享一台印表機.從此頁面您可以選擇要啟用的列印通訊協定 .",	//tps_intro3
"自動取得IP位址 ",	//help428
"傳送",	//ss_Sent
"群組金鑰更新間隔l: ",	//help378
"會談(session)金鑰 ",	//help682
"Tribes of Vengeance ",	//gw_gm_80
"上傳成功",	//_uploadgood
"PIN (個人識別碼) ",	//wps_p3_2
"設定執行將會搜尋在您電腦上相容印表機驅動程式,若沒有被找到,您將會被提醒去插入適用於印表機的驅動程式光碟",	//wprn_s3c
"路由器僅提供有限的防火牆保護給DMZ主機.路由器不會轉發一個沒有符合活動中DMZ 會談(session)的TCP封包, 除非它是一個連線建立封包 (SYN). 除了這個有限的保護外,DMZ主機是實際上&quot;防火牆之外&quot;.任何人考慮使用一個DMZ主機應該也考慮在那個DMZ主機系統上執行一個防火牆來提供額外的保護. ",	//haf_dmz_20
"至Apply主選單,選擇系統偏好,選擇網路,且選擇乙太網路介面卡連線至D-Link路由器.選擇乙太網路按鈕且乙太網路識別碼將會被列出,這與MAC位址相同 ",	//help343
"已接收",	//ss_Received
"勾選此項目來透過在澳洲的Telstra BigPond有線寬頻來連線到網路, Telstra BigPond提供數值給 ",	//help263
"30天免費試用",	//_bsecure_free_trial
"韌體更新通知選項",	//tf_FUNO
"為了去存取它或一個網路,一個提供證明給一台伺服器的電子方式 ",	//help492
"Short GI ",	//aw_sgi
"在一個用戶端將被要求重新認證的時間",	//help386
"有幾個可選擇的連線類型: 固定IP, DHCP, PPPoE, PPTP, L2TP. 若您不確定您的連線方式,請與您的網路服務提供者聯絡.注意:若使用PPPoE選項,您將需要確認在您電腦上任何的PPPoE用戶端軟體已經移除或停用",	//help254_ict
"選擇過濾器的方式",	//_aa_wiz_s5_msg1
"確認密碼或金鑰",	//td_VPWK
"分裂 ",	//help526
"Need for Speed 3 ",	//gw_gm_33
"Age of Empires ",	//gw_gm_0
"OSI模型的第三層處理網路上流量的路由 ",	//help631
"MAC位址過濾 ",	//_macfilt
"由製造商指定每張網路介面卡一個獨一無二的硬體識別碼 ",	//help606
"(相容於某些DHCP用戶端 ) ",	//bd_DAB_note
"選擇您想要瀏覽事件的種類",	//help796
"重新啟動電腦且從穩定的儲存裝置中重新載入它的運作軟體或韌體 ",	//help665
"3 pm ",	//tt_time_16
"(GMT-07:00) 亞利桑那州 ",	//up_tz_05
"當您收到一個記錄檔的檔案或透過Email方式做韌體更新通知時此Email地址將會以寄件者的方式出現",	//help861
"選擇服務用的通訊協定",	//help19
"DHCP WAN模式 ",	//bwn_DWM
"ICMP ",	//_ICMP
"此區域列出目前允許的網站 ",	//help148
"當滿檔或在排程中時寄送記錄檔 ",	//help868
"Half Life ",	//gw_gm_22
"密碼",	//_password
"速率評估失敗,因資源很少",	//RATE_ESTIMATOR_RESOURCE_ERROR
"5 am ",	//tt_time_6
"一個標準允許網路裝置去互相發現且設定他們自己成為網路中的一部分",	//help721
"<warn>路由閘道器位址 %v不是在介面的遮罩內 (%v/%v)且將會被停用</warn> ",	//GW_ROUTES_ROUTE_GATEWAY_NOT_IN_SUBNET_WARNING
"若您想要從指定的LAN端電腦來執行限制網路存取的請查看 <strong>啟用存取控制</strong> . ",	//hhac_en
"手動設定",	//int_LWlsWz
"選擇傳輸速率 ",	//at_STR
"HTTPS ",	//gw_vs_2
"八月",	//tt_Aug
"開啟MAC過濾器和拒絕在清單上的電腦去存取網路 ",	//am_FM_4
"步驟 5 - 選擇過濾器 ",	//aa_wiz_s1_msg5
"存取控制",	//ACCESS_CONTROL
"更新動態DNS項目錯誤: %s,請檢查設定,正在停用DynDNS ",	//GW_DYNDNS_HERROR
"UTP ",	//help729
"要開啟的服務埠",	//sps_ports
"無線網路服務提供者",	//help757
"若您沒有在實行中的NTP伺服器選項,您可以在這手動設定時間給您的路由器,或者您可以點選<span class='button_ref'>複製您電腦時間的設定</span>按鈕來從您正在使用的電腦複製時間(確定電腦的時間有正確的被設定) ",	//help851
"您可以從DHCP用戶端清單內 <strong>電腦名稱</strong>的下拉式選單內選擇一台電腦,或您可以手動輸入一個您想開啟特定服務埠的LAN端電腦IP位址 ",	//hhag_20
"這個設備已經被使用了 ",	//aa_alert_7
"DMZ IP位址 ",	//af_DI
"Ping測試傳送 &quot;ping&quot;封包來測試在網路上的一台電腦",	//tsc_pingt_mesg
"潛在因素 ",	//help595
"觀看層級",	//sl_VLevs
"結束時間",	//tsc_EndTime
"一個MAC位址是由網路介面卡製造商指定獨一無二的位址 ",	//help151
"選擇一個遠端管理要開啟的通訊埠",	//hhta_pt
"網路存取控制從%v:%u到 %v:%u (協定 %u)丟棄封包 ",	//GW_INET_ACCESS_DROP_ACCESS_CONTROL
"RIP(Routing Information Protocol)是用來使所有在網路上的路由器同時發生路由表 ",	//help671
"啟用自動頻道掃描 ",	//ebwl_AChan
"WEP(Wired Equivalent Privacy)是給無線網路的安全性應該比得上一個有線網路 . ",	//help747
"電腦名稱",	//bd_CName
"TCP/IP ",	//help707
"若您沒有存在的網路建議您使用預設的設定",	//help305rt
"無效的密碼,請重試一次",	//li_alert_3
"因逾時正在更新動態DNS項目 ",	//GW_DYNDNS_UPDATE_TO
"第四",	//tt_week_4
"所有方向同時傳送資料",	//help451
"日",	//tt_Day
"LAN 乙太網路載波丟失",	//GW_LAN_CARRIER_LOST
"每個可以<strong>允許</strong>或者<strong>拒絕</strong>從WAN端存取",	//hhai_action
"設定精靈會依步驟引導您定義每個存取控制.一個是存取控制的&quot;誰,什麼,何時和如何&quot;--哪些電腦將會被控制影響,什麼網路位址會被控制,何時控制會開始生效,和控制如何執行.您可以定義多個.當您點選下方按鈕時設定精靈即會開啟且當您編輯一個存在的時也會.",	//help121
"利用此區域來配置您D-Link路由器的無線設定,請注意在此區域所做的變更也需要在您的無線用戶端做相同的設定.",	//bwl_Intro_1
"要設定此連線您需要由您的網路服務提供者提供一個使用者名稱和密碼,若您沒有此資料,請聯絡您的網路服務提供者.",	//wwa_msg_set_pppoe
"啟用Raw埠列印 ",	//tps_enraw
"保全服務是由任何網頁瀏覽器管理用整套一致服務來保護您所有電腦很好的方式.包含防毒,防火牆,入侵偵測, 內容過濾, 垃圾信殺手和彈跳視窗阻擋等.任何或所有服務可以用一個低的價格選擇 .",	//_bsecure_security_blurb
"DHCP用戶端清單 ",	//bd_DHCP
"輸入您用來寄送Email的帳號. ",	//help865
"下載",	//help501
"WEP ( Wired Equivalent Privacy)金鑰必須要符合以下指示條文的其中之一 : ",	//wwl_s4_intro_z1
"若有需要的話網路服務提供者會提供此參數,此數值可能會和閘道器IP位址相同. ",	//help280
"DHCP連線 ",	//help775
"BigPond已啟用 ",	//GW_BIGPOND_INIT
"連線",	//_connect
"永遠",	//_always
"(分) ",	//_minutes
"防火牆通訊埠",	//as_IPR_b
"eMule ",	//gw_gm_67
"電子郵件(Email)是透過網際網路傳送電腦儲存的訊息 .",	//help514
"網路存取控制從 %v到 %v (protocol %u)丟棄損壞的封包. ",	//GW_INET_ACCESS_DROP_BAD_PKT
"Dark Reign 2 ",	//gw_gm_12
"從日光節約時間選擇變更的起始時間與結束時間.舉例來說.假設您選擇的日光節約時間起始於月=&quot;十月&quot;, 週=&quot;第三週&quot;, 日=&quot;星期日&quot;且時間=&quot;2 am&quot;,這也就是說&quot;日光節約時間起始於10月第三個星期日的2:00 AM.&quot;",	//help846
"Hexen II ",	//gw_gm_25
"請選擇以下設定方式其中之一後點選下一步來繼續. ",	//wps_KR37
"Gamespy Arcade ",	//gw_gm_76
"可擴展認證協定, Extensible Authentication Protocol(EAP)",	//help512
"系統記錄被IP位址%v瀏覽過 ",	//GW_LOGS_VIEWED
"這是一個介於WAN端電腦和LAN端電腦間所有活動中對話的清單. ",	//hhsa_intro
"當WPA企業型加密方式啟用時,路由器會透過一個遠端的RADIUS伺服器使用 EAP (802.1x)來驗證用戶端. ",	//bws_msg_EAP
"乙太網路最常使用的連線方式.",	//help675
"此區域允許您將您的系統記錄歸檔至一個Syslog伺服器. ",	//help856
"Dir ",	//sa_Dir
"IGMP 多點廣播成員",	//_bln_title_IGMPMemberships
"存取控制清單",	//help399
"網路基礎輸入/輸出 系統, Network Basic Input/Output System(NetBIOS)",	//help626
"L2TP (使用者名稱/ 密碼) ",	//bwn_Mode_L2TP
"星期四 ",	//_Thu
"Ping ",	//_ping
"Beacons是由一個無線路由器傳送的封包給同時發生的無線裝置.指定一個 Beacon期間數值介於20和1000間,預設的數值設為100 毫秒.",	//help184
"選擇對您的安裝運作最好的選項.",	//_worksbest
"達不到的 ",	//_unavailable
"偵測到的檔案系統是不相容的 (FAT32,FAT16,FAT12) ",	//IPFAT_INCOMPATIBLE_FILESYS
"天線",	//help415
"(GMT-08:00)太平洋時間 (美國/加拿大), 提華納 ",	//up_tz_04
"阻擋 從%v:%u到%v:%u進入的TCP封包 因 %s 收到但沒有活動中的連線",	//IPNAT_TCP_BLOCKED_INGRESS_NOT_SYN
"現在啟用系統記錄設定",	//sl_ApplySt
"CHAP authentication challenge received from peer.",	//IPPPPCHAP_CHALLENGE_RECVD
"此區域是您用在存取控制功能時新增網站的地方.",	//help141
"取消 ",	//bd_Revoke
"一個裝置連線您的網路至另一個網路,像是網際網路一樣. ",	//help533
"連線啟用時間",	//_conuptime
"步驟1:偵測印表機",	//wprn_intro3
"確認印表機是開啟的. ",	//wprn_tt4
"無線網路技術啟用普遍存在的溝通. ",	//help383
"從路由器執行ping沒有回應,將會重試.",	//tsc_pingt_msg6
"初啟從LAN 到WAN",	//help821a
"全球資訊網瀏覽器是由微軟創造及提供的",	//help572
"PPPoE收到會談(session)提供 ",	//PPPOE_EVENT_SESSION_OFFER_RECVD
"Myth ",	//gw_gm_30
"若您覺得您自己是一個進階的使用者且曾經有設定過路由器,點選<span class='button_ref'>手動設定</span>來手動輸入所有設定.",	//bi_man
"一個網路的裝置將多個裝置連線在一起. ",	//help557
"混合 (1020-5000, 689) ",	//help60
"資料加密標準",	//help468
"遠端管理通訊埠",	//ta_RAP
"BigPond (澳洲使用者) ",	//bwn_Mode_BigPond
"DST 起始",	//tt_dststart
"目前印表機的狀態將會導致在設定程序中之後列印測試頁失敗",	//wprn_cps2
"當通訊協定為TCP時, SPI會檢查會談(session)位於有效範圍內封包連續數目,丟棄那些沒效連續數目的封包 ",	//help164_1
"由一台電腦傳送一個需求至另一台電腦且由請求的電腦傳輸一個檔案至其他電腦 ",	//help724
"工具程式可以核對特定網路位址的存在且可以接收訊息.工具程式送出一個控制封包到特定位址且等待回應.",	//help648
"請稍候",	//wt_title
"現在寄送Email ",	//sl_emailLog
"無線網路設定",	//bwl_title_1
"BigPond密碼 ",	//bwn_BPP
"重新整理",	//sl_reload
"步驟 1: 為您的無線網路命名",	//wwl_title_s1
"裝置安裝失敗",	//IPDRIVE_MOUNT_FAILED
"網路連線設定精靈",	//int_ConWz
"允許任何WAN端使用者來存取相關的功能.",	//help178
"PPTP(Point-to-Point Tunneling Protocol)是用來在兩個網路間透過網際網路建立VPN通道. ",	//help657
"<code>取消</code>選項在租約清單變滿或快滿的狀況下是可用的,您需要在清單內回復空間給新的項目使用, 且目前有些租約已不再需要.點選<code>取消</code>來刪除給特定LAN端裝置的租約且釋放在租約清單內的一個項目.此動作僅在裝置不再需要租用IP位址時執行,例如它在網路中已被移除.",	//help329
"L2TP區端tunnel 0x%04X已經被斷線 ",	//IPL2TP_TUNNEL_DISCONNECTED
"遠端管理流入封包過濾器 ",	//help830
"The Maximum Transmission Unit (MTU)是一個決定路由器將會傳送到WAN端最大封包長度的參數.若LAN端裝置傳送較大的封包,路由器將會把它們分裂成較小的封包 .較理想是您需要設定這個去符合您ISP連線的MTU值,典型乙太網路連線的值為1500,而PPPoE連線則為1492.若路由器的MTU值設定太高,封包將會被分成碎片.若路由器的MTU值設定太低,路由器將會將封包分碎成不必要的封包且在最後的情況可能某些連線會無法建立.不管在哪個情況,網路效能都會受損害.",	//help294
"(GMT-02:00) 大西洋中部 ",	//up_tz_21
"dBm ",	//help482
"演算法用於加密與認證 ",	//help679
"BigPond登入, 狀態=%d, 伺服器回應=%s ",	//GW_BIGPOND_SUCCESS
"拒絕所有",	//_denyall
"自動分類 ",	//at_AC
"可見的狀態 ",	//bwl_VS
"在此區域您可看見區域網路內有哪些裝置目前正在租用IP位址.  ",	//help327
"(小時) ",	//td_
"要完成設定的程序,精靈現在將會在您的電腦上啟動一個執行檔. ",	//wprn_s2a
"遠端PPTP存取者回應速度慢,可能是連線的問題. ",	//PPTP_EVENT_TUNNEL_WINDOW_TIMEOUT
"傳送電力 ",	//aw_TP
"固定IP位址網路連線類型",	//bwn_SIAICT
"有些應用程式要求多個連線,例如網路遊戲,視訊會議,網路電話和其他,這些應用程式透過NAT(Network Address Translation)運作上有些困難.此區域用來在您路由器內開啟多個服務埠或一個服務埠範圍且透過這些服務埠將資料轉送到在您網路內的一個電腦,您可以用多種格式輸入服務埠: ",	//help57
"啟用DHCP伺服器 ",	//bd_EDSv
"中斷連線中 (請稍候...) ",	//_sdi_s5
"2 am ",	//tt_time_3
"製造商 ",	//wprn_man
"若使用PPPoE的選項,您需要將在您電腦上的任何PPPoE用戶端軟體移除或停用. ",	//bwn_note_clientSW
"(GMT-03:00) 格林蘭島 ",	//up_tz_20
"RIP 從路由器%v拒絕路由%v起因於低系統資源",	//RIP_LOW_RESOURCES
"服務名稱:",	//help266
"已連線",	//CONNECTED
"若您的網路服務提供者已指定一組固定的IP給您請選擇此項目.網路服務提供者會提供以下欄位的數值: ",	//help265_5
"天",	//tsc_Days
"新裝置用以連接以及與舊裝置之間的向下相容性保證能力。 ",	//help431
"(GMT-05:00) 印第安納州 (東部) ",	//up_tz_13
"一般",	//sd_General
"UPnP功能協助其他LAN端主機和路由器互相作用,將UPnP選項啟用只要LAN端有其他UPnP應用程式. ",	//hhan_upnp
"和您公司網路的系統管理員確認是否您的VPN用戶端有支援NAT traversal. ",	//help35
"在您的內部網路中系統的IP位址將會提供虛擬伺服器,例如<code>192.168.0.50</code>",	//help18
"印表機設定精靈",	//bwz_psw
"日期和時間",	//tt_DaT
"排程可以被建立來使用強制.例如,若您想要限制從星期一到星期五下午3點到8點去存取網頁,您可以建立一個排程選擇星期一,星期二,星期三,星期四,星期五且開始時間為下午3點,結束時間為下午8點.",	//help190
"SYN 傳送 -- 系統之一正在嘗試去開始一個連線",	//help819_2
"電氣電子工程師協會IEEE(Institute of Electrical and Electronics Engineers) ",	//help560
"最大閒置時間",	//bwn_MIT
"給每個一個<strong>名稱</strong>是對您來說有意義的. ",	//hhai_name
"當系統記錄存滿或在排程中時寄送系統記錄檔",	//te__title_EmLog
"WCN(Windows Connect Now). 一個微軟用來設定和連接無線網路設備(AP)和無線用戶端的方式,包含電腦和其他裝置.",	//help742
"(GMT+05:30) 加爾各答, 辰內, 孟買, 新德里 ",	//up_tz_47
"傳輸資料的寬頻可用頻率",	//help449
"SMTP在寄件者/收件者對話時失敗  ",	//IPSMTPCLIENT_DIALOG_FAILED
"點選<strong>清除</strong>按鈕來從MAC過濾清單中移除MAC位址. ",	//hham_del
"若您的網路服務提供者沒有被列出或您不知道是誰提供服務,請在以下選擇網路類型 : ",	//wwa_msg_ispnot
"封包被傳送時被丟棄的數量,  起因於錯誤,衝突或路由器資源限制. ",	//help808
"嘗試去建立一個PPTP連線 ",	//PPTP_EVENT_TUNNEL_ESTABLISH_REQUEST
"支援在LAN端電腦使用 Microsoft Windows Messenger(微軟Windows內建的網路訊息用戶端)和MSN.當Windows Messenger ALG啟用時SIP ALG也必須被啟用.",	//help37
"WCN功能要求重新啟動 ",	//WCN_LOG_REBOOT
"PPTP連線嘗試失敗,請檢查遠端PPTP伺服器詳細資料.",	//PPTP_EVENT_TUNNEL_CONNECT_FAIL
"頻道寬度",	//bwl_CWM
"(GMT-05:00) 東部時間 (美國/加拿大) ",	//up_tz_12
"IKE ",	//help565
"啟用UPnP ",	//ta_EUPNP
"取消",	//_cancel
"整合資訊以便它可以被管理更新,而且容易被使用者或應用程式存取. ",	//help473
"啟用DNS 中繼轉送 ",	//bln_EnDNSRelay
"(GMT+03:00) 科威特, 利雅德 ",	//up_tz_38
"DTIM間隔 ",	//aw_DI
"(GMT+02:00) 雅典, 伊斯坦堡, 明斯克 ",	//up_tz_31
"點選<strong>刪除</strong> 在清單內的圖示來永遠移除一個. ",	//hhai_delete
"正嘗試去重新連結WAN端連線",	//GW_WAN_RECONNECT_ALWAYS_ON
"虛擬伺服器允許您在您的路由器上定義一個單一公用服務埠來轉向到一個內部LAN IP位址和私人LAN服務埠.此功能對於線上服務如FTP或WEB伺服器來說是很實用的.",	//av_intro_vs
"進入",	//INGRESS
"無線安全金鑰",	//wwl_WSP
"受限的",	//RESTRICTED
"Legacy ",	//help599
"若您的網路服務提供者(ISP)未提供您IP位址的資料或使用者名稱和密碼時使用此種網路連線類型. ",	//bwn_msg_DHCPDesc
"啟用遠端管理者來允許您透過網路在任何地方去管理路由器.停用遠端管理者則只能允許您從區網的電腦來管理路由器.  ",	//help828
"此服務埠是用來連線到認證伺服器",	//help390
"重新輸入和帳戶有關的密碼",	//help867
"正嘗試去開始WAN端連線",	//GW_WAN_CONNECT_ALWAYS_ON
"通訊埠轉送欄位 ",	//help60f
"IPX ",	//help585
"Counter Strike ",	//gw_gm_10
"(分, 0=永遠啟用) ",	//bwn_min
"同時傳送及接收資料",	//help530
"月",	//tt_Month
"NetBEUI ",	//help623
"使用WPA加密來代替WEP(WPA加密比WEP方式嚴謹且所有D-Link無線網卡皆支援WPA加密方式) ",	//wwz_wpa_support
"現行韌體日期",	//tf_CFWD
"進階網路",	//_advnetwork
"PPPOE網路連線類型 ",	//bwn_PPPOEICT
"若您的位置有日光節約時間請選擇時間補償",	//help844
"RADIUS伺服器連接埠t: ",	//help389
"4 pm ",	//tt_time_17
"L2TP (Layer Two Tunneling Protocol) 利用一個虛擬私人網路來連線到您的ISP.這種連線方式會要求您輸入一個<span class='option'>使用者名稱</span> 和 <span class='option'>密碼</span> (由您的網路服務提供者提供) 來存取到網際網路. ",	//help284
"無線系統和MAC位址 %m的組合 ",	//GW_WIRELESS_DEVICE_ASSOCIATED
"次要MAC位址認證",	//bws_2RMAA
"SIP ",	//as_SIP
"Syslog",	//help704
"WLAN ",	//help758
"(GMT) 格林威治時間: 都柏林, 愛丁保, 里斯本, 倫敦 ",	//up_tz_25
"NIC ",	//help634
"以上範例應用程式已啟用的情況下,路由器將會從網路開啟一個從6000-6200的範圍服務埠給進入的流量,不論何時任何在內部網路的電腦開啟一個應用程式使用一個在6500-6700範圍內的服務埠傳送資料到網路. ",	//help55
"無線連線已連線 ",	//GW_WLAN_LINK_UP
"您LAN端連線到的較大網路,可能是網際網路本身,或是一個地區或公司網路. ",	//help752
"啟用動態DNS (DDNS)",	//td_EnDDNS
"網際網路協定安全,Internet Protocol Security(IPSec)",	//help575
"流入封包過濾器",	//ai_title_IFR
"PPTP ",	//_PPTP
"兩者皆是",	//_both
"(GMT+03:00) 奈洛比 ",	//up_tz_40
"拔除再重新插入印表機的USB連接線  ",	//wprn_tt8
"停用軟體重置功能 ",	//tps_dsr
"其他設備",	//_aa_other_machines
"廣播",	//help450
"這會重新啟動路由器,當您不在路由器旁時可用此重新啟動路由器.",	//help875
"網站過濾參數 ",	//awsf_p
"-精確的5或13個字元",	//wwl_s4_intro_z2
"實體層",	//help645
"要設定這個連線您需從您的網路服務提供者取得一個使用者名稱和密碼 ,您也需要L2TP IP位址,若您沒有這些資料,請聯絡您的網路服務提供者. ",	//wwa_set_l2tp_msg
"(GMT+04:00) 阿布達比, 馬斯喀特 ",	//up_tz_42
"錯誤",	//_error
"目的地 IP<br />結束 ",	//aa_FPR_c4
"利用左方的勾選方塊來啟用或停用定義好的",	//help75a
"無效的區域網路位址,IP位址在DHCP的範圍內",	//network_dhcp_ip_in_server
"您必須使用實體網路線連接至路由器來執行韌體更新.輸入更新韌體的檔案名稱再點選上傳按鈕.",	//tf_msg_wired
"在上方輸入一個主機名稱或IP位址再點選「ping」按鈕",	//tsc_pingt_msg1
"設定使用者名稱和密碼連線(PPPoE) ",	//wwa_title_set_pppoe
"在特殊情況下其他選項是可用的 ",	//bwl_CWM_h2
"線上檢查",	//help884
"重新啟動中",	//rb_Rebooting
"時間等待 -- 當連線在FIN等待被完全關閉時短時間的等待",	//help819_6
"9 am ",	//tt_time_10
"此區域顯示目前已定義的排程.排程可以用點選編輯圖示來做變更,或點選刪除圖示來刪除.當您點選編輯圖示時,那個項目會反白,且&quot;編輯排程&quot;區域會準備好被編輯.",	//help199
"一個當您的路由器從ISP的伺服器要求一個時ISP指派您的IP位址地方的連線方式,有些ISP在您的路由器可以連線到網際網路之前會要求您去做一些設定.",	//help259
"應用程式等級閘道Application Level Gateway (ALG)設定",	//af_algconfig
"PPTP用戶端 ",	//wwa_msg_pptp
"次要RADIUS伺服器IP位址 ",	//bws_2RIPA
"步驟 3: 選擇設備 ",	//_aa_wiz_s4_title
"注意: 您可能也需要提供一個服務名稱.若您沒有或不知道此資料,請聯絡您的網路服務提供者.",	//wwa_note_svcn
"偵測 xDSL 或Frame Relay網路 ",	//help85
"若您需要變更路由器WAN端介面的MAC位址,可以輸入一組可替換的MAC位址(例如,路由器最初連線到ISP的MAC位址),或者複製一台電腦的MAC位址.要複製最初連線到ISP那台電腦的MAC位址,利用那台電腦連線到D-Link路由器且點選 <span class='button_ref'>複製您電腦的IP位址</span> 的按鈕,則WAN端介面將會使用在您電腦內網卡的MAC位址.",	//help304
"BigPond狀態 ",	//sd_BPSt
"(GMT+06:00) 阿馬堤, 諾曼斯比爾斯科 ",	//up_tz_49
"World of Warcraft ",	//gw_gm_62
"BigPond登出 ",	//BIGPOND_LOGGED_OUT
"更新韌體版本的Email通知",	//tf_EmNew
"MAC位址%m的網路存取無法被設定",	//GW_INET_ACCESS_INITIAL_MAC_FAIL
"MAC位址: ",	//help303
"沒有列出或未知",	//wwa_selectisp_not
"阻擋流出TCP 封包,從 %v:%u 到 %v:%u；與意外的認可 %lu (預計 %lu 到 %lu)",	//IPNAT_TCP_BLOCKED_EGRESS_BAD_ACK
"適用於這邊的LAN 端通訊埠範圍設定,以確定這個範圍內的訊息傳遞.",	//help94
"Xbox Live",	//gw_gm_70
"丟棄 ICMP 封包,從 %v 到 %v 因無法控制的封包表頭",	//IPNAT_ICMP_UNABLE_TO_HANDLE_HEADER
"FTP",	//_FTP
"NAT 終點過濾",	//_neft
"當兩個裝置位於同一乙太網路中同時強制嘗試傳輸資料.",	//help463
"管理",	//ta_A12n
"D-Link DVC-1000",	//gw_gm_83
"BigPond 登出",	//GW_BIGPOND_LOGOUT
"應用程式使用於當路由器判斷資料傳送到網際網路時使用到”觸發”通訊埠或觸發通訊埠範圍時,開啟路由器的單一或多重通訊埠(但觸發與開啟通訊埠都是由使用者定義).應用程式適用於所有位於網際網路的電腦.",	//help46
"頻繁的檢查系統記錄,以查出未經授權的網路使用.",	//hhsl_intro
"幫助工具",	//help770
"要設定這個連線您還從網際網路服務提供業者索取得的使用者名稱及密碼.您還需要PPTP IP 位址.如果您不知道這些資訊,請聯絡您的ISP.",	//wwa_msg_set_pptp
"無法解析韌體更新伺服器 %s 的DNS 記錄",	//GW_FW_NOTIFY_FAILED_DNS
"Rainbow Six: Raven Shield",	//gw_gm_40
"位址解析協定",	//help407
"路由器使用IGMP 協定以支援高效率多點廣播 -- 在同一個內容中進行傳輸,像多媒體資訊內容,從一個來源到接收群組中.",	//bln_IGMP_title_h
"只有供有要求的國家使用 <strong>802.11d</strong> 功能.",	//hhaw_11d
"如果不是的話,請按下取消按鈕,然後按下儲存設定.",	//up_jt_2
" %s 已起始; 網際網路存取MAC 位址 %s 變更為: %s",	//GW_INET_ACCESS_POLICY_START_MAC
"一個應用程式,它允取您存取位於網站上的資源以及提供這些給您統計圖表.",	//help453
"如果您的網際網路連線要求輸入使用這名稱及密碼以取得連線的話,請選擇這個項目；大部分的xDSL 數據機都使用此種類的連線.",	//wwa_msg_pppoe
"假設您設定DHCP 伺服器的位址發放範圍從192.168.0.100 到 192.168.0.199,這代表位址192.168.0.3 到 192.168.0.99 以及192.168.0.200 到 192.168.0.254 不在DHCP伺服器位址發放的範圍內.電腦或裝置要使用這些IP位址的話就需要手動在本機設定.假設您有一台WEB伺服器電腦已經手動設定IP位址為192.168.0.100.因為這個位址在&quot;發放範圍&quot;之中,所以請確定已新增一個保留位址供這個位址及合適的電腦使用(請查看以下的<a href='#Static_DHCP'>靜態DHCP 用戶端</a>).",	//help323
" &quot;管理者&quot;及 &quot;使用者&quot;帳號都可以存取裝置管理界面,但只有 &quot;管理者&quot;有完整的讀/寫 權限及變更密碼,使用者 只有唯讀權限.",	//ta_intro1
"IGMP",	//help561
"Bit/sec",	//help442
"第三",	//tt_week_3
"DHCP 伺服器",	//_dhcpsrv
"使用數位用戶迴路(DSL)技術的連線方式通稱,包含ADSL, HDSL, RADSL,及 SDSL.",	//help762
"啟用",	//_enabled
"一個或更多的網際網路存取被使用中,網際網路的存取將被受限於這些已定義的下.",	//GW_INET_ACCESS_RESTRICTED
"WON Servers ",	//gw_gm_69
"過濾",	//aa_ACR_c5
"這個選項讓您得以設定保留IP位址,以及指派位於區域網路端的裝置以定義的MAC 位址為基礎,在此MAC任何時間要求下都發放同一個IP位址.這幾乎與當裝置設定為靜態IP位址時一樣,但是該裝置還是需要跟D-Link路由器要求取得一個IP位址(啟用DHCP取得IP位址).DHCP 保留功能對於有在區域網路端架設伺服器(例如Web及FTP伺服器)的使用者來說相當有用,不過伺服器的IP位址設定還是可以選擇使用此功能取得一個固定IP,或使由使用者自行指定.",	//help331
"某些使用設定精靈所作的變更,會要求您變更一些相對的無線網路卡端設定,這樣才可以繼續與D-Link 無線路由器無線連結.",	//bwz_note_WlsWz
"您可以指派一個名稱給每個有給予保留IP 位址的電腦.這可以幫助您記錄哪些電腦[在保留的IP位址設定中.",	//help345
"按下 <strong>應用程式名稱</strong> 下拉選單,以列出預先定義的伺服器類型,並選擇您所需的伺服器類型.選擇後相關的設定欄位內容將自動被填上.",	//hhav_name
"私用通訊埠",	//av_PriP
"% 遺失",	//tsc_pingt_msg103
"透過使用超文件傳輸協定,HTTP 伺服器(WEB伺服器)能夠將檔案傳輸至HTTP 用戶端(WEB 瀏覽器).",	//help553
"如果您需要使用UPnP 功能,您可以在這邊啟用它.",	//help_upnp_2
"錯誤的WAN 連接模式",	//WAN_MODE_INCORRECT
"Kbps",	//help590
"WEP 金鑰必須輸入滿 5個由字母或數字組成的字元(ASCII).",	//wwl_alert_pv5_2_5
"每秒兆位元(Megabits)",	//help608
"步驟 4: 選擇過濾方式",	//_aa_wiz_s5_title
"無效的 PIN 數值.",	//KR22_ww
"定義一個以禁止存取特定的IP 位址及通訊埠.",	//_aa_wiz_s7_help
"區域端會談(session) 0x%04X,L2TP會談(session)伺服器停止傳送排序數值",	//IPL2TP_SEQUENCING_DEACTIVATED
"印表機進階設定",	//tps_apc
"(GMT-06:00) 墨西哥市",	//up_tz_09
"七月",	//tt_Jul
"WAN 實體介面已中斷",	//GW_WAN_INTERFACE_DOWN
"回復無線設定值",	//WCN_LOG_RESTORE
"Everquest",	//gw_gm_17
"進階加密標準",	//help411
"DNS",	//gw_vs_4
"網際網路存取 IP 位址 %v 開始: %s",	//GW_INET_ACCESS_INITIAL_IP
"十六進位",	//help546
"您確定要放棄透過這個精靈所做的所有變更?",	//_wizquit
"系統設定項目允許您可以重新啟動裝置,或是將路由器設定值回復為出廠預設值.回復為出廠預設值會清空所有的設定,包含您之前新增的所有規則.",	//tss_intro
"終點獨立",	//af_EFT_0
"當您設定 <span class='option'>啟用DHCP 伺服器</span> 時,下面的其他選項將顯示出來.",	//help318
"SysLog 功能選項允許您傳送系統記錄資訊至您的Syslog 伺服器上.",	//tsl_intro
"3 am",	//tt_time_4
"當這個選項被啟用,路由器將限制對外流量的傳遞不超過WAN端上傳的頻寬.",	//KR107
"8 pm",	//tt_time_21
"碎裂化(Fragmentation)門檻",	//aw_FT
"L2TP區域端會談(session) 0x%04X 已連結",	//IPL2TP_SESSION_CONNECTED
"儲存",	//_save
"不判斷",	//at_NEst
"當您的電腦有更新的韌體檔案時,您可以使用這個選項來瀏覽該檔案已將其更新至路由器中.",	//help888
"網路上的邏輯通道終點.一台電腦可能擁有唯一的實體傳輸通道(實體乙太網路傳輸通道),但是卻可以有多重的通訊埠(邏輯通道)以各自的通訊埠號做辨識.",	//help653
"分貝相對等向輻射體(Decibels relative to isotropic radiator)",	//help481
"Anti-Spoof 檢查",	//KR105
"韌體",	//_firmware
"Rogue Spear",	//gw_gm_43
"請開始無線裝置的WPS功能,以新增至您的無線網路",	//wps_messgae1_1
"L2TP 區域端通道 0x%04X RTE 模組已經關閉停止.",	//IPL2TP_SHUTDOWN_STARTED
"TX 丟棄封包",	//ss_TXPD
"(GMT+08:00) 北京, 北韓, 香港, 烏拉圭 ",	//up_tz_55
"如果您要繼續進行路由器的安全密碼及時區設定,請按下&quot;下一步&quot;按鈕.",	//wwa_intro_online2
"選擇流出封包通訊協定以供您的應用程式使用(例如: <code>Both</code>).",	//help50
"輸入欲開啟的UDP 通訊埠 (例如: <code>6159-6180, 99</code>).",	//help70
"DHCP 保留位址",	//bd_title_SDC
"加密",	//wwl_enc
"(GMT+09:00) 大阪, 札幌, 東京",	//up_tz_60
"Ultima",	//gw_gm_54
"管理者登出",	//GW_ADMIN_LOGOUT
"非必要的備份 RADIUS 伺服器",	//bws_ORAD
"Serious Sam II",	//gw_gm_44
"啟用裝置 WAN 端Ping 回應",	//bwn_RPing
"若有位於LAN端多點廣播群組應用程式,這個選項必須被啟用.如果您有一個多媒體LAN 應用程式沒有接收到預期中的內容的話,請嘗試啟用這個選項.",	//igmp_e_h
"全雙工",	//help529
"訊號衰退(Attenuation)",	//help425
"ACL,網路裝置中允許存取網路資源的資料庫.",	//help400
"從路由器所傳送的封包數量.",	//help806
"輸入由您所使用的應用程式流出通訊埠範圍 (例如: <code>6500-6700</code>).",	//help49
"例如: ",	//help367
"動態IP 位址",	//help509
"Links",	//gw_gm_28
"Windows Me",	//help337
"管理者設定",	//ta_AdmSt
"(GMT-06:00) 中央時間 (美國/加拿大)",	//up_tz_08
"SysLog",	//_syslog
"如果這被選擇使用,無論什麼時候使用者都必需從同一台電腦登入無線網路.",	//help394
"步驟 5: 通訊埠過濾",	//_aa_wiz_s7_title
"時間設定選項允許您網際網路系統時間的設定,更新及維持正確的時間.從這個項目中您可以設定您所在的時區,以及設定NTP(網路時間協定)伺服器.日光節約時間可以被設定為當您需要時自動調節.",	//tt_intro_Time
"動態DNS 記錄更新失敗:%s.稍後重試.",	//GW_DYNDNS_SERROR
"DHCP",	//_DHCP
"備註:所有的D-Link 無線網路卡目前都支援WPA 安全加密功能.",	//wwl_s3_note_2
"TCP Raw",	//help709
"啟用 BigPond:",	//help262
"通訊埠",	//sps_port
"不管將SPI 啟用或停用,路由器總是會追蹤TCP 連線的狀態及確定哪個TCP 封包標誌在現行狀態中是可信賴的.",	//help164_2
"等候路由器重新啟動.這可能需要幾分鐘的時間.",	//help881
"目的地 IP",	//_destip
"時間設定選項允許您路由器網際網路系統時間的設定,更新及維持正確的時間.從這個項目中您可以設定您所在的時區,以及設定NTP(網路時間協定)伺服器.日光節約時間可以被設定為當您需要時自動調節.",	//help840
"日光節約日期",	//tt_dsdates
"L2TP 伺服器IP 位址 (也許跟通訊閘位址相同)",	//wwa_l2tp_svra
"請注意L2TP VPN 連線通常都使用IPsec 以讓連線更安全.要完成多重VPN 透通的話IPSec ALG必需被啟用.",	//help34b
"10 am",	//tt_time_11
"啟用Email警告",	//te_EnEmN
"用戶端實際傳輸速率為每秒兆位元組(megabits).",	//help786
"使用者名稱",	//bwn_UN
"這個名稱已經被使用.",	//aa_alert_8
"萬用隨插即用(UPnP)",	//help720
"啟用裝置遠端管理",	//ta_ERM
"LCP sets 遠端認證: %04x",	//IPPPPLCP_SET_REMOTE_AUTH
"萬用串列匯流排(USB)",	//help728
"L2TP 區域端通道 0x%04X RTE 模組嚴重超時 - 遠端伺服器沒有回應.",	//IPL2TP_FATAL_TIMEOUT
"<strong>非 UDP/TCP/ICMP LAN 端會談(session)</strong> 通常為啟用.這將對遠端主機單一VPN 連線有所幫助.",	//hhaf_ngss
"網路設定",	//bln_title_NetSt
"流量類型",	//av_traftype
"這已經被轉譯成二進位資訊,所以這可以被處理或移動到另外的裝置.",	//help467
"PPTP (使用者名稱 / 密碼)",	//bwn_Mode_PPTP
"這個項目顯示出現行已定義的存取控制.按下編輯圖示後,可以被變更的內容,或是按下刪除圖示以刪除它.當您按下編輯圖示後,設定精靈將開始引導您變更的程序.您也可以透過勾選或不勾選 “啟用”方框,以決定是否啟用或停用已經定義完成的.",	//help140
"所有有關WAN 端及LAN 端連線的詳細資訊都會被顯示在這邊.",	//hhsd_intro
"必要的列印通訊協定被停用",	//wprn_rppd
"假設您的線上遊戲伺服器主機在電腦上執行,使用的私有IP位址為192.168.0.50.這個遊戲要求您必須在路由器上開啟多重的通訊埠(6159-6180, 99)後,網際網路端的使用者才可以連線.",	//help63
"請按下無線裝置的Push 按鈕(實體的或虛擬的皆可),您就可以新增該裝置至您的無線網路中",	//wps_messgae1_2
"新的設定值已經被裝置套用.",	//ap_intro_sv
"L2TP子網路遮罩",	//_L2TPsubnet
"裝置重新啟動前寄出系統記錄Email",	//GW_LOG_EMAIL_BEFORE_REBOOT
"所有的",	//at_Any
"下面的設定項目對所有的WAN 端模式發生作用.",	//help288
"除非這其中之一的加密模式已經被選取,否則您的無線網路封包的傳遞內容將可以被未經授權的使用者輕易的擷取並解譯.",	//bws_SM_h1
"在這邊的過濾清單以外,兩個可用的預先定義的過濾在任何的流入封包過濾功能中都可以被套用.",	//help177
"(GMT+05:00) 伊斯蘭馬巴德, 喀拉蚩港, 塔什干",	//up_tz_46
"請稍後 <span id='show_sec'></span>&nbsp;秒.",	//rb_wait
"單一傳送者及接收者之間的通訊",	//help719
"阻擋封包從 %v 到 %v (LAND 攻擊)",	//IPSTACK_REJECTED_LAND_ATTACK
"無線網路名稱(SSID)",	//bwl_NN
"區域網路",	//help594
"L2TP 區域端會談(session) 0x%04X 連結嘗試失敗",	//IPL2TP_SESSION_CONNECT_FAIL
"Final Fantasy XI (PS2)",	//gw_gm_21
"最佳的",	//wwl_BEST
"支援",	//_support
"您無法新增IP位址.您只可以從別的中重新使用IP位址.",	//aa_alert_14
"實體纜線狀態",	//_cablestate
"動態主機設定協定(DHCP)；您可以在DHCP 選項這邊設定內建的DHCP 伺服器功能,以分派IP位址給位於區域網路(LAN)端的電腦或其他網路裝置.",	//help314
"新增無線裝置及WPS (WI-FI 保護設定)設定精靈",	//wps_LW13
"緊急",	//sl_Critical
"系統系統記錄無活動",	//SYSTEM_LOG_INACTIVE
"新的裝置設定值已經被儲存.",	//sc_intro_sv
"我的網際網路連線為",	//bwn_mici
"如果路由器因為任何原因而關閉電源的話,這將造成時間設定無法維持,而且在設備啟動之後無法顯示正確的時間.要保持正確的排程及系統記錄時間,請確定您必需在路由器重新啟動之後輸入正確的時間,或啟用NTP 網路時間伺服器選項.",	//help852
"分鐘",	//gw_mins
"在",	//_In
"一個PC Card 或PCMCIA介面的新版本.它支援32位元資料路徑,DMA 及較少的消耗電力.",	//help457
"如果您要透過Email依照排程寄送系統記錄,請選擇這個選項.",	//help870
"防火牆及安全",	//help797
"MSN Game Zone (DX)",	//gw_gm_74
"Rainbow Six",	//gw_gm_39
"會合(Rendezvous)",	//help666
"WEP 金鑰必須輸入滿10個16進位數值(輸入範圍為0-9,A-F).",	//wwl_alert_pv5_3_10
"MAC 位址過濾選項使用在以設備網路卡的唯一MAC 位址為基礎以過濾它們的網路存取動作.",	//help149
"如果您要嘗試執行一個表列的網路應用程式但是卻無法順利執行的話,請使用這個功能.",	//hhpt_intro
"WAN 實體介面纜線已經連結",	//GW_WAN_CARRIER_DETECTED
"Secure Shell是一個命令列介面,允許您安全的連結遠端電腦主機.",	//help698
"BigPond 使用者標誌",	//bwn_BPU
"圖形使用者介面(GUI)",	//help538
"如果您要這個排程套用在選擇的日期中整天使用的話,請選擇這個項目.",	//help195
"連結可信賴種類及狀態逾時起始值.",	//help823_1
"網際網路連結",	//_internetc
"辨識到",	//tsc_pingt_msg5
"輸入一個對您有意義的名稱以供辨識這個.",	//help172
"觸發",	//_trigger
"無線用戶端乙太網路辨識碼 (MAC 位址).",	//help783
"通訊閘將不被編程.",	//ub_intro_2
"為了安全上的考量,建議您變更管理者及使用者帳戶的密碼.並確定已記下新的密碼以免您日後忘記.",	//hhta_pw
"狀態幫助",	//help771
"步驟 6: 設定Web 存取事件記錄",	//_aa_wiz_s8_title
"可以任一選擇允許或拒絕訊息.",	//help173
"Syslog伺服器IP 位址",	//tsl_SLSIPA
"新增通訊埠過濾",	//_aa_wiz_s7_msg
"12 pm ",	//tt_time_13
"(GMT+10:00) 關島, 摩爾斯比港",	//up_tz_67
"主要的DNS伺服器, 次要的DNS伺服器 ",	//help289a
"BigPond 已登入 ",	//BIGPOND_LOGGED_IN
"網路層 ",	//help630
"當LAN端主機被放置到DMZ時, 它成為所有不符合其他流入會談(session)或的封包目的地. 如果任何其他進入的是適當的, 將會被用來取代傳送封包到DMZ主機; 所以,一條有效的會談(session) 虛擬伺服器, 有效的觸發埠, 或通訊埠轉送將會取得優先權傳送封包到DMZ主機. (DMZ類似一個預設的通訊埠轉送,轉送所有沒有特定指向的埠) ",	//haf_dmz_10
"使用TCP通訊協定的連線狀態 ",	//help819
"TCP 通訊埠 ",	//sps_tcpport
"如果progress bar沒有出現, 執行檔沒有啟動並且設定沒有完成. 請參考下方的除錯秘訣.",	//wprn_s3b
"OSI模型的第七層. 提供服務給應用程式並保證他們在網路上可以和其他應用程式適當地互相溝通. ",	//help422
"網站過濾器 ",	//_websfilter
"BigPond 服務名稱 ",	//sd_BPSN
"使用者密碼 ",	//_password_user
"%s 政策停止; 對IP位址%v的網路存取已變更: %s ",	//GW_INET_ACCESS_POLICY_END_IP
"選擇路由器使用的模式連接到網際網路. ",	//bwn_msg_Modes
"IP位址 ' + mf.dmz_address.value + ' 是無效的. ",	//up_gX_1
"下一步 ",	//_next
"設定 ",	//_setup
"持續地ping主機位址直到您按下這個按鈕. ",	//htsc_pingt_s
"Email ",	//EMAIL
"Direct Sequence Spread Spectrum (直接序列展頻) ",	//help493
"模式 ",	//_mode
"二月 ",	//tt_Feb
"使用此資訊來設定您電腦的raw TCP通訊埠列印. ",	//sps_raw1
"%s的動態DNS更新成功 ",	//GW_DYNDNS_SUCCESS
"IGMP router 由於系統資源太低已經拒絕群組%v. ",	//IGMP_ROUTER_LOW_RESOURCES
"&quot;自動 20/40 MHz&quot;最佳建議使用. ",	//bwl_CWM_h1
"(GMT+03:00) 莫斯科, 聖彼得堡, 伏爾加格勒",	//up_tz_39
"允許設備和應用程式使用VoIP (Voice over IP)穿過NAT互相溝通. 有些VoIP應用程式和設備能夠找到NAT裝置並且繞過他們運作. ALG 可以干擾這些設備的運作. 如果您在撥打VoIP電話遇到問題時, 嘗試關閉ALG功能. ",	//help40
"為D-Link 的免費DDNS服務簽名 ",	//td_intro_DDNS_DLINK
"通訊埠轉送 ",	//_pf
"MAC位址 %m 對網際網路的存取設置: %s ",	//GW_INET_ACCESS_INITIAL_MAC
"CHAP 驗證成功. ",	//IPPPPCHAP_AUTH_SUCCESS
"通常無線發射台使用100% 的功率運作. 在某些情況下, 可能會有隔離特定頻率的小部份區域需求. 藉由降低無線電波的功率, 您可以防止訊號傳送到越過公司/家用辦公室或特定的無線區域. ",	//help187
"阻擋所有存取 ",	//_aa_block_all
"無線網路連線中斷 ",	//GW_WLAN_LINK_DOWN
"在廣播和多點廣播的資料使用group key之前的總時間已變更.",	//help379
"(GMT+11:00) 馬加丹, 所羅門群島, 新卡倫多尼亞 ",	//up_tz_70
"動態DNS服務 ",	//help507
"此頁面不包含在路由器的允許網站清單內. ",	//fb_p_2
"網頁瀏覽器 ",	//help571
"印表機狀態 ",	//sps_ps
"評估速率失敗如同測量值整合失敗 ",	//RATE_ESTIMATOR_CONVERGENCE_ERROR
"您必須設定路由器允許軟體應用程式在網路上的任何電腦執行, 連接到 web介面的伺服器或網路上的其他使用者. ",	//help47
"5 pm ",	//tt_time_18
"步驟 4: 儲存設定和連線 ",	//wwa_title_s4
"啟用此功能時, 路由器的活動紀錄或韌體更新通知將被email到指定的email信箱, 並顯示下列參數. ",	//help860
"網路連線設定精靈已經完成. 按下連線按鈕以儲存設定並重新啟動路由器. ",	//wwa_intro_s4
"當沒有使用者輸入數值或設定時, 程式將使用預定的數值或設定. ",	//help487
"有些ISP會要求您輸 入服務名稱. 請在ISP要求時再輸入服務名稱.  ",	//help267
"L2TP 本地會談(session) 0x%04X 中止 ",	//IPL2TP_SESSION_ABORTED
"此部分允許您管理路由器的設定, 重新啟動路由器, 和載入原廠預設值. 將設備回復原廠預設值會清除所有設定, 包含您之前新增的所有.  ",	//help874
"九月 ",	//tt_Sep
"無法處理封包標頭時, 停止從%v到%v的ESP封包 ",	//IPSEC_ALG_ESP_UNABLE_TO_HANDLE_HEADER
"NetBIOS Extended User Interface是區域網路互相溝通的通訊協定. 它是NetBIOS的更新版本 ",	//help624
"Group Key更新間隔 ",	//bws_GKUI
"啟用<strong>WMM</strong> 能幫助控制當透過無線網路傳送多媒體內容時的等待時間和跳動. ",	//hhaw_wmm
"這樣, 您可以使用流入封包過濾器限制開放給您信任的網際網路IP位址透過開啟的通訊埠存取區域網路. 例如, 您可以只允許讓你邀請來玩線上遊戲的朋友電腦存取您家裡LAN端的遊戲伺服器.",	//help168c
"BigPond 登入中 ",	//BIGPOND_LOGGING_IN
"使用者名稱 / 密碼連線 (PPTP) ",	//wwa_wanmode_pptp
"資料無法同時傳送和接收 ",	//help543
"Service Set Identifier(SSID)為無線網路的名稱 ",	//help700
"範圍 (50-100) ",	//help58
"此項目是檢查D-Link的技術支援網站確認是否有最新版韌體. 如果有新版韌體, 將會顯示下載說明. ",	//help885
"已連線 ",	//ddns_connected
"上傳失敗",	//ub_Upload_Failed
"PPTP (點對點通道協定Point to Point Tunneling Protocol) 透過虛擬網路連接到ISP. 這種連線方式主要用於歐洲地區. 這種連線方式需要輸入 <span class='option'>使用者名稱</span>和<span class='option'>密碼</span> (由您的ISP提供)才能取得網際網路連線. ",	//help278
"用戶端 ",	//help460
"A System Logger (syslog) 將不同來源的系統記錄訊息集中在同一個地方的伺服器. 如果LAN端已經有syslog伺服器, 您可使用此功能將路由器的系統記錄傳送到伺服器上.",	//hhts_def
"輸入目標電腦的IP位址或完整合格的網域名稱. ",	//htsc_pingt_h
"當您的ISP提供您一組不會變動的IP位址. IP資訊要手動輸入到IP設定裡. 您必須輸入  ",	//help255
"次要的 RADIUS 伺服器通訊埠 ",	//bws_2RSP
"輸入私人通訊埠 [80] ",	//help7
"可見的 ",	//bwl_VS_0
"TCP 結點過濾 ",	//af_TEFT
"當<span class='option'>連線類型</span> 設定成 <span class='option'> 自動偵測</span>, 這裡會顯示自動偵測到的連線類型. ",	//help86
"網路名稱 (SSID) ",	//sd_NNSSID
"通訊閘 ",	//_gateway
"目前路由器時間 ",	//tt_CurTime
"AM ",	//_AM
"斷線 ",	//DISCONNECTED
"(GMT-01:00) 亞速爾群島 ",	//up_tz_22
"雙絞線 ",	//help730
"Soldier of Fortune ",	//gw_gm_47
"WAN IP變更成 %v, 正在更新到動態DNS提供者 ",	//GW_DYNDNS_UPDATE_IP
"請輸入兩行相同的密碼再重試 ",	//_pwsame
"Windows/MSN Messenger ",	//as_WM
"(GMT-09:00) 阿拉斯加 ",	//up_tz_03
"從一台電腦傳送請求到另一台, 並將檔案回傳到請求的電腦. ",	//help502
"請在兩個方塊裡輸入相同的密碼做確認.  ",	//ta_msg_TW
"取決於WAN端連線類型, 您可以採用下列其中一種動作: ",	//help774
"Push 按鈕設定,Push Button Configuration(PBC)",	//wps_p3_3
"(GMT+02:00)  耶路撒冷 ",	//up_tz_36
"點選 <strong>編輯</strong> 按鈕使用設定精靈修改已存在的. ",	//hhac_edit
"網際網路存取控制初始化失敗 ",	//GW_INET_ACCESS_INITIAL_FAIL
"主機名稱 ",	//_hostname
"網站過濾初始化失敗 ",	//GW_WEB_FILTER_INITIAL_FAIL
"按照預定時間 ",	//te_OnSch
"Email ",	//help513
"步驟 3: 設定您的無線網路安全密碼 ",	//wwl_title_s4
"重新連線模式: ",	//help281
"Session Initiation Protocol. 標準的通訊協定用來初始化使用者的會談(session),包含多媒體內容, 例如聲音或聊天. ",	//help690
"Gamespy Tunnel ",	//gw_gm_77
"複製電腦的MAC位址",	//_clonemac
"從路由器上一次啟動以後, 通過介於WAN和LAN之間的封包數字的摘要. ",	//hhss_intro
"已測量上傳速度",	//at_MUS
"若您已經購買自己的網域名稱並和DNS服務廠商註冊便可以啟用此功能. 下列參數會在啟用此功能時顯示. ",	//help892
"通常WAN端速度會自動偵測. 如果您在連線到WAN端時發生問題, 嘗試手動選擇速度.  ",	//hhan_wans
"Mbps ",	//help607
"無線網路連線的密碼最多可輸入63個ASCII(美國資訊交換標準碼ASCII) 格式的字母或數字. 密碼不可少於8個字元, 為了較高的安全性通常密碼需要足夠的長度並且不應使用一般已知的密碼. 此密碼是用來產生獨特的會談(session)金鑰給每個無線網路用戶端. ",	//help382
"(時:分, 12 小時制) ",	//tsc_hrmin
"當WAN端介面最近一次重新建立連線時所測量的上傳速度.  這個值可能會比ISP提供的測量值低, 因為它不包含和ISP網路相關之所有額外的網路協定. 典型的計算值約是介於xDSL連線的上傳速度87% 和91% 之間, 比cable連線速度低5kbps. ",	//help82
"程式設計(Programming)是說嵌入硬體設備並告知它該如何運作. ",	//help525
"Heretic II ",	//gw_gm_24
"Delta Force ",	//gw_gm_13
"一間透過無線網路提供寬頻網路連線的公司 ",	//help754
"RTS 門檻(Threshold) ",	//aw_RT
"Windows XP ",	//help340
"無線區域網路 ",	//sd_WLAN
"若您的SMTP伺服器需要驗證, 選擇此項目. ",	//help864
"MPPE ",	//help617
"一個和IP位址結合的名稱 ",	//help500
"未支援的作業系統 ",	//wprn_bados
"公制(Metric) ",	//_metric
"流入封包過濾器 ",	//INBOUND_FILTER
"阻擋從%v:%u 到 %v:%u進來的UDP封包",	//IPNAT_UDP_BLOCKED_INGRESS
"此項目可以開啟或關閉路由器的無線網路功能. 設定此項目時, 下列參數便生效.  ",	//help351
"如果您偏好建立自己的金鑰請使用此項目.  ",	//wwz_manual_key2
"PPTP 子網路遮罩 ",	//_PPTPsubnet
"將會使用在內部網路的通訊埠. ",	//help20
"網際網路控制訊息協定,Internet Control Message Protocol(ICMP) ",	//help558
"Black and White ",	//gw_gm_6
"APIPA. 當作業系統設定成自動取得IP但是網路上沒有可用的DHCP伺服器時, 作業系統指派給自己的IP位址. ",	//help429
"EAP ",	//help511
"WPA 模式 ",	//bws_WPAM
"良好 ",	//wwl_GOOD
"輸入您的主機名稱, 完整且合格地;  例如: <code>myhost.mydomain.net</code>. ",	//help894
"Postal 2: Share the Pain ",	//gw_gm_36
"Gbps ",	//help534
"子網路遮罩 ",	//_subnet
"步驟 1: 選擇無線網路的設定方式 ",	//wps_KR35
"<code>保留位址</code> 項目將配置的動態IP轉換成保留的 DHCP IP位址並且在DHCP保留位址清單裡新增相同的設定. ",	//help329_rsv
"Vietcong ",	//gw_gm_58
"&quot;非軍事區域&quot;. 電腦介於LAN端和WAN端之間所設置的&quot;無人島&quot;.DMZ的電腦以路由器的安全性保護交換為了能讓網際網路直接存取的便利性. ",	//help496
"瓶頸 ",	//help446
"允許您供電給電腦儘管它是網路介面卡 ",	//help739
"使用%s 啟動廣域網路 ",	//GW_WAN_MODE_IS
"決定IP位址的哪部份指定網路和哪部分指定主機",	//help627
"使用這部份設定路由器的內部網路並且也設定內建DHCP伺服器分配IP位址給網路上的電腦. 設定在這裡的IP位址也就是您要存取網頁管理介面的IP位址. 若您變更IP位址, 您須要調整電腦端的網路設定才可以重新存取.  ",	//ns_intro_
"DNS relay ALG 拒絕從 %v:%u到 %v:%u的封包 ",	//IPDNSRELAYALG_REJECTED_PACKET
"流量統計顯示穿過路由器接收和傳送的封包. ",	//ss_intro
"選擇此所需要的控制存取過濾器. 若您在清單裡沒有看到所需要的過濾器, 請到 <a href='Inbound_Filter.asp''> 進階設定&rarr;流入封包過濾器</a>的頁面新增過濾器. ",	//help71
"無線網路設備的PIN欄位不能是空白 ",	//KR20
"會談(session) 超過閒置時間 ",	//KR25
"選擇啟用此時適用的排程. 若您在排程清單裡沒有看到需要的排程, 請到<a href='tools_schedules.asp' onclick='return jump_if();'>工具 &rarr; 排程</a> 頁面建立新的排程. ",	//hhag_30
"%s' [通訊協定:%u]->%v 和 '%s' [protocol:%u]->%v衝突. ",	//GW_NAT_VS_PROTO_CONFLICT_INVALID
"%s': 優先權, %u, 必需介於0和7之間 ",	//GW_WISH_RULES_PRIORITY_RANGE
"設定好路由器的動態DNS, 您可以打開瀏覽器將URL網址連到你的網域(例如 <code>http://www.mydomain.info</code>) 路由器將會試圖轉送請求到區域網路的80埠. 然而, 若您在LAN端電腦做這個動作, 卻沒有在虛擬伺服器定義80埠, 將會連回到路由器的網頁管理畫面. 請參考<a href='adv_virtual.asp'>進階設定 &rarr; 虛擬伺服器</a> 設定虛擬伺服器 ",	//help900
"為管理者通訊埠選擇控制存取的過濾器. 如果您在過濾器清單裡沒有看到需要的過濾器, 到<a href='Inbound_Filter.asp' onclick='return jump_if();'>進階設定 &rarr;流入封包過濾器</a>頁面建立新的過濾器",	//hhta_831
"%s': 主機1的起始IP, %u, 必須小於主機1的結束IP, %u ",	//GW_WISH_RULES_HOST1_PORT
"選擇適用此虛擬伺服器需要的控制存取的過濾器. 若您在過濾器清單裏沒有看到需要的過濾器, 到<a href='Inbound_Filter.asp'> 進階設定&rarr;流入封包過濾器</a>頁面建立新的過濾器. ",	//help22
"%s': 本地起始IP '%v' 不在LAN的子網路內 ",	//GW_QOS_RULES_LOCAL_IP_END_SUBNET
"%s': 遠端起始通訊埠, %u, 必須小於遠端節通訊埠, %u ",	//GW_QOS_RULES_REMOTE_PORT
"%s': 本地起始通訊埠, %u, 必須小於本地結束通訊埠, %u ",	//GW_QOS_RULES_LOCAL_PORT
"%s': 本地起始IP '%v' 不在LAN的子網路內 ",	//GW_QOS_RULES_LOCAL_IP_START_SUBNET
"新增有WPS的無線設備 ",	//LW13
"選擇一個此生效時適用的排程時間. 如果您在排程清單裡沒有看到需要的排程, 到 <a href='tools_schedules.asp'> 工具&rarr;排程</a> 頁面建立新的排程. ",	//help72
"選擇啟用此服務時使用的排程.如果您在排程清單裡沒有看到需要的排程, 到 <a href='tools_schedules.asp' onclick='return jump_if();'> 工具&rarr;排程</a> 頁面建立新的排程. ",	//hhpt_sch
"從<em>工具</em>子目錄裡的<em>列印伺服器?</em>啟用raw TCP 通訊埠列印",	//wprn_tt2
"選擇適用此生效時的排程. 如果您在排程清單裡沒有看到需要的排程, 到 <a href='tools_schedules.asp'> 工具&rarr;排程</a> 頁面建立新的排程.",	//help53
"%s': 主機1的起始IP, %v, 必須小於主機1的結束IP, %v ",	//GW_WISH_RULES_HOST1_IP
"無法停止程序 ",	//KR24
"Super G 模式 ",	//help358
"WLAN 分隔 ",	//KR4
"WEP 金鑰長度 ",	//wwl_WKL
"從電腦使用共用印表機, 從<a href='../Basic/Wizard.shtml' onclick='return jump_if();'> <i>精靈?</i> 頁面</a>啟動印表機精靈",	//tps_intro4
"%s': 通訊協定, %u, 必需介於0和257之間 ",	//GW_WISH_RULES_PROTOCOL
"%s': 遠端結束IP '%v' 在LAN的子網路裡 ",	//GW_QOS_RULES_REMOTE_IP_END_SUBNET
"允許FTP用戶端和伺服器穿過NAT傳輸資料. 若您要設定FTP伺服器可參考<a href='adv_virtual.asp'>進階設定&rarr;虛擬伺服器</a> 頁面. ",	//help38
"網站過濾器是允許您存取特定網頁的其中一種方法. 您也可以使用另一種方法警戒家長控制器服務, 允許您指定廣泛種類的網頁並且省下輸入特定網址URL的麻煩. 要多了解警戒服務, 參考<a href='../Tools/Sentinel.shtml'>工具&rarr;Sentinel</a>. ",	//help143s
"%s': 主機2的起始IP, %v, 必須小於主機2的結束IP, %v ",	//GW_WISH_RULES_HOST2_IP
"程序停止. 您可以按下方的取消按鈕回到精靈的開始畫面並重新啟動程序. ",	//KR23
"%s' [%s:%s] 和 '%s'[%s:%s] 在不同的IP位址發生衝突. ",	//GW_NAT_PORT_FORWARD_CONFLICT_INVALID
"偵測到PIN (2nd half) 不符合 ",	//KR30
"%s' [%s:%d]->%v/%d 和 '%s' [%s:%d]->%v:%d發生衝突. ",	//GW_NAT_VS_PORT_CONFLICT_INVALID
"AP透過%s註冊到Registrar (%s)失敗, 理由 (%s), 錯誤碼 (%u)",	//WIFISC_AP_REGISTRATION_FAIL
"偵測到PIN (1st half) 不符合 ",	//KR29
"啟用時, 此項目使路由器自動決定流量的優先權,它不會另外確認, 是根據流量表現的行為而定. 路由器將出現大量傳送的特徵時, 例如檔案傳送, 或出現相互作用的流量時, 例如gaming或VoIP, 在普通的優先權下執行. ",	//YM143
"指定的介面 -- WAN -- 使用此路徑時, IP封包必須傳送到路由器外部. ",	//help111
"%s': 遠端起始IP '%v'在LAN端子網路內 ",	//GW_QOS_RULES_REMOTE_IP_START_SUBNET
"%s':優先權, %d, 必須介於1和255之間 ",	//GW_QOS_RULES_PRIORITY_RANGE
"如果使用此路徑, 指定下一個將被使用的hop. 通訊閘0.0.0.0表示沒有下一個hop, 匹配的IP位址是直接連接到路由器指定的介面: WAN.",	//help109
"如果您已經設定Wi-Fi保護設定, 按下<strong>新增無線裝置精靈</strong>把新的設備加入到您的無線網路裡. ",	//LW45
"接收未知的訊息",	//KR32
"新增無線設備到網路裏有幾個方法. 無線網路是由Registrar控制. Registrar只允許有輸入PIN碼,或按下裝置特定的Wi-Fi保護設定按鈕的設備連到無線網路. 路由器充當registrar的角色, 雖然其他設備也同樣是扮演registrar. ",	//LW63
"%s': 主機2的起始通訊埠, %u, 必須小於主機2的結束通訊埠, %u ",	//GW_WISH_RULES_HOST2_PORT
"%s': 通訊協定, %d, 必須介於0和257之間 ",	//GW_QOS_RULES_PROTOCOL
"%s' 是 '%s'的兩倍 ",	//GW_WISH_RULES_DUPLICATED
"%s': 遠端起始IP, '%v' ,必須小於遠端結束IP, '%v' ",	//GW_QOS_RULES_REMOTE_IP
"%s': 本地起始IP, '%v', 必須小於本地結束IP, '%v' ",	//GW_QOS_RULES_LOCAL_IP
"如果LAN端機器存取的網頁被存取控制所限制, 要求會被重新導向&quot;Forbidden&quot;頁面. 在<a href='adv_filters_url.asp'> 進階設定&rarr;網站過濾器</a> 的頁面新增WAN端身分(路由器的WAN端IP位址或它的動態DNS名稱)以解決這個問題. ",	//help30
"無效的IP位址 ",	//LS46
"位在區域網路<span>rou</span><span>ter</span> 的IP位址. ",	//KR78
"使用中的Sessions",	//_actsess
"一般的選擇--UDP, TCP, 和兩者UDP and TCP --可從下拉式選單內選擇",	//help19x1
"為明確說明任何其他的通訊協定，從清單內選擇&quot;其他&quot;，然後在<span class='option'>Protocol</span>方格中輸入對應的通訊協定數字(<a href='http://www.iana.org/assignments/protocol-numbers' target='_blank'> as assigned by the IANA</a>)",	//help19x2
"選擇一個服務將被啟用的排程。若您在排程清單中未看見您所需的，請至<a href='tools_schedules.asp'> 工具&nbsp;&rarr;&nbsp;排程</a>設定中建立一個新排程。",	//help23
"當以上範例值填滿且此Port Forwarding規則被啟用時，所有在6159-6180和99埠上所有TCP和UDP的流量會通過路由器且被導向到您內部IP位址為192.168.0.50的遊戲伺服器",	//help74
"輸入一個名稱給特殊應用規則，例如<code>Game App</code>，如此將可以在未來協助您識別此規則。另一個選擇，您可以從<span class='option'>Application</span>常用應用程式清單內選取",	//help48
"，取代輸入一個名稱給特殊應用規則，您可以從常用應用程式清單內選取，且依據選擇將會填滿剩下的設定值",	//help48a
"此區域即為定義特殊應用程式規則之處",	//help56_a
"QoS Engine&trade;的特性利用將網路應用程式優先權化來協助改善您網路戲的效能",	//help76
"啟用此選項來使線上遊戲和其他互動式的應用程式，例如VoIP得到較好的效能",	//help78
"一個QoS Engine規則能定義一個特定的訊息流程並指派一個優先權給該流程。",	//help88
"自動分類能夠適用於大多數應用程式，而不需要額外設定特定的QoS Engine規則。",	//help88b
"衝突性的規則是不被允許的，衝突性規則是那些共享任何來源位址/通訊埠、目的地位址/通訊埠和通訊協定的組合。拒絕衝突性規則確保每個在規則內的被定義的流程接收預期的優先權和防止可能減少QoS的不明權級。",	//help88c
"在這裡設定訊息流程的優先權。0代表最高的優先權(最緊急)，255代表最低的優先權(最不緊急)。 ",	//help91
"優先權0是被保留的",	//help91a
"沒有被任何規則分級的流程接收最低的優先權",	//help91b
"該訊息流程所使用的通訊協定類型。",	//help92
"常用的項目可從下拉式選單內來選擇",	//help92x1
"要指明任何其他的通訊協定 (<a href='http://www.iana.org/assignments/protocol-numbers' target='_blank'>常用通訊埠查詢</a>)，在<span class='option'>Protocol</span>視窗內輸入它的通訊埠數",	//help92x2
"此區域是定義QoS Engine規則之處",	//help99_s
"當網站過濾器功能在 <a href='#Access_Control'>存取控制</a>功能被啟用時網站會被列在此處。",	//help141_a
"輸入您想要允許的網站，例如<code>google.com</code>。不要在URL前面輸入<code>http://</code>輸入最主要的網域，例如：dlink.com，那麼www.dlink.com和 support.dlink.com 都可以被允許存取。",	//help145
"當選擇&quot;OFF&quot;時表示不啟用MAC位址控制網路存取。當選擇&quot;ALLOW&quot;時表示只有MAC位址在MAC位址清單內的電腦才可以存取網路。當選擇&quot;DENY&quot;時表示MAC位址在MAC位址清單內的任何電腦皆不可存取網路。",	//help155_2
"也可參考<a href='adv_virtual.asp'> 虛擬伺服器</a>, <a href='adv_portforward.asp'>通訊埠轉送</a>, <a href='adv_appl.asp'> 應用程式規則</a>, 和<a href='adv_network.asp'>UPnP</a>相關項目。",	//haf_intro_2
"SPI啟用時，能夠測試每回進出設備的封包準確性，以防止駭客攻擊。用以確認封包通過的資訊與協定一致。 ",	//help164
"DMZ (Demilitarized Zone) 是不受防火牆保護的區域，若一個應用程式無法正常在路由器後端執行，您可以讓一台電腦曝露於Internet上並執行電腦上的應用程式。",	//help165
"指定您想要在Internet上溝通不受限制的LAN端電腦IP位址。若此電腦用DHCP方式自動取得它的IP位址，則您可以在<a href='adv_network.asp'>設定 &rarr; 網路設定</a> 頁面上指定一個固定位址來讓DMZ電腦的IP位址不會變動。",	//help167
"當一個LAN端應用程式使用一個除了UDP, TCP和 ICMP的通訊協定初始一個連線到Internet，路由器的NAT可以追踨這類連線，即使它無法辨識這個通訊協定。這個功能因為它啟用某個應用程式而不需使用ALG所以很實用(特別是一個單一VPN連線到一個遠端主機)。",	//TA21
"注意:此功能不會在DMZ主機上執行(若一個被啟用時)，DMZ主機總在處理這類的連線。",	//TA22
"當PPTP ALG為啟用時，LAN端電腦可以用相同或不同的VPN伺服器來建立PPTP VPN連線。當PPTP ALG為停用時，路由器允許VPN以受限的方式來運作。LAN端電腦可以建立VPN通道到不同的VPN網路伺服器但是不能到相同的伺服器，停用PPTP ALG的好處是用來增加VPN的效能。啟用PPTP ALG也可以允許來源VPN連線到LAN端VPN伺服器(參考<a href='adv_virtual.asp'>虛擬伺服器</a>)",	//help33b
"允許H.323(特別是微軟的NetMeeting)用戶端透過NAT互相溝通。注意到如果您想要您的朋友呼叫您，您必須先在虛擬伺服器上設定。請參考<a href='adv_virtual.asp'> 進階功能&nbsp;&rarr;&nbsp;虛擬伺服器</a>頁面，如何設定虛擬伺服器。 ",	//help39
"這個功能夠傳送從WAN端到LAN端電腦或其他有支援WOL功能的裝置的”Magic Packets”(即特別被格式化成喚醒的封包)。WOL的裝置必須在<a href='adv_virtual.asp'> 進階功能&nbsp;&rarr;&nbsp;虛擬伺服器</a> 的頁面設定。虛擬伺服器的LAN IP被設定為廣播位址192.168.0.255。MAC位址包含在Magic Packet內的區域網路電腦將會被喚醒。 ",	//help41
"新增/編輯 流入封包過濾器規則 ",	//help170
"儲存新增或編輯流入封包過濾規則，當完成更新流入封包過濾清單設定，請務必按下畫面上方的<span class='button_ref'> 儲存設定值</span>按鈕之後，所有的設定才會被套用。 ",	//help175
"在這個流入封包過濾清單規則部份，流入過濾規則可以透過點擊編輯或刪除圖示改變，當你點編輯圖示這個項目是明亮的，並且”編輯流入封包過濾”部分被編輯執行。",	//help176
"預設值為2346，若非必要，請勿任意更動此數值。但是如果遇到無線傳輸資料不一致的狀況的話，可以將此數值以小幅度調整嘗試解決這個問題 ",	//help182
"是建議的",	//help183
"預設值為2346，若非必要，請勿任意更動此數值",	//help180
"針對鄰近的11b無線網路提供額外的保護，關閉此選項來減少在802.11n上剩餘無線網路的不利影響。",	//aw_erpe_h
"此路由器有一個USB埠;所以若您有一個USB快閃裝置，在您電腦上有一個USB埠，且您的電腦使用Windows XP Service Pack 2 (SP2)或更新的版本，您可以使用USB快閃裝置在您的電腦和路由器之間轉存無線設定資料。到控制台並選擇無線網路設定精靈，此精靈會給您&quot;使用一個USB快閃裝置&quot;和&quot;手動設定一個網路連線&quot;的選擇，請選擇&quot;使用一個USB快閃裝置&quot;。",	//help202
"注意:不要連接一個以上的USB快閃裝置到路由器，即使是使用USB hub也不要。",	//help203
"在裝置與您的PPPoE 連線中斷之前，活動停止的最長時間。最大閒置時間設定只有使用於&quot;有流量時連線&quot;和&quot;手動連線&quot;的重新連線模式時有效。",	//help277
"在裝置與您的PPTP連線中斷之前，活動停止的最長時間。最大閒置時間設定只有使用於&quot;有流量時連線&quot;和&quot;手動連線&quot;的重新連線模式時有效。",	//help283
"在裝置與您的L2TP連線中斷之前，活動停止的最長時間。最大閒置時間設定只有使用於&quot;有流量時連線&quot;和&quot;手動連線&quot;的重新連線模式時有效。",	//help287
"手動設定一個在此範圍內的位址給一台電腦或設備是有可能的。在此情況下位址應該被保留(查看以下<a href='#Static_DHCP'>動態DHCP用戶端的數量</a>)，因此DHCP伺服器能辨識此特定位址只能被特定電腦或設備來使用。",	//help320
"為了保護您的隱私，使用無線安全模式來設定無線安全的功能。此設備支援兩種無線安全模式包含WPA-Personal和 WPA-Enterprise。WPA 提供高層級的安全性，WPA-PSK不需要一個驗證伺服器，WPA-Enterprise選項則需要一個RADIUS伺服器來提供驗證。",	//help350
"一種用在無線溝通想要達成像有線網路般的隱私層級的資料加密方式。WEP不像WPA加密的安全性，要獲得一個WEP網路的存取權，您必須知道金鑰為何，此金鑰是一個您建立的串連字元。當使用WEP時，您必須決定加密的層級，加密的類型取決於金鑰的長度，128位元加密需要一個比64位元加密較長的金鑰。金鑰可設定輸入為HEX (hexadecimal - 使用字元為 0-9, A-F) 或是ASCII (American Standard Code for Information Interchange - alphanumeric characters)的格式，ASCII格式的提供讓您可輸入一個較容易記憶的字串，在不同的網路可交換使用ASCII和HEX的字串，可設定四組金鑰讓您可輕鬆的更換。一個預設的金鑰被選擇用在網路內。",	//help366
"在64位元HEX加密下長度為精確的10個字元(例如12345678FA就是一個64位元加密10個字元的有效字串)",	//help368
"在128 位元HEX 加密下長度為精確的26 個字元(例如456FBCDF123400122225271730就是一個128位元加密26個字元的有效字串)",	//help369
"在64位元ASCII加密下長度最多為5個字元(例如DMODE就是一個64位元加密5個字元的有效字串)",	//help370
"在128 位元ASCII 加密下長度最多是13 個字元 (例如2002HALOSWIN1就是一個128位元加密13個字元的有效字串)",	//help371
"注意:若您輸入在WEP金鑰的字元少於要求時，剩餘的金鑰會自動用0來填滿。",	//help371_n
"WPA是較舊的標準;當用戶端將使用只支援較舊標準的路由器時請選擇此選項。WPA2是較強大的IEEE 802.11i的新型安全標準，有&quot;WPA&quot;和&quot;WPA2&quot;兩種選擇，路由器會先執行WPA2，但若用戶端只支援WPA時則會跳回WPA，將會使用用戶端支援最強的加密方式。使用&quot;WPA2 ONLY&quot;的選項時，路由器只會與也支援WPA2安全的用戶端連結。在&quot;WPA or WPA2&quot;和 &quot;WPA2 Only&quot;模式下時將會使用AES加密方式來確保最好的安全性。有些遊戲和設備只會在&quot;WPA Only&quot;的模式下執行。TKIP是&quot;WPA only&quot;模式下的加密方式。",	//help375
"准許這個選項後將可以使DHCP伺服器將NetBIOS的規劃設定傳送給LAN的主機.",	//help400_b
"XXX",	//help401_b
"設定IP位址給優先的WINS伺服器",	//help402_b
"ActiveX",	//help403
"設定IP位址給備用WINS伺服器,如果有的話.",	//help403_b
"微軟公司研發出針對某些軟體互動所須的元件",	//help404
"XXX",	//help404_b
"Ad-hoc network(點對點網路)",	//help405
"XXX",	//help405_b
"無線用戶端點對點使用網路",	//help406
"AppleTalk",	//help417
"由蘋果電腦開發出的一種區域網路協定,用於蘋果電腦與其它種類電腦的溝通上",	//help418
"AppleTalk Address Resolution Protocol (AARP)",	//help419
"蘋果電腦IP位址和網卡實體位址(MAC位址)之間的轉換的一種通訊協定",	//help420
"Basic Input/Output System (BIOS, 基本輸入/輸出系統 )",	//help434
"當電腦開機時執行處理程序的程式",	//help435
"Baud (鮑率)",	//help436
"資料傳輸速度的測量單位",	//help437
"BOOTP (啟動程序)",	//help444
"Bootstrap Protocol. Bootstrap協定描述於RFC 951和1084,在沒有使用者介入下用來啟動終端機並給予IP位址",	//help445
"CAT 5",	//help458
"Category 5.用於10/100M bps傳輸的網路線。",	//help459
"DB-25",	//help474
"一般用於連接外接式數據機，與電腦的RS-232 界面做通訊連結使用的線材接頭，有25 支 Pin 腳。 ",	//help475
"DB-9",	//help476
"一般用於介接高階裝置設定時使用，與電腦的RS-232 界面做終端機連結使用的線材接頭，有9 支 Pin 腳。",	//help477
"dBd (天線增益值)",	//help478
"與雙極天線有關的分貝數",	//help479
"Fiber optic (光纖)",	//help518
"光束沿光導纖維傳輸的技術。一束光，如激光，可以通過調變使其帶上資訊。一條光纖信道可以帶上較其他傳輸方式多得多的資訊，而且不受電磁干擾",	//help519
"File sharing (檔案共享)",	//help522
"重程式設計的一種功能。該功能支持兩個或多個併發執行的程式可存取同一個檔案",	//help523
"File Transfer Protocol(檔案傳輸協定). 由麻省理工學院所發展出來，用於網路上電腦間傳輸檔案的通訊協定，是目前網路上最穩定的檔案傳輸模式",	//help528
"Gain (增益)",	//help531
"一個設備的無線輸出信號與輸入信號之比",	//help532
"Hashing (雜湊法)",	//help544
"為儲存和檢索資料項，把搜索鍵標字轉換成某一位址的一種方法。在索引資料集中，為儲存與檢索一個記錄，將一個記錄的鍵標轉換為索引值的一種過程。一種造表和查表的技術。",	//help545
"Hop",	//help548
"IIS (網際網路資訊伺服器)",	//help563
"網際網路資訊伺服器是由微軟提供的WEB和FTP伺服器功能",	//help564
"Intranet (企業內部網路)",	//help579
"是指運用Internet技術，在企業內部所建立的網路系統，只有企業內部的人員可以使用，資訊存取只限於企業內部，並在安全的控制下連上Internet",	//help580
"Intrusion Detection (入侵偵測)",	//help581
"一種安全機制，掃描整個網路來偵測從內部和外部網路所發出的攻擊",	//help582
"Java",	//help588
"JAVA爪哇程式語言是昇陽公司(Sun Microsystems)在1995年，專門為網際網路設計的一項程式語言。JAVA是一種全新的物件導向程式語言，和C++程式語言非常類似，但較容易使用，用來開發全球資訊網的內容。",	//help589
"LPR/LPD (列印表機遠程控制)",	//help602
"&quot;Line Printer Requestor&quot;/&quot;Line Printer Daemon&quot;. 透過TCP/IP通訊協定，將列印資料傳送給執行LPD伺服器的電腦列印的一種方式.",	//help603
"MDI",	//help609
"Multiple Document Interface. 表示這個乙太網路埠使用平行線來連接",	//help610
"MDIX",	//help611
"Medium Dependent Interface Crossover. 表示這個乙太網路埠使用跳線來連接",	//help612
"MIB (管理資訊庫)",	//help613
"Mmanagement information base, 代表關於裝置各類資訊的物件集，可供簡單網路管理通訊協定（SNMP）管理裝置使用。因為不同種類的裝置及通訊協定使用不同的網路管理服務，所以每種服務都會有其本身的物件集。 ",	//help614
"Modem (數據機)",	//help615
"一種設備，將來自電腦的數位資料轉換成可在電話線路上傳輸的類比信號，並且將可接收到的類比信號再轉換成數位資料送給電腦",	//help616
"OFDM (正交頻分多路複用技術)",	//help636
"OFDM-Orthogonal Frequency Division Multiplexing 正交頻分多工，是802.11a 和802.11g的多通道調變解調變技術。利用離散快速傅利葉轉換(FFT)和反快速傅利葉轉換(IFFT)來調變和解調變傳送的訊號。可使用的頻寬被劃分為多個狹窄的頻帶，資料就可以被平行的在這些頻帶上傳輸。 ",	//help637
"OSI",	//help638
"Open Systems Interconnection(開放系統互連), 提供網路上兩個設備之間的資料該如何傳送的參考模型。",	//help639
"OSPF",	//help640
"一個找到最短傳送數據、信件路徑的路由協定。在大型網路中，比RIP使用更頻繁。",	//help641
"Personal Area Network (PAN)",	//help643
"PAN（Personal Area Network）是藍芽技術問世後才出現的名詞。也就是用無線的藍芽技術將個人用的手機，PDA，無線耳機連接成一個「個人區域網路」。有效距離是十公尺範圍。",	//help644
"PoE",	//help649
"Power over Ethernet是一種電源管理技術，可作為設備端直接嵌入交換機中，或是獨立的中繼集線器，透過CAT 5網路線來傳送電力",	//help650
"RJ-11",	//help672
"連接電話最常使用的接頭，又稱 6P4C，也就是接頭有6個槽，但只有4個金屬接點",	//help673
"RS-232C",	//help676
"美國電子工業協會制定的一種標準，它規定了電腦通信設備之間的序列界面。它具有25針的電纜連接器，但並不需要使用全部25條線",	//help677
"SOHO",	//help693
"在家辦公族,小型辦公室和家庭辦公室",	//help694
"TFTP (次要檔案傳輸協定)",	//help711
"Trivial File Transfer Protocol，一種FTP的簡化版工具程式",	//help712
"VLAN",	//help733
"虛擬區域網路",	//help734
"WDS",	//help743
"Wireless Distribution System. 簡單地說是無線橋接功能, 讓無線基地台透過無線的方式互連的系統.",	//help744
"Yagi antenna (Yagi天線)",	//help763
"一種指向型的天線,集中無線的訊號發射到特定的位置",	//help764
"當IGMP啟用時，此區塊的畫面將會顯示所有在區域網路內屬於multicast群組成員的裝置",	//_bln_title_IGMPMemberships_h
"無線用戶端使用的無線傳輸標準，依802.11b或802.11g分別為11b或11g",	//help785
"注意:紀錄訊息使用的語言是產生在事件被紀錄的當下，若您更改語言，則您可能會看到一些紀錄訊息是用一種語言而其他訊息是用另一種語言。",	//help795a
"如果您在<a href='tools_email.asp'>工具&nbsp;-&gt;&nbsp;電子郵件設定</a> 選項內有提供電子郵件的相關資訊，在點選<span class='button_ref'>寄出系統資訊</span>此按鈕時,系統將會寄出記錄檔至您設定的電子郵件信箱內。",	//help802
"點選此按鈕來儲存此記錄檔至您的電腦內。",	//help803
"NAT Session 統計功能能夠顯示所有經由 DGL-4300 的來源及目的地的 NAT 封包資訊。",	//help813
"內部IP",	//sa_Internal
"在區域網路端使用服務的IP位址和通訊埠。",	//help814
"外部IP",	//sa_External
"在廣域網路端使用服務的IP位址和通訊埠。 ",	//help816
"開啟或關閉TCP連線",	//help823_15
"建立TCP連線",	//help823_17
"請選擇遠端管理者權限(Allow all 允許全部/Deny All 拒絕全部)，如果不合您的過濾須求，請到<a href='Inbound_Filter.asp'' onclick='return jump_if();'>進階設定 &rarr; 流入封包過濾器</a> 設定中來建立新的封包過濾規則。",	//help831
"請選擇遠端管理者權限(Allow all 允許全部/Deny All 拒絕全部)，如果不合您的過濾須求，請到<a href='Inbound_Filter.asp'' onclick='return jump_if();'>Advanced &rarr; Inbound&nbsp;Filter</a> 頁面來建立新的封包過濾規則。",	//help831_1
"若您選擇此功能請選擇一個定義好的排程，若您在清單內沒有看到您需要的排程，請至 <a href='tools_schedules.asp'>工具&nbsp;-&gt;&nbsp;排程</a>設定中建立一個新排程。",	//help872
" 儲存設定值 ",	//ts_ss
"將先前備份設定值檔案載入",	//ts_ls
"將所有設定回復出廠預設值 ",	//ts_rfd
"您可以點選<span class='button_ref'>檢查網路上最新的韌體版本</span>按鈕來檢查是否有最新版。您也可以勾選 <span class='option'>Email Notification of Newer Firmware Version</span>來啟用Email 通告，透過本功能得知網路上最新的韌體版本，當有新韌體時，將會email通知您。",	//help877
"有些更新韌體時會將路由器清回原廠預設值，在更新韌體之前，您可以到<a href='tools_system.asp''>工具&nbsp;-&gt;&nbsp;系統</a>設定頁面來備份儲存目前的設定。",	//help887
"當這個功能啟用，您可以啟用Email 通告網路上最新的韌體版本；當有新韌體時，將會email通知您，您必須到 <a href='tools_email.asp'>工具&nbsp;-&gt;&nbsp;EMail設定</a>中進行相關設定。",	//help890
"請在下拉功能表中選擇一個動態DNS 提供者。 ",	//help893
"或您可以手動輸入一個動態DNS提供者",	//help893b
"新增/編輯 排程設定規則",	//help191
"儲存已經新增或修改好的排程規則至下面的清單之中。每當更新排程規則時，仍然必須按下網頁最上方的<span class='button_ref'>儲存設定值</span>按鈕，使設定永久生效。 ",	//help198
"若您更改路由器 <br />的IP位址，則您再次進入設定網頁之前需要更改 <br /> 網頁瀏覽器內的IP位址。",	//rb_change
"此頁面顯示所有到您路由器有效連線數的完整細節",	//sa_intro
"未知的(請稍候...)",	//_unknown_wait
"未知的",	//_unknown
"N/A",	//_na
"尚未有電腦的資訊",	//_sdi_nciy
"DHCP用戶端",	//_sdi_dhcpclient
"BigPond用戶端",	//_sdi_bpc
"啟用",	//_on
"尚未有多點廣播群組會員的資訊",	//_bln_nmgmy
"不正確的設定",	//_sdi_s1
"被管理者中斷連線",	//_sdi_s6
"已建立",	//_sdi_s4
"狀態變更中(請稍侯…)",	//_sdi_s10
"登入",	//_sdi_s7
"登出",	//_sdi_s8
"失敗",	//_sdi_s9
"日",	//_sdi_days
"(中斷連結，並懸置",	//_sdi_disconnectpending
"秒)",	//_sdi_secs
"DHCP更新",	//sd_Renew
"DHCP釋放",	//sd_Release
"斷線",	//sd_Disconnect
"BigPond登入",	//sd_bp_login
"BigPond登出",	//sd_bp_logout
"頻道",	//_channel
"安全模式",	//sd_SecTyp
"這個紀錄檔已寄出至電子郵件地址",	//sl_alert_2
"Email通告功能沒有被啟用",	//sl_alert_3
"系統紀錄",	//sl_SLogs
"若您在<a href='tools_email.asp'>工具&nbsp;-&gt;&nbsp;EMail設定</a> 的選項內有提供電子郵件的相關資訊，在點選此按鈕時系統將會寄出記錄檔至您設定的電子郵件信箱內。",	//hhsl_lmail
"列印伺服器狀態",	//sps_intro2
"印表機是",	//sps_pare
"此列印通訊協定目前是停用的，您可在<a href='../Tools/PS.shtml' onclick='return jump_if();'>here</a>啟用它。",	//sps_protdis
"路由表",	//sr_RTable
"此頁面顯示在路由器上設定路由的細節。",	//sr_intro
"網路流量狀態",	//ss_title_stats
"無線網路端相關的清單",	//sw_title
"訊號強度(%)",	//_rssi
"無效的遠端管理閒置時間數值，應該要在1-65535的範圍內。",	//ta_alert_1
"請確認管理者的兩組密碼相同後再試一次",	//_pwsame_admin
"請確認使用者的兩組密碼相同後再試一次",	//_pwsame_user
"無效的遠端管理通訊埠'+data.wan_web_port+'，應該要在(1...65535)的範圍內.",	//ta_alert_3
"遠端管理者<a href='Inbound_Filter.asp'' onclick='return jump_if();'>流入封包過濾器</a>",	//ta_RAIF
"未支援此特定動態網域名稱服務提供者",	//_invalidddnsserver
"此特定伺服器位址是空白的",	//_blankddnsserver
"請檢查伺服器位址的設定",	//tt_alert_checkdyndns
"逾時數值不可以小於或等於0",	//td_alert_2
"逾時數值不可以大於8760",	//td_alert_3
"動態網域名稱伺服器(DDNS)",	//td_DDNSDDNS
"選擇動態DNS伺服器",	//tt_SelDynDns
"(例如:myhost.mydomain.net)",	//_hostname_eg
"您首先需要在下拉式選單中服務提供中一個動態DNS的帳戶",	//TA16
"帳戶名稱錯誤",	//_emailaccnameisblank
"來源電子郵件地址不應空白",	//_blankfromemailaddr
"目的電子郵件地址不應空白",	//_blanktomemailaddr
"SMTP伺服器地址不應空白",	//_blanksmtpmailaddr
"' + from_addr + '不是有效的電子郵件地址",	//_badfromemailaddr
"' + to_addr + '不是有效的電子郵件地址",	//_badtoemailaddr
"' + data.smtp_email_server_addr + '不是有效的SMTP伺服器",	//_invalidsmtpserveraddr
"SMTP伺服器地址不被允許",	//_badsmtpserveraddr
"有較新的韌體版本可使用",	//tf_NFWA
"點選此處去下載檔案",	//tf_ClickDL
"注意:有些韌體在更新後會將設備的設定回復成原廠預設值。在執行更新動作前，請確認已從工具-系統設定的頁面儲存目前的設定值。您仍想執行更新嗎?",	//tf_USSW
"網頁開啟超時，請重新登入此頁面",	//tf_alert_1
"根據網路上檢查的結果，最新的韌體版本為:",	//tf_LFWVis
"線上檢查失敗，伺服器無法使用或您可能沒有連上網路",	//tf_FailFWC
"韌體更新檢查正在進行中",	//tf_FWCinP
"正在檢查可使用的新韌體",	//tf_Ching_FW
"在工具-->Email設定內未啟用Email 通告功能 ",	//tf_EM_not
"如果要檢查最新的韌體版本的話，請按下&quot;檢查網路上最新的韌體版本&quot;按鈕。如果您要即時的通告韌體版本更新資訊的話，您可以配合&quot;韌體更新通告功能設定&quot;功能中勾選&quot;自動檢查網路上最新的韌體版本&quot;功能。",	//tf_intro_FWCh
"最新韌體版本",	//tf_LFWV
"檢查網路上最新的韌體版本",	//tf_FWChNow
"有些韌體更新會回復設定到原廠預設值。在執行更新前，請確認已從<a href='tools_system.asp' onclick='return jump_if();'>工具&nbsp;-&gt;&nbsp;系統</a>頁面來儲存目前的設定。",	//tf_msg_FWUgReset
"注意:正在載入中，載入可能需要1&nbsp;分鐘",	//tf_msg_Upping
"韌體更新檔案會定期提供出來改善路由器的效能和增加性能。若您的路由器在特定性能上運作有些問題，請點選<strong>Check Online Now for Latest Firmware Version</strong>連結到本公司服務支援的網站查看是否有新版的韌體可用。",	//TA17
"印表機搜尋中…",	//tps_sfp
"連續兩次點選這圖形來啟動安裝印表機程序",	//tps_dci
"印表機伺服器設定",	//tps_intro2
"印表機的IP位址和TCP埠顯示在<a href='../Status/PS.shtml' onclick='return jump_if();'>這裏</a>.",	//tps_foo
"印表機的IP位址及佇列名稱顯示在<a href='../Status/PS.shtml' onclick='return jump_if();'>這裏</a>.",	//tps_foo2
"沒有日期被排程名稱 '+(data.sched_table[i].sched_name)+'' 選擇'",	//tsc_alert_1
"無效時間",	//tsc_alert_2
"排程名稱'+(data.sched_table[i].sched_name)+'已經被設定且無法使用",	//tsc_alert_3
"此排程已被使用",	//tsc_alert_6
"已無空間再新增",	//tsc_alert_9
"選擇日程",	//tsc_SelDays
"Time Frame",	//tsc_TimeFr
"Syslog伺服器IP位址不應與閘道IP位址相同",	//tsl_alert_3
"Syslog伺服器IP位址是在WAN子網路，它應該在LAN子網路內('+lan_subnet+')",	//tsl_alert_1
"Syslog伺服器IP位址應該在LAN子網內(+lan_subnet+)",	//tsl_alert_2
"回復所有設定至原廠預設值",	//tss_RestAll
"一旦路由器依您的需求設定後，您可以儲存設定成一個設定檔，在路由器回復成原廠預設值之後您可能需要此檔案來載入設定值。點選<strong>Save Configuration</strong> 按鈕來儲存設定值。",	//TA18
"毫秒，TTL=",	//tsc_pingt_msg9
"使用者停止ping偵測",	//tsc_pingt_msg10
"NTP伺服器尚未被設定",	//tt_alert_nontp
"閘道器時間已經被更新",	//tt_alert_tupdt
"週",	//TA24
"日",	//TA25
"若前一頁沒有在 <span id='show_sec'></span>&nbsp; 秒下回復請按下下方的按鈕來繼續路由器的設定",	//ap_intro_noreboot
"被禁止的存取",	//fb_FbAc
"監控封鎖網頁存取",	//sentinel_1
"此電腦已被路由器監控服務封鎖此網站的存取",	//sentinel_2
"聯絡您監控服務的管理者來啟用對此頁面的存取",	//sentinal_3
"失敗",	//fl_Failure
"新的設定因發生錯誤所以尚未被儲存",	//fl_text
"有一個新版韌體可更新，在登入後您將會直接到更新的頁面",	//li_newfw
"您現在將會再直接到登入頁面",	//rd_p_1
"若登入的頁面沒有出現，請點選 <a href='/login.html'>this link</a>.",	//rd_p_2
"回復設定",	//rs_Restoring_Settings
"此設定檔是無效的",	//reh
"正在恢回復廠設定中，請稍後",	//rs_RSPW
"轉換局端資料",	//rs_cld
"完成",	//rs_Done
"拆封局端資料",	//rs_uld
"拆封儲存資料",	//rs_usd
"轉換儲存資料",	//rs_csd
"重新封裝資料",	//rs_Repacked
"轉換",	//rs_Converted
"儲存中",	//rs_Saving
"路由器必須在新設定生效前重新啟動。您可以現在使用以下重新啟動按鈕或執行其他修改，然後使用在工具/系統設定 頁面的重新啟動按鈕。",	//sc_intro_rb
"上傳的韌體檔案可能不正確，您上傳的檔案可能非此路由器",	//ub_intro_1
"若載入的檔案是正確的，路由器有可能因太忙碌以致於無法立即正確地接收它，請試著重新載入。也有可能是您用使用者而非管理者的身分登入所致-只有管理者可載入新的韌體",	//ub_intro_3
"無法執行設定",	//_cantapplysettings
"使用者的帳戶不能配置路由器",	//ca_intro
"重新登入",	//_relogin
"路由器目前正在測量您的網路連線",	//wt_p_1
"存取此網頁可能對測量有影響",	//wt_p_2
"此頁面將很快地的重新整理",	//wt_p_3
"XXX",	//wprn_intro2
"XXX",	//wprn_bados2
"XXX",	//wprn_s1a
"XXX",	//wprn_tt5
"XXX",	//wprn_tt6
"XXX",	//wprn_tt7
"XXX",	//wprn_s2b
"XXX",	//wprn_s2c
"XXX",	//wprn_s3a
"XXX",	//wprn_tt10
"無效的WAN端子網路遮罩",	//_badWANsub
"無效的通訊閘IP位址",	//wwa_pv5_alert_4
"通訊閘IP位址不在WAN端子網路遮罩範圍內",	//wwa_pv5_alert_5
"您必須指定一個主要DNS伺服器",	//wwa_pv5_alert_8
"無效的主要DNS伺服器IP位址",	//wwa_pv5_alert_6
"無效的次要DNS伺服器IP位址",	//wwa_pv5_alert_7
"使用者名稱不能為空白",	//wwa_pv5_alert_21
"無效的PPTP通訊閘IP位址",	//_badPPTPgwip
"無效的PPTP伺服器IP位址",	//wwa_pv5_alert_15
"無效的L2TP通訊閘IP位址",	//_badL2TPgwip
"無效的L2TP伺服器IP位址",	//wwa_pv5_alert_20
"設定使用者名稱和密碼連線(PPTP)",	//wwa_title_set_pptp
"無線安全密碼必須至少為13或26個字元，您輸入",	//wwl_alert_pv5_1
"WEP密碼須為13個字元，若要輸入英文字母僅可用a-z或A-Z",	//wwl_alert_pv5_2
"WEP密碼需為26個hex字元，僅可用[0-9a-fA-F]",	//wwl_alert_pv5_3
"無線安全密碼必須至少為8個字元。",	//wwl_alert_pv5_4
"歡迎使用DI-635無線網路安全設定精靈",	//wwl_title_wel
"此精靈將會透過逐步的的程序來帶領您設定無線網路並使它有安全性。",	//wwl_intro_wel
"您的無線網路需要一個名稱來使無線用戶端可輕易的識別，為了安全起見，強烈建議更改預設為[dlink]的網路名稱。",	//wwl_intro_s1
"為了防止駭客和未經授權的使用者使用來保護您的網路，強烈建議您選擇下列無線網路安全其中之一",	//wwl_intro_s3_1
"以下有三個無線安全的層級--低安全性，中安全性或高安全性。依您無線網卡支援的加密方式來選擇層級。",	//wwl_intro_s3_2r
"中安全性",	//wwl_BETTER
"選擇這個項目代表您的無線網路使用WPA-PSK 安全加密。",	//wwl_text_better
"選擇這個項目代表您的無線網路使用WEP 128bit安全加密。",	//wwl_text_good
"當您選擇了一個無線網路安全加密等級之後，您還必須設定一個無線網路安全密碼",	//wwl_s4_intro
"請在以下欄位輸入一個無線網路安全密碼。",	//wwl_WSP_1
"(13個字元或26個hex字元)",	//wwl_wsp_chars_1
"(8-63個字元)",	//wwl_wsp_chars_2
"注意:為了啟用適當的無線通訊，您將需要在無線網路用戶端輸入相同於在此步驟鍵入的密碼",	//wwl_s4_note
"128位元",	//wwl_128bits
"使用預設WEP金鑰",	//wwl_DWKL
"Wep金鑰",	//wwl_WK
"WPA-PSK/TKIP (也可稱為 WPA Personal)",	//wwl_wpa
"WPA2-PSK/AES (也可稱為 WPA2 Personal)",	//wwl_wpa2
"TELNET",	//gw_vs_0
"遠端桌面連線",	//gw_vs_8
"AIM Talk",	//gw_sa_0
"Calista IP phone",	//gw_sa_2
"ICQ",	//gw_sa_3
"MSN Messenger",	//gw_sa_4
"PalTalk",	//gw_sa_5
"選擇BigPond伺服器",	//gw_SelBPS
"名稱1",	//gw_bp_0
"名稱2",	//gw_bp_1
"名稱3",	//gw_bp_2
"請接受和安裝ActiveX並重試一次",	//gw_wcn_alert_3
"WCN ActiveX控制項無法使用，請檢查此頁面的安全設定且重新載入來執行安裝",	//gw_wcn_alert_4
"WCN並未支援除了1之外的金鑰索引",	//gw_wcn_alert5
"WCN並未支援WPA2的模式",	//gw_wcn_alert6
"WCN尚未支援WPA enterprise的驗證方式",	//gw_wcn_alert7
"無線網路已儲存成功",	//gw_wcn_err_ok
"錯誤代碼:",	//gw_wcn_err_code
"此版本的作業系統並未支援WCN功能",	//gw_wcn_err_os_version
"載入無線網路設定檔案失敗，請執行Windows無線網路設定精靈來建立/重建 設定檔",	//gw_wcn_err_load_config
"新增無線設定檔失敗，請確認新的SSID沒有和現存的設定檔衝突",	//gw_wcn_err_provision
"寫入無線資料至設定檔失敗，請檢查加密設定",	//gw_wcn_err_io_write_config
"無線資料加密失敗",	//gw_wcn_err_encryption
"發生內部異議",	//gw_wcn_err_exception
"WCN ActiveX控制項沒有註冊，請檢查此頁面的安全設定且重新載入來執行安裝",	//gw_wcn_err_com
"無效的無線網路設定，請檢查無線網路設定",	//gw_wcn_err_bad_wsetting_entry
"無法建立無線網路設定檔XML檔案",	//gw_wcn_err_bad_wps_profile
"WPA安全模式尚未啟用，請檢查WPA加密設定",	//gw_wcn_err_unsupported_wsetting
"MSXML2 DOM parser 未符合XML格式字串的語法",	//gw_wcn_err_dom_processing
"不可預期的錯誤",	//gw_wcn_err_default
"每個人皆允許",	//adv_Everyone
"沒有人被允許",	//adv_Noone
"等候",	//psQueued
"開始",	//psStarting
"結束",	//psClosed
"閒置",	//psIdle
"就緒",	//psReady
"離線",	//psOffline
"未插上",	//psUnplugged
"列印",	//psPrinting
"紙張錯誤",	//psPaperError
"' + value + ' 字串太長(最大長度為'+ length +' 個字元).",	//up_gS_1
"數字' + value + ' 是無效的.",	//up_gIUH_1
"數字' + value + ' 必須為正數.",	//up_gIUH_2
"數字' + value + ' 應在'+ min + ' 到'+ max + '之間.",	//up_gIUH_3
"hex字串' + value + ' 是無效的.",	//up_gH_1
"沒有空間給新增的項目",	//up_ae_se_1
"'+this.primary_key_name+'欄位不可空白",	//up_ai_se_2
"'這個 '+primary_key_name+ '+ this.thearray[-1][this.primary_key] +' 已經被使用了",	//up_ae_se_3
"您尚未儲存在此項目修改的變更",	//up_ae_wic_1
"按下'Ok'來放棄這些變更且完成要求的動作",	//up_ae_wic_2
"在此頁面沒有任何改變，您仍想要儲存嗎?",	//up_nosave
"您想放棄在此頁面做的所有變更嗎?",	//up_fm_dc_1
"設定的回復失敗",	//up_fm_re_1
"點選OK來繼續設定",	//up_fm_re_2
"不正確的設定檔案",	//up_fm_dr_1
"不正確的設定檔案",	//up_fm_dr_2
"不可接受的復原資料",	//up_fm_dr_3
"動作因網路連線中斷而無法完成",	//up_if_1
"重新啟動時將會中斷目前使用中的連線",	//up_rb_2
"重新啟動中",	//up_rb_3
"回復設定至原廠預設值並重新啟動中",	//up_rb_6
"這個 +name+' 通訊埠範圍字串''+input_string+''是無效的.'",	//up_vp_1
"這個 +name+' port ''+n+'' 在通訊埠範圍內的字串''+input_string+''應要介於1-65535之間.'",	//up_vp_2
"這個 +name+' port range''+got2[0]+'' 在通訊埠範圍內的字串 ''+input_string+''應該由低到高通訊埠.'",	//up_vp_3
"這個 +name+' 通訊埠範圍字串不可空白.'",	//up_vp_0
"MAC位址的欄位不可空白",	//up_vm_1
"input_string+ 輸入的字串不是一個有效的MAC位址",	//up_vm_2
"(GMT+01:00)阿姆斯特丹,柏林,伯恩,羅馬,斯德哥爾摩,維也納",	//up_tz_26
"(GMT+01:00)貝爾格勒,布拉提斯拉瓦,布達佩斯,盧布亞納、",	//up_tz_27
"(GMT+01:00)塞拉耶佛、斯高比亞、華沙、札格雷布",	//up_tz_29
"(GMT+13:00)努瓜婁發",	//up_tz_73
"在此頁面產生一個錯誤，這有可能因為您\n+'沒有正常的登入，例如剛重新啟動之後。\n'",	//up_he_1
"按下OK來連線到登入頁面，或您想要查看錯誤訊息則請按下取消。",	//up_he_2
"錯誤在+line+' of '+url+' is\n\''+msg+'\'.'",	//up_he_5
"PPP斷線",	//IPPPPIPCP_PPP_LINK_DOWN
"PAP驗證失敗 - 請檢查登入設定",	//IPPPPPAP_AUTH_FAIL
"阻擋%v到%v從錯誤的網路介面(IP位址欺偽)接收的封包",	//IPSTACK_REJECTED_SPOOFED_PACKET
"單純網路SetDeviceSetting變更DeviceName為'%s'",	//GW_PURE_SETDEVICESETTINGS
"進階網路設定",	//ADVANCED_NETWORK
"嘗試租用指派的任務失敗 - 偵測到一個LAN端主機的IP位址%v已和%m的MAC位址使用",	//IPDHCPSERVER_HOST_IS_ACTIVE
"%S服務授權失敗: 未註冊的服務",	//BSECURE_LOG_AUTH_FAIL_UNREG
"評估的連線速率是%d kbps",	//RATE_ESTIMATOR_RATE_IS
"過濾器 - 已拒絕從IP位址%v埠%u,通訊協定%u,到%v埠%u的封包",	//GW_IPFILTER_DENY
"Pure Networks AddPortMapping '%s' %v:%d<->%v:%d %S 和第 %dth筆虛擬伺服器設定'%s' %v:%d<->%v:%d %S衝突",	//GW_PURE_ADDPORTMAPPING_CONFLICT
"單純網路SetDeviceSettings設定%S為WAN端模式, %v/%v/%v",	//GW_PURE_SETWANSETTINGS
"無法建立到email伺服器的連線",	//GW_SMTP_EMAIL_CANNOT_CREATE_CONNECTION
"PPP連線已和IP位址%v建立",	//IPPPPIPCP_PPP_LINK_UP
"遺失從%v到非法目的位址%v的封包",	//IPNAT_ILLEGAL_DEST
"單純網路AddPortMapping 修改第%d筆虛擬伺服器設定從'%s' %v:%d<->%v:%d %S 到 %S",	//GW_PURE_ADDPORTMAPPING_CHG_PROTOCOL
"%S過濾器伺服器斷線:連線逾時",	//BSECURE_LOG_FLTR_DISCONNECTED_TIMEOUT
"用戶端%02x:%02x:%02x:%02x:%02x:%02x的租約時間(%v)已撤銷",	//IPDHCPSERVER_LEASE_REVOKED1
"先前的訊息重複1次",	//LOG_PREV_MSG_REPEATED_1_TIME
"完成啟始化,啟動DHCP伺服器",	//GW_DHCPSERVER_START
"UPnP改變虛擬伺服器設定%v <-> %v:%d <-> %v:%d %S to %S",	//GW_UPNP_PORTMAP_VS_CHANGE
"租約到期%v",	//IPDHCPSERVER_LEASE_EXPIRED
"%S服務授權失敗:內部發生錯誤",	//BSECURE_LOG_AUTH_FAIL_INTNL
"Admin",	//ADMIN
"單純網路 DeletePortMapping %s:%d 修改第 %d 筆虛擬伺服器設定'%s' %v:%d<->%v:%d %S 到 %S",	//GW_PURE_DELETEPORTMAPPING_MODIFY
"單純網路AddPortMapping建立第%d筆虛擬伺服器設定'%s' %v:%d<->%v:%d %S",	//GW_PURE_ADDPORTMAPPING_CREATE
"虛擬伺服器",	//VIRTUAL_SERVERS
"UPnP刪除%v <-> %v:%d %S設定",	//GW_UPNP_PORTMAP_DEL
"單純網路重新啟動",	//GW_PURE_REBOOT
"當&quot;%s&quot;不是有效的&quot;To:&quot;位址時無法傳送email",	//GW_SMTP_EMAIL_INVALID_TO_ADDRESS
"傳送log email失敗 - 重試排程",	//GW_LOG_EMAIL_FAILED
"單純網路 SetMACFilters2",	//GW_PURE_SETMACFILTERS2
"先前的訊息重複%d次",	//LOG_PREV_MSG_REPEATED_N_TIMES
"%S過濾器伺服器斷線:關閉",	//BSECURE_LOG_FLTR_DISCONNECTED_CLOSED
"%v租約時間到期 - 一個用戶端特別請求這組位址故重新分配",	//IPDHCPSERVER_LEASE_EXPIRED_SPECIFIC
"單純網路SetRouterLanSettings設置RouterIPAddress %v, RouterSubnetMask %v, DHCPServerEnabled %s",	//GW_PURE_SETROUTERLANSETTINGS
"%S服務授權通過",	//BSECURE_LOG_AUTH_PASS
"%S服務授權失敗:授權伺服器傳回未知的錯誤",	//BSECURE_LOG_AUTH_FAIL_UNKNW
"PAP傳送驗證&quot;%s&quot;的回應到遠端對等點.",	//IPPPPPAP_AUTH_RESULT
"%S服務授權失敗:服務需要更新",	//BSECURE_LOG_AUTH_FAIL_RENEW
"遠端管理者通訊閘啟用",	//GW_REMOTE_ADMINSTRATION
"用戶端%m需要特定的位址(%v)但此位址是無效的",	//IPDHCPSERVER_LEASE_DENIED
"XXX無法傳送email (連線逾時)",	//GW_SMTP_EMAIL_TIMEOUT
"%S服務授權失敗:授權伺服器傳回DB錯誤",	//BSECURE_LOG_AUTH_FAIL_DB
"DHCP伺服器參數%u已更新",	//IPDHCPSERVER_PARAM_DB_UPDATED
"特殊應用程式規則",	//APP_RULES
"租約表已滿",	//IPDHCPSERVER_LEASE_POOL_FULL
"PAP驗證逾時 - 驗證失敗.",	//IPPPPPAP_AUTH_TIMEOUT
"進階網路",	//ADVANCED_NETWORKS
"分配新的租約時間%v到用戶端%m",	//IPDHCPSERVER_LEASE_ASSIGNED
"%S過濾器伺服器已連線",	//BSECURE_LOG_FLTR_CONNECTED
"%S 驗證伺服器已連線",	//BSECURE_LOG_AUTH_CONNECTED
"%S服務授權失敗:授權回應的封包損壞",	//BSECURE_LOG_AUTH_FAIL_PKT
"SMTP用戶端連接到伺服器%v失敗",	//IPSMTPCLIENT_CONN_FAILED
"PAP驗證成功.",	//IPPPPPAP_AUTH_SUCCESS
"由於%S放棄WCN設定",	//WCN_LOG_ABORT
"其他項目",	//MISC
"從伺服器擷取的最新韌體版本為%d.%d",	//GW_LOG_ON_LATEST_FIRMWARE_RETRIEVED
"無法傳送email (傳送狀態%u)",	//GW_SMTP_EMAIL_SEND_FAILURE
"租約%v是由用戶端%m所釋放",	//IPDHCPSERVER_LEASE_RELEASED
"透過DHCP取得的網際網路端IP位址和LAN端的IP位址衝突.網際網路功能將被停用直到您更改LAN端IP位址以解決IP位址衝突所造成的問題",	//GW_WAN_LAN_ADDRESS_CONFLICT_DHCP
"單純網路 setWLanSecurity 設定啟動 %s, 類型%s",	//GW_PURE_SETWLANSECURITY
"單純網路DeletePortMapping %s:%d 刪除第%d筆虛擬伺服器設定'%s' %v:%d<->%v:%d %S",	//GW_PURE_DELETEPORTMAPPING_DELETE
"單純網路AddPortMapping 修改第%d筆虛擬伺服器設定為從'%s' %v:%d<->%v:%d %S 到 '%s' %v:%d<->%v:%d %S",	//GW_PURE_ADDPORTMAPPING_MODIFY
"DHCP伺服器參數%u已加入到參數資料庫",	//IPDHCPSERVER_PARAM_DB_ADDED
"PAP核發一個驗證請求.",	//IPPPPPAP_AUTH_ISSUE
"UPnp 加入設定 %v <-> %v:%d <-> %v:%d %S timeout:%d '%s'",	//GW_UPNP_PORTMAP_ADD
"單純網路SetWLanSettings24設定 Enabled %s,SSIDBroadcast %s, Channel %d",	//GW_PURE_SETWLANSETTINGS24
"伺服器IP位址未知所以無法傳送email",	//GW_SMTP_EMAIL_NO_SERVER_IP_ADDRESS
"UPnP更新設定%v <-> %v:%d <-> %v:%d %S timeout:%d '%s'",	//GW_UPNP_PORTMAP_REFRESH
"UPnP期滿設定%v <-> %v:%d <-> %v%d %S '%s'",	//GW_UPNP_PORTMAP_EXPIRE
"DHCP伺服器參數%u已從參數資料庫移除",	//IPDHCPSERVER_PARAM_DB_REMOVED
"租約已從共同伺服器%v刪除",	//IPDHCPSERVER_LEASE_DELETED
"UPnP和現存設定%v <-> %v:%d <-> %v:%d %S '%s'衝突",	//GW_UPNP_PORTMAP_CONFLICT
"不是所有必須的元件已被載入;網頁重新整理.",	//TA1
"不是一個有效的IP位址",	//aa_alert_11
"必須在LAN端子網路",	//aa_alert_12
"這個過濾器的條件已被此規則定義 + data.access_ctrl_table[i].policy_name",	//aa_alert_1
"規則名稱不能為空白",	//aa_alert_9
"未儲存的規則' + unsaved_policies + ',您確定要放棄這些規則.",	//aa_sched_conf_3
"請輸入一台機器",	//aa_alert_10
"請選擇一個過濾器",	//aa_alert_13
"這個服務埠過濾器條件' + data.access_ctrl_table[-1].port_filter_table[i].entry_name +'已重複.",	//aa_alert_16
"服務埠過濾器的目的地IP起始位址= '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+'必須在LAN端子網路('+lan_subnet+')內",	//aa_alert_2
"服務埠過濾器的目的地IP結束位址 = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+'不應該在LAN端子網路 ('+lan_subnet+')內",	//aa_alert_3
"服務埠過濾器的目的地IP位址範圍無效 = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+'",	//aa_alert_4
"服務埠過濾器的目的埠範圍無效 = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+'必須在(1..65535)範圍內",	//aa_alert_5
"服務埠過濾器的起始埠範圍無效 = '+data.access_ctrl_table[-1].port_filter_table[j].entry_name+'不應該大於目的地結束埠",	//aa_alert_6
"產品頁",	//TA2
"硬體版本",	//TA3
"其他",	//aa_AT_2
"版權所有© 2004-2006 DLink, Inc.",	//_copyright
"無線封包切割率有效的起點範圍是256..65535",	//aw_alert_1
"RTS臨界值有效的起點範圍是1..65535",	//aw_alert_2
"beacon間隔有效的範圍是20..1000",	//aw_alert_3
"DTIM間隔有效的範圍是1..255",	//aw_alert_4
"附加的無線防護功能",	//aw_erpe
"DMZ位址應該在LAN端子網路('+lan_subnet+')內",	//af_alert_1
"DMZ位址不被允許",	//af_alert_2
"防火牆功能可允許區域網路中的單一電腦曝露在路由器外面.",	//af_intro_x
"(UPnP啟用時此功能自動停用)",	//TA19
"啟用DMZ功能只是最後非不得已的解決方案.如果您的電腦在路由器後端使用應用程式有問題,請先嘗試在<a href='adv_virtual.asp' onclick='return jump_if();'>虛擬伺服器</a> 或者<a href='adv_portforward.asp' onclick='return jump_if();'>通訊埠轉送</a>為應用程式開埠.",	//hhaf_dmz
"這筆''+ data.game_rules[j].entry_name + '紀錄已經存在.",	//ag_alert_4
"這筆''+ data.game_rules[j].entry_name + '紀錄和'' + data.game_rules[i].entry_name + ''重複.",	//ag_alert_5
"'TCP 通訊埠 ['+data.game_rules[i].tcp_ports_to_open+']和'+data.game_rules[j].entry_name+' 的TCP 通訊埠 ['+data.game_rules[j].tcp_ports_to_open+']衝突.'",	//ag_conflict10
"'UDP 通訊埠 ['+data.game_rules[i].udp_ports_to_open+']和'+data.game_rules[j].entry_name+' 的UDP 通訊埠 ['+data.game_rules[j].udp_ports_to_open+']衝突.'",	//ag_conflict20
"請選擇一個提供此規則' + data.game_rules[i].entry_name + ''使用的時間排程設定。'",	//ag_conflict21
"'+data.game_rules[i].entry_name+'的IP位址應該在LAN端子網路('+lan_subnet+')內'",	//ag_alert_1
"+data.game_rules[i].entry_name+'的IP位址不被允許",	//ag_alert_3
"'要開啟的TCP通訊埠'和'要開啟的UDP通訊埠'兩者欄位均不能空白.",	//ag_alert2
"TCP通訊埠",	//_tcpports
"UDP通訊埠",	//_udpports
"'TCP 通訊埠[' + data.game_rules[i].tcp_ports_to_open + ']和遠端管理的通訊埠衝突'",	//ag_conflict4
"您不可以變更設定的名稱,因為在+used_page+'頁面裡已被使用.'",	//tsc_alert_7
"無效的來源IP範圍'+data.ingress_rules[i].ingress_filter_name+'+' ('+data.ingress_rules[i].ip_range_table[j].ip_start+',+data.ingress_rules[i].ip_range_table[j].ip_end+)'",	//ai_alert_3
"啟用至少一筆來源IP範圍'+ data.ingress_rules[i].ingress_filter_name",	//ai_alert_5
"流入封包過濾器範圍' + data.ingress_rules[i].ip_range_table[k].ip_start + '-' + data.ingress_rules[i].ip_range_table[k].ip_end + ''重複.'",	//ai_alert_7
"此流入封包過濾器名稱'+(data.ingress_rules[i].ingress_filter_name)+''已被保留不可使用'",	//ai_alert_4
"此流入封包過濾器規則' + data.ingress_rules[-1].ingress_filter_name + '是重複的.'",	//ai_alert_6
"您無法刪除因為此筆輸入已在+x+'頁面使用中'",	//tsc_alert_5
"流入封包過濾器規則",	//ai_title_2
"編輯",	//_edit
"來源IP範圍",	//_srcip
"來源起始IP位址",	//ai_c2
"來源結束IP位址",	//ai_c3
"按下<strong>儲存</strong>按鈕來完成下方規則清單的設定.",	//hhai_save
"這個 ' + saved_records[i].mac_addr + ' MAC位址重複.",	//amaf_alert_1
"拒絕存取對外所有連線除了(subject to &quot;Filter Settings&quot;)清單內的電腦:",	//am_cMT_deny
"允許存取對外所有連線除了(subject to &quot;Filter Settings&quot;)清單內的電腦:",	//am_cMT_Allow
"WAN Ping<a href='Inbound_Filter.asp'' onclick='return jump_if();'>流入封包過濾器</a>",	//bwn_IF
"自動 10/100/1000Mbps",	//anet_wp_2
"尚未有路由相關資訊.",	//_sr_nriy
"此內部路由已經使用",	//ar_alert_1
"此路由已經存在",	//ar_alert_2
"Metric數值應該介於(1..16).",	//ar_alert_3
"下一個Hop不在特定的介面裡",	//ar_alert_4
"無效的子網路遮罩.",	//ar_alert_5
"透過路由表功能，您可以自行指定靜態路由的相關設定。",	//ar_RoutI
"路由",	//ar_Route
"路由表清單",	//ar_RoutesList
"刪除",	//_delete
"已存在的路由",	//ar_ERTable
"特殊應用程式規則名稱 ' + saved_records[i].entry_name + ' 重複.",	//ag_alert_duplicate_name
"特殊應用程式規則名稱 ' + saved_records[j].entry_name + '和' + saved_records[i].entry_name + '重複",	//ag_alert_duplicate
"此規則已經被使用",	//ag_inuse
"觸發通訊埠範圍 '+protocols[ae.thearray[-1].trigger_ports.protocol]+' ['+ae.thearray[-1].trigger_ports.port_range+'] 和'+saved_records[i].entry_name+''+protocols[saved_records[i].trigger_ports.protocol]+' ['+saved_records[i].trigger_ports.port_range+']衝突'",	//_specapps_alert_2
"觸發通訊埠範圍",	//_specapps_tpr
"輸入通訊埠範圍",	//_specapps_ipr
"特殊應用程式規則",	//as_title_SAR
"觸發通訊埠範圍",	//as_TPRange
"例如.",	//as_ex
"觸發通訊協定",	//as_TPR
"輸入通訊埠範圍",	//as_IPR
"輸入通訊協定",	//as_IPrt
"最大傳輸率應該介於8 kbps和100 Mbps之間.",	//at_alert_1
"&quot;名稱不可空白.&quot;",	//at_alert_15
"'+data.qos_rules[i].entry_name+'規則的優先權'+data.qos_rules[i].priority+'應該介於1和255之間.",	//at_alert_16
"'+data.qos_rules[i].entry_name+'規則的通訊協定不可空白.",	//at_alert_17
"'+data.qos_rules[i].entry_name+'規則的來源IP範圍'+data.qos_rules[i].source_ip_start+'應該在LAN端子網路('+lan_subnet+')內.",	//at_alert_2
"'+data.qos_rules[i].entry_name+'規則的來源IP範圍'+data.qos_rules[i].source_ip_start+'無效.",	//at_alert_18
"'+data.qos_rules[i].entry_name+'規則的來源IP範圍'+data.qos_rules[i].source_ip_end+'應該在LAN端子網路('+lan_subnet+')內.",	//at_alert_3
"'+data.qos_rules[i].entry_name+'規則的來源IP範圍'+data.qos_rules[i].source_ip_end+' 無效.",	//at_alert_19
"'+data.qos_rules[i].entry_name+'規則的來源IP範圍無效.'",	//at_alert_4
"'+data.qos_rules[i].entry_name+'規則的目的地IP範圍'+data.qos_rules[i].dest_ip_start+'不應該在LAN端子網路('+lan_subnet+')內.",	//at_alert_5
"'+data.qos_rules[i].entry_name+' 規則的目的地IP範圍'+data.qos_rules[i].dest_ip_start+'無效.",	//at_alert_20
"'+data.qos_rules[i].entry_name+'規則的目的地IP範圍'+data.qos_rules[i].dest_ip_end+'不應該在LAN端子網路('+lan_subnet+')內.",	//at_alert_6
"'+data.qos_rules[i].entry_name+'規則的目的地IP範圍'+data.qos_rules[i].dest_ip_end+'無效.",	//at_alert_21
"'+data.qos_rules[i].entry_name+'規則的目的地IP範圍無效.",	//at_alert_8
"'+data.qos_rules[i].entry_name+'規則的來源通訊埠範圍應該介於0和65535之間.",	//at_alert_7
"'+data.qos_rules[i].entry_name+'規則的來源通訊埠起始範圍應該少於來源通訊埠結束範圍.",	//at_alert_10
"'+data.qos_rules[i].entry_name+'規則的目的地通訊埠應該介於0和65535之間.",	//at_alert_9
"'+data.qos_rules[i].entry_name+'規則的目的地通訊埠起始範圍應該少於目的地通訊埠結束範圍.",	//at_alert_11
"名稱'+data.qos_rules[i].entry_name+'已經被使用.",	//at_alert_22
"'+data.qos_rules[j].entry_name+'的來源/目的地 IP範圍和'+data.qos_rules[i].entry_name+'發生重疊.",	//at_alert_23
"'+data.qos_rules[j].entry_name+'來源/目的地的IP/通訊埠範圍和'+data.qos_rules[i].entry_name+'發生重疊.",	//at_alert_24
"通訊協定'ANY'包含IGMP所以停用通訊埠範圍.如果您要設定通訊埠範圍請選擇TCP或UDP.",	//at_alert_14
"D-Link's QoS Engine功能是由QoS Engine&trade;科技所提供的核心技術.QosEngine功能利用把遊戲流量的優先權設定高於其他網路流量,例如FTP或瀏覽網頁,增進您對使用線上遊戲的體驗  .",	//at_intro
"為了最佳效能,使用自動分配功能為您的應用程式設定優先權.",	//at_intro_2
"QoS Engine 設定",	//at_title_SESet
"啟用QoS Engine",	//at_ESE
"偵測到 xDSL Or Other Frame Relay Network",	//at_DxDSL
"QoS Engine規則",	//at_title_SERules
"(1..255)",	//at_lowpriority
"ANY",	//at_Prot_0
"來源通訊埠範圍",	//_srcport
"目的地IP範圍",	//at_DIPR
"目的地通訊埠範圍",	//at_DPR
"紀錄' + data.virtual_servers[j].entry_name + '是重複的.",	//av_alert_11
"紀錄' + data.virtual_servers[j].entry_name + '和' + data.virtual_servers[i].entry_name + '重複.",	//av_alert_21
"請選擇適合此紀錄' + data.virtual_servers[i].entry_name + '的時間排程.",	//av_alert_24
" + data.virtual_servers[i].entry_name + '的IP位址應該在LAN端子網路('+lan_subnet+')內",	//av_alert_1
" + data.virtual_servers[i].entry_name + '的IP位址不被允許",	//av_alert_2
" + data.virtual_servers[i].entry_name + '的私人通訊埠應該在(1..65535)範圍內",	//av_alert_3
" + data.virtual_servers[i].entry_name + '的公用通訊埠應該在(1..65535)範圍內",	//av_alert_4
"公用通訊埠不能和遠端管理通訊埠相同",	//av_alert_12
"無法建立ICMP(protocol 1)的任何設定,	會造成路由器無法正常運作",	//av_alert_18
"無法建立IGMP(protpcol 2)的任何設定,	會造成路由器無法正常運作",	//av_alert_23
"請選擇代替protocol 6的TCP並且指定通訊埠細項",	//av_alert_19
"請選擇代替protocol 17的UDP並且指定通訊埠細項",	//av_alert_20
" + data.virtual_servers[i].entry_name + '的其他通訊協定應該介於(3..5, 7..16 或 18..255)",	//av_alert_13
" + data.virtual_servers[i].entry_name + '的通訊協定和' + data.virtual_servers[j].entry_name+'重疊",	//av_alert_17
"' + data.virtual_servers[i].entry_name + '的通訊埠和' + data.virtual_servers[j].entry_name+'重疊",	//av_alert_5
"' + data.virtual_servers[i].entry_name + '的私人通訊埠和' + data.virtual_servers[j].entry_name+'發生衝突",	//av_alert_6
"已啟用FTP ALG",	//av_alert_7
"已啟用PPTP ALG",	//av_alert_8
"已啟用Wake-On-LAN ALG",	//av_alert_9
"已啟用H.323 ALG",	//av_alert_10
"公用",	//_public
"其它",	//_other
"私人",	//_private
"選擇此規則何時該啟用的時間排程.如果您在清單內沒有看到所需要的排程,到<a href='tools_schedules.asp' onclick='return jump_if();'>工具 &rarr; 排程</a> 的畫面並建立新的時間排程.",	//hhav_sch
"選擇一筆過濾器來限制網際網路上的主機透過虛擬伺服器存取您信任的電腦.若您在過濾器清單沒有看到所需的過濾器,到<a href='Inbound_Filter.asp'' onclick='return jump_if();'> 進階功能 &rarr; 流入封包過濾器</a>的畫面並建立新的過濾器.",	//hhav_filt
"網頁",	//aa_WebSite
"不支援https通訊協定",	//awf_alert_4
"此網頁位址'' + data.web_filter[i].url + ''已經存在.",	//awf_alert_5
"此網頁位址' + invalid_wf_str + '無效.",	//awf_alert_7
"此網頁位址' + invalid_wf_str + '無效.'",	//awf_alert_8
"必須和<a href='adv_access_control.asp' onclick='return jump_if();'>存取控制</a>一起使用.",	//hhwf_xref
"網際網路連線設定精靈",	//int_ConWz2
"如果您要利用簡單的設定精靈來協助您設定DLink 路由器連線到網際網路,還有無線網路設定,請按下下方的精靈執行按鈕,開始設定。",	//int_intro_ConWz
"手動設定網際網路連線",	//int_WlsWz
"您果您想要手動設定DLink 路由器,請按下下方的手動設定按鈕.",	//int_intro_WlsWz
"如果您是網路新手且從來沒有設定過路由器,請按下<strong>設定精靈</strong>路由器將會引導您經由幾個簡單的步驟設定完成網路連線.",	//hhbi_wiz
"如果您是網路進階使用者且之前有設定過路由器,請按下<strong>手動設定</strong>自行輸入設定.",	//hhbi_man
"尚未偵測到動態用戶端.",	//bd_noneyet
"租約已被取消",	//bd_revoked
"無效的LAN端IP位址",	//bln_alert_2
"LAN端子網路遮罩和WAN端發生衝突",	//bln_alert_3
"起始的DHCP位址範圍不在LAN端子網路內.",	//bd_alert_10
"結束的DHCP位址範圍不在LAN端子網路內.",	//bd_alert_11
"DHCP起始位址不包含一個有效的主機起始值.",	//bd_alert_1
"DHCP位址範圍應該由低至高,不是由高至低",	//bd_alert_3
"DHCP位址範圍不能包含子網路廣播位址",	//bd_alert_13
"範圍內的IP位址數目超過256的限制.",	//bd_alert_12
"DHCP 租約時間不可為 0",	//bd_alert_5
"MAC位址('+ae.thearray[-1].mac_addr+')的IP位址已經保留",	//bd_alert_6
"電腦名稱('+ae.thearray[-1].comp_name+')的IP位址已經保留",	//bd_alert_7
"預約的IP位址不能和LAN IP位址相同.",	//TA20
"保留的IP位址應該在DHCP設定的範圍內.",	//bd_alert_8
"如果您的區網已經有DHCP伺服器或是您的電腦使用指定IP位址,請不要勾選<strong>啟用DHCP伺服器 </strong>.",	//TA7
"如果區網的電腦必須永遠使用指定IP,請在<strong>靜態DHCP </strong>為每個裝置設定IP.",	//TA8
"在設定次要的DNS伺服器前請務必指定主要的DNS伺服器",	//bd_alert_22
"無效的主要DNS IP位址",	//bd_alert_23
"無效的次要DNS IP位址",	//bd_alert_24
"無效的WAN端IP位址",	//_badWANIP
"無效的WAN端子網路遮罩",	//bwn_alert_2
"預設的通訊閘位址不在WAN端子網路內",	//bwn_alert_3
"DNS未設定.用戶端將不會解決網域名稱.繼續處理?",	//bwn_alert_4
"WAN端子網路遮罩和LAN端發生衝突",	//bwn_alert_5
"請再次輸入使用赭名稱",	//_nousername
"最大閒置時間應該在0..600範圍內",	//bwn_alert_8
"無效的PPPoE IP位址",	//bwn_alert_12
"無效的PPTP IP位址",	//_badPPTPip
"無效的PPTP子網路遮罩",	//_badPPTPsub
"PPTP通訊閘IP位址不在PPTP子網路遮罩內",	//_badPPTPipsub
"無效的PPTP伺服器IP位址",	//bwn_alert_11
"無效的L2TP IP位址",	//_badL2TP3
"無效的L2TP子網路遮罩",	//_badL2TP
"L2TP通訊閘IP位址不在L2TP子網路遮罩內",	//_badL2TP2
"無效的L1TP伺服器IP位址",	//bwn_alert_17
"MTU值應該介於128..30000範圍內",	//bwn_alert_21
"WEP 金鑰 '+ wep_error_msg + ' 無效.",	//bws_alert_15
"WEP 金鑰 '+ wep_error_msg + ' 無效.",	//bws_alert_16
"在802.11a模式下不能使用802.11b/g的頻道",	//bwl_alert_2
"在802.11b/g模式下不能使用802.11a的頻道",	//bwl_alert_3
"RADIUS伺服器通訊埠不可空白.",	//bwl_alert_15
"RADIUS 伺服器通訊埠' + data.wireless.radius_server_port + '應該介於(1..65535).",	//bwl_alert_16
"PHY模式設定為802.11a時不能使用802.11b的傳輸率",	//bwl_alert_4
"PHY模式設定為802.11b時不能使用802.11a/g的傳輸率",	//bwl_alert_5
"Static Turbo mode和802.11b不相容",	//bwl_alert_6
"Dynamic Turbo mode和802.11b不相容",	//bwl_alert_7
"11g Turbo模式下,頻道應該設定在 6",	//bwl_alert_8
"11a Static Turbo模式下,頻道應該設定在42,50,58,152, or 160其中之一.",	//bwl_alert_9
"11a Dynamic Turbo模式下,頻道應該設定在40,48,56,153 or 161其中之一.",	//bwl_alert_10
"不正確的金鑰長度,應該介於 8 到 63 個字元.",	//bws_alert_2
"WPA金鑰群組更新間隔時間應該介於 30 到 65535 秒.",	//bwl_alert_11
"IEEE 802.1X 認證逾時時間應該介於 1 到 65535 分鐘.",	//bwl_alert_12
"WEP 金鑰 '+(i+1)+' 必須為 '+len+' 個字元長度",	//bws_alert_3
"啟用WDS模式時請勿勾選'自動選擇頻道'.",	//aw_alert_5_1
"IP address ' + data.wireless.radius_server_address + ' 無效.'",	//bwl_alert_13
"IP address ' + data.wireless.second_radius_server_address + ' 無效.'",	//bwl_alert_14
"802.11g only",	//bwl_Mode_2
"Mixed 802.11g and 802.11b",	//bwl_Mode_3
"802.11b only",	//bwl_Mode_1
"802.11n only",	//bwl_Mode_8
"Mixed 802.11n, 802.11g and 802.11b",	//bwl_Mode_11
"20 MHz",	//bwl_ht20
"Auto 20/40 MHz",	//bwl_ht2040
"Best (automatic)",	//bwl_TxR_0
"為了保護您的隱私,您可以自行設定無線安全功能.DIR-635提供三種無線安全加密模式:WEP, WPA-Personal, and WPA-Enterprise. WEP是基本的加密標準. WPA提供較高層次的安全性. WPA-Enterprise和WPA-Personal的差別在於WPA-Enterprise需要透過額外的RADIUS伺服器來做認證.",	//bws_intro_WlsSec
"如果您選擇WEP加密模式,<strong>只會</strong>在<strong>無線模式(802.11B/G)下</strong>運作.意思是您將<strong>無法</strong>得到11N的傳輸效能,因為事實上11N草案規格裡不支援WEP加密模式.",	//bws_msg_WEP_3
"WEP式無線加密的標準.您必須在無線網路用戶端輸入相同的金鑰. 使用 64 bit加密時，您必須輸入10個HEX字元。使用 128 bit 加密時，您必須輸入26個HEX字元. HEX字元代表數字 0 到 9 或是英文字母 A 到 F. 大部分在啟用WEP加密時的認證類型設定為&quot;共用金鑰&quot;.",	//bws_msg_WEP_1
"您也可以在WEP金鑰欄位輸入任何字串, 它會將ASCII碼轉換成HEX碼. 使用 64 bit加密時可輸入最多5個字元, 使用 128 bit加密時可輸入最多13個字元.",	//bws_msg_WEP_2
"WEP 加密類型",	//bws_WKL
"64 bit (10 hex digits)",	//bws_WKL_0
"128 bit (26 hex digits)",	//bws_WKL_1
"(length applies to all keys)",	//bws_length
"WEP 金鑰 1",	//_wepkey1
"WEP 金鑰 2",	//_wepkey2
"WEP 金鑰 3",	//_wepkey3
"WEP 金鑰 4",	//_wepkey4
"預設使用的WEP金鑰",	//bws_DWK
"Open",	//_open
"Shared Key",	//bws_Auth_2
"使用<strong>WPA 或 WPA2</strong>加密模式來達到強大的安全性和最佳相容性的平衡. 用戶端使用WPA加密模式為了保持工作站較高的安全性且和WPA2相容. 也是用戶端支援的最強大的演算法. 使用<strong>WPA2 Only</strong>加密模式擁有最佳的安全性. 此模式使用 AES(CCMP) 演算法且無法和WPA相容. 為了最大的相容性, 建議使用<strong>WPA Only</strong>. 此模式使用TKIP演算法. 某些裝置只能在此模式下運作.",	//bws_msg_WPA
"使用<strong>WPA2 Only</strong>加密模式(或是其它的AES演算法).是為了達到更好的無線傳輸效能.",	//bws_msg_WPA_2
"Auto (WPA or WPA2)",	//bws_WPAM_2
"WPA Only",	//bws_WPAM_1
"更改您的無線網路名稱是加強無線安全性的第一步. 請設定為其它的名稱並且不要包含任何個人資訊.",	//TA9
"啟用自動選擇頻道,路由器會自動選擇環境中干擾最少的頻道來供無線網路傳輸使用。 ",	//TA11
"關閉SSID廣播功能是另一種加強無線安全性的方法. 關閉SSID廣播功能, 無線網路用戶端在檢視無線網路時將無法搜尋到您的基地台. 當電腦要連線到基地台時, 必須在每個用戶端手動設定無線網路名稱.",	//TA12
"如果您啟用無線加密模式, 請確認您已記下所設定的網路金鑰.",	//TA14
"您必須在每一台要連線到無線網路的電腦輸入這些資訊.",	//TA15
"設定精靈",	//_wizard
"The D-Link RangeBooster N&trade; 650 是由 QoS Engine&trade;科技所提供的核心技術滿足個別使用者對線上遊戲所要求的高品質、可靠、穩定的連線效能.",	//bwz_intro
"透過下面的設定精靈協助您設定D-Link Router連線到網際網路.設定精靈將會一步步的引導您設定.請按下下方的精靈執行按鈕,開始設定。",	//bwz_intro_ConWz
"執行網際網路連線設定精靈",	//bwz_LConWz
"無線網路安全設定精靈",	//bwz_WlsWz
"透過下面的設定精靈協助您設定無線網路.設定精靈將會一步步的引導您設定無線網路,並且加強無線網路的安全性.",	//bwz_intro_WlsWz
"執行網際網路連線設定精靈",	//bwz_LWlsWz
"完成評估速率. 上傳速率是 %u kbps",	//RATE_ESTIMATOR_RATE_COMPLETED_WITH_SPEED
"完成評估速率",	//RATE_ESTIMATOR_RATE_COMPLETED
"特殊應用程式",	//_specapps
"Gaming",	//_gaming
"網站過濾器",	//_webfilter
"設定",	//_basic
"名稱不能為空白.",	//ag_alert_empty_name
"此名稱'+ data.game_rules[j].entry_name + ' 重覆.",	//ag_alert_duplicate_name2
"不允許這個MAC過濾區域,因為它會鎖死所有的電腦",	//amaf_alert_2
"此名稱 ' + saved_records[i].entry_name + ' 重覆.",	//specapps_alert_duplicate_name
"規則 ' + saved_records[j].entry_name + ' 和 ' + saved_records[i].entry_name + ' 重覆.",	//specapps_alert_duplicate1
"觸發埠範圍 ''+saved_records[i].entry_name+'' '+protocols[saved_records[i].trigger_ports.protocol]+'  ['+saved_records[i].trigger_ports.port_range+'] 和 ''+saved_records[j].entry_name+'' '+protocols[saved_records[j].trigger_ports.protocol]+' ['+saved_records[j].trigger_ports.port_range+'] 衝突.'",	//specapps_alert_conflict1
"請選擇規則 ''+ data.port_trigger_rules[i].entry_name + '' 的排程.",	//specapps_alert_empty_schedule
"設定網路流量控制",	//at_title_TSSet
"啟動網路流量控制",	//at_ETS
"'' + entry_1.entry_name + '' 的 '' + entry_1.user_protocol + '' 協定和 ''+ entry_2.entry_name + '' 衝突.",	//av_alert_35
"'名稱' 欄位不能為空白",	//av_alert_empty_name
"'名稱''+ data.virtual_servers[j].entry_name + ''已被使用.'",	//av_alert_16
"主要的 WINS IP 位址必須設定",	//bln_alert_lannbpri
"次要的 WINS IP 位址不正確",	//bln_alert_lannbsec
"主要的DNS伺服器",	//lan_dns
"次要的DNS伺服器",	//lan_dns2
"NetBIOS 通知",	//bd_NETBIOS
"從WAN學習NetBIOS訊息",	//bd_NETBIOS_WAN
"主要WINS伺服器的IP位址",	//bd_NETBIOS_WINS_1
"次要WINS伺服器的IP位址",	//bd_NETBIOS_WINS_2
"NetBIOS範圍",	//bd_NETBIOS_SCOPE
"NetBIOS 註冊模式",	//bd_NETBIOS_REG
"Hybrid (點對點然後廣播)",	//bln_NetBIOSReg_H
"混合模式 (先廣播然後點對點)",	//bln_NetBIOSReg_M
"點對點 (不廣播)",	//bln_NetBIOSReg_P
"只廣播 (當沒有WINS伺服器設定時始用)",	//bln_NetBIOSReg_B
"802.11n 及802.11g混合模式",	//bwl_Mode_10
"支援",	//_help
"當這個功能被啟用, 路由器會限制外部的流量以避免超過WAN上傳的頻寬",	//help81ets
"NAT終點過濾的選項控制路由器NAT如何控管從新連接的要求到已被始用的通訊埠的管理",	//af_EFT_h4
"一但經由一個特別的通訊埠建立起的區網端應用程式連線, NAT會轉送任何有連接到相同區網端應用程式的新連線要求,不論此要求來自那. 這是最低的限制選項,提供最佳的連線及允許一些應用程式(特別是點對點的應用程式) 如同直接連接到網路的運作",	//af_EFT_h0
"NAT只轉送當新連線的要求是來自於已連線的相同連線IP位置給區網端主機.這樣可以使遠端應用程式經由與已建立的對外連線的不同通訊埠傳送資料回來",	//af_EFT_h1
"NAT 無法傳遞新的連結要求中含有任何已經驗證連結",	//af_EFT_h2
"注意!部份選項可與其他通訊埠限制互相影響. 終點獨立過濾比流入封包過濾或排程有更高的優先權.因此讓與對外封包有關連的流入封包要求通過沒有流入封包過濾器的通訊埠,是有可能的.然而可遇期的,封包會因被送至因沒有傳送中封包而封鎖的通訊埠而被拒絕,不論通訊埠是因排程或流入封包過濾器而封鎖. 通訊埠及位置限制過濾器確保流入過濾及排程能運作正常但避免某些程度的連線. 因此也許會要求始用通訊觸發埠,虛擬伺服器或利用通訊埠轉送來開啟應用程式所需的通訊埠. 位置限制過濾器提供一個折衷的位置可避免當與部份其他型式路由器連接時產生的問題(特別是對稱式的NAT),同時確保來源過慮及排程能如預期進行.",	//af_EFT_h5
"控制UDP協定封包的終點過濾器",	//af_UEFT_h1
"控制TCP協定封包的終點過濾器",	//af_TEFT_h2
"只有在802.11是設在802.11n only或 802.11g only時這個選項才是可被選擇的",	//aw_erpe_h2
"(請參考<a href='wireless.asp'>設定&rarr;無線網路設定</a>網頁.)",	//aw_erpe_h3
"在本地區域網路中的子網路遮罩",	//help309A
"NetBIOS 允許區域網路主機發現所有在此網域的其它電腦, 例如: 在網路芳鄰中.",	//help400_1
"把這個設定選項關閉將可進入手動模式.",	//help401_1
"WINS 伺服器儲存網路主機的資訊, 它可讓其他主機註冊,以及找尋其他可用主機. 可用於例如網路芳鄰.",	//help402_1
"如果 '從WAN端學習 NetBios 資訊' 已經啟動, 那麼這個設定無效",	//help402_2
"這表示複合狀態的運作. 首先嘗試 WINS 伺服器, 如果有的話, 接下來作區域網路廣播. 如果你有設好的WINS 伺服器, 通常這是最常用的模式.",	//help405_1
"M-Node (預設), 這表示混合狀態的運作. 首先作網路廣播, 以便註冊主機, 及找尋其他可用主機. 如果網路廣播失敗, 嘗試找尋WINS 伺服器, 如果WINS 伺服器在低速網路中, 而大多數其他伺服器及印表機在區域網路中, 可以選用這個模式.",	//help405_2
"P-Node, 這個選項是指 只使用 WINS 伺服器. 這個選項是在強制設定 WINS 伺服器中的NetBIOS選項時特別有幫助. 你至少必需有設定好的主要WINS伺服器IP位址去表明已經在工作中的WINS伺服器.",	//help405_3
"B-Node, 這個選項是指只使用本地網路廣播. 這項設定是在沒有 WINS伺服器時特別有幫助, 不過, 建議你先使用 N-Node選項.",	//help405_4
"錯誤的設定 - 請檢視記錄器",	//_sdi_s1a
"無效的來源遠端管理埠'+data.web_server_wan_port_https+', 範圍必需在 (1..65535)'",	//ta_alert_3b
"來源遠端管理埠和遠端管理埠不能為相同的設定.",	//ta_alert_3c
"你必需啟動管理器中的一個方法.",	//ta_alert_3d
"無效的來源管理埠'+data.web_server_lan_port_http+',範圍必需在 (1..65535)'",	//ta_alert_3e
"無效的來源管理埠'+data.web_server_lan_port_https+',範圍必需在 (1..65535)'",	//ta_alert_3f
"來源管理埠和本地管理埠不能為相同的設定.",	//ta_alert_3g
"啟動管理",	//ta_ELM
"管理通訊埠",	//ta_LMAP
"登入錯誤",	//fb_FailLogin
"需要正確的密碼才能存取這項裝置.",	//fb_FailLogin_1
"email 系統記錄",	//KR67
"目的地端通訊埠應在0到65535之間。",	//YM71
"來源 IP 範圍與 '%v-%v' 相同。",	//GW_FIREWALL_RANGE_DUPLICATED_INVALID
"硬體位址",	//LS422
"使用Windows WCN 功能",	//bwz_LWCNWz
"無效的WAN 端通訊閘IP 位址: %v",	//GW_WAN_WAN_GATEWAY_IP_ADDRESS_INVALID
"儲存設定值至無線網路設定精靈",	//ta_wcn
"辨識碼(PIN)是用來增加路由器至一個已存在的網路或建立一個新網路的獨特數值。預設的PIN碼可能印在路由器的底部貼紙上。為了增加安全性，您可以建立一個新的辨識碼。您可以在任何時間恢復辨識碼至原廠預設值。但僅有管理者(admin)帳戶才可以更改或重置此辨識碼。",	//LW57
"Hop",	//tsc_pingt_msg109
"NetBIOS 網點類型",	//bd_NETBIOS_REG_TYPE
"請按下下方的&quot;繼續&quot;按鈕，以繼續設定路由器。",	//ap_intro_cont
"建立一個任意的數值做為有效的辨識碼，此數值將會成為路由器的無線存取辨識碼。您可以複製此辨識碼到登錄者(無線用戶端)的使用者介面。",	//LW60
"回存設定值失敗",	//_rs_failed
"若裝置從其他路由器連線到一個區域網路則選擇此項目。在此模式下，裝置功能像一個介於網路的WAN埠和裝置的LAN埠之間用無線連接起的橋樑(沒有NAT 功能)。",	//KR62
"NetBIOS 通知",	//bd_NETBIOS_ENABLE
"本地端區域網路的子網路遮罩。",	//KR77
"Super G with Dynamic Turbo",	//help364
"購物",	//_aa_bsecure_shopping
"公用代理",	//_aa_bsecure_public_proxies
"WEP 金鑰 1",	//wepkey1
"傳送/接收 授權特許",	//ZM11
"啟動時間",	//tsc_start_time
"來源結束通訊埠應在0到65535之間。",	//YM69
"若NetBIOS宣告(advertisement)開啟，將因WINS資訊從WAN端被學習到而啟動此設定。",	//KR82
"只有管理者才有權限可以存取這些功能。",	//LW39b
"時間計畫規劃名稱 '%s' 為預設保留您無法使用",	//GW_SCHEDULES_NAME_RESERVED_INVALID
"增加無線工作站",	//LW12
"Windows Media Center",	//YM75
"路由器通訊閘IP 位址 %v 為無效的",	//GW_ROUTES_GATEWAY_IP_ADDRESS_INVALID
"WPA 群組金鑰更新間隔設定範圍應該在30~65535 秒之間。",	//GW_WLAN_WPA_REKEY_TIME_INVALID
"啟用L2(Layer 2)阻絕功能，可預防無線網路用戶端相互溝通連結。",	//KR58
"Gambling",	//_aa_bsecure_gambling
"橋接模式",	//KR14
"FROM 位址(%s) 為無效的",	//GW_SMTP_FROM_ADDRESS_INVALID
"表示網路主機如何去執行NetBIOS名稱註冊和探索。",	//KR89
"網路遮罩:",	//help106
"當設定路由器去存取網路時，需確認在下拉式選單內選擇的是正確的  <strong>網際網路連線類型</strong>。若您不確定該選擇何種類型，請聯絡您的 <strong>網路服務提供者(ISP) </strong>。",	//LW35
"語音 (最急迫)",	//YM151
"您所作的變更已經被儲存，路由器必須重新啟動後才能套用剛才的變更。您可以馬上重新啟動，或是繼續變更其他設定，稍後再重新啟動路由器。",	//YM2
"路由器的設定在設定精靈操作期間因未知的操作被變更。\n設定精靈功能將取消操作，請重新一次。",	//YM131
"HTTP and HTTPS cannot occupy the same LAN port.",	//GW_WEB_SERVER_SAME_PORT_LAN
"重新啟動",	//YM3
"<warn>虛擬伺服器已經有一筆相同需求的設定被新增，Wake-On-LAN ALG 已經自動啟用。</warn>",	//GW_NAT_WOL_ALG_ACTIVATED_WARNING
"無效的目的地IP 範圍(通訊埠過濾功能)",	//YM20
"如果您要允許&quot;WISH&quot;功能自動處理流量優先順序，請啟用此功能。",	//YM141
"無效的WAN 端MAC 位址: %m",	//GW_WAN_MAC_ADDRESS_INVALID
"收件E-mail 位址為無效的格式",	//IPSMTPCLIENT_MSG_WRONG_RECEPIENT_ADDR_FORMAT
"WISH支援重疊規則的定義。若有一個以上的規則符合一個特定的訊息來源，則擁有最高優先權的規則將會先被執行。",	//YM146
"設定警告",	//LS151
"規則名稱不能為空的字串。",	//GW_QOS_RULES_NAME_INVALID
"規則名稱不能為空的字串。",	//GW_WISH_RULES_NAME_INVALID
"增加無線工作站%m 失敗，原因: %s，錯誤代碼 %u",	//WIFISC_IR_REGISTRATION_FAIL
"路徑清單",	//r_rlist
"輸入8~63 個英數混合字元的通行金鑰。",	//KR18
"創作者",	//sa_Originator
"通訊埠範圍不能為空值",	//GW_NAT_PORT_FORWARD_RANGE_BOTH_EMPTY_INVALID
"路由通訊閘IP %v ，與該界面為不同網段",	//GW_ROUTES_GATEWAY_IP_ADDRESS_IN_SUBNET_INVALID
"無線網路設定精靈",	//LW37
"當同樣身分的使用者登入時，這個功能將被停用",	//tsc_pingdisallowed
"要將設定儲存的話，請按下 <strong>儲存設定</strong> 按鈕。",	//ZM20
"密碼類型:",	//help376
"在 工具->Email 設定頁面中，Email 通知功能並未啟用；但 工具->軔體 頁面中的Email軔體更新通知功能已經啟用。",	//GW_FW_NOTIFY_EMAIL_DISABLED_INVALID
"無效的WEP 金鑰",	//YM122
"DMZ 位址 %v 不能與LAN 界面IP位址相同。",	//GW_NAT_DMZ_CONFLICT_WITH_LAN_IP_INVALID
"起始通訊埠必須小於結束通訊埠: %d-%d。",	//GW_INET_ACL_START_PORT_INVALID
"Email 寄送失敗!",	//IPSMTPCLIENT_DATA_FAILED
"M-Node(預設值)表示一個執行的混合模式。第一次廣播執行是表現註冊主機和探索其他主機，若有廣播執行失敗的話，WIN伺服器會嘗試執行。",	//KR91
"意見",	//_aa_bsecure_opinion
"回復設備設定至出廠預設值",	//tss_RestAll_b
"%s of '%s' [%s:%s]->%s 與 '%s' [%s:%s]->%s 衝突。",	//GW_NAT_PORT_TRIGGER_CONFLICT_INVALID
"當訊框(frame)位元組值大於分裂門檻時將會產生碎裂化。",	//LW54
"IP 位址須與本設備在同一區域網路端。",	//KR74
"預設 WEP 金鑰",	//bws_DFWK
"若您是無線網路的新手，而且之前從未設定過無線寬頻路由器；請點選<strong>無線網路設定精靈</strong>，將會透過幾個簡易的步驟來設定無線寬頻路由器，引導您快速的完成無線網路設定。",	//LW46
"SMTP (Email)伺服器 %s IP 位址為 %v",	//IPSMTPCLIENT_RESOLVED_DNS
"界面:",	//help110
"無效的PPTP 通訊閘IP 位址",	//YM107
"閒置超時時間設定值最大不能超過8760。",	//YM180
"無效的WAN 子網路遮罩 %v",	//GW_WAN_WAN_SUBNET_INVALID
"<warn>DMZ 功能已經停用，因為LAN 端子網路已經被變更。</warn>",	//GW_NAT_DMZ_DISABLED_WARNING
"您要停用這個IP 位址的DHCP 保留記錄功能嗎?",	//YM93
"<warn>虛擬伺服器已經有一筆相同需求的設定被新增，FTP ALG 已經自動啟用。</warn>",	//GW_NAT_FTP_ALG_ACTIVATED_WARNING
"不受限的主機",	//_aa_bsecure_free_host
"無效的路徑網路遮罩",	//_r_alert2
"無效的MAC 位址",	//LS47
"LAN 端子網路遮罩沒有足夠的位址為DHCP 伺服器使用。",	//GW_DHCP_SERVER_SUBNET_SIZE_INVALID
"MAC 位址 %m 不能新增，您只能由其他的規則中重新定義MAC 位址。",	//GW_INET_ACCESS_POLICY_TOO_MANY_MAC_INVALID
"起始IP位址必須小於結束IP 位址: %v-%v",	//GW_FIREWALL_START_IP_ADDRESS_INVALID
"秒",	//YM8
"旅遊",	//_aa_bsecure_travel
"路徑是一個從1到16的數值用來表示此路徑使用的成本。數值1表示成本最低，而15則是成本最高。數值16代表從此路由器無法到達的路徑。當嘗試去到達一個特定的目的地時，您網路中的電腦將會選則一個最佳路徑，會略過無法達到的路徑。",	//help113
"BigPond 用戶端",	//ZM6
"WCN Active X控制項透過瀏覽器提供介於路由器和您的電腦之間需要的WCN連結。若您的電腦尚無可用的WCN Active X控制項，瀏覽器將會嘗試去下載。為了使這個動作能成功的執行，WAN端的連線必須被建立，且瀏覽器的網際網路安全性必須設定為中安全性或較低（選擇&quot;工具&quot;&rarr; 網際網路選項 &rarr; 安全性 &rarr; 自定層級 &rarr; 中)。",	//help836
"請使用有效的回存設定值檔案再重新回存設定一次。",	//rs_intro_2
"IP 位址 %v 已經存在。",	//GW_INET_ACL_IP_ADDRESS_DUPLICATION_INVALID
"您必須使用管理者登入後，才有權限使用這些功能。",	//KR7
"(UPnP 功能啟用時自動停用)",	//ZM1
"手動進行網路連線設定",	//LW30
"無效的L2TP 子網路遮罩",	//YM110
"點對點傳送(不進行廣播)",	//bd_NETBIOS_REG_TYPE_P
"無效的LAN 端子網路遮罩。",	//GW_LAN_SUBNET_MASK_INVALID
"沒有更多的保留可以被新增",	//YM88
"無效的主要WINS IP 位址",	//GW_DHCP_SERVER_NETBIOS_PRIMARY_WINS_INVALID
"名稱",	//YM187
"%s 規則名稱 %s 在 '%s' 沒有被定義清楚。",	//GW_NAT_NAME_UNDEFINED_INVALID
"偵測到的無線網路頻道 %d",	//GW_WIRELESS_RADAR_DETECTED
"預先共用金鑰(Pre-shared Key)",	//LW25
"回存設定值無效",	//_rs_invalid
"無效的主要DNS 伺服器IP位址",	//YM113
"Wi-FI 防護設定",	//LW65
"如果您的無線裝置支援上傳按鈕(Push Button)，請選擇這個功能",	//KR41
"無效的主要DNS 伺服器IP 位址: %v",	//GW_WAN_DNS_SERVER_PRIMARY_INVALID
"不可用的無線裝置辨識碼",	//KR21
"個人",	//_aa_bsecure_personals
"下方的<span class='option'>路由器LAN 端IP位址</span>欄位必須被設定(代表路由器的IP位址)，而<span class='option'>通訊閘</span>必須設定為上端路由器的IP位址。此兩者的位址必須在<span class='option'>子網路遮罩</span>中，在被定義的LAN 端子網路同一範圍。",	//KR63
"下面的網頁介面設定精靈是用來輔助您設定透過網路分享您介接在路由器上的印表機。此設定精靈將會透過一步一步的指示來教導您如何進行相關設定。",	//LW31
"無效的次要DNS 伺服器IP 位址: %v",	//GW_WAN_DNS_SERVER_SECONDARY_INVALID
"如果您要手動設定網際網路的話，請按下下面的按鈕。",	//LW29
"無效的遠端結束IP位址。",	//YM55
"無線裝置支援設定方式的更多資訊，請參考無線網卡相關使用手冊。",	//KR37
"請勾選這項目允許DHCP 伺服器提供NetBIOS 配置設定至LAN 端主機。",	//KR80
"無效的WNA 端子網路遮罩",	//YM100
"Wake-On-LAN",	//_wakeonlan
"裝置可能太忙碌以致於現在無法接收正確，請再次嘗試回存設定檔一次。也有可能因為您以&quot;使用者&quot;帳戶登入而非&quot;管理者&quot;-僅有管理者可以回存設定檔，任何裝置相關錯誤，請查看系統紀錄。",	//rs_intro_3
"PalTalk",	//YM47
"您將被重新導向至登入畫面:",	//YM7
"若您沒有利用Super G with Dynamic Turbo來加強無線連線速度；啟用自動掃描頻道則可讓路由器針對您現有的環境來選擇可能最佳的無線頻道執行，以取得較佳的無線網路通訊品質。",	//YM124g
"MAC 位址 %m 已經存在。",	//GW_INET_ACL_MAC_ADDRESS_DUPLICATION_INVALID
"無效的目的地起始IP 位址。",	//YM66
"非必要的",	//LT124
"目標",	//sa_Target
"<warn>DHCP伺服器因LAN端子網路設定不正確已被重新配置，請確認您的伺服器仍正確運作</warn>",	//GW_DHCP_SERVER_RECONFIG_WARNING
"失敗",	//_wifisc_addfail
"Beacon間隔設定值應在20~1000之間。",	//GW_WLAN_BEACON_PERIOD_INVALID
"最佳效果 (BE)",	//YM79
"無效的最大聚集(Aggregation)值",	//YM32
"透過微軟的Windows Connect Now技術將會從路由器儲存無線網路設定到您的電腦，且允許將來透過微軟的無線網路設定精靈來複製此設定至其他電腦。",	//ta_intro_wcn
"背景",	//YM78
"頻道",	//sd_channel
"注意: 不同區域網路端的電腦帶有包含任何共同的通訊埠，通訊埠轉送規則不可以相互關聯，這樣的規則設定將會相互抵觸。",	//KR53
"在所有無線網路裝置都已經完成設定後，<strong>鎖定無線安全設定。</strong> ",	//LW16
"TCP",	//GW_NAT_TCP
"[CRIT]",	//CRIT
"此規則執行一個訊息的遞送給IP位址落在設定在此的範圍內的其他電腦。",	//YM154
"選擇11G Turbo 模式時，頻道應設定為6。",	//GW_WLAN_11G_TURBO_INVALID
"娛樂",	//_aa_bsecure_entertainment
"無活動的",	//YM165
"生活方式",	//_aa_bsecure_lifestyles
"DMZ IP位址應在LAN 端子網路(%v) 的範圍中。",	//GW_NAT_DMZ_NOT_IN_SUBNET_INVALID
"Turbo 模式",	//sd_TMode
"%s 通訊埠範圍 '%s' 在 '%s' 為無效。",	//GW_NAT_PORT_FORWARD_PORT_RANGE_INVALID
"請選擇一個過濾設定。",	//GW_INET_ACL_NO_FILTER_SELECTED_INVALID
"AES",	//bws_CT_2
"注意: 無法存取控制使用安全HTTP協定的網站，也就是一些使用<code>https://...</code>開頭為格式的URL連結。",	//_bsecure_parental_limits
"64 Kbytes",	//aw_64
"幽默",	//_aa_bsecure_humor
"P-Node,此表示僅可使用WIN伺服器。此設定對強制所有NetBIOS運作至已設定的WINS伺服器是很實用的。您必須已設定至少主要的WINS伺服器IP指向一個有用的WINS伺服器。",	//KR92
"路由器模式",	//KR13
"規則名稱無法被複製: %s。",	//GW_INET_ACL_POLICY_NAME_DUPLICATE_INVALID
"透過NAT 無法轉送任何連接埠位址和已建立連線相同的進入連線要求。",	//YM136
"Super G without Turbo:",	//help360
"警告",	//YM10
"無效的PPTP 伺服器IP 位址: %v",	//GW_WAN_PPTP_SERVER_IP_ADDRESS_INVALID
"影像",	//YM150
"IP 位址 %v 正在被使用中；您必須將此IP釋放以及重新設定網路組態後，裝置才可使用這個IP位址。",	//GW_DHCP_SERVER_RESERVATION_IN_USE
"防火牆通訊埠",	//GW_NAT_INPUT_PORT
"由 %s 重新啟動成功",	//WIFISC_AP_REBOOT_COMPLETE
"最新的軔體版本",	//YM182
"1000Mbps",	//LW3
"WPA(個人級) 金鑰至少必須輸入 8個字元。",	//YM116
"WEP 金鑰",	//LW22
"開啟",	//open
"WISH Sessions",	//YM158
"傳送/接收 引證失敗",	//ZM16
"Age 種類選擇",	//_aa_bsecure_select_age
"路由目的IP 位址 %v 為無效",	//GW_ROUTES_DESTINATION_IP_ADDRESS_INVALID
"由 %s 重新啟動完成",	//WIFISC_AP_RESET_COMPLETE
"無效的LAN 端通訊閘IP 位址。",	//GW_LAN_GATEWAY_IP_ADDRESS_INVALID
"新增儲存或編輯一個時間規劃規則。",	//KR96
"設定檔輸出完成",	//GW_XML_CONFIG_GET_SUCCESS
"沒有任何設定被改變，依舊要儲存?",	//_ask_nochange
"UPnP 記錄更新 %v <-> %v:%d <-> %v:%d %s 閒置超時:%d '%s'",	//GW_UPNP_IGD_PORTMAP_REFRESH
"無效的LAN 端IP 位址。",	//GW_LAN_IP_ADDRESS_INVALID
"遠端起始IP",	//KR5
"時間規劃名稱 %s 尚未被定義。",	//GW_INET_ACL_SCHEDULE_NAME_INVALID
"IP位址'%s' 應在LAN 端子網路(%v) 的範圍中。",	//GW_NAT_IP_ADDRESS_INVALID
"無線網路設定",	//LW38
"使用者帳號必須被定義",	//GW_DYNDNS_USER_NAME_INVALID
"目的地IP 位址是指一個主機的位址或網路(網段)。",	//hhav_r_dest_ip
"遠端管理通訊埠不是正確的。",	//YM175
"Wi-Fi防護設定是利用一個辨識碼(PIN)或硬體連線按鈕來簡易的新增裝置到一個無線網路中。無線裝置如果要使用此方式設定必須支援Wi-Fi防護設定。",	//LY3
"UPnP 增加記錄 %v <-> %v:%d <-> %v:%d %s 閒置超時:%d '%s'",	//GW_UPNP_IGD_PORTMAP_ADD
"UPnP 與已存在的記錄衝突 %v <-> %v:%d <-> %v:%d %s '%s'",	//GW_UPNP_IGD_PORTMAP_CONFLICT
"訊息",	//KRA1
"埠",	//_vs_port
"<warn>LAN 端子網路已經被變更，存許控制表將重新定義</warn>",	//GW_INET_ACL_RECONFIGURED_WARNING
"啟用路由器來整合由Windows Media Center PC產生的某些音訊及視訊串流及給予這些其他流量優先權。這樣的流動被系統稱為Windows Media Extenders的使用，例如Xbox 360。",	//help80b
"對於大部分的應用程式來說，優先權分類功能能夠確保正確的優先權被分派，且不需要求特定的WISH規則。",	//YM145
"未確定的選擇登錄",	//WIFISC_AP_UNSET_SELECTED_REGISTRAR
"在主要DNS 伺服器未定義前，次要DNS 伺服器無法被設定。",	//GW_WAN_DNS_SERVER_SECONDARY_WITHOUT_PRIMARY_INVALID
"觸發通訊埠",	//GW_NAT_TRIGGER_PORT
"透過WISH (Wireless Intelligent Stream Handling) 功能，能夠提供自動將各種各樣的無線應用流量按優先順序處理。",	//YM72
"幫助項目",	//_hints
"無效的本地端起始IP 位址。",	//YM52
"聊天",	//_aa_bsecure_chat
"目的地 IP:",	//help104
"注意：在目前微軟WCN的實行來說，若一個相同名稱的設定檔已存在時，您不可以儲存無線網路的設定。為了此限制下運作，您可以刪除現有的設定檔或是在您改更無線網路設定時更改SSID。之後當您儲存新的設定時，一個新的設定檔將會被建立。",	//help839
"無效的WAN 端IP 位址",	//YM99
"由年齡選擇",	//_aa_bsecure_byage
"規則名稱 '%s' 已經存在。",	//GW_INET_ACL_NAME_DUPLICATE_INVALID
"DHCP 伺服器結束位址 %v，不在LAN 端子網路 %v 的範圍中。",	//GW_DHCP_SERVER_POOL_TO_INVALID
"進行中",	//KR26
"您要啟用DHCP 預留IP 位址記錄功能嗎?",	//YM92
"預留IP 位址 %v 為無效",	//GW_DHCP_SERVER_RESERVED_IP_INVALID
"不穩定的",	//_aa_bsecure_unstable
"預留IP 位址 %v，應該在已設定的DHCP 發放範圍之內。",	//GW_DHCP_SERVER_RESERVED_IP_IN_POOL_INVALID
"過濾器規則 '%s'，已經在使用中，所以無法被刪除或重新命名。",	//GW_FIREWALL_FILTER_NAME_INVALID
"您可能需要此設定備份檔，以便在路由器被重置為預設值之後，您可以載入此設定備份檔以回復先前的設定。",	//ZM19
"影像 (VI)",	//YM80
"本頁面的新增/更新區域，請按下新增/更新按鈕來清除任何您在之前所做的更改。",	//KR57
"使用中的",	//YM164
"不被允許的IP 位址",	//_logsyslog_alert2
"最佳效果",	//YM149
"無效的DHCP 租約時間",	//LT120
"自動 (WPA 或 WPA2) - 個人級",	//KR48
"無效的重新連線間隔: %u (必須介於20~180之間)",	//GW_WAN_RECONNECT_INTERVAL_INVALID
"控制基於TCP協定的終點封包過濾。",	//YM139
"遠端起始通訊埠範圍，應該在0~65535之中。",	//YM61
"<warn>LAN 端子網路已經被變更，虛擬伺服器規則表必須重新設定</warn>",	//GW_NAT_VIRTUAL_SERVER_TABLE_RECONFIGURED_WARNING
"需要重新啟動",	//YM1
"辨識碼設定",	//LY5
"儲存設定成功",	//KR102
"無效的PPTP IP 位址: %v",	//GW_WAN_PPTP_IP_ADDRESS_INVALID
"酒精",	//_aa_bsecure_alcohol
"通訊埠過濾規則名稱無法被複製。",	//YM14
"Dynamic Turbo 模式無法容許802.11b 無線模式。",	//GW_WLAN_11B_DYNAMIC_TURBO_INVALID
"UPnP 期限終止記錄 %v <-> %v:%d <-> %v%d %s '%s'",	//GW_UPNP_IGD_PORTMAP_EXPIRE
"IP 位址必須與子網路遮罩位元定義相符合。",	//help107
"無效的目的地起始通訊埠(通訊埠過濾器)",	//YM21
"優先權資訊流程已在此輸入，優先權已經被定義:",	//YM147
"當email 系統記錄功能被設定後，系統記錄將由上層的路由器被寄送到網際網路端。",	//KR68
"透過這個設定精靈，可以幫助您新增無線裝置至現行的無線網路環境中。",	//LW61
"L2TP 使用者名稱必須被定義",	//GW_WAN_L2TP_USERNAME_INVALID
"無效的次要WINS IP 位址",	//LT120z
"WPA/WPA2",	//KR97
"無效的L2UP 子網路遮罩 %v",	//GW_WAN_L2TP_SUBNET_INVALID
"儲存設定值至本地端硬碟中",	//help_ts_ss
"汽車",	//_aa_bsecure_automobile
"時間範圍",	//sch_time
"PPPoE 密碼必須被定義",	//GW_WAN_PPPOE_PASSWORD_INVALID
"在您使用路由器的WCN設定精靈前，您必須先在您的電腦端執行無線安裝精靈。若您尚未執行此動作，請至控制台選擇無線網路設定精靈，當無線網路設定精靈給您選擇&quot;使用一個快閃記憶體&quot;或是&quot;手動設定一個網路線&quot;時，請選擇後者。(事實上，您不需要手動設定，它將會用WCN Active X控制項來完成）。",	//help211
"無效的子網路遮罩",	//LS202
"結束時間",	//tsc_end_time
"透過精靈您可以依序按步驟流程，來新增您的無線裝置至現行的無線網路環境中。",	//KR34
"遠端通訊埠範圍",	//at_RePortR
"其他",	//_vs_other
"無效的輸入伺服器位址 (%s)",	//GW_SMTP_SERVER_ADDRESS_INVALID
"無效的L2TP 通訊閘IP 位址: %v",	//GW_WAN_L2TP_GATEWAY_IP_ADDRESS_INVALID
"顯示目前的路由器辨識碼內容。",	//LW58
"輸入以供使用",	//LW22usekey
"Static Turbo 模式無法容許802.11b 無線模式。",	//GW_WLAN_11B_STATIC_TURBO_INVALID
"無效的目的地結束IP 位址。",	//YM67
"<warn>無線安全設定變更，可能是因為Wi-Fi 防護設定沒有運作</warn>",	//GW_WIFISC_CFG_CHANGED_WARNING
"在DNS 詢問期間重啟",	//ZM10
"Can not use 802.11b/g channel when the 802.11 mode is 802.11a.",	//GW_WLAN_11A_CHANNEL_INVALID
"遠端管理通訊埠範圍應在1~65535之內。",	//YM176
"NetBIOS 允許LAN 端主機可以發現在同一網路中的其他電腦，例如在範圍內的鄰近網路。",	//KR81
"TCP 通訊埠",	//GW_NAT_TCP_PORT
"此規則執行訊息的轉送至主機2的通訊埠，通訊埠號設定在此範圍內。",	//YM155
"此模式可向下相容於不支援Turbo 模式的裝置。此模式應在有些無線網路裝置未啟用Turbo但支援以上提到其他Super G功能時啟用。",	//help365
"會談放棄",	//KR28
"無效的聚集(Aggregation)Num 封包",	//YM33
"自動的",	//YM76
"解開AP 設定",	//WIFISC_AP_SETUP_UNLOCKED
"虛擬伺服器 '%s' 不能與路由器WAN 端的HTTPS 管理通訊埠 %u 共用",	//GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
"釋放",	//LS313
"微軟 Windows Connect Now(WCN) 設定精靈",	//bwz_WCNWz
"DNS 檢視登入伺服器",	//ZM9
"對應這個MAC 位址(%m) 的預留IP 位址已經被設定。",	//GW_DHCP_SERVER_RESERVED_MAC_UNIQUENESS_INVALID
"辨識碼設定",	//LW7
"對於大部分的應用程式來說，優先權分類功能能夠確保正確的優先權被分派，且不需要求特定的WISH規則。",	//YM87
"WAN 端Ping 過濾規則名稱 %s 不存在",	//GW_NAT_WAN_PING_FILTER_INVALID
"若您的電腦作業系統為Windows XP Service Pack 2 (SP2)或以上且您使用Windows Internet Explorer (IE)作為您使用的預設瀏覽器，您可以透過Windows Connect Now (WCN)技術，使用此選項來儲存路由器目前無線安全性設定的重要部分至您的電腦。設定之後亦可被使用在其他支援WCN技術的無線裝置上。",	//help835
"規則名稱必須與規則號碼相符",	//YM49
"您無法加入一個新的IP 位址 %v；您可以從其他的規則中再編輯使用。",	//GW_INET_ACCESS_POLICY_TOO_MANY_IP_INVALID
"無效的L2TP 伺服器IP 位址",	//YM112
"H-Node，表示一個混合模式的運作。若有第一個WINS伺服器的話會被拿來嘗試，經由區域網路端廣播。若您已設定WINS伺服器的話通常將偏好使用此模式。",	//KR90
"注意: WCN僅能儲存少數基本的無線安全設定。當您使用WCN複製設定至其他無線裝置時，您可能需要在那些裝置上手動執行額外進階的無線網路相關設定。",	//help838
"若WAN埠模式設定為&quot;橋接模式&quot;，以下選擇會顯示在上方選項的地方，因為裝置功能將變成在網路內像是包含其他路由器的一個橋樑，且裝置的NAT 功能將取消不被使用。",	//KR73
"這邊有數種無線安全層級可供選擇；但請確定您所使用的無線網路卡有支援您所選擇的安全層級。",	//wwl_intro_s3_2
"無效的路徑公制(Metric)",	//_r_alert5
"<warn>WAN 端Ping 過濾規則名稱 %s 過長，WAN端PING 功能將被停用。</warn>",	//GW_NAT_WAN_PING_FILTER_WARNING
"無效的本地端結束IP 位址。",	//YM53
"注意: WCN功能只能設定一些基本的無線選項。您仍需要至 <a href='wireless.asp'>無線網路設定</a>頁面中，去設定其他像是Super G模式和傳輸速率等無線網路選項。",	//help215
"WISH是Wireless Intelligent Stream Handling(無線串流智慧處理)的簡稱，是一種全新的技術經由設備自動判斷不同應用程式，派發不同流量優先權的方式，以增強您使用流暢的無線網路經驗。",	//YM140
"DHCP 伺服器位址 %v 被網路裝置拒絕；如果您的環境中有一台以上的DHCP 伺服器的話，有可能導致目前IP 位址衝突的狀況。",	//GW_DHCPSERVER_REJECTED
"允許路由器整合HTTP傳送一般音訊及視訊串流以及自動給予較高的優先權。這樣的串流媒體格式是經常被數位多媒體撥放器所使用。",	//YM142
"密碼必須被定義",	//GW_DYNDNS_PASSWORD_INVALID
"此規則執行訊息的傳遞給IP位址在設定在此的範圍內的其他電腦。",	//YM152
"無效的DHCP 伺服器結束IP 位址",	//LT119a
"若您透過路由器來存取網路有問題時，請再次確認在此頁面所輸入的任何設定，您可能需要與您的網路提供業者(ISP)核對這些網際網路連線資料。",	//LW36
"透過加密演算法以讓資料傳輸獲得安全。TKIP(Temporal Key Integrity Protocol)提供每個封包金鑰的產生且是以WEP為基礎的。AES (Advanced Encryption Standard)是一個非常安全封鎖基礎的加密。使用&quot;TKIP&quot;和&quot;AES&quot;選項，當AES可用時，路由器使用AES和用戶端協調密碼加密類型。",	//help377
"%s '%s' 為無效。",	//GW_NAT_PORT_TRIGGER_PORT_RANGE_INVALID
"無效的 WPE 金鑰",	//YM121
"無效的碎裂化(Fragmentation)臨界值",	//YM29
"當WISH功能被啟動時，在WISH Sessions頁面會顯示透過您路由器作用的所有無線連線詳細資料。",	//YM159
"無效的通訊埠數值",	//YM120
"啟用Wi-Fi 防護設定功能",	//LW55
"無效的PPTP 子網路遮罩",	//YM106
"封鎖未批准的網站",	//_aa_bsecure_block_unrated
"Big Pond使用者名稱必須被定義",	//GW_WAN_BIGPOND_USERNAME_INVALID
"例如:192.168.0.101",	//KR76
"DHCP伺服器因所有可用的IP位址皆在使用中，而無法再提供IP位址以供發放；請在DHCP伺服器設定中加大IP位址發放範圍，以增加可用IP位址數量。",	//GW_DHCPSERVER_EXHAUSTED
"無效的L2TP 伺服器IP 位址: %v",	//GW_WAN_L2TP_SERVER_IP_ADDRESS_INVALID
"路徑子網路 %v 為無效",	//GW_ROUTES_SUBNET_INVALID
"Drugs",	//_aa_bsecure_drugs
"IP 位址不能與路由器LAN 端IP 位址相同。",	//LW1
"一個在網路中的電腦 %v 正在更新釋放IP 位址，且已失去使用這個IP位址的權利。若裝置想繼續使用這個IP位址則可能會造成IP位址衝突。",	//GW_DHCPSERVER_EXPIRED
"IP位址 %v，應該在LAN 端子網路 (%v)的範圍中 。",	//GW_INET_ACL_IP_ADDRESS_IN_LAN_SUBNET_INVALID
"廣播專用 (當WINS 伺服器被設定完成後使用)",	//bd_NETBIOS_REG_TYPE_B
"金融",	//_aa_bsecure_financial
"NAT只有在來源是相同IP位址的連線建立時，轉送此進入連線要求給區域網路端的主機。這允許遠端應用程式透過一個不同於這個當對外連線建立時所使用的服務埠傳送資料回來。",	//YM135
"無效的DHCP 伺服器起始IP 範圍",	//LT119
"公眾",	//_vs_public
"B-Node，表示僅使用區域連線的廣播。此設定對於沒有可用WINS伺服器的地方是實用的，然而，它會偏好您先嘗試M-Node運行方式。",	//KR93
"遠端管理啟用通訊埠: %u",	//GW_SECURE_REMOTE_ADMINSTRATION
"雇用",	//_aa_bsecure_employment
"IP位址以及在適當地方產生網路連線的通訊埠號碼。",	//YM160
"分配IP 位址",	//LS423
"L2TP 通訊閘IP位址 %v，必須在WAN 端子網路範圍之中。",	//GW_WAN_L2TP_GATEWAY_IN_SUBNET_INVALID
"私人",	//_vs_private
"當&quot;從WAN 端學習NetBIOS 資訊&quot;功能被啟用時，這個設定將被停用。",	//KR86
"次要WINS IP位址",	//bd_NETBIOS_SEC_WINS
"起始IP 位址必須小於結束IP 位址: %v-%v.",	//GW_INET_ACL_START_IP_ADDRESS_INVALID
"驗證",	//auth
"5GHz",	//KR17
"主機 2 IP 範圍",	//YM84
"啟用這個選項以允許單一VPN 連線至遠端VPN主機(預設為啟用)。(但若是使用多重的VPN 連線的話，則必須選擇使用適當的VPN ALG。)如果您選擇停用這個選項的話，則已被選擇使用適當的VPN ALG亦同時將被停用。",	//LW50
"無效的PPPoE IP 位址",	//YM103
"在橋接模式下，裝置依舊支援數種以流量有通過WAN 埠至上端路由器為前提的功能。",	//KR64
"效能增強功能提供類似封包擠壓，高速訊框，及資料壓縮技術的效用。",	//help361
"Wi-Fi 防護設定",	//LW4
"辨識碼",	//KR38
"在11a Static Turbo模式下，頻道設定應為42,50,58,152,160。",	//GW_WLAN_11A_STATIC_TURBO_INVALID
"您沒有權限可以執行這個項目。",	//YM6
"種類選擇",	//_aa_bsecure_categ_select
"優先權值必須介於1~255之間。",	//YM58
"青少年(13-17)",	//_aa_bsecure_age_youth
"請按下 <strong>無線裝置新增精靈</strong> 按鈕，來使用Wi-Fi 防護設定功能增加無線裝置至現行無線網路中。",	//LW17
"無效的通訊埠過濾器目的地結束IP 位址",	//YM18
"WPA2-PSK/AES (WPA2 個人級)",	//LT210
"無效的閒置時間 (允許範圍為 %u 到 %u)",	//GW_WAN_IDLE_TIME_INVALID
"多點廣播群組位址",	//YM186
"運動",	//_aa_bsecure_sports
"規則名稱 '%s' 已經在使用中。",	//GW_QOS_RULES_NAME_ALREADY_USED
"下面的連線精靈使用微軟WCN(Windows Connect Now)技術，將可自動將在作業系統種已設定完成的無線網路相關設定至路由器中。使用這個功能前請先確認您已經使用微軟無線網路管理程式完成相關設定。",	//bwz_intro_WCNWz
"DHCP 伺服器發放範圍 %v，不在LAN 端子網路 %v 範圍中。",	//GW_DHCP_SERVER_POOL_TO_IN_SUBNET_INVALID
"<warn>虛擬伺服器已經有一筆相同需求的設定被新增，H.323 已經自動啟用。</warn>",	//GW_NAT_H323_ALG_ACTIVATED_WARNING
"無效的主要WINS IP 位址",	//LT120y
"Wi-Fi 防護設定已經成功設定並儲存。",	//KR103
"Calista網路電話",	//YM44
"若您是進階使者，且曾經設定過無線寬頻路由器；請點擊 <strong>手動設定無線網路設定</strong>按鈕，以手動輸入其相關設定。",	//LW47
"設定檔輸出失敗  #%u",	//GW_XML_CONFIG_GET_FAILED
"由 (%s) 設定AP 完成",	//WIFISC_AP_SET_APSETTINGS_COMPLETE
"與路由器通信失敗",	//YM168
"規則名稱 '%s' 已經在使用中。",	//GW_NAT_NAME_USED_INVALID
"無效的伺服器索引值: %d",	//GW_DYNDNS_SERVER_INDEX_VALUE_INVALID
"[警告]",	//WARN
"企業",	//LW23
"PPTP 密碼必須被定義",	//GW_WAN_PPTP_PASSWORD_INVALID
"將路由器辨識碼回復為預設值。",	//LW59
"若您已經啟動無線安全加密功能，請確認您已完成網路金鑰的輸入，並另外記下您所輸入的金鑰內容。日後當您的無線裝置要連線到這個無線網路時，您必須輸入此網路金鑰才能通過驗證並完成無線連線。",	//YM126
"啟用/設定",	//LW66
"無效的路徑界面",	//_r_alert4
"新增無線工作站",	//LY10
"DHCP 起始位址 %v，不在LAN 端子網路 %v 的範圍中。",	//GW_DHCP_SERVER_POOL_FROM_INVALID
"鎖定AP 設定",	//WIFISC_AP_SETUP_LOCKED
"您要放棄現行的所有設定不做變更嗎?",	//YM91
"設定選擇登錄位置失敗，原因 (%s)，錯誤代碼 (%u)",	//WIFISC_AP_SET_SELECTED_REGISTRAR_FAIL
"沒有任何設定被改變，依舊要儲存?",	//LS3
"未知",	//GW_NAT_UNKNOWN
"在11a Dynamic Turbo模式下，頻道設定應為40,48,56,153,161。",	//GW_WLAN_11A_DYNAMIC_TURBO_INVALID
"注意:即使NTP 伺服器功能被啟用，您還是需要選擇正確時區及日光節約參數。",	//YM163
"您首先需要在下拉式選單中服務提供中一個動態DNS的帳戶.",	//YM181
"不足的許可",	//_cantapplysettings_1
"警告:",	//YM11
"主要WINS 伺服器IP位址",	//bd_NETBIOS_PRI_WINS
"無線裝置辨識碼",	//KR44
"猥褻的",	//_aa_bsecure_obscene
"無效的伺服器IP 位址",	//YM130
"選擇動態DNS (DDNS)伺服器",	//KR99
"如果要定義次要WINS 伺服器IP位址，則主要WINS 伺服器IP 位址也必須被定義。",	//GW_DHCP_SERVER_PRIMARY_AND_SECONDARY_WINS_IP_INVALID
"為 '%s' 啟用至少一個來源IP 範圍。",	//GW_FIREWALL_NO_IP_RANGE_INVALID
"虛擬伺服器 '%s'，通訊協定數值，%d；必須為0或介於3~255 之間。",	//GW_NAT_VS_PROTOCOL_INVALID
"如果您要手動設定網路的話，請選擇這個項目",	//KR52
"歡迎使用無線裝置新增精靈",	//KR33
"您必須使用 'Admin'登入後，才可以執行這個動作。",	//ZM23
"設定精靈將幫助您將您的無線裝置無線連線到本路由器，它將一步一步的引導您操作如何設定無線連線，按下下面的按鈕開始執行設定精靈。",	//LW40
"鎖定無線安全設定",	//LY4
"若您是進階使者，並且曾經設定過無線寬頻路由器；請按下<strong>手動無線網路設定</strong> 按鈕，以手動輸入其相關設定。",	//LW34
"您確定您要刪除?",	//YM25
"無效的通訊埠過濾器目的地起始IP位址",	//YM15
"Super&nbsp;G&trade;&nbsp;模式",	//bwl_SGM
"無效的Radius 伺服器位址",	//GW_WLAN_80211X_RADIUS_INVALID
"登入",	//LS316
"用戶已經登出",	//ZM15
"<warn>因為與路由器LAN 端IP 位址衝突，DHCP 保留功能已經被停用。</warn>",	//GW_DHCP_SERVER_RESERVATION_DISABLED_IN_CONFLICT_WARNING
"主機必須被定義",	//GW_DYNDNS_HOST_NAME_INVALID
"手動設定無線網路",	//LW42
"無效的PPTP 通訊閘IP 位址: %v",	//GW_WAN_PPTP_GATEWAY_IP_ADDRESS_INVALID
"設定組態備份檔已成功上傳至路由器。",	//rs_intro_4
"不適用",	//_NA
"通訊閘IP 位址為路由器IP 位址，如果為任意的話，請使用已定義可達到的目的地位址。",	//hhav_r_gateway
"[通知]",	//INFO
"公制:",	//help112
"強制802.11N 用戶端使用Short Slot",	//aw_igslot
"(預設如果沒有任何相符的其他項目)",	//ZM2
"您沒有權限可以執行這個定義動作。",	//LT7
"設定選擇登錄",	//WIFISC_AP_SET_SELECTED_REGISTRAR
"當必要設定準備工作完成後，透過WCN技術將把電腦端的無線網路設定傳送到無線寬頻路由器。之後您必須將無線寬頻路由器重新啟動後，才可使其設定生效。",	//help214
"兩者",	//at_Both
"每週的其中一天",	//ZM22
"回復設定為出廠預設值",	//help_ts_rfd
"如果您要手動設定您的D-Link 路由器無線相關設定，請按下下方的&quot;手動設定無線網路&quot;按鈕。",	//LW44
"若您的電腦使用的作業系統為Windows XP Service Pack 2 (SP2)以及IE瀏覽器的話，您可使用WCN技術(Windows Connect Now technology)來幫助您完成無線網路相關的安全設定.",	//help209
"目的地起始通訊埠應該介於0~65535 之間。",	//YM70
"UPnP 已變更VS 記錄 %v <-> %v:%d <-> %v:%d %s 到 %s",	//GW_UPNP_IGD_PORTMAP_VS_CHANGE
"此模式不適用於沒有支援Super G技術的無線網路卡使用，選擇使用此模式只適用於無線網路環境所有裝置皆支援並啟動Super G Static Turbo模式。",	//help363
"Web 新聞群組",	//_aa_bsecure_web_newsgroup
"無效的主要DNS 位址",	//YM128
"%s 之中的 '%s' 無法被清空。",	//GW_NAT_PORT_TRIGGER_PORT_RANGE_EMPTY_INVALID
"串流引擎&trade;技術係指多媒體串流資料在橋接模式下，用戶端資料傳輸經由WAN 端至上端路由器時適用。",	//KR72
"密碼不相符，請重新輸入",	//YM177
"主機 1 IP範圍",	//YM82
"無效的驗證閒置超時時間",	//YM119
"在橋接模式下依舊可以分析連接WAN 端的上端路由器流量，因此可確定WAN 端的連線速度。",	//KR70
"IP位址以及在哪裡被使用，電腦端已建立的網路連線的通訊埠號碼。",	//YM161
"DHCP 伺服器發放範圍超過限制 (總和必須小於256個位址)。",	//GW_DHCP_SERVER_POOL_SIZE_INVALID
"已建立的",	//_sdi_s4b
"DNS 解析驗證伺服器",	//ZM8
"無效的次要DNS 位址",	//YM129
"封鎖無線安全設定來避免設定被任何新的外部登錄者使用它的辨識碼(PIN)來執行相關變更。裝置仍可利用Wi-Fi保護設定來加入至無線網路，並仍可在<a href='wireless.asp' shape='rect'>手動無線網路設定</a>、<a href='wizard_wlan.asp' shape='rect'>無線網路設定精靈</a>、或一個存在的外部無線網路的登錄(用戶)端來變更無線設定。",	//LY29
"設定檔寫入期間警告: %s",	//GW_XML_CONFIG_WRITE_WARN
"規則名稱 '%s' 已經在使用中",	//GW_FIREWALL_NAME_INVALID
"連線",	//LS314
"流量類型",	//_vs_traffictype
"閒置超時時間設定值最大不能超過8760。",	//GW_DYNDNS_TIMEOUT_TOO_BIG_INVALID
"請輸入您的無線裝置辨識碼之後，按下下方的連線按鈕。",	//KR43
"如果您的無線裝置支援Wi-Fi 防護設定的話，請選擇這個項目。",	//KR51
"PPTP 通訊閘IP 位址 %v 必須在WAN 子網路的範圍之中。",	//GW_WAN_PPTP_GATEWAY_IN_SUBNET_INVALID
"請按下<span class='button_ref'>儲存至WCN(Windows Connect Now)</span> 按鈕，透過WCN 技術將由路由器取得無線網路設定值並儲存至您的電腦之中。",	//help837
"請選擇一個設定方法來配置您的無線網路",	//KR49
"新聞",	//_aa_bsecure_news
"更新",	//YM34
"進階無線網路",	//_advwls
"<warn>因為DHCP 發放範圍過小，所以DHCP 保留位址 %v 已經被停用</warn>",	//GW_DHCP_SERVER_RESERVATION_DISABLED_OUT_OF_POOL_WARNING
"MAC 過濾器設定將封鎖所有LAN端設備，請注意現行設定並非允許。",	//GW_MAC_FILTER_ALL_LOCKED_OUT_INVALID
"非必要的",	//YM98
"搜尋引擎",	//_aa_bsecure_search_engine
"WPA 專用",	//KR47
"<warn>E-Mail 伺服器位址與路由器LAN 端IP 位址衝突 - email 功能將被停用</warn>",	//GW_SMTP_LAN_ADDRESS_CONFLICT_WARNING
"LAN 端IP 模式為無效",	//GW_LAN_IP_MODE_INVALID
"定義的Big Pond 伺服器不是正確的網域名稱或IP 位址。",	//GW_WAN_BIGPOND_SERVER_NOTSTD15
"當您的路由器已經照您需求設定後，您可以將當下的路由器設定檔儲存至本機端硬碟中。",	//ZM18
"碎裂化(Fragmentation)臨界值設定應介於256~2346 之間。",	//GW_WLAN_FRAGMENT_THRESHOLD_INVALID
"給予的網域名稱為無效",	//GW_LAN_DOMAIN_NAME_INVALID
"發現重疊的會談(Session Overlap)",	//_wifisc_overlap
"連線精靈將顯示無線網路相關設定並引導您手動完成設定，並提示您輸入此設備之辨識碼(PIN)或要求您按下硬體設定按鈕。若設備支援Wi-Fi防護設定，點選設定按鈕，新增到這個網路，完成設定後會倒數60秒儲存設定。此時面板Status燈號閃爍三次後，表示此設備已新增到此網路中。",	//LW62
"描寫色情",	//_aa_bsecure_pornography
"規則名稱不能為空的字串。",	//GW_NAT_NAME_INVALID
"特殊串流通訊埠",	//bwl_NSS
"無效的PPTP 伺服器IP 位址",	//YM108
"目的地結束IP 位址應該沒有在LAN 端子網路範圍中",	//YM19
"STA 與 MAC (%m) 已註冊登記",	//WIFISC_AP_PROXY_PROCESS_COMPLETE
"記錄 '%s' 與 '%s' 相同。",	//GW_NAT_ENTRY_DUPLICATED_INVALID
"如果您要透過簡單、容易、清楚的網頁界面設定精靈來設定您的新D-Link路由器以連上網際網路的話，請按下下面的按鈕。",	//LW27
"您確定您要更新嗎?",	//YM38
"NTP 伺服器還沒有被設定。",	//YM185
"Wi-Fi 防護設定",	//LY2
"會談(session)結束",	//KR31
"起始失敗",	//_init_fail
"來源起始通訊埠設定範圍應在0~65535之間。",	//YM68
"MAC 位址",	//sd_macaddr
"WAN 埠模式",	//KR12
"基地台(AP)已註冊至(%s) 經由 %s",	//WIFISC_AP_REGISTRATION_COMPLETE
"TPC 最大增益",	//aw_TPC
"WDS AP MAC 位址",	//aw_WDSMAC
"遠端結束通訊埠應該介於0~65535之間。",	//YM62
"無效的重新連結模式",	//GW_WAN_RECONNECT_MODE_INVALID
"DelAP設定已由 (%s) 完成",	//WIFISC_AP_DEL_APSETTINGS_COMPLETE
"您目前不是使用管理者權限登入，清除統計資料按鈕將被停用；只有管理者可以清除這些統計資料。",	//ss_intro_user
"若您第一次使用網路或從未設過無線寬頻路由器，請按下<strong>網際網路連線設定精靈</strong>按鈕，設定精靈將引導您透過簡易的步驟完成網路設定並連線上網際網路。",	//LW33
"接著要新增其他的裝置，請按下取消按鈕下方的項目；或是按下無線狀態按鈕，以確認無線狀態。",	//KR27
"控制用戶端的UDP 通訊協定封包過濾。",	//YM138
"步驟 五:標記類型",	//_aa_wiz_s6_title
"WISH 規則",	//YM77
"QoS Engine",	//YM48
"無效的保留IP 位址",	//YM89
"預先共用金鑰(Pre-shared Key)長度若為64 的話，應該內容全部為HEX 字元。",	//GW_WLAN_WPA_PSK_HEX_STRING_INVALID
"無效的WAN IP 位址: %v",	//GW_WAN_WAN_IP_ADDRESS_INVALID
"您確定要放棄目前設定頁面的所有變更?",	//LS4
"已定義的動態DNS(DDNS) 服務提供者為不支援。",	//KR98
"背景(迫切度小)",	//YM148
"如果您希望當有新版本設備軔體釋出時收到通知，請勾選<span class='option'>新版軔體釋出Email 通知</span>項目。",	//help877a
"新增/更新",	//KR56
"主機名稱",	//LS424
"DHCP 伺服器位址 %v 已經被其他網路設備使用中 - 請確認您的網路是否有設備IP 位址衝突。",	//GW_DHCPSERVER_DECLINED
"您沒有選擇一個日期",	//GW_SCHEDULES_DAY_INVALID
"UDP",	//GW_NAT_UDP
"無法與Email 伺服器新增連線",	//IPSMTPCLIENT_CANNOT_CREATE_CONNECTION
"檢查所有的",	//_aa_check_all
"您確定要放棄您已經定義的保留規則記錄?",	//YM94
"更新",	//LS312
"無效的IP 位址",	//KR2
"通訊協定",	//_vs_proto
"輸入的位址 (%s) 為無效",	//GW_SMTP_TO_ADDRESS_INVALID
"規則名稱 '%s' 已經在使用中。",	//GW_WISH_RULES_NAME_ALREADY_USED
"當區域網路端有使用UDP、TCP、或ICMP通訊協定的應用程式開始網路會談(session)要求；即使是無法辨識的通訊協定，路由器的NAT功能將會追蹤這樣的會談(session)要求。這個功能很實用，因為透過此功能將有效的啟用應用程式 (例如:一個獨立VPN連線到遠端主機)，而不需再額外進行ALG相關設定。",	//LW48
"無效的遠端起始IP 位址",	//YM54
"現行的辨識碼",	//LW9
"設定精靈將幫助您完成無線網路相關設定。它將一步一步的引導您操作如何正確的設定無線網路和安全性設定。",	//LW41
"啟用自動頻道掃描功能，路由器將自動選擇一個可能的最佳無線頻道，供您的無線網路運行使用。",	//YM124
"RTS 門檻限制設定值應在0~2347之間。",	//GW_WLAN_RTS_THRESHOLD_INVALID
"L2TP 密碼必須被定義",	//GW_WAN_L2TP_PASSWORD_INVALID
"某些設定值的變更將會影響其他系統(功能)的設定，這些變更可能對您先前的設定產生相關連的影響，您必須修改或停用這些設定，以符合新的操作環境。",	//YM12
"使用者已登出",	//ZM14
"連接網路線接頭至裝置背板上的 &quot;連接埠(Port)&quot;上面。",	//KR60
"無效的RTS 門檻限制設定值",	//YM28
"無效的時間規劃設定",	//YM184
"若您想利用Web管理介面來設定WCN (Windows Connect Now technology)的話，請按下下方的設定精靈按鈕。",	//int_intro_WCNWz7
"回存設定值檔案不正確，您可能使用了不是給這台裝置的設定值檔案，或是設定值檔案已經毀損。",	//rs_intro_1
"兩者",	//GW_NAT_BOTH
"回存設定值成功",	//rs_success
"(GMT+01:00) 布達佩斯, 維也納, 布拉格, 華沙",	//up_tz_29b
"日",	//day
"<warn>因為不適宜的LAN 端子網路設定，所以DHCP 伺服器已經被停用</warn>",	//GW_DHCP_SERVER_DISABLED_WARNING
"您所輸入的密碼及確認密碼欄位內容不相符，請重新確認您的管理者(admin)密碼。",	//YM173
"無效的MAC 位址 %m。",	//GW_INET_ACCESS_POLICY_MAC_INVALID
"Wi-Fi 防護設定",	//LW2
"請在LAN 端可用的IP 位址範圍中，任意分派輸入一個可用IP 位址。",	//KR75
"寫入設定值檔案失敗: %s",	//GW_XML_CONFIG_WRITE_FAILED
"啟用:",	//help102
"規則名稱 '%s' 已經在使用中。",	//GW_WISH_RULES_NAME_USED_INVALID
"DHCP 伺服器發放範圍太大，與LAN 端子網路設定不符 %v。",	//GW_DHCP_SERVER_POOL_SIZE_IN_SUBNET_INVALID
"最大聚集(Aggregation)值",	//aw_AS
"這個清單將顯示所有在區域網路端的已連線或正在連線中的無線用路端資訊。",	//YM171
"保留IP %v 與現行LAN 端設定之IP 位址衝突",	//GW_DHCP_SERVER_RESERVED_IP_NOT_LAN_IP_INVALID
"虛擬伺服器規則 '%s'，不能與路由器WAN 遠端管理功能使用相同通訊埠，%u。",	//GW_NAT_VS_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT
"定義的目的地網路遮罩欄位已經使用中。",	//hhav_r_netmask
"虛擬伺服器設定清單",	//vs_vslist
"請注意這一些選項會與其他通訊埠限制功能相互影響。用戶端獨立過濾器功能對流入封包過濾器或時間規劃來說有更高的優先權，儘管在對應通訊埠的流入封包過濾器可能只適合一個進入的會談請求與一個透過單一通訊埠進入的對外會談。不過，當封包被送到被阻絕的通訊埠(或是被流入封包過濾器或時間規劃功能阻絕)時，封包將預期中的被拒絕丟棄，且會談無法被建立。通訊埠和位址限制過濾保證流入封包過濾器和時間規劃功能準確的工作。但是也防止了一些層級的連接，以及可能需要使用通訊埠觸發，虛擬伺服器，或通訊埠遞送功能以開啟這些由應用程式要求的通訊埠。 ",	//YM137
"優先權分類",	//YM74
"Syslog 伺服器IP 位址 %v 不在LAN 端子網路範圍中。",	//GW_SYSLOG_ADDRESS_IN_SUBNET_INVALID
"如果您要允許使用WISH 功能來自動按優先次序處理無線流量的話，請啟用這個功能。",	//YM86
"MAC 位址已經在使用中: %m",	//GW_MAC_FILTER_MAC_UNIQUENESS_INVALID
"按下連線按鈕(Push Button)",	//KR40
"MAC 位址過濾器設定不接受空白的位址: %m",	//GW_MAC_FILTER_NULL_MAC_INVALID
"32 Kbytes",	//aw_32
"WAN 端子網路與LAN 端子網路衝突",	//GW_WAN_LAN_SUBNET_CONFLICT_INVALID
"啟用/沒有被設定",	//LW67
"DelAP設定由 (%s) 失敗，原因 (%s)，錯誤碼 (%u)",	//WIFISC_AP_DEL_APSETTINGS_FAIL
"WINS伺服器把關於網路主機的相關訊息儲存，允許主機來'註冊'主機本身的資訊和透過WINS 來發現其他可使用的主機。例:使用於網路上的芳鄰。",	//KR85
"無效的MTU 值",	//YM115
"主機 1 通訊埠範圍",	//YM83
"當過度過量的無線封包發生碰撞發生，無線的效能可透過使用 RTS/CTS 交握協定得到改善(傳送要求/傳送清除)。",	//LW51
"您必須輸入一個介於0~8760 的數值。",	//YM178
"儀式",	//_aa_bsecure_cults
"禁用",	//YM5
"軔體更新檢查",	//KR65
"透過定期發佈更新的軔體，得以改進路由器的功能並增加新的功能特色。假如您執行路由器的某個特殊功能發生問題時，您可以檢查使用新軔體，也許可以協助您將問題解決。",	//ZM17
"如果您希望將其他區域網路端的無線裝置(需支援Wi-Fi 防護設定)包括在內的話，請勾選<strong>啟用</strong>。",	//LW14
"儲存至WCN(Windows Connect Now)",	//ta_wcn_bv
"虛擬伺服器規則 '%s'，不能使用路由器已定義的設備IP 位址，%v。",	//GW_NAT_VS_IP_ADDRESS_CAN_NOT_MATCH_ROUTER
"時間規劃規則 '%s'，已經在使用中，無法被刪除或變更。 ",	//GW_SCHEDULES_IN_USE_INVALID
"WEP 金鑰 3",	//wepkey3
"網際網路速率偵測",	//KR69
"AIM 交談",	//YM43
"ICQ",	//YM45
"無效的使用者名稱",	//GW_SMTP_USERNAME_INVALID
"Super G with Static Turbo",	//help362
"如果您希望當有新版本設備軔體釋出時收到通知，請勾選&quot;新版軔體釋出Email 通知&quot;項目。",	//tf_intro_FWChA
"遠端桌面連線",	//_remotedesktop
"Super G模式必須使用第六頻道連線。以Super G with Static Turbo 模式來說，<span class='option'>802.11 模式</span>必須被設定為802.11g。為了較恰當的操作使用， RTS 門檻及碎裂化(Fragmentation)門檻設定，在<a href='adv_wlan_perform.asp'>進階設定&rarr; 進階無線網路</a> 設定頁面中，請將這兩者的設定值使用預設即可，不須變更。",	//help359
"設定優選WINS 伺服器IP 位址。",	//KR84
"DTIM 設定值範圍應在1~255之間。",	//YM30
"區域端通訊埠範圍",	//at_LoPortR
"DHCP 伺服器發放範圍起始 %v 不在LAN 端子網路 %v 的範圍中。",	//GW_DHCP_SERVER_POOL_FROM_IN_SUBNET_INVALID
"MAC 位址過濾器不能為多點廣播位址格式: %m",	//GW_MAC_FILTER_MULTICAST_MAC_INVALID
"<warn>Email 初始化失敗</warn>",	//GW_SMTP_INIT_FAILED_WARNING
"停用 DHCP 伺服器",	//GW_DHCPSERVER_STOP
"DMZ IP位址 %v，不被允許。",	//GW_NAT_DMZ_NOT_ALLOWED_INVALID
"設定檔 #%u，輸入失敗",	//GW_XML_CONFIG_SET_FAILED
"%s '%s' 之中的 '%s' 不能包含重複的通訊埠號碼。",	//GW_NAT_PORT_DUP_INVALID
"您的第二個無線裝置將被連結；如果您要停止這個設定程序的話，請按下下方的&quot;取消&quot;按鈕。",	//KR46
"步驟 1:請選擇一個設定無線網路的方式",	//KR35
"Big Pond 密碼必須被定義",	//GW_WAN_BIGPOND_PASSWORD_INVALID
"通訊協定必須被定義。",	//YM57
"路由器必須重新啟動之後所有新的設定才會生效；您可以選擇馬上重新啟動，或是繼續其他的設定稍後再重新啟動。",	//KR104
"寄件者Email 位址的格式錯誤",	//IPSMTPCLIENT_MSG_WRONG_SENDER_ADDR_FORMAT
"登出",	//LS317
"輸入的密碼不相符",	//YM102
"當 WDS 設定成啟用時，存取點(AP) 的功能作為一台無線中繼器，並且能和其他的 AP 使用WDS做無線通訊的連接。需注意 WDS 和WPA這兩個功能是不能並存，兩個功能無法同時被使用。WDS 鏈接是雙向的；所以其他 AP 必須知道這台 AP 的 MAC位址，並且其他的 AP 也必須有 WDS的連線回到這台 AP 的MAC 位址。",	//help188
"無效的IP 位址",	//_logsyslog_alert1
"無效的MAC 位址",	//KR3
"仇恨",	//_aa_bsecure_hate
"當802.11 模式為802.11b/g時，無法使用802.11a頻道。",	//GW_WLAN_11BG_CHANNEL_INVALID
"聚集(Aggregation)界限",	//aw_aggr
"開始",	//_wifisc_addstart
"通訊埠過濾器功能--無效的目的地結束通訊埠",	//YM22
"無法在WDS 設定中使用多點廣播MAC 位址。",	//GW_WLAN_WDS_MAC_ADDR_INVALID
"回復辨識碼為預設值",	//LW10
"在<a href='wireless.asp'>設定&rarr; 無線設定</a> 頁面中，可以對這此功能作設定。<span class='option'>MAC 位址</span> 為無線網路卡出廠時所配發的獨立且唯一的識別號碼。                                                                                                                                                                                                                                          ",	//LT291
"您可以在這個項目中，定義WISH 規則。",	//YM156
"青少年 (9~12)",	//_aa_bsecure_age_ado
"一旦區域網路(LAN)端應用程式已經透過一個特定的通訊埠建立一個連接後，透過NAT 機制將轉送每一個來源連線需求至相同的通訊埠，至區域網路(LAN)端應用程式所發起的原始通訊埠。這是限制最少的選項，給予最好的連接性並且允許某些應用程式(特別是P2P的點對點傳輸應用程式)，如此在邏輯上來看，這些應用程式就像直接連接到網際網路上一樣。",	//YM134
"網頁郵件",	//_aa_bsecure_web_mail
"請確定AP(無線基地台)所設定的無線頻道是相同的。",	//help188b
"WAN 端流量控制",	//at_title_Traff
"當定義為WDS 連結時，其它基地台(AP)也必須提供MAC 位址給建立WDS 連結的基地台(AP)設定使用。",	//help189
"無線網路頻道偵測完成，切換頻道至 %d",	//GW_WIRELESS_SWITCH_CHANNEL
"Big Pond 伺服器必須被定義",	//GW_WAN_BIGPOND_SERVER_INVALID
"設定檔語法分析錯誤，行 %u 字元 %u",	//GW_XML_CONFIG_SET_PARSE
"啟用隱藏模式可能是另一種使您的網路更加安全的方法。當啟用這個項目時，當無線用戶端掃描有那些無線網路為可用時，他們將無法看到(掃描到)您的無線網路。所以當您的無線裝置要連結至無線路由器時，您將需要在每個無線裝置上手動輸入您的無線網路名稱(SSID)。",	//YM125
"在<a href='wireless.asp'>設定 &rarr; 無線設定</a> 頁面中，您可以對此進行相關設定。在 <a href='adv_wish.asp'>進階設定 &rarr; WISH</a> 設定頁面，以及 <a href='../Advanced/Protected_Setup.shtml'>進階設定&rarr; Wi-Fi 保護設定</a> 頁面中，<span class='option'>MAC 位址</span> 是無線網路卡在出廠時所分派的實體辨識號碼。",	//LT290wifisc
"規則名稱不能為空字串",	//GW_FIREWALL_RULE_NAME_INVALID
"時間規劃",	//GW_NAT_SCHEDULE
"無效的RIP 模式。",	//GW_LAN_RIP_MODE_INVALID
"當資料訊框位元組值大於RTS 門檻限制時，無線傳送端將開始傳送RTS訊框(並等待CTS訊框)。",	//LW52
"跳出",	//_aa_bsecure_popups
"WPA2 專用模式不支援TKIP。",	//GW_WLAN_WPA_WPA2_TKIP_INVALID
"2.4GHz",	//KR16
"虛擬伺服器",	//_vs_title
"PPPoE 使用者名稱必須被定義",	//GW_WAN_PPPOE_USERNAME_INVALID
"無效的PPTP 子網路遮罩 %v",	//GW_WAN_PPTP_SUBNET_INVALID
"無效的NetBIOS 領域格式",	//GW_DHCP_SERVER_NETBIOS_SCOPE_INVALID
"固定IP 模式已啟用，所以沒有可執行的項目。",	//KR94
"WISH",	//YM63
"通訊閘:",	//help108
"這個時間規劃已經在 '%s' 設定使用中",	//GW_SCHEDULES_DUPLICATED_INVALID
"虛擬伺服器設定中的公用通訊埠設定必須在1~65535 的範圍之中",	//KR11
"遠端結束IP",	//KR6
"無效的NetBIOS 註冊類型",	//GW_DHCP_SERVER_NETBIOS_TYPE_INVALID
"遊戲",	//_aa_bsecure_games
"如果您要手動設定您的無線裝置的話，請選擇這個項目",	//KR42
"無效的閒置時間",	//YM104
"票卷",	//_aa_bsecure_tickets
"如果您的無線裝置支援辨識碼(PIN)的話，請選擇這個項目",	//KR39
"混合模式 (點對點廣播)",	//bd_NETBIOS_REG_TYPE_M
"如果您要以WDS 模式連結的話，請輸入每一個欲連結的基地台(AP)MAC 位址。",	//help189a
"UPnP 刪除記錄 %v <-> %v:%d %s",	//GW_UPNP_IGD_PORTMAP_DEL
"無效的L2TP 通訊閘IP 位址",	//YM111
"中斷連線",	//LS315
"不正確的 key 長度, 應該設定為 8 ~ 63 個字元長.",	//GW_WLAN_WPA_PSK_LEN_INVALID
"個人",	//LW24
"取得正在使用中的會談(session)清單中，請稍後… ",	//YM167
"無秩序",	//_aa_bsecure_anarchy
"稍後重新啟動",	//YM4
"犯罪技術",	//_aa_bsecure_criminal_skills
"警告，設定已經被變更。\n系統現在無法產生一個關於這些警告的清單，但是將嘗試在重試。",	//YM188
"NAT 用戶端過濾項目控制路由器如何管理已經被使用的通訊埠流入連線需求。",	//YM133
"區域端起始通訊埠應介於0~65535 之間。",	//YM59
"手動",	//_aa_bsecure_manually
"Email 位址沒有被設定。",	//YM169
"使用這個項目來進行路由器內部網路相關設定。在這裡所設定的IP 位址是您使用網頁方式進入設備管理界面的IP 位址。如果您改變這邊的IP 位址，您可能需要改變您電腦的IP 位址設定為相同網段後，再使用新的IP位址重新連結一次。",	//YM97
"兒童 (0~8)",	//_aa_bsecure_age_child
"網站位址 '%s' 為無效。 ",	//GW_WEB_FILTER_WEBSITE_INVALID_INVALID
"週",	//ZM21
"網際網路會談(Sessions)",	//YM157
"WCN ActiveX 控制項提供不須透過USB 快閃記憶裝置，只需透過瀏覽器及可完成您的電腦與路由器之間的WCN 連結設定。瀏覽器將嘗試下載WCN 的ActiveX 控制項，如果在您的電腦上無法下載使用。如果要完成這個步驟的話，您必須確認電腦已經可以連線上網際網路，以及瀏覽器的安全性設定層級必須為中低或低。(請點擊連覽器的工為&rarr；網際網路選擇 &rarr；安全性 &rarr；自定層級&amp;rarr；選擇為中低或低)",	//help213
"您確定您要啟用/停用?",	//YM24
"同位(peer) 設定錯誤  %u",	//WIFISC_AP_PEER_CFG_ERR
"如果您的無線網路已經完成Wi-Fi 防護設定，再進行無線網路手動設定的話，將會變更現行的無線網路組態。",	//LW43
"無效的保留MAC 位址",	//YM90
"TKIP 及 AES",	//bws_CT_3
"<warn>DHCP 保留位址 %v 已經被重複設定至 %v，請確認這個重複的設定是您的網路所必須。</warn>",	//GW_DHCP_SERVER_RESERVATION_RECONFIG_WARNING
"無效的路徑通訊閘",	//_r_alert3
"無效的RIP 公制(metric)",	//GW_LAN_RIP_METRIC_INVALID
"WPA 群組金鑰更新間隔設定範圍應該在30~65535 秒之間。",	//YM118
"無效的通訊閘位址",	//YM127
"串流引擎",	//KR71
"啟用WDS",	//aw_WDSEn
"區域端",	//sa_Local
"閒置時間不能為0。",	//GW_WEB_SERVER_IDLE_TIME
"這個選項控制設備如何對WAN 端連線的流量做出回應。",	//KR59
"WAN 通訊閘IP 位址 %v必須再WAN 端子網路的範圍中。",	//GW_WAN_WAN_GATEWAY_IN_SUBNET_INVALID
"區域端IP 範圍",	//at_LoIPR
"語音 (VO)",	//YM81
"聚集(Aggregation)Num 封包",	//aw_AP
"在<a href='wireless.asp'>設定&rarr; 無線設定</a> 頁面，以及<a href='adv_wish.asp'>進階設定 &rarr; WISH</a> 頁面中，可以對這此功能作設定。<span class='option'>MAC 位址</span> 為無線網路卡出廠時所配發的獨立且唯一的識別號碼。",	//LT290
"WISH功能將自動指派這個會談的封包傳送優先權。優先權為︰",	//YM162
"設定檔語法分析錯誤 (MIME)",	//GW_XML_CONFIG_SET_PARSE_MIME
"UDP 通訊埠",	//GW_NAT_UDP_PORT
"成功",	//YM9
"無效的MTU 值(允許可設定的範圍值為 %u 到 %u)",	//GW_WAN_MTU_INVALID
"工作站新增成功 %s (%m)",	//WIFISC_IR_REGISTRATION_SUCCESS
"路徑內容將包含封包IP 位址。",	//help105
"DHCP 伺服器位址 %v，已經由網路上的其他裝置釋放。",	//GW_DHCPSERVER_RELEASED
"開始印表機伺服器設定精靈",	//LW32
"(%s) SetAP設定失敗，原因 (%s)，錯誤碼 (%u)",	//WIFISC_AP_SET_APSETTINGS_FAIL
"無效的路徑IP 位址",	//KR8
"規則名稱欄位允許您定義一個名稱以供識別這筆路徑設定，例如 &quot;Network 2&quot;。",	//hhav_r_name
"混合網路 (點對點傳送之後廣播)",	//bd_NETBIOS_REG_TYPE_H
"發生不適當的對應時，下列介於NAT&quot;Cone&quot;分類類型和&quot;結點過濾器&quot;模式之間的嚴密的通信可能會被拉長;如果路由器被設定成獨立結點過濾，它會提供完整的NAT cone行為；限制位址過濾提供受限的cone行為；限制位址和服務埠過濾則提供受限的服務埠NAT cone行為。",	//KR55
"PPPoE IP 位址 %v 與LAN 端子網路衝突",	//GW_WAN_PPPOE_LAN_SUBNET_CONFLICT_INVALID
"設定檔輸入回存成功",	//GW_XML_CONFIG_SET_SUCCESS
"區域端結束通訊埠設定範圍應介於0~65535之間。",	//YM60
"儲存設定失敗",	//KR100
"如果WAN 埠已經連線至網際網路(internet)端，請選擇這個項目；路由器將運行為NAT 模式。",	//KR61
"無效的L2TP IP 位址",	//YM109
"由 %s 重設失敗，原因 (%s)，錯誤碼 (%u)",	//WIFISC_AP_RESET_FAIL
"由本機端的硬碟中載入(回存)設定值",	//help_ts_ls
"無效的WAN 端通訊閘IP 位址",	//YM101
"自動",	//KR50
"通訊協定設定值必須為數值",	//YM56
"網站 URL/網域",	//aa_WebSite_Domain
"最大傳輸速率設定值必須介於8kbps 到100Mbps 範圍之中。",	//GW_QOS_RULES_MAX_TRANS
"HTTP 或HTTPS 必須至少啟用一個。",	//GW_WEB_SERVER_NO_ACCESS
"設定備用的WINS 伺服器IP 位址。",	//KR87
"目的地起始IP 位址不在LAN 端子網路的範圍中",	//YM16
"規則名稱 '%s' 已經在使用中。",	//GW_SCHEDULES_NAME_CONFLICT_INVALID
"WEP 金鑰 4",	//wepkey4
"WAN 端的同一個通訊埠無法同時使用HTTP 或HTTPS 通訊協定",	//GW_WEB_SERVER_SAME_PORT_WAN
"無效的來源結束IP 位址",	//YM65
"網路設定",	//bln_title
"MAC STA (%m) 登錄失敗，原因 (%s)，錯誤碼 (%u)",	//WIFISC_AP_PROXY_PROCESS_FAIL
"更多",	//_more
"傳送/接收 記錄",	//ZM12
"Banner Ad",	//_aa_bsecure_banner_ad
"無線狀態",	//LY23
"選擇一個以上的空間串流以增加傳輸效能，但是有時候會因此而降低訊號品質。",	//bwl_NSS_h1
"沒有裝置被定義在規則 %s 之中。",	//GW_INET_ACL_NO_MACHINE_IN_LAN_SUBNET_INVALID
"在開始這些設定精靈之前，您可以先參考產品包裝中快速安裝手冊的所有步驟說明。",	//LW39c
"設定選擇登錄端完成",	//WIFISC_AP_SET_SELECTED_REGISTRAR_COMPLETE
"無效的DHCP 用戶端名稱",	//GW_DHCP_CLIENT_CLIENT_NAME_INVALID
"重新整理使用中的會談(Session)清單失敗，請重試一次。",	//YM166
"由 %s 重新啟動失敗，原因 (%s)，錯誤碼 (%u)",	//WIFISC_AP_REBOOT_FAIL
"下面的設定精靈可以幫助您設定您的無線網路和無線設備的連接。",	//LW39
"密碼與密碼確認欄位內容不相符，請重新確認您所輸入的使用者密碼。",	//YM174
"通訊埠過濾器規則名稱不能為空白。",	//YM13
"您的網頁瀏覽器版本過舊無法正確瀏覽本網頁，請更新您的網頁瀏覽器。",	//YM172
"無效的TPC 最大增益",	//YM31
"選擇一個標記類型以供過濾器使用。",	//_aa_wiz_s6_msg
"無效的密碼",	//GW_SMTP_PASSWORD_INVALID
"主機 2 通訊埠範圍",	//YM85
"規則名稱欄位內容不能為空白",	//GW_SCHEDULES_NAME_INVALID
"無效的通訊閘",	//LS204
"16 Kbytes",	//aw_16
"開始設定精靈",	//LW64
"一天或每天",	//_days
"指定任一條設定規則將被啟用或停用。",	//help103
"-",	//YM183
"無效的群組金鑰更新間隔。",	//YM117
"NAT有&quot;Full Cone&quot;、&quot;Restricted Cone&quot;、&quot;Port Restricted Cone&quot;、&quot;Symmetric&quot;這幾種類型。但是這些類型名稱不在這裡使用，因為它們無法完全描述本路由器的NAT 行為。",	//KR54
"使用者可以在路徑設定頁面，自行指定特定的路徑，以決定封包傳遞的路徑。",	//av_intro_r
"如果您要使用這條路徑設定的話，請勾選它。",	//hhav_enable
"DNS 伺服器必須設定。",	//GW_WAN_DNS_SERVERS_INVALID
"回復完成",	//_rs_succeeded
"PPTP 使用者名稱必須被定義",	//GW_WAN_PPTP_USERNAME_INVALID
"無效的L2TP IP 位址: %v",	//GW_WAN_L2TP_IP_ADDRESS_INVALID
"規則名稱不能為空的字串。",	//GW_INET_ACL_NAME_INVALID
"每天",	//days
"這個進階設定預設值為空白的。這邊允許使用者設定一個目前網路主機操作的NetBIOS ”網域(domain)”名稱。",	//KR88
"無效的PPPoE IP位址: %v",	//GW_WAN_PPPOE_IP_ADDRESS_INVALID
"使用較大長度的字元來定義加密金鑰，而非簡單、字數少的加密金鑰，以取得最佳的安全性。",	//KR19
"無效的Beacon 間隔",	//YM27
"在<a href='wireless.asp'>設定 &rarr; 無線設定</a> 頁面中，您可以對此進行相關設定。在 <a href='../Advanced/Protected_Setup.shtml'>進階設定&rarr; Wi-Fi 保護設定</a> 頁面中，<span class='option'>MAC 位址</span> 是無線網路卡在出廠時所分派的實體辨識號碼。",	//LT291wifisc
"通訊埠過濾器規則名稱",	//KR1
"規則 \'",	//YM51
"傳送/接收 狀態",	//ZM13
"次要DNS 無法使用。",	//GW_LAN_PRIMARY_DNS_INVALID
"11a 模式下無法啟用Turbo 功能。",	//GW_WLAN_11A_DFS_TURBO_INVALID
"改變您的無線網路名稱(SSID)是使您的無線網路更安全的過程中第一步。把它改成為一個不包含任何個人訊息的只有您自己熟悉名稱。",	//YM123
"虛擬伺服器中設定的IP 位址為無效",	//KR9
"例如: 192.168.0.1",	//KR79
"成人 (18+)",	//_aa_bsecure_age_adult
"未定義",	//ZM7
"通訊埠過濾器功能中的目的地起始通訊埠設定值不能大於目的地結束通訊埠",	//YM23
"啟用 WISH",	//YM73
"到期",	//LS425
"產生新辨識碼",	//LW11
"<warn>虛擬伺服器已經有一筆相同需求的設定被新增，PPTP ALG 已經自動啟用。</warn>",	//GW_NAT_PPTP_ALG_ACTIVATED_WARNING
"您確定要刪除?",	//YM35
"選擇一天",	//tsc_sel_days
"路由器必須重新啟動之後所有新的設定才會生效；您可以選擇馬上重新啟動，或是繼續其他的設定稍後再重新啟動。",	//sc_intro_rb4
"時間規劃名稱: '%s'，無效的時間設定",	//GW_SCHEDULES_TIME_INVALID
"無效的租約時間 (必須為1~65535之間)",	//GW_DHCP_SERVER_LEASE_TIME_INVALID
"伺服器IP 位址無法辨識，寄送email 失敗",	//IPSMTPCLIENT_NO_SERVER_IP_ADDRESS
"虛擬伺服器設定的私人通訊埠設定範圍應在1~65535之間",	//KR10
"Https 不是一個支援的通訊協定。",	//GW_WEB_FILTER_HTTPS_NOT_SUPPORTED_INVALID
"無線裝置辨識碼應設定4或8個數值",	//KR22
"兩者",	//_vs_both
"在開始設定前AP 不會被鎖定。",	//GW_WIFISC_LOCK_VERIFY_ERR
"無線訊框可以被分成更小的單位(碎片)，在RF 干擾和RF覆蓋範圍受限制的情況下改善傳輸性能。",	//LW53
"網站位址 '%s' 已經在使用中。",	//GW_WEB_FILTER_WEB_SITE_IS_USED_INVALID
"無效的來源起始IP 位址。",	//YM64
"無效的路徑界面",	//GW_ROUTES_INTERFACE_INVALID
"無效的次要DNS。",	//GW_LAN_SECONDARY_DNS_INVALID
"從WAN 學習NetBIOS",	//bd_NETBIOS_LEARN_FROM_WAN_ENABLE
"<warn>由於LAN 端子網路已經被變更，通訊埠轉送記錄表將重新設定。</warn>",	//GW_NAT_PORT_FORWARDING_TABLE_RECONFIGURED_WARNING
"802.11 頻帶",	//KR15
"基地台(AP)已註冊至(%s) 經由 %s 失敗，意外終止 (%s), 狀態 (%s)",	//WIFISC_AP_REGISTRATION_UNEXPECTED_EVENT
"<warn>Syslog 伺服器IP 位址不在LAN 端子網路中，您可能需要重新設定</warn>",	//GW_SYSLOG_ADDRESS_NOT_IN_SUBNET_WARNING
"無效的次要WINS IP 位址",	//GW_DHCP_SERVER_NETBIOS_SECONDARY_WINS_INVALID
"注意: 這些功能並不會套用至DMZ 主機功能；這些種類的會談 DMZ主機將持續控制。",	//LW49
"新增/變更 時間規劃規則",	//KR95
"8 Kbytes",	//aw_8
"無效的次要DNS 伺服器IP 位址",	//YM114
"密碼類型",	//bws_CT
"R-rated",	//_aa_bsecure_rrated
"鎖定無線安全設定",	//LW6
"發放範圍IP 位址起始必須大於結束。",	//GW_DHCP_SERVER_POOL_FROM_TO_ORIENTATION_INVALID
"TKIP",	//bws_CT_1
"設定資料庫鎖定失敗 #%u",	//GW_XML_CONFIG_SET_LOCK
"保留 IP %v 與其他的保留IP 設定衝突",	//GW_DHCP_SERVER_RESERVED_IP_UNIQUENESS_INVALID
"WEP 金鑰 2",	//wepkey2
"網際網路連線手動組態",	//LW28
"停用這個設定以手動設定它。",	//KR83
"無效的Syslog 伺服器IP 位址。",	//GW_SYSLOG_ADDRESS_INVALID
"無效的PPTP IP 位址",	//YM105
"DHCP 用戶端",	//ZM5
"WCN ActiveX 控制項",	//help212
"請按下位於無線裝置的配置按鈕，然後按下畫面下方的連線按鈕。",	//KR45
"步驟 2:與您的無線裝置連線",	//KR36
"無效的路徑公制 %u ，必須介於1~6之間",	//GW_ROUTES_METRIC_INVALID
"SSID 欄位不能為空白。",	//GW_WLAN_SSID_INVALID
"閒置超時時間設定值不能小於或等於0。",	//YM179
"橋接模式下透過上端路由器在支援網站上查看相關更新。",	//KR66
"雜誌",	//_aa_bsecure_magazine
"目前裝置可能因過多的要求導致忙碌；請嘗試再儲存設定一次。",	//KR101
"WPA 專用模式無法支援AES 加密。",	//GW_WLAN_WPA_WPA_AES_INVALID
"流入封包過濾器",	//GW_NAT_INBOUND_FILTER
"規則名稱不能為空白。",	//GW_INET_ACL_POLICY_NAME_INVALID
"網際網路",	//sa_Internet
"當無線雷達偵測啟用時，無線頻道52-140 將無法被使用。",	//GW_WLAN_11A_DFS_CHANNEL_INVALID
"規則適用於主機1 的連接埠數在設定落在此範圍內訊息的遞送。",	//YM153
"遠端IP 範圍",	//at_ReIPR
"只有 '管理者(Admin)' 帳戶可以變更安全設定。",	//LW15
"DTIM 設定值範圍應在1~255之間。",	//GW_WLAN_DTIM_INVALID
"一個WISH規則定義一個特定訊息遞送並指派一個優先權給此遞送。",	//YM144
"DNS 設定",	//wwa_dnsset
"這個設定精靈將協助您的來賓無線裝置與您的無線路由器連線。設定精靈將一步步的引導您完成正確的連線步驟。請按下下面的按鈕以開始設定精靈。",	//wireless_gu
"透過WPA 新增來賓無線裝置",	//add_gu_wps
"無線頻段",	//wwl_band
"頻段",	//_band
"手動設定5GHz頻段的網路名稱",	//wwa_5G_nname
"來賓區域選擇",	//guestzone_title_1
"啟用來賓區域",	//guestzone_enable
"包含於無線網路中",	//guestzone_inclw
"來賓",	//guest
"較低於無線網路",	//lower_wnt
"與無線網路相等",	//equal_wnt
"較低",	//_lowest
"SSID 清單",	//ssid_lst
"來賓用戶端可以搜尋到網際網路來賓SSID",	//dlink_help150
"多重SSID",	//mult_ssid
"您可能需要為每一張無線網卡指派至少一個SSID。",	//dlink_help155
"新增/編輯 SSID",	//add_ed_ssid
"啟用或停用這個SSID。當選擇為啟用時, 下面的這些設定值將被套用。 ",	//dlink_help156
"選擇與這個SSID連線的無線用戶端, 在所屬的這個區域內為同一網路, 可以在這個區域中互相存取資料。",	//dlink_help157
"阻擋來自WAN 端的Ping 封包",	//wpin_filter
"選擇一個過濾方式以控制位於WAN 端的電腦是否可以使用Ping 這個功能。如果您在過濾清單中沒有看到有您需要的項目的話, 請到 進階→ 來源封包過濾 設定畫面中, 請自訂新增一個符合您需求使用的過濾方式。",	//dlink_help151
"如果您要新增一個來賓網路的話,  請選擇這個項目",	//S500
"網路類型",	//S496
"啟用HTTPS 伺服器",	//LV2
"現在寄送Email按鈕現在被停用, 因為在<a href='tools_email.asp' onclick='return jump_if();' shape='rect'>工具 &rarr; EMAIL設定</a>中的啟用Email告警功能並未被啟用。",	//logs_LW39b_email
"使用HTTPS",	//LV3
"%s%s無線網路系統的MAC 位址 %m 已安全的連結 ",	//GW_WIRELESS_DEVICE_LINK_UP
"所有的系統紀錄內容已清除",	//LT248
"%s PPPoE 會談, PPPoE 伺服器搜尋中",	//GW_PPPOE_EVENT_DISCOVERY_ATTEMPT
"5GHz 頻段",	//GW_WLAN_RADIO_1_NAME
"SMTP伺服器通訊埠",	//te_SMTPSv_Port
"無法變更802.11 模式為802.11n only, 當有一個SSID 被設定為使用WEP 加密時。 ",	//GW_WLAN_CHANGING_PHY_MODE_TO_11NG_ONLY_INVALID
"選擇您的無線網路",	//S558
"選擇您要進行設定的無線頻段",	//KRL8
"透過這個項目以協助您定義一個來賓區域範圍",	//LY30
"虛擬伺服器 '%s'無法使用與與路由器HTTPS WAN 管理者相同的通訊埠, %u",	//GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
"Wi-Fi 保護設定(WPS)已停用, 因為SSID '%s' 的安全設定目前為設定為WPA-企業級。",	//GW_WIFISC_DISABLED_AUTOMATICALLY
"%s PPPoE 會談提供接收, 服務提供為 %s 從 %s (%m)",	//GW_PPPOE_EVENT_OFFER
"2.4GHz 頻段",	//GW_WLAN_RADIO_0_NAME
"%s PPPoE 會談協定錯誤, 連線嘗試失敗。",	//GW_PPPOE_EVENT_DISCOVERY_REQUEST_ERROR
"PPPoE 會談名稱 %s 與其他會談名稱衝突",	//GW_WAN_PPPOE_SESSION_NAME_CONFLICT
"接收系統記錄發生錯誤! 記憶體不足以顯示系統記錄或因為其他的連線錯誤造成。",	//S525
"密碼內容只能為可印刷的字元(英文)。",	//S493
"您可以檢查這些警告, 因為可能有些功能已經被停用或變更。",	//KR136
"%s PPPoE 會談編號 %u , 終止中",	//GW_PPPOE_EVENT_DISCONNECT
"IGMP Proxy 增強",	//anet_multicast_enhanced
"使用這個項目以啟用主機區域與來賓區域的繞送, 沒有啟用這個功能的話, 來賓用戶端將無法存取主機用戶端的資料。",	//LY34
"%s無線網路關閉 ",	//GW_WIRELESS_SHUT_DOWN
"%s無線網路重新啟動 ",	//GW_WIRELESS_RESTART
"管理者閒置時間可設定範圍為1-65535。",	//S528
"服務埠轉傳ALG 失敗, 無法分配TCP 封包會談 從%v:%u 到 %v:%u",	//GW_PORT_FORWARD_TCP_PACKET_ALLOC_FAILURE
"使用這個項目已為您的路由器進行來賓區域相關設定。來賓區域將提供一個分隔的網路區域僅供來賓存取網際網路使用。",	//guestzone_Intro_1
"虛擬伺服器 '%s'無法使用與與路由器HTTPS WAN 管理者相同的通訊埠, %u",	//GW_NAT_VIRTUAL_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTPS_ADMIN_PORT
"啟用區域間繞送",	//S473
"通訊埠應該在這個範圍內(1..65535)",	//te_SMTPSv_Port_alert
"%s起始無線網路失敗 ",	//GW_WIRELESS_DEVICE_START_FAILED
"服務埠轉傳ALG 失敗, 無法分配UDP 封包會談 從%v:%u 到 %v:%u",	//GW_PORT_FORWARD_UDP_PACKET_ALLOC_FAILURE
"%s中斷所有station 連線 ",	//GW_WIRELESS_DEVICE_DISCONNECT_ALL
"%s PPPoE 會談提供發佈需求",	//GW_PPPOE_EVENT_OFFER_REQUEST
"路由器IP %v 必須為一個有效的主機位址(xxx.xxx.xxx.xxx)",	//GW_ROUTES_ROUTERS_IP_ADDRESS_INVALID
"通訊埠觸發ALG 失敗, 無法分配UDP 封包會談 從%v:%u 到 %v:%u",	//GW_PORT_TRIGGER_UDP_PACKET_ALLOC_FAILURE
"當802.11 模式設定為802.11n only 時, WEP 安全加密無法被設定在任一SSID。",	//GW_WLAN_SETTING_SSID_SECURITY_TO_WEP_INVALID
"虛擬伺服器 '%s'無法使用與與路由器HTTPS WAN 管理者相同的通訊埠, %u",	//GW_WEB_SERVER_PUBLIC_PORT_CAN_NOT_MATCH_HTTP_ADMIN_PORT
"超過閒置時間, station中斷",	//GW_WLAN_STATION_TIMEOUT
"虛擬主機 '%s' 不能使用路由器的IP 位址, %v。",	//GW_NAT_VIRTUAL_SERVER_IP_ADDRESS_CAN_NOT_MATCH_ROUTER
"%s' [通訊協定:%u]->%v 發生衝突與 '%s' [通訊協定:%u]->%v. ",	//GW_NAT_VIRTUAL_SERVER_PROTO_CONFLICT_INVALID
"不論如何設定來賓區域都會被停用或啟用。",	//LY28
"嘗試建立 %s PPPoE 連線",	//GW_PPPOE_EVENT_CONNECT
"操作期間的頻率頻段。 選擇2.4Ghz 以適用最佳的相容性及較遠的無線範圍。選擇5GHz 以達到最小的無線干擾, 干擾的程度多寡將影響無線網路的效能。",	//KR971
"自動配置一個網路金鑰供2.4Ghz 及5GHz 頻段 使用(建議)",	//wwz_auto_assign_key3
"請為來賓區域無線網路提供一個名稱。",	//LY292
"為讓您的無線網路更加安全, 請選擇使用一種無線網路安全加密方式。 本路由器提供四種無線安全加密方式: WEP, WPA only, WPA2 only 及WPA/WPA2(自動偵測)。",	//LY293
"如果您選擇了使用WEP 安全加密選項的話, 裝置將<strong>只能</strong>運作使用<strong>基本無線模式 (802.11B/G)</strong>。因為WEP 加密並沒有被802.11n 草案所支援, 所以這代表您將<strong>不能使用</strong>802.11n 模式以達到最佳無線效能。",	//bws_msg_WEP_4
"路由器 %v 在介面 %s 可能沒有被產生 - 這個介面只有路由經由通訊閘才可能被產生",	//GW_ROUTES_ON_LINK_DATALINK_CHECK_INVALID
"MTU 預設值 =",	//_308
"本機網域名稱",	//_262
"此項目是選擇性的. 輸入本地網路的網域名稱. AP的DHCP伺服器將會把網域名稱給無線區域網路裡的電腦. 例如, 若是您在這裡輸入<code>mynetwork.net</code>, 您有一台電腦名稱是<code>chris</code>的無線筆記型電腦, 筆電將會成為<code>chris.mynetwork.net</code>.",	//_1044
"您想設定的LAN端位址",	//_1066
"您真的想要使用韌體檔案來改編裝置嗎 ",	//tf_really_FWF
"點選此按鈕來開啟建立一個新的存取控制",	//_501_12
"注意,若基地台的設定為&quot;DHCP(動態)&quot;位址，且<span>rou</span><span>ter</span>的DHCP伺服器指派一個網域名稱給基地台，則此網域名稱將會使您在此輸入的任何名稱無效。",	//_1044a
"選擇通訊協定",	//at_Prot_1
"到期時間",	//_223
"路由器位址不在子網路中",	//_225ap
"IP 位址或是子網路遮罩不正確",	//_226ap
"這是一個可選擇的輸入選項, 在設定本地網域的主要網域名稱. 當你在此區域網路中的電腦經由<span>rou</span><span>ter</span>的DHCP取得IP位址後將會採用這個主要網域名稱.所以,舉例：如果你在此輸入<code>mynetwork.net</code>, 而你在此區域網路的電腦名稱為 <code>chris</code>, 因此這台電腦將被認知為<code>chris.mynetwork.net</code>.",	//_1044wired
"註譯, 無論如何, 輸入了主要網域名稱就可以覆蓋掉原本已經在<span>rou</span><span>ter</span>的上傳路徑 DHCP伺服器中的相同名稱主機.",	//_1044awired
"廣域網路(WAN) IPv6位址設定",	//IPV6_WAN_IP
"IPv6位址",	//IPV6_TEXT0
"請先變更為IPv6 WAN端通訊協定",	//IPV6_TEXT1
"無效的網路金鑰",	//IPV6_TEXT2
"啟用區域間的路由",	//IPV6_TEXT3
"啟用SSID",	//IPV6_TEXT4
"此區塊可協助您去定義來賓區域",	//IPV6_TEXT5
"無論來賓區域會被停用或啟用都要定義",	//IPV6_TEXT6
"提供一個名稱給來賓區域的無線網路",	//IPV6_TEXT7
"利用此區塊來啟用主人與來賓區域間的路由，若無啟用此功能時來賓區的用戶端無法存取主人區的資料。",	//IPV6_TEXT8
"保全您的無線網路是很重要的，因為它用來保護被傳輸資料的完整性，路由器有支援四種類型的安全模式:WEP, 僅WPA, 僅WPA2和 WPA/WPA2 (自動偵測)",	//IPV6_TEXT9
"Wired Equivalent Protocol (WEP)是給無線區域網路(WLAN)的一種無線安全協定，WEP是經由對WLAN內傳送的資料加密來提供安全性。路由器提供兩個等級的WEP加密方式:64位元和128位元。WEP加密預設是停用的，WEP設定可以變更來適用於現存的無線網路或去自訂您的無線網路。",	//IPV6_TEXT10
"驗證是由路由器確認任何想要加入無線網路的網路裝置身份的一個程序。當使用WEP加密時有兩個驗證類型。",	//IPV6_TEXT11
"選擇此項目來允許所有的無線裝置不被要求提供密碼即可與路由器溝通來存取網路",	//IPV6_TEXT12
"若您要求任何想要與路由器溝通的無線裝置在被允許與DIR-615溝通前提供必要的加密金鑰來存取網路則選取此項目",	//IPV6_TEXT13
"選擇您想要在網路內使用的WEP加密等級，支援64位元和128位元兩種等級",	//IPV6_TEXT14
"DIR-615支援的金鑰類型為HEX (Hexadecimal) 和ASCII (American Standard Code for Information Interchange.)金鑰類型可以被變更來適用於現存的無線網路或去自訂您的無線網路。",	//IPV6_TEXT15
"金鑰",	//IPV6_TEXT16
"金鑰1-4讓您可簡易的變更無線加密設定來維護一個安全的網路，選擇要被使用的特定金鑰來為無線網路的資料加密。",	//IPV6_TEXT17
"金鑰類型",	//IPV6_TEXT18
"WEP加密",	//IPV6_TEXT19
"Wi-Fi Protected Access允許並驗證連到無線網路的使用者，WPA使用比WEP更強的安全性且是以一個在固定間隔時間會自動變更的金鑰為基礎。",	//IPV6_TEXT20
"當以WPA作為安全模式時，DIR-615支援兩個不同的密碼類型，此兩個選項為TKIP (Temporal Key Integrity Protocol)和AES (Advanced Encryption Standard).",	//IPV6_TEXT21
"PSK/EAP",	//IPV6_TEXT22
"當PSK被選擇時，您的無線用戶端將需要提供一個用來驗證的密碼。當EAP被選擇時，您將需要一個處理所有無線網路用戶端驗證的RADIUS伺服器在網路內。",	//IPV6_TEXT23
"密碼",	//IPV6_TEXT24
"當PSK被選擇時，為了與您的DIR-615溝通，您的無線網路用戶端必須輸入8-63個字元的密碼。請確定將此密碼寫下，因為當您要嘗試加入其他無線裝置到網路時將需要輸入此密碼。",	//IPV6_TEXT25
"這表示WPA驗證使用與RADIUS伺服器相關聯必須架設在您的網路內。輸入RADIUS伺服器的IP位址，通訊埠和用來配置伺服器的Shared Secret。若您在網路內有兩台伺服器用來驗證無線用戶端的話，您也可以選擇輸入次要RADIUS伺服器的資料。",	//IPV6_TEXT26
"Wi-Fi Protected Access2允許並驗證連到無線網路的使用者，WPA2使用比WEP更強的安全性且是以一個在固定間隔時間會自動變更的金鑰為基礎。",	//IPV6_TEXT27
"利用此區塊來配置您的IPv6連線類型，若您不確定您的連線方式，請與您的網路服務提供者聯絡",	//IPV6_TEXT28
"IPv6連線類型",	//IPV6_TEXT29
"IPv6連線類型",	//IPV6_TEXT29a
"選擇要被路由器",	//IPV6_TEXT30
"我的IPv6連線為",	//IPV6_TEXT31
"固定的IPv6",	//IPV6_TEXT32
"DHCPv6",	//IPV6_TEXT33
"PPPoE",	//IPV6_TEXT34
"IPv6 in IPv4 通道",	//IPV6_TEXT35
"6to4",	//IPV6_TEXT36
"僅區域間連線",	//IPV6_TEXT37
"IPv6 in IPv4 通道設定",	//IPV6_TEXT38
"請輸入由通道提供者所提供的Pv6 in IPv4 通道設定資訊",	//IPV6_TEXT39
"遠端IPv4位址",	//IPV6_TEXT40
"遠端IPv6位址",	//IPV6_TEXT41
"本地端IPv4位址",	//IPV6_TEXT42
"本地端IPv6位址",	//IPV6_TEXT43
"區域網路IPv6位址設定",	//IPV6_TEXT44
"使用這個項目以進行路由器的網際網路相關設定。如果您在這邊變更為區域網路IPv6位址,您可能需要變更您的本機電腦的網路設定後再重新存取網路。",	//IPV6_TEXT45
"區域網路IPv6位址",	//IPV6_TEXT46
"區域網路IPv6 區域間連線位址",	//IPV6_TEXT47
"位址自動設定",	//IPV6_TEXT48
"使用這個項目,以設定IPv6自動配置IP位址到位於您的網路上的電腦。",	//IPV6_TEXT49
"啟用自動設定",	//IPV6_TEXT50
"驗證類型",	//IPV6_TEXT51
"無狀態配置(Stateless)",	//IPV6_TEXT52
"全狀態配置(Stateful)/(DHCPv6)",	//IPV6_TEXT53
"IPv6位址範圍(起始)",	//IPV6_TEXT54
"IPv6位址範圍(結束)",	//IPV6_TEXT55
"IPv6位址生存時間",	//IPV6_TEXT56
"路由器固定存活時間",	//IPV6_TEXT57
"當設定路由器去存取IPv6網路時，請確定在下拉式選單內選擇正確的IPv6連線類型。若您不確定該選哪個項目，請與您的網路服務提供者(ISP)聯絡。",	//IPV6_TEXT58
"若您透過路由器來存取IPv6網路時有問題，請再次檢查您在此頁面已輸入的任何設定且必要時與您的ISP確認。",	//IPV6_TEXT59
"6to4設定",	//IPV6_TEXT60
"輸入由您網路服務提供者(ISP)提供的IPv6位址資料",	//IPV6_TEXT61
"6to4位址",	//IPV6_TEXT62
" IPv6 DNS設定",	//IPV6_TEXT63
"自動取得一個DNS伺服器位址或輸入一個特定的DNS伺服器位址",	//IPV6_TEXT64
"自動取得一個DNS伺服器位址",	//IPV6_TEXT65
"使用下列DNS位址",	//IPV6_TEXT66
"利用此區塊來配置您路由器內部網路的設定",	//IPV6_TEXT67
"位址存活時間",	//IPV6_TEXT68
"固定存活時間",	//IPV6_TEXT69
"位址範圍(起始)",	//IPV6_TEXT70
"位址範圍(結束)",	//IPV6_TEXT71
"輸入由您網路服務提供者(ISP)提供的資料",	//IPV6_TEXT72
"閒置時間",	//IPV6_TEXT73
"子網路前置碼(Subnet Prefix Length)",	//IPV6_TEXT74
"預設閘道",	//IPV6_TEXT75
"IPv6(Internet Protocol version 6) 區塊可設定您的IPv6連線類型",	//IPV6_TEXT76
"有幾個連線類型可供選擇:區域間連線(Link-local), 靜態 IPv6, DHCP IPv6, 無狀態自動配置(Stateless Autoconfiguration), PPPoE, IPv6 in IPv4 通道和6to4，若您不確定您的連線方式，請聯絡您的IPv6網路服務提供者。注意:若使用PPPoE的選項，您需確認在電腦內的任何 PPPoE用戶端軟體己被移除或停用。",	//IPV6_TEXT77
"區域間連線模式",	//IPV6_TEXT78
"區域間連線位址其主要是用來溝通在同一個區域網路端上相鄰近的節點(電腦),如在一個沒有路由器的單一IPv6網路環境下, 區域間連線位址(link-local address)便用來溝通在此連線下的各個主機。",	//IPV6_TEXT79
"固定IPv6模式",	//IPV6_TEXT80
"此模式用於當您的ISP提供一組不會變動的IPv6位址時。此IPv6的資料是手動輸入在您的IPv6設定內，您必須輸入IPv6位址、子網路前置碼(Subnet Prefix Length)、預設閘道、主要DNS伺服器和次要DNS伺服器。您的ISP會提供您所有的資料。",	//IPV6_TEXT81
"DHCPv6模式",	//IPV6_TEXT82
"這是一個當您的路由器從ISP的伺服器要求一個IPv6位址的方式。有些ISP在路由器可以連線到IPv6網路前要求您在這端做一些設定",	//IPV6_TEXT83
"無狀態(Stateless)自動配置模式",	//IPV6_TEXT84
"這是一個當您的路由器從預設閘道要求一組IPv6位址的方式。",	//IPV6_TEXT85
"若您的ISP要求您使用 PPPoE (Point to Point Protocol over Ethernet)來連線到IPv6網路則選擇此項目，DSL提供者通常是使用此項目。此連線方式要求您輸入一個<strong>使用者名稱</strong>和<strong>密碼</strong>(由您的ISP提供)來存取IPv6網路，支援PAP和CHAP兩種驗證協定。",	//IPV6_TEXT86
"若ISP的伺服器派發路由器的WAN端IPv6位址來建立連線的話則選擇此項目",	//IPV6_TEXT87
"若您的ISP有指定一組固定的IPv6位址則選擇此項目，ISP會提供此IPv6<SPAN class=option>位址的數值",	//IPV6_TEXT88
"在WAN連線被中斷前設備可以閒置的時間間隔。最大閒置時間的數值只用於&quot;有流量時連線&quot;和&quot;手動&quot;的重新連線方式",	//IPV6_TEXT89
"IPv6 in IPv4 通道模式",	//IPV6_TEXT90
"IPv6 in IPv4 通道模式為利用現有 IPv4 網路，透過二端建立起一條 隧道(Tunnel) ，Server端透過這個 Tunnel 發送一組 IPv6 位址給另一端，使兩端可以使用 IPv6 封包在 Tunnel 內傳遞。使用者在外可使用公司內部私人網路，一樣是透過 Tunnel 建立，公司內部網段 IP 在 Tunnel 內傳遞，只不過這時換成 IPV6 封包。",	//IPV6_TEXT91
"6to4模式",	//IPV6_TEXT92
"6to4 位址用於在二個執行網際網路上 IPv4 及 IPv6 的節點間通訊。",	//IPV6_TEXT93
"主要的DNS伺服器，次要的DNS伺服器:輸入DNS伺服器的IPv6位址，若次要伺服器不使用時請將欄位留成空白",	//IPV6_TEXT94
"這些是路由器區域網路IPv6介面的設定。路由器的區域網路 IPv6位址設定以IPv6為基礎且子網路遮罩由您的ISP指派(以/64為字首的子網路遮罩是被區域網路支援的)",	//IPV6_TEXT95
"使用這個項目以進行IPv6 自動配置IPv6 位址給位於區域端網路的電腦。這邊您可以選擇無狀態(Stateless)自動配置模式或全狀態配置(Stateful)方式。",	//IPV6_TEXT96
"這兩個數值(起始和結束)定義一個DHCPv6伺服器用來派發位址給在您區域網路端電腦和裝置的IPv6位址範圍。然而，這些可能被用於手動設定的裝置或無法使用DHCPv6來自動取得網路位址詳細資料的裝置。",	//IPV6_TEXT97
"當您選擇狀態Stateful (DHCPv6)時以下的項目會顯示出來",	//IPV6_TEXT98
"連線到您區域網路的電腦(和其他裝置)也需要去設定他們的TCP/IP至”IPv6位址範圍內”或”自動取得IPv6位址”",	//IPV6_TEXT99
"IPv6位址範圍(DHCPv6)",	//IPV6_TEXT100
"一旦您的D-Link路由器做合適的設定且此選項被啟用時，路由器將會為連線到您區域網路內的電腦和其他裝置管理IPv6位址和其他網路設定資訊，您不需要自行來管理。",	//IPV6_TEXT101
"一台電腦或裝置手動設定取得一組在此範圍內的IPv6位址是有可能的",	//IPV6_TEXT102
"電腦在要求更新租約時間前取得一組IPv6位址可能需要的總時間",	//IPV6_TEXT103
"D-Link友訊科技(股)有限公司 | 無線寬頻路由器 | 主頁",	//TEXT000
"無狀態(Stateless)自動配置",	//TEXT001
"服務埠轉傳名稱 '+ i +'無效，不正確的字元',/,''",	//TEXT002
"規則名稱'+ i +'無效，不正確的字元',/,''",	//TEXT003
"無效的主機名稱. 不正確的字元',/,''",	//TEXT004
"無效的區域網域名稱. 不正確的字元',/,''",	//TEXT005
"規則名稱'+ i +' 無效，不正確的字元',/,''",	//TEXT006
"服務埠轉傳名稱'+ i +'無效，不正確的字元',/,''",	//TEXT007
"規則'+i+'設定與規則'+j+'.",	//TEXT008
"obj_word + '與其他公用服務埠衝突'",	//TEXT009
"obj_word + '與其他私人服務埠衝突'",	//TEXT010
"其他通訊協定類型是無效的",	//TEXT011
"請選擇有wps功能的無線裝置!",	//TEXT012
"流入封包過濾器必須小於'+ rule_max_num",	//TEXT013
"名稱不可設定和預設流入封包過濾器名稱&quot;允許所有&quot;和&quot;拒絕所有&quot;相同'.",	//TEXT014
"排程規則已滿!請刪除一個規則",	//TEXT015
"第一頁",	//TEXT016
"最後一頁",	//TEXT017
"前一頁",	//TEXT018
"系統活動",	//TEXT019
"除錯資料",	//TEXT020
"攻擊",	//TEXT021
"丟棄的封包",	//TEXT022
"注意",	//TEXT023
"當WPS被啟用時不可選擇WEP金鑰 2, 3, 4",	//TEXT024
"當WPS被啟用時不可選擇WPA-個人級/TKIP和AES加密",	//TEXT025
"當WPS被啟用時不可選擇WPA-企業級加密",	//TEXT026
"當WPS被啟用時不可選擇共用金鑰",	//TEXT027
"請先啟用無線",	//TEXT028
"WPS的功能目前設定為停用，請點選&quot;是&quot;來啟用它或&quot;不是&quot;來離開安裝精靈",	//TEXT029
"%s  無法允許回送IP 或多點廣播IP (127.x.x.x, 224.x.x.x ~ 239.x.x.x) 規則。",	//TEXT030
"輸入的 %s 服務埠是無效的.",	//TEXT031
"%s secret entered 為無效",	//TEXT032
"保留IP位址",	//TEXT033
"請輸入其他的名稱,",	//TEXT034
"起始IP位址",	//TEXT035
"結束IP位址",	//TEXT036
"LAN IP位址和起始IP位址不在相同的子網路遮罩",	//TEXT037
"LAN IP位址和結束IP位址不在相同的子網路遮罩",	//TEXT038
"結束IP位址必須大於起始IP位址",	//TEXT039
"設定已經被儲存",	//TEXT040
"金鑰  '+ i + ' 是無效的，金鑰必須為' + wep_key_len +' 字元或 ' + hex_len + ' hexadecimal number.",	//TEXT041
"金鑰 ' + i + '是錯誤的，正確的字元應該為0~9、A~F或 a~f",	//TEXT042
"%s 通訊閘IP位址 %s 必須在WAN子網路遮罩內,",	//TEXT043
"請先選擇一個電腦名稱",	//TEXT044
"此韌體是最新的版本",	//TEXT045
"連線至伺服器錯誤，請檢查網路連線的狀態",	//TEXT046
"WAN和LAN的IP位址不能在同一個子網路遮罩",	//TEXT047
"請輸入以下的設定至新增到您無線網路的裝置並記下以作為未來的參考",	//TEXT048
"您在指定時間內新增無線裝置到您的無線網路失敗，請點選下方的按鈕來重做一次",	//TEXT049
"IP位址 '+ res_ip +' 已經被使用.",	//TEXT050
"此確認密碼與新密碼不相符",	//TEXT051
"請先選擇一個應用程式名稱",	//TEXT052
"在WINDOWS VISTA也稱為WCN 2.0",	//TEXT053
"obj_word + 和服務埠轉傳的服務埠衝突",	//TEXT054
"obj_word + 和應用程式防火牆的服務埠衝突",	//TEXT055
"obj_word + 和虛擬伺服器的服務埠衝突",	//TEXT056
"服務埠衝突",	//TEXT057
"TCP埠衝突",	//TEXT058
"UDP埠衝突",	//TEXT059
"此服務埠轉傳的名稱已經在清單內",	//TEXT060
"請輸入一個TCP埠數字或一個UDP埠數字",	//TEXT061
"您想要啟用DHCP保留規則給IP位址 ' + DataArray[idx].IP'嗎?",	//TEXT062
"此規則已經被其他規則使用且無法被刪除",	//TEXT063
"排程名稱是無效的，正確的字元應該為0~9、A~Z或 a~z",	//TEXT064
"排程名稱是預設名稱",	//TEXT065
"此排程名稱已經在清單內",	//TEXT066
"此規則已經被其他規則使用且無法被編輯",	//TEXT067
"IPv6網路資訊",	//TEXT068
"所有IPv6的網際網路和網路連線詳細資料皆顯示於此頁面",	//TEXT069
"IPv6連線資訊",	//TEXT070
"廣域網路(WAN) IPv6位址",	//TEXT071
"區域網路(LAN) IPv6電腦",	//TEXT072
"重試",	//TEXT073
"下一頁",	//TEXT074	
"主機名稱或IPv6位址",	//TEXT075
"請在登入密碼欄位中輸入設備登入密碼後, 再請觀看下方的圖形, 在本欄位中輸入圖形中的文字。", //_authword
"重新整理", //regenerate
"請輸入圖形認證碼", //li_alert_4
"啟用圖形認證" //_graph_auth
	
	);


