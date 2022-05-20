#ifndef __XML_H__
#define __XML_H_
/* fill in the TR-069 paramater for your device */

/* device.c */
#define DEVICE_LANDEV_NUM 4 /* dev_landev_num, read only */
#define DEVICE_WANDEV_NUM 1 /* dev_wandev_num, read only */

/* dev_conf.c (InternetGatewayDevice.Config), Optional */
						/* dev_PersistentData, read/write, Optional */
						/* dev_ConfigFile, read/write, Optional */ 

/* dev_info.c (InternetGatewayDevice.DeviceInfo)*/
#define DEV_INFO_MANUFACTURER "D-Link"						/* dev_Manufacturer, read only */
#define DEV_INFO_MANU_OUI "00195B"							/* dev_ManufacturerOUI, read only */
#define DEV_INFO_MODEL_NAME "DIR-825_B1"						/* dev_ModelName, read only */
#define DEV_INFO_DESCRIPTION "Dual-Band WLAN, Gige Router"	/* dev_Description, read only */
#define DEV_INFO_PRODUCT_CLASS "Prodct-Class"				/* dev_ProductClass, read only, Optional */
#define DEV_INFO_SERIAL_NUM "1234567890AB"					/* dev_SerialNumber, read only */
#define DEV_INFO_HW_VER "B1"									/* dev_HardwareVersion, read only */
#define DEV_INFO_SW_VER "2.0"				 				/* dev_SoftwareVersion, read only */
#define DEV_INFO_SPEC_VER "1.0"								/* dev_SpecVersion, read only */
#define DEV_INFO_PROVISION_CODE "098765"						/* dev_ProvisioningCode, read only */
#define DEV_INFO_UP_TIME "2000-00-00T00:00:00"				/* dev_UpTime, read only */
#define DEV_INFO_DEV_LOG "Device-Log"						/* dev_DeviceLog, read only */
#define DEV_INFO_VENDOR_CFILE_NUM 10							/* dev_Vendor_CFile_Num, read only, Optional */
#define DEV_INFO_MODEM_VER "1234567890"						/* dev_Modem_Ver, read only, Optional */
#define DEV_INFO_ENABLE_OPT "111,222,333"					/* dev_Enable_Opt, read only, Optional */
#define DEV_INFO_ADDITIONAL_HW_VER "2222222222"				/* dev_Additional_Hard_Ver, read only, Optional */
#define DEV_INFO_ADDITIONAL_SW_VER "b01"						/* dev_Additional_Soft_ver, read only, Optional */
#define DEV_INFO_1ST_USER_DATE "2000-00-00T00:00:01"			/* dev_FirstUserDate, read only, Optional */
/* dev_info.c (InternetGatewayDevice.DeviceInfo.VendorConfigFile{i}), Optional */
#define DEV_INFO_VENDOR_FILE_NAME "VendorFile-Name"			/* dev_VendorFile_name, read only, Conditional */
#define DEV_INFO_VENDOR_FILE_VER "VendorFile-Version"		/* dev_VendorFile_version, read only, Conditional */
#define DEV_INFO_VENDOR_FILE_DATE "VendorFile-Date"			/* dev_VendorFile_date, read only, Conditional */ 
#define DEV_INFO_VENDOR_FILE_DESC "VendorFile-Desc"			/* dev_VendorFile_desciption, read only, Optional */ 

/* dev_param.c */
						/* dev_get_wan_para */
						/* dev_first_install */
						/* dev_reboot_cmdkey */
						/* get_flash_free_size */
						/* kill_all_apps */
						/* parse_date */
						/* write_config_file */
						/* write_web */
						/* flash_image */
						/* reboot_dev */
						/* TR_sys_cmd */
	
/* dev_time.c (InternetGatewayDevice.Time), Optional */
#define DEV_TIME_NTP_SERVER1 "NTP-Server1"		/* dev_Time_NTPServer1, read/write, Conditional */
#define DEV_TIME_NTP_SERVER2 "NTP-Server2"		/* dev_Time_NTPServer2, read/write, Conditional */
#define DEV_TIME_NTP_SERVER3 "NTP-Server3"		/* dev_Time_NTPServer3, read/write, Optional */
#define DEV_TIME_NTP_SERVER4 "NTP-Server4"		/* dev_Time_NTPServer4, read/write, Optional */
#define DEV_TIME_NTP_SERVER5 "NTP-Server5"		/* dev_Time_NTPServer5, read/write, Optional */
#define DEV_TIME_CURR_LOCAL_TIME "Local-Time"	/* dev_Time_CurrentLocalTime, read only, Conditional */
												/* dev_Time_LocalTimeZone, read/write, Conditional */
												/* dev_Time_LocalTimeName, read/write, Conditional */
												/* dev_Time_DayLightSavingUsed, read/write, Conditional */
												/* dev_Time_DayLightSavingStart, read/write, Conditional */
												/* dev_Time_DayLightSavingEnd, read/write, Conditional */
												


/* dev_upload.c */
					/* dev_getconfigfile */
					/* dev_getsyslog */

