#!/bin/bash
 
EXPECTED_ARGS=1
E_BADARGS=65
 
printHelp ()
{
     echo
     echo -e "\tPurpose: For fixing and unfixing your vpn connections"
     echo -e "\tUsage: sudo `basename $0` [options]\n"
     echo -e "\tOptions"
     echo -e "\tprep\t - fixes racoon.conf. Run only once!!!"
     echo -e "\t\t this adds --> include "/etc/racoon/remote/*.conf" to /etc/racoon/racoon.conf \n"
     echo -e "\tunprep\t - unfixes racoon.conf."
     echo -e "\t\t this removes --> include "/etc/racoon/remote/*.conf" from /etc/racoon/racoon.conf \n"
     echo -e "\tfix\t - run after you login to the vpn. This will disconnect you!"
     echo -e "\t\t This will change the lifetime to 168 hours in the IP.conf file\n"
     echo -e "\tunfix\t - run after your done with the vpn."
     echo -e "\t\t Do this if you need to connect to an other location or you can't connect to the vpn.\n"
 
}
 
if [ $# -lt $EXPECTED_ARGS ]
then
printHelp
exit $E_BADARGS
fi
 
#################
if [ $1 = prep ]
     then
 
mkdir -p /etc/racoon/remote
echo -e "creating directory /etc/racoon/remote \n"
cp -a /etc/racoon/racoon.conf /etc/racoon/racoon.conf.orig
echo -e "backing up /etc/racoon/racoon.conf to /etc/racoon/racoon.conf.orig\n"
 
echo 'include "/etc/racoon/remote/*.conf" ;' >> /etc/racoon/racoon.conf
echo -e 'adding this line --> include "/etc/racoon/remote/*.conf" ;" <-- to end of /etc/racoon/racoon.conf\n'
fi
 
#################
if [ $1 = unprep ]
     then
 
rm -rf /etc/racoon/remote
echo -e "removing directory /etc/racoon/remote \n"
 
sed -i -e '/include "\/etc\/racoon\/remote\/\*\.conf" ;/d' /etc/racoon/racoon.conf
 
echo -e 'removing lines --> include "/etc/racoon/remote/*.conf" ;" <-- from /etc/racoon/racoon.conf\n'
fi
 
#################
if [ $1 = fix ]
     then
mv /var/run/racoon/*.conf /etc/racoon/remote
 
sed -i -e 's~include "/var/run/racoon/\*\.conf"~#include "/var/run/racoon/\*\.conf"~' /etc/racoon/racoon.conf
 
sed -i -e 's/lifetime time 3600 sec/lifetime time 168 hours/' /etc/racoon/remote/*.conf
 
 
launchctl stop com.apple.racoon
launchctl start com.apple.racoon
 
fi
 
#################
if [ $1 = unfix ]
     then
sed -i -e 's~#include "/var/run/racoon/\*\.conf"~include "/var/run/racoon/\*\.conf"~' /etc/racoon/racoon.conf
rm -f /etc/racoon/remote/*
 
launchctl stop com.apple.racoon
launchctl start com.apple.racoon
 
fi
 
#################
