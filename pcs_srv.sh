#!/bin/bash
APPSERVER="do_admin@10.178.17.10"
DBSERVER="do_admin@10.178.17.20"
PASSWORD="Lic@doa011#"
export SSHPASS="$PASSWORD" 
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $APPSERVER <<EOT

echo "[do_admin@p011as01 ~]$ date"
date
#sudo pcs status
sudo service agencysynch status 
sudo service synch status 
echo "
************* DOCKETSERVICE STATUS "
sudo service DocketService status 
echo "
************* JBOSS-EAP-RHEL STATUS "
sudo systemctl status jboss-eap-rhel.service |grep -i active
echo
sudo service MI_ArchivalOfEdigiBonds status
echo "
************* UPLOADARCHIVAL STATUS " 
sudo service uploadarchival status 
echo
sudo service epolicyinsert status 
echo
sudo service irdocdownload status 
echo "
************* NEWGENLDAP STATUS "
sudo systemctl status NewgenLdap | grep -i active
echo
ps -ef | grep -i wrapper 
echo "
************* SMS STATUS "
ps -ef | grep -i sms 

ps -ef | grep -i thumbnailschedule 

ps -ef | grep -i scheduler 

ps -ef | grep -i alarm 


EOT
#sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $DBSERVER <<EOT
#echo "[do_admin@p011db01 ~]$ date ; sudo pcs status"
#date
#sudo pcs status
#EOT