/* ip_ping_diag.c(InternetGatewayDevice.IPPingDiagnostics), Optional */
					/* dev_IPPing_DiagnosticsState, read/write, Conditional */
					/* dev_IPPing_Interface, read/write, Conditional */
					/* dev_IPPing_Host, read/write, Conditional */
					/* dev_IPPing_NumberOfRepetitions, read/write, Conditional */
					/* dev_IPPing_Timeout, read/write, Conditional */
					/* dev_IPPing_DateBlockSize, read/write, Conditional */
					/* dev_IPPing_DSCP, read/write, Conditional */
#define DEV_IPPING_SUCCESS_COUNT	10			/* dev_IPPing_SuccessCount, read only, Conditional*/
#define DEV_IPPING_FAIL_COUNT 10				/* dev_IPPing_FailureCount, read only, Conditional*/
#define DEV_IPPING_AVG_RSP_TIME 10			/* dev_IPPing_AverageResponseTime, read only, Conditional*/
#define DEV_IPPING_MIN_RSP_TIME 10			/* dev_IPPing_MinimumResponseTime, read only, Conditional*/
#define DEV_IPPING_MAX_RSP_TIME 10			/* dev_IPPing_MaximumRespTime, read only, Conditional*/


/* lan_conf_secut.c(InternetGatewayDevice.LANConfigSecurity)*/
						/* dev_LAN_ConfigPassword, write only */

