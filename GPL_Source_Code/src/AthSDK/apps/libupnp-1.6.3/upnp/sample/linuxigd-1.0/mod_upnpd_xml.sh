#!/bin/sh
#
# This shell is used for upnpd (linux-igd)
# replacing LAN IP in gatedesc.xml with new lan IP
#

UPNPD_XML_BAK="/etc/linuxigd/gatedesc.xml"
UPNPD_XML_TMP="/tmp/gatedesc.xml"
UPNPD_XML="/var/etc/gatedesc.xml"
LAN_INTERFACE="br0"

usage(){
	echo "Usage: "
	echo "	To directly set with given new IP"
	echo "	$0 192.168.0.1"
	echo "	To automatically get IP"
	echo "	$0 auto"
	echo ""
}

# checking parameters
if [ $# != 1 ];then
	#echo "incorrect parameters numbers"
	usage;
	exit
fi

if [	$1 = "auto"	];then 
	IP=`ifconfig $LAN_INTERFACE | grep 'inet addr:' |sed 's/^.*addr://g' | sed 's/  Bcast.*$//g'`
else
	IP=$1
fi


#checking if XML file exists
if [	-r $UPNPD_XML	];then
	UPNPD_XML_BAK=$UPNPD_XML
else
	if [	! -r $UPNPD_XML_BAK ]; then
		echo "Error !! "
		echo "$UPNPD_XML_BAK does not exist !!"
		exit
	fi
fi


#replacing IP

cat $UPNPD_XML_BAK |sed 's/<controlURL>http:\/\/.*:/<controlURL>http:\/\/'$IP':/g' \
	|sed 's/<eventSubURL>http:\/\/.*:/<eventSubURL>http:\/\/'$IP':/g' \
	|sed 's/<SCPDURL>http:\/\/.*:/<SCPDURL>http:\/\/'$IP':/g' \
	|sed 's/<presentationURL>http:\/\/.*:/<presentationURL>http:\/\/'$IP':/g' \
	> $UPNPD_XML_TMP

mv $UPNPD_XML_TMP $UPNPD_XML



