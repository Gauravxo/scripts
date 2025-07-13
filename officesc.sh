#!/bin/bash
echo " ############################ HALDWANI Server Analysis  ######################################" 
echo " *****************************************************************************" 
echo "   PING STATUS "
echo " *****************************************************************************"
date
for ip in '10.33.178.4' '10.33.178.5' '10.33.178.6' '10.33.178.10' '10.33.178.11' '10.33.178.12' '10.33.178.20' '10.33.178.21' '10.33.178.22' '10.33.178.37' '10.33.178.38' '10.33.178.39' '10.31.6.42' '10.31.6.45' '10.240.26.71'

do
    ping  "$ip" -c1 > /dev/null
    if [ $? -eq 0 ]; then    #if exit status is true(0) means got successful execution 
    echo "node $ip is up"  
    else
    echo  " DOWN !!! node $ip is DOWN !!! "
   
    fi 
done

echo " ##################################### APP-Cluster ##########################################" 
export SSHPASS=Lic@doa024#
sshpass -e ssh -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no   do_admin@10.33.178.10 /bin/bash<<EOT

echo " *****************************************************************************" 
echo  "                                         SERVICE STATUS" 
echo " *****************************************************************************"
#sudo service --status-all
echo "   
********** AGENCYSYNCH Status ***********"
sudo service agencysynch status
echo "   
********** SYNCH Status *****************"
sudo service synch status
echo "    
********** DOCKETSERVICE Status *********"
sudo service DocketService status
echo "    
********* JBOSS-EAP-RHEL Status *********"
sudo service jboss-eap-rhel status
echo "     
********* MI_ARCHIVALOFEDIFIBONDS Status**"
sudo service MI_ArchivalOfEdigiBonds status
echo "     
********* UPLOADARCHIVAL Status **********"
sudo service uploadarchival status
echo "     
********* EPOLICYINSERT Status ***********"
sudo service epolicyinsert status
echo "     
********* IRDOCDOWNLOAD Status ************"
sudo service irdocdownload status
echo "    
********* NEWGENLDAP Status ***************"
sudo systemctl status NewgenLdap
echo "     
********* NEWGENWRAPPER Status ************"
ps -ef | grep -i wrapper
echo "
********* SMS Status **********************"
ps -ef | grep -i sms
echo "
******** THUMBNAILSCHEDULE Status *********"
ps -ef | grep -i thumbnailschedule
echo "
******** SCHEDULER Status *****************"
ps -ef | grep -i scheduler
echo "
******** NEWGENALARM Status ***************"
ps -ef | grep -i alarm
echo "
******** NEWGENTHM Status *****************"
ps -ef | grep -i NewgenTHM

echo " *****************************************************************************" 
echo "                         APP CLUSTER STATUS " 
echo " *****************************************************************************"
sudo pcs status

echo " *****************************************************************************" 
echo "                        APP CLUSTER  MEMORY STATUS" 
echo " *****************************************************************************" 
free -h | grep -i mem 
free -h | grep -i mem | awk '{printf "Memory used percentage : %.2f%\n",(\$3/\$2*100)}'


echo " *****************************************************************************" 
echo "                       APP CLUSTER CPU UTILIZE DETAIL" 
echo " *****************************************************************************" 
top -b -n 1  | grep Cpu
mpstat -u 2 5 | grep -i average | awk '{printf "CPU used percentage: %.2f%\n",(100-\$12)}'

echo " *****************************************************************************" 
echo "                       APP CLUSTER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs

EOT

echo  "## DBCluster ##"
export SSHPASS=Lic@doa024#
sshpass -e ssh -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no   do_admin@10.33.178.20 /bin/bash<<EOT

echo " *****************************************************************************" 
echo "                      SERVICE STATUS " 
echo " *****************************************************************************" 
systemctl status postgresql-10.service | grep Active

echo " *****************************************************************************" 
echo "                     DB CLUSTER STATUS " 
echo " *****************************************************************************" 
sudo pcs status 

echo " *****************************************************************************" 
echo "                     DB CLUSTER  MEMORY STATUS" 
echo " *****************************************************************************" 
free -h | grep -i mem 
free -h | grep -i mem | awk '{printf "Memory used percentage : %.2f%\n",(\$3/\$2*100)}'


echo " *****************************************************************************" 
echo "                    DB CLUSTER CPU UTILIZE DETAIL" 
echo " *****************************************************************************" 
top -b -n 1  | grep Cpu 
mpstat -u 2 5 | grep -i average | awk '{printf "CPU used percentage: %.2f%\n",(100-\$12)}'


echo " *****************************************************************************" 
echo "                    SYNCH STATUS " 
echo " *****************************************************************************" 
cd /home/do_admin
sh SynchCount.sh 
sh ptcount.sh    

sudo su - postgres
psql division_024
select count (*) from miepolicytable;
\q
exit

echo " *****************************************************************************" 
echo "                    DB CLUSTER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs

echo "
#10.33.178.20
base & pg_wal size"
sudo du -shc /dbdata1/data/base
sudo du -shc /dbdata1/data/pg_wal

EOT

echo " 
Backup Server"
export SSHPASS=Lic@doa024#
sshpass -e ssh -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no   do_admin@10.33.178.6 /bin/bash<<EOT

echo " *****************************************************************************" 
echo "                     BACKUP SERVER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs

echo " *****************************************************************************" 
echo "                     DB DAILY BACKUP STATUS " 
echo " *****************************************************************************" 
sudo su - barman
barman show-backup bkp024 last

echo " *****************************************************************************" 
echo "                     DB HDD BACKUP " 
echo " *****************************************************************************" 
barman list-backup bkp024
exit

echo " *****************************************************************************" 
echo "                     DB_60DAYS BACKUP " 
echo " *****************************************************************************" 
ls -ltr /mnt/DB_60days/bkp024/base | tail -10
sudo du -sh /mnt/DB_60days/bkp024/base/* | tail -5

echo " *****************************************************************************" 
echo "                     DB TDO BACKUP LOG " 
echo " *****************************************************************************" 
cd /var/log/rsync
cat barman_TDO_$(date +%F)* | tail -3

echo " *****************************************************************************" 
echo "                    DB_1YEAR BACKUP  " 
echo " *****************************************************************************" 
ls -ltr /mnt/DB_1yr/ | tail -3
sudo du -shc /mnt/DB_1yr/*

echo " *****************************************************************************" 
echo "                    DB TDO BACKUP " 
echo " *****************************************************************************" 
cd /var/log/rsync
cat barman_TDO_$(date +%F)* | tail -3

echo " *****************************************************************************" 
echo "                    LAST WALS ON TAPE " 
echo " *****************************************************************************" 
cd /mnt/DB_60days/bkp024/wals
ls -ltr | tail -10

echo " *****************************************************************************" 
echo "        ########## Tape Image_noretention backup ##########" 
echo " *****************************************************************************" 
cd /var/log/rsync/CP
echo "#/imagedata7"
cat APP_backup_imagedata7_bo_*$(date +%F)* | tail -4
echo "
#/imagedata8"
cat APP_backup_imagedata8_bo_*$(date +%F)* | tail -4
echo "
#/imagedata9"
cat APP_backup_imagedata9_bo_*$(date +%F)* | tail -4


echo " *****************************************************************************" 
 
echo "              LAG SIZE " 
echo " *****************************************************************************"
sudo su - barman
barman replication-status bkp024
exit

EOT

echo "################################### HALDWANI ######################################"