/* lan_dev.c(InternetGatewayDevice.LANDevice{i})*/
#define DEV_LANDEVICE_ETH_NUM 4							/* dev_LANDevice_Ethnum, read only */
#define DEV_LANDEVICE_USB_NUM 2							/* dev_LANDevice_USBnum, read only */
#define DEV_LANDEVICE_WLAN_NUM 2						/* dev_LANDEVICE_WLANnum, read only */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.LANHostConfigManagement)*/
											/* dev_LANHost_DHCPServerConfigurable, read/write */
											/* dev_LANHost_DHCPServerEnable, read/write */
											/* dev_LANHost_DHCPRelay, read only */
											/* dev_LANHost_MinAddress, read/write */
											/* dev_LANHost_MaxAddress, read/write */
											/* dev_LANHost_ReservedAddresses, read/write */
											/* dev_LANHost_SubnetMask, read/write */
											/* dev_LANHost_DNSServers, read/write */
											/* dev_LANHost_DomainName, read/write */
											/* dev_LANHost_IPRouters, read/write */
											/* dev_LANHost_DHCPLeaseTime, read/write, Optional */
											/* dev_LANHost_UseAllocatedWAN, read/write, Optional */
											/* dev_LANHost_AssociatedConnection, read/write, optional */
											/* dev_LANHost_PassthroughLease, read/write, Optional */
											/* dev_LANHost_PassthroughMACAddress, read/write, Optional */
											/* dev_LANHost_AllowedMACAddress, read/write, Optional */
											/* dev_LANHost_IPnum, read only */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.LANHostConfigManagement.IPInterface{i}) */
											/* dev_LH_IPInterface_Enable, read/write */
											/* dev_LH_IPInterface_IPAddress, read/write */
											/* dev_LH_IPInterface_SubnetMask, read/write */
											/* dev_LH_IPInterface_AddressingType, read/write */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.LANEthernetInterfaceConfig{i}), Conditional */
											/* dev_Eth_config_Enable, read/write, Conditional */
											/* dev_Eth_config_Status, read/write, Conditional */
											/* dev_Eth_config_MACAddress, read only, Conditional */
											/* dev_Eth_config_MACControlEnabled, read/write, Conditional */
											/* dev_Eth_config_MaxBitRate, read/write, Conditional */
											/* dev_Eth_config_DuplexMode, read/write, Conditional */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.LANEthernetInterfaceConfig{i}.Stats), Conditional */
											/* dev_LAN_Ethstats_BytesSent, read only, Conditional */
											/* dev_LAN_Ethstats_BytesReceived, read only, Conditional */
											/* dev_LAN_Ethstats_PacketsSent, read only, Conditional */
											/* dev_LAN_Ethstats_PacketsReceived, read only, Conditional */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.LANUSBInterfaceConfig{i}), Conditional */
											/* dev_usb_config_Enable, read/write, Conditional */
											/* dev_usb_config_Status, read only, Conditional */
											/* dev_usb_config_MACAddress, read only, Conditional */
											/* dev_usb_config_MACControlEnabled, read/write, Conditional */
											/* dev_usb_config_Standard, read only, Conditional */
											/* dev_usb_config_Type, read only, Conditional */
											/* dev_usb_config_Rate, read only, Conditional */
											/* dev_usb_config_Power, read only, Conditional */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.LANUSBInterfaceConfig{i}.Stats), Conditional */
											/* dev_LAN_USB_BytesSent, read only, Conditional */
											/* dev_LAN_USB_BytesReceived, read only, Conditional */
											/* dev_LAN_USB_CellsSent, read only, Conditional */
											/* dev_LAN_USB_CellsReceived, read only, Conditional */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.WLANConfiguration{i}), Conditional */
											/* dev_WLAN_Enable, read/write, Conditional */
											/* dev_WLAN_Status, read only, Conditional */
											/* dev_WLAN_BSSID, read only, Conditional */
											/* dev_WLAN_MaxBitRate, read/write, Conditional */
											/* dev_WLAN_Channel, read/write, Conditional */
											/* dev_WLAN_SSID, read/write, Conditional */
											/* dev_WLAN_BeaconType, read/write, Conditional */
											/* dev_WLAN_MACAddressControlEnabled, read/write, Conditional */
											/* dev_WLAN_Standard, read only, Conditional */
											/* dev_WLAN_WEPKeyIndex, read/write, Conditional */
											/* dev_WLAN_KeyPassphrase, write only, Conditional */
											/* dev_WLAN_WEPEncryptionLevel, read only, Conditional */
											/* dev_WLAN_BasicEncryptionModes, read/write, Conditional */
											/* dev_WLAN_BasicAuthenticationMode, read/write, Conditional */
											/* dev_WLAN_WPAEncryptionModes, read/write, Conditional */
											/* dev_WLAN_WPAAuthenticationMode, read/write, Conditional */
											/* dev_WLAN_IEEE11iEncryptionModes, read/write, Optional */
											/* dev_WLAN_IEEE11iAuthenticationMode, read/write, Optional */
											/* dev_WLAN_PossibleChannels, read only, Conditional */
											/* dev_WLAN_BasicDataTransmitRates, read/write, Conditional */
											/* dev_WLAN_OperationalDataTransmitRates, read/write, Conditional */
											/* dev_WLAN_PossibleDataTransmitRates, read only, Conditional */
											/* dev_WLAN_InsecureOOBAccessEnabled, read/write, Optional */
											/* dev_WLAN_BeaconAdvertisementEnabled, read/write, Optional */
											/* dev_WLAN_RadioEnabled, read/write, Conditional */
											/* dev_WLAN_AutoRateFallBackEnabled, read/write, Conditional */
											/* dev_WLAN_LocationDescription, read/write, Conditional */
											/* dev_WLAN_RegulatoryDomain, read/write, Optional */
											/* dev_WLAN_TotalPSKFailures, read only, Optional */
											/* dev_WLAN_TotalIntegrityFailures, read only, Optional */
											/* dev_WLAN_ChannelsInUse, read only, Optional */
											/* dev_WLAN_DistanceFromRoot, read/write, Optional */
											/* dev_WLAN_DeviceOperationMode, read/write, Optional */
											/* dev_WLAN_PeerBSSID, read/write, Optional */
											/* dev_WLAN_TotalBytesSent, read only, Conditional */
											/* dev_WLAN_TotalBytesReceived, read only, Conditional */
											/* dev_WLAN_TotalPacketsSent, read only, Conditional */	
											/* dev_WLAN_TotalPacketsReceived, read only, Conditional */
											/* dev_WLAN_TotalAssociations, read only, Conditional */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.WLANConfiguration{i}.AssociatedDevice.{i}), Conditional */
											/* dev_WLAN_Assoc_DeviceMACAddress, read only, Conditional */
											/* dev_WLAN_Assoc_DeviceIPAddress, read only, Conditional */
											/* dev_WLAN_Assoc_AuthenticationState, read only, Conditional */
											/* dev_WLAN_Assoc_LastRequestedUnicastCipher, read only, Optional */
											/* dev_WLAN_Assoc_LastRequestedMulticastCipher, read only, Optional */
											/* dev_WLAN_Assoc_LastPMKId, read only, Optional */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.WLANConfiguration{i}.WEPKey.{i}), Conditional */
											/* dev_WLAN_WEPKey, write only, Conditional */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.WLANConfiguration{i}.PreSharedKey.{i}), Conditional */
											/* dev_WLAN_PreSharedKey_PreSharedKey, write only, Conditional */
											/* dev_WLAN_PreSharedKey_KeyPassphrase, write only, Conditional */
											/* dev_WLAN_PreSharedKey_AssociatedDeviceMACAddress, read/write, Optional */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.Hosts)*/
#define DEV_LANDEVICE_HOST_HOSTNUM 2					/* dev_LAN_Hosts_Hostnum, read only */
/* lan_dev.c(InternetGatewayDevice.LANDevice{i}.Hosts.Host.{i})*/
#define DEV_LANDEVICE_HOST_IP_ADDR "192.168.0.1"		/* dev_LAN_Hosts_Host_IPAddress, read only */
#define DEV_LANDEVICE_HOST_ADDR_SRC "DHCP"				/* dev_LAN_Hosts_Host_AddressSource, read only */
#define DEV_LANDEVICE_HOST_MAC_ADDR "00:01:23:45:67:89"	/* dev_LAN_Hosts_Host_MACAddress, read only */ 
#define DEV_LANDEVICE_HOST_LEASE_TIME_REMAIN 30			/* dev_LAN_Hosts_Host_LeaseTimeRemaining, read only */
#define DEV_LANDEVICE_HOST_HOSTNAME "ADSL-1"			/* dev_LAN_Hosts_Host_HostName, read only */
#define DEV_LANDEVICE_HOST_IF_TYPE "Ethernet"			/* dev_LAN_Hosts_Host_InterfaceType, read only */ 
#define DEV_LANDEVICE_HOST_ACTIVE 0						/* dev_LAN_Hosts_Host_Active, read only */

