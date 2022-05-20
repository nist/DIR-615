#
# $Id: net.sunrise.sh,v 1.1 2008/10/01 03:04:56 ken_chiang Exp $
#
if [ -n "$UML_east_CTL" ]
then
    net_eth0="eth0=daemon,10:00:00:dc:bc:01,unix,$UML_east_CTL,$UML_east_DATA";
elif [ -n "$UML_private_CTL" ]
then
    net_eth0="eth0=daemon,10:00:00:dc:bc:01,unix,$UML_private_CTL,$UML_private_DATA";
else
    net_eth0="eth0=mcast,10:00:00:dc:bc:01,239.192.0.1,21200"
fi

net="$net_eth0"



