#
# $Id: net.beet.sh,v 1.1 2008/10/01 03:04:56 ken_chiang Exp $
#
if [ -n "$UML_public_CTL" ]
then
    net_eth0="eth0=daemon,10:00:00:de:76:ba,unix,$UML_public_CTL,$UML_public_DATA";
else
    net_eth0="eth0=mcast,10:00:00:de:76:ba,239.192.1.2,31200";
fi

net="$net_eth0"