/* layer3_fwd.c (InternetGatewayDevice.Layer3Forwarding) */
						/* dev_Layer3_DefaultConnectionService, read/write */
						/* dev_Layer3_ForwardNumberOfEnties, read only */
/* layer3_fwd.c (InternetGatewayDevice.Layer3Forwarding.Forwarding{i}) */
						/* dev_Forwarding_Enable, read/write */
						/* dev_Forwarding_Status, read only */
						/* dev_Forwarding_DestIPAddress, read/write */
						/* dev_Forwarding_DestSubnetMask, read/write */
						/* dev_Forwarding_SourceIPAddress, read/write */
						/* dev_Forwarding_SourceSubnetMask, read/write */
						/* dev_Forwarding_GatewayIPAddress, read/write */
						/* dev_Forwarding_Interface, read/write */
						/* dev_Forwarding_ForwardingMetric, read/write */
						/* dev_Forwading_MTU, read/write, Optional */	



/* manag_server.c (InternetGatewayDevice.ManagementServer) */
						/* dev_ManageServer_URL, read/write */
						/* dev_ManageServer_Username, write only */
						/* dev_ManageServer_Password, read/write */
						/* dev_ManageServer_PeriodicInformEnable, read/write */
						/* dev_ManageServer_PeriodicInformInterval, read/write */
						/* dev_ManageServer_PeriodicInformTime, read/write */
						/* dev_ManageServer_ParameterKey, read only */
						/* dev_ManageServer_ConnectionRequestURL, read only */
						/* dev_ManageServer_ConnectionRequestUsername, read/write */
						/* dev_ManageServer_ConnectionRequestPassword, write only */


						/* dev_ManageServer_UpgradesManaged, read/write */
						/* dev_ManageServer_KickURL, read only, Optional */
						/* dev_ManageServer_DownloadProgressURL, ready only, Optional */


/* user_if.c (InternetGatewayDevice.UserInterface), Optional */
						/* dev_UI_PasswordRequired, read/write, Optional */
						/* dev_UI_PasswordUserSelectable, read/write, Optional */
						/* dev_UI_UpgradeAvailable, read/write, Optional */
						/* dev_UI_WarrantyDate, read/write, Optional */
						/* dev_UI_ISPName, read/write, Optional */
						/* dev_UI_ISPHelpDesk, read/write, Optional */
						/* dev_UI_ISPHomePage, read/write, Optional */
						/* dev_UI_ISPHelpPage, read/write, Optional */
						/* dev_UI_ISPLogo, read/write, Optional */
						/* dev_UI_ISPLogoSize, read/write, Optional */
						/* dev_UI_ISPMailServer, read/write, Optional */
						/* dev_UI_ISPNewsServer, read/write, Optional */
						/* dev_UI_TextColor, read/write, Optional */
						/* dev_UI_BackgroundColor, read/write, Optional */
						/* dev_UI_ButtonColor, read/write, Optional */
						/* dev_UI_ButtonTextColor, read/write, Optional */
						/* dev_UI_AutoUpdateServer, read/write, Optional */
						/* dev_UI_UserUpdateServer, read/write, Optional */
						/* dev_UI_ExampleLogin, read/write, Optional */
						/* dev_UI_ExamplePassword, read/write, Optional */

/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}) */
						/* dev_WAN_WANnum, read only */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANCommonInterfaceConfig) */
						/* dev_WANCommon_If_EnableForInternet, read/write */
						/* dev_WANCommon_If_WANAccessType, read only */
						/* dev_WANCommon_If_Layer1UpstreamMaxBitRate, read only */
						/* dev_WANCommon_If_Layer1DownstreamMaxBitRate, read only */
						/* dev_WANCommon_If_PhysicalLinkStatus, read only */
						/* dev_WANCommon_If_WANAccessProvider, read only, Optional */
						/* dev_WANCommon_If_TotalBytesSent, read only */
						/* dev_WANCommon_If_TotalBytesReceived, read only */
						/* dev_WANCommon_If_TotalPacketsSent, read only */
						/* dev_WANCommon_If_TotalPacketsReceived, read only */
						/* dev_WANCommon_If_MaximumActiveConnections, read only, Optional */
						/* dev_WANCommon_If_NumberOfActiveConnections, read only, Optional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANCommonInterfaceConfig.Connection.{i}), Optional */
						/* dev_WANCommon_If_DeviceContainer, read only, Optional */
						/* dev_WAMCommon_If_ServiceID, read only, Optional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLInterfaceConfig), Conditional */
						/* dev_WANDSL_If_Enable, read/write, Conditional */
						/* dev_WANDSL_If_Status, read only, Conditional */
						/* dev_WANDSL_If_ModulationType, read only, Optional */
						/* dev_WANDSL_If_LineEncoding, read only, Optional */
						/* dev_WANDSL_If_DataPath, read only, Optional */
						/* dev_WANDSL_If_InterleaveDepth, read only, Optional */
						/* dev_WANDSL_If_LineNumber, read only, Optional */
						/* dev_WANDSL_If_UpstreamCurrRate, read only, Conditional */
						/* dev_WANDSL_If_DownstreamCurrRate, read only, Conditional */
						/* dev_WANDSL_If_UpstreamMaxRate, read only, Conditional */
						/* dev_WANDSL_If_DownstreamMaxRate, read only, Conditional */
						/* dev_WANDSL_If_UpstreamNoiseMargin, read only, Conditional */
						/* dev_WANDSL_If_DownstreamNoiseMargin, read only, Conditional */
						/* dev_WANDSL_If_UpstreamAttenuation, read only, Conditional */
						/* dev_WANDSL_If_DownstreamAttenuation, read only, Conditional */
						/* dev_WANDSL_If_UpstreamPower, read only, Conditional */
						/* dev_WANDSL_If_DownstreamPower, read only, Conditional */
						/* dev_WANDSL_If_ATURVendor, read only, Conditional */
						/* dev_WANDSL_If_ATURCountry, read only, Conditional */
						/* dev_WANDSL_If_ATURANSIStd, read only, Optional */
						/* dev_WANDSL_If_ATURANSIRev, read only, Optional */
						/* dev_WANDSL_If_ATUCVendor, read only, Conditional */
						/* dev_WANDSL_If_ATUCCountry, read only, Conditional */
						/* dev_WANDSL_If_ATUCANSIStd, read only, Optional */
						/* dev_WANDSL_If_ATUCANSIRev, read only, Optional */
						/* dev_WANDSL_If_TotalStart, read only, Conditional */
						/* dev_WANDSL_If_ShowtimeStart, read only, Conditional */
						/* dev_WANDSL_If_LastShowtimeStart, read only, Optional */
						/* dev_WANDSL_If_CurrentDayStart, read only, Optional */
						/* dev_WANDSL_If_QuarterHourStart, read only, Optional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLInterfaceConfig.Stats), Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLInterfaceConfig.Stats.Total), Conditional */
						/* dev_WANDSL_Stats_Total_ReceiveBlocks, read only, Conditional */
						/* dev_WANDSL_Stats_Total_TransmitBlocks, read only, Conditional */
						/* dev_WANDSL_Stats_Total_CellDelin, read only, Conditional */
						/* dev_WANDSL_Stats_Total_LinkRetrain, read only, Conditional */
						/* dev_WANDSL_Stats_Total_InitErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Total_InitTimeouts, read only, Conditional */
						/* dev_WANDSL_Stats_Total_LossOfFraming, read only, Conditional */
						/* dev_WANDSL_Stats_Total_ErroredSecs, read only, Conditional */
						/* dev_WANDSL_Stats_Total_SeverelyErroredSecs, read only, Conditional */
						/* dev_WANDSL_Stats_Total_FECErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Total_ATUCFECErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Total_HECErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Total_ATUCHECErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Total_CRCErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Total_ATUCCRCErrors, read only, Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLInterfaceConfig.Stats.Showtime), Conditional */
						/* dev_WANDSL_Stats_Showtime_ReceiveBlocks, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_TransmitBlocks, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_CellDelin, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_LinkRetrain, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_InitErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_InitTimeouts, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_LossOfFraming, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_ErroredSecs, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_SeverelyErroredSecs, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_FECErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_ATUCFECErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_HECErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_ATUCHECErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_CRCErrors, read only, Conditional */
						/* dev_WANDSL_Stats_Showtime_ATUCCRCErrors, read only, Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLInterfaceConfig.Stats.LastShowtime), Optional */
						/* dev_WANDSL_Stats_LastShowtime_ReceiveBlocks, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_TransmitBlocks, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_CellDelin, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_LinkRetrain, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_InitErrors, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_InitTimeouts, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_LossOfFraming, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_ErroredSecs, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_SeverelyErroredSecs, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_FECErrors, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_ATUCFECErrors, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_HECErrors, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_ATUCHECErrors, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_CRCErrors, read only, Optional */
						/* dev_WANDSL_Stats_LastShowtime_ATUCCRCErrors, read only, Optional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLInterfaceConfig.Stats.CurrentDay), Optional */
						/* dev_WANDSL_Stats_CurrentDay_ReceiveBlocks, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_TransmitBlocks, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_CellDelin, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_LinkRetrain, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_InitErrors, read only, Optional */
						/* dev_WANDSL_Stats_CurrnetDay_InitTimeouts, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_LossOfFraming, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_ErroredSecs, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_SeverelyErroredSecs, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_FECErrors, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_ATUCFECErrors, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_HECErrors, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_ATUCHECErrors, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_CRCErrors, read only, Optional */
						/* dev_WANDSL_Stats_CurrentDay_ATUCCRCErrors, read only, Optional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLInterfaceConfig.Stats.QuarterHour), Optional */
						/* dev_WANDSL_Stats_QuarterHour_ReceiveBlocks, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_TransmitBlocks, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_CellDelin, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_LinkRetrain, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_InitErrors, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_InitTimeouts, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_LossOfFraming, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_ErroredSecs, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_SeverelyErroredSecs, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_FECErrors, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_ATUCFECErrors, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_HECErrors, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_ATUCHECErrors, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_CRCErrors, read only, Optional */
						/* dev_WANDSL_Stats_QuarterHour_ATUCCRCErrors, read only, Optional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDEthernetInterfaceConfig), Conditional */
						/* dev_WANEth_If_Enable, read/write, Conditional */	
						/* dev_WANEth_If_Status, read only, Conditional */
						/* dev_WANEth_If_MACAddress, read only, Conditional */
						/* dev_WANEth_If_MaxBitRate, read/write, Conditional */
						/* dev_WANEth_If_DuplexMode, read/write, Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDEthernetInterfaceConfig.Stats), Conditional */
						/* dev_WAN_Ethstats_BytesSent, read only, Conditional */
						/* dev_WAN_Ethstats_BytesReceived, read only, Conditional */
						/* dev_WAN_Ethstats_PacketsSent, read only, Conditional */
						/* dev_WAN_Ethstats_PacketsReceived, read only, Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLConnectionManagement), Conditional */
						/* dev_WANDSL_Manage_ServiceNumber, read only */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLConnectionManagement.ConnectionService.{i}), Conditional */
						/* dev_WANDSL_Manage_ConnectionServ_WANConnectionDevice, read only */
						/* dev_WANDSL_Manage_ConnectionServ_WANConnectionService, read only */
						/* dev_WANDSL_Manage_ConnectionServ_DestinationAddress, read only */
						/* dev_WANDSL_Manage_ConnectionServ_LinkType, read only */
						/* dev_WANDSL_Manage_ConnectionServ_ConnectionType, read only */
						/* dev_WANDSL_Manage_ConnectionServ_Name, read only, User-readable namr if the connection */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANDSLDiagnostics), Conditional */
						/* dev_WANDSL_Diag_LoopDiagnosticsState, read/write, Conditional */
						/* dev_WANDSL_Diag_ACTPSDds, read only, Conditional */
						/* dev_WANDSL_Diag_ACTPSDus, read only, Conditional */
						/* dev_WANDSL_Diag_ACTATPds, read only, Conditional */
						/* dev_WANDSL_Diag_ACTATPus, read only, Conditional */
						/* dev_WANDSL_Diag_HLINSCds, read only, Conditional */
						/* dev_WANDSL_Diag_HLINpsds, read only, Conditional */
						/* dev_WANDSL_Diag_QLNpsds, read only, Conditional */
						/* dev_WANDSL_Diag_BITSpsds, read only, Conditional */
						/* dev_WANDSL_Diag_SNRpsds, read only, Conditional */
						/* dev_WANDSL_Diag_GAINSpsds, read only, Conditional */	
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}), Conditional */
						/* get_wanconndev_instance, read/write, obj_instance_func */
						/* dev_WANConnectionDev_IPConnectionNumber, read only, Conditional */
						/* dev_WANConnectionDev_PPPConnectionNumber, read only, Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANDSLLinkConfig), Conditional */
						/* dev_WANConnectionDev_LinkConfig_Enable, read/write, Conditional */
						/* dev_WANConnectionDev_LinkConfig_LinkStatus, read only, Conditional */
						/* dev_WANConnectionDev_LinkConfig_LinkType, read/write, Conditional */
						/* dev_WANConnectionDev_LinkConfig_AutoConfig, read only, Conditional */
						/* dev_WANConnectionDev_LinkConfig_ModulationType, read only, Optional */
						/* dev_WANConnectionDev_LinkConfig_DestinationAddress, read/write, Conditional */
						/* dev_WANConnectionDev_LinkConfig_ATMEncapsulation, read/write, Optional */
						/* dev_WANConnectionDev_LinkConfig_FCSPreserved, read/write, Optional */
						/* dev_WANConnectionDev_LinkConfig_VCSearchList, read/write, Optional */
						/* dev_WANConnectionDev_LinkConfig_ATMAAL, read only, Optional */
						/* dev_WANConnectionDev_LinkConfig_ATMTransmittedBlock, read only, Conditional */
						/* dev_WANConnectionDev_LinkConfig_ATMReceivedBlocks, read only, Conditional */
						/* dev_WANConnectionDev_LinkConfig_ATMQoS, read/write, Optional */
						/* dev_WANConnectionDev_LinkConfig_ATMPeakCellRate, read/write, Optional */
						/* dev_WANConnectionDev_LinkConfig_ATMMaximumBurstSize, read/write, Optional */
						/* dev_WANConnectionDev_LinkConfig_ATMSustainableCellRate, read/write, Optional */
						/* dev_WANConnectionDev_LinkConfig_AAL5CRCErrors, read only, Conditional */
						/* dev_WANConnectionDev_LinkConfig_ATMCRCErrors, read only, Conditional */
						/* dev_WANConnectionDev_LinkConfig_ATMHECErrors, read only, Optional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANATMF5LoopbackDiagnostics), Conditional */
						/* dev_WANConnectionDev_ATMF5_DiagnosticsState, read/write, Conditional */
						/* dev_WANConnectionDev_ATMF5_NumberOfRepetitions, read/write, Conditional */
						/* dev_WANConnectionDev_ATMF5_Timeout, read/write, Conditional */
						/* dev_WANConnectionDev_ATMF5_SuccessCount, read only, Conditional */
						/* dev_WANConnectionDev_ATMF5_FailureCount, read only, Conditional */
						/* dev_WANConnectionDev_ATMF5_AverageResponseTime, read only, Conditional */
						/* dev_WANConnectionDev_ATMF5_MinimumResponseTime, read only, Conditional */
						/* dev_WANConnectionDev_ATMF5_MaximumResponseTime, read only, Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANEthernetLinkConfig), Conditional */
						/* dev_WANEthConfig_EthernetLinkStatus, read only, Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPOSTLinkConfig), Conditional */
						/* dev_WANPOSTConfig_Enable, read/write, Conditional */
						/* dev_WANPOSTConfig_LinkStatus, read only, Conditional */
						/* dev_WANPOSTConfig_ISPPhoneNumber, read/write, Conditional/Optional */
						/* dev_WANPOSTConfig_ISPInfo, read/write, Conditional/Optional */
						/* dev_WANPOSTConfig_LinkType, read/write, Conditional/Optional */
						/* dev_WANPOSTConfig_NumberOfRetries, read/write,  Conditional/Optional */
						/* dev_WANPOSTConfig_DelayBetweenRetries, read/write, Conditional/Optional */
						/* dev_WANPOSTConfig_Fclass, read only, Optional */
						/* dev_WANPOSTConfig_DataModulationSupported, read only, Optional */
						/* dev_WANPOSTConfig_DataProtocol, read only, Optional */
						/* dev_WANPOSTConfig_DataCompression, read only, Optional */
						/* dev_WANPOSTConfig_PlusVTRCommandSupported, read only, Optional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection{i}) */
						/* get_wanipconn_instance, read/write */
						/* dev_WANIPConnection_Enable, read/write*/
						/* dev_WANIPConnection_ConnectionStatus, read only */
						/* dev_WANIPConnection_PossibleConnectionTypes, read only */
						/* dev_WANIPConnection_ConnectionTypes, read/write */
						/* dev_WANIPConnection_Name, read/write */
						/* dev_WANIPConnection_Uptime, read only */
						/* dev_WANIPConnection_LastConnectionError, read only */
						/* dev_WANIPConnection_AutoDisconnectTime, read/write, Optional */
						/* dev_WANIPConnection_IdleDisconnectionTime, read/write, Optional */
						/* dev_WANIPConnection_WarnDisconnectionDelay, read/write, Optional */
						/* dev_WANIPConnection_RSIPAvailable, read only */
						/* dev_WANIPConnection_NATEnable, read/write, Required/Conditional */
						/* dev_WANIPConnection_AddressingType, read/write, Required/Optional */
						/* dev_WANIPConnection_ExternalIPAddress, read/write, Required/Optional */
						/* dev_WANIPConnection_SubnetMask, read/write, Required/Optional */
						/* dev_WANIPConnection_DefaultGateway, read/write, Required/Optional */
						/* dev_WANIPConnection_DNSEnabled, read/write, Required/Optional */
						/* dev_WANIPConnection_DNSOverrideAllowed, read/write, Required/Optional */
						/* dev_WANIPConnection_DNSServers, read/write, Required/Optional */
						/* dev_WANIPConnection_MaxMTUSize, read/write, Optional */
						/* dev_WANIPConnection_MACAddress, read/write, Required/Optional */
						/* dev_WANIPConnection_MACAddressOverride, read/write, Optional */
						/* dev_WANIPConnection_ConnectionTrigger, read/write */
						/* dev_WANIPConnection_RouteProtocolRx, read/write */
						/* dev_WANIPConnection_PortMappingNumberOfEntries, read only */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection{i}.PortMapping.{i}) */
						/* get_ipportmap_instance, read/write, obj_instance_func */
						/* dev_WANIP_PortMap_PortMappingEnabled, read/write */
						/* dev_WANIP_PortMap_PortMappingLeaseDuration, read/write */
						/* dev_WANIP_PortMap_RemoteHost, read/write */
						/* dev_WANIP_PortMap_ExternalPort, read/write */
						/* dev_WANIP_PortMap_InternalPort, read/write */
						/* dev_WANIP_PortMap_PortMappingProtocol, read/write */
						/* dev_WANIP_PortMap_InternalClient, read/write */
						/* dev_WANIP_PortMap_PortMappingDecrition, read/write */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANIPConnection{i}.Stats), Conditional */
						/* dev_WANIConnectionStats_EthernetBytesSent, read only, Conditional */
						/* dev_WANIConnectionStats_EthernetBytesReceived, read only, Conditional */
						/* dev_WANIConnectionStats_EthernetPacketsSent, read only, Conditional */
						/* dev_WANIConnectionStats_EthernetPacketsReceived, read only, Conditional */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection{i}) */
						/* get_wanpppconn_instance, read/write, obj_instance_func */
						/* dev_WANPPP_Enable, read/write */
						/* dev_WANPPP_ConnectionStatus, read only */
						/* dev_WANPPP_PossibleConnectionTypes, read only */
						/* dev_WANPPP_ConnectionTypes, read/write */
						/* dev_WANPPP_Name, read/write */
						/* dev_WANPPP_Uptime, read only */
						/* dev_WANPPP_LastConnectionError, read only */
						/* dev_WANPPP_AutoDisconnectTime, read/write, Optional */
						/* dev_WANPPP_IdleDisconnectionTime, read/write, Optional */
						/* dev_WANPPP_WarnDisconnectionDelay, read/write, Optional */
						/* dev_WANPPP_RSIPAvailable, read only */
						/* dev_WANPPP_NATEnable, read/write, Required/Conditional */
						/* dev_WANPPP_Username, read/write */
						/* dev_WANPPP_Password, write only */
						/* dev_WANPPP_PPPEncryptionProtocol, read only, Optional */
						/* dev_WANPPP_PPPCompressProtocol, read only, Optional */
						/* dev_WANPPP_PPPAuthenticationProtocol, read only, optional */
						/* dev_WANPPP_ExternalIPAddress, read only */
						/* dev_WANPPP_RemoteIPAddress, read only, Optional */
						/* dev_WANPPP_MaxMRUSize, read/write, Optional */
						/* dev_WANPPP_CurrentMRUSize, read only, Optional */
						/* dev_WANPPP_DNSEnabled, read/write, Requred/Optional */
						/* dev_WANPPP_DNSOverrideALLowed, read/write, Required/Optional */
						/* dev_WANPPP_DNSServers, read/write, Required/Optional */
						/* dev_WANPPP_MACAddress, read/write, Required/Optional */
						/* dev_WANPPP_MACAddressOverride, read/write, Optional */
						/* dev_WANPPP_TransportType, read only */
						/* dev_WANPPP_PPPoEACName, read/write */
						/* dev_WANPPP_PPPoEServiceName, read/write */
						/* dev_WANPPP_ConnectionTrigger, read/write */
						/* dev_WANPPP_RouteProtocolRx, read/write */
						/* dev_WANPPP_PPPLCPEcho, read only, Optional */
						/* dev_WANPPP_PPPLCPEchoRetry, read only, Optional */
						/* dev_WANPPP_PortMappingNumberOfEntries, read only */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection{i}.PortMapping.{i}) */
						/* get_pppportmap_instance, read/write, obj_instance_func */
						/* dev_WANPPP_PortMap_PortMappingEnabled, read/write */
						/* dev_WANPPP_PortMap_PortMappingLeaseDuration, read/write */
						/* dev_WANPPP_PortMap_RemoteHost, read/write */
						/* dev_WANPPP_PortMap_ExternalPort, read/write */
						/* dev_WANPPP_PortMap_InternalPort, read/write */
						/* dev_WANPPP_PortMap_PortMappingProtocol, read/write */
						/* dev_WANPPP_PortMap_InternalClient, read/write */
						/* dev_WANPPP_PortMap_PortMappingDescription, read/write */
/* wan_dev.c (InternetGatewayDevice.WANDevice.{i}.WANConnectionDevice.{i}.WANPPPConnection{i}.Stats), Conditional */
						/* dev_WANPPP_Stats_EthernetBytesSent, read only, Conditional */
						/* dev_WANPPP_Stats_EthernetBytesReceived, read only, Conditional */
						/* dev_WANPPP_Stats_EthernetPacketsSent, read only, Conditional */
						/* dev_WANPPP_Stats_EthernetPacketsReceived, read only, Conditional */
						/* dev_obj_forward, read/write, obj_dev_func */
						/* dev_obj_IPInterface, read/write, obj_dev_func */
						/* dev_obj_wanconndev, read/write, obj_dev_func */
						/* dev_obj_wanipconn, read/write, obj_dev_func */
						/* dev_obj_wanpppconn, read/write, obj_dev_func */
						/* dev_obj_ipportmap, read/write, obj_dev_func */
						/* dev_obj_pppportmap, read/write, obj_dev_func */
						/* get_forwarding_instance, read/write, obj_instance_func */
						/* get_ipinterface_instance, read/write, obj_instance_func */
						/* get_instance_num, internal use */
						/* get_init_instance_num, internal use */
						/* read_obj_conf, internal use */
						/* write_obj_conf, internal use */
						/* init_multi_conf, internal use */



#endif
