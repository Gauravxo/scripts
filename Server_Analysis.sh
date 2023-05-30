#!/bin/bash
echo "This script is code by Gauravxo"
echo " ############################ Server Analysis  ######################################" 
echo " *****************************************************************************" 
echo "   PING STATUS "
echo " *****************************************************************************"
date
for ip in 'insert your ip here'

do
    ping  "$ip" -c1 > /dev/null
    if [ $? -eq 0 ]; then    #if exit status is true(0) means got successful execution 
    echo "node $ip is up"  
    else
    echo  " DOWN !!! node $ip is DOWN !!! "
   
    fi 
done

echo " ##################################### APP-Cluster ##########################################" 
export SSHPASS="insert your server passwd here"
sshpass -e ssh -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no username@ip /bin/bash<<EOT

echo " *****************************************************************************" 
echo  "                          SERVICE STATUS" 
echo " *****************************************************************************"
#sudo service --status-all
# You Can List your running service here"

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
export SSHPASS="insert passwd here"
sshpass -e ssh -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no username@ip /bin/bash<<EOT

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
cd /home/username
#sh SynchCount.sh "i will provide if you need synch count script"
#sh ptcount.sh    "i will provide if you need ptcount script"

echo " *****************************************************************************" 
echo "                    DB CLUSTER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs

echo "
#insert you ip here
base & pg_wal size"
sudo du -shc /path
sudo du -shc /path

EOT

echo " 
Backup Server"
export SSHPAS=insert your passwd here
sshpass -e ssh -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no username@ip /bin/bash<<EOT

echo " *****************************************************************************" 
echo "                     BACKUP SERVER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs

echo " *****************************************************************************" 
echo "                     DB DAILY BACKUP STATUS " 
echo " *****************************************************************************" 
sudo su - barman
barman show-backup "insert backname here" last

echo " *****************************************************************************" 
echo "                     DB HDD BACKUP " 
echo " *****************************************************************************" 
barman list-backup "insert backup name here"
exit

echo " *****************************************************************************" 
echo "                     Weekly BACKUP " 
echo " *****************************************************************************" 
ls -ltr /mnt/insert path here | tail -10
sudo du -sh /mnt/insert path here | tail -5

echo " *****************************************************************************" 
echo "                     DB TDO BACKUP LOG " 
echo " *****************************************************************************" 
cd /var/log/rsync
cat barman_TDO_$(date +%F)* | tail -3

echo " *****************************************************************************" 
echo "                    YEAR BACKUP  " 
echo " *****************************************************************************" 
ls -ltr /mnt/"path here" | tail -3
sudo du -shc /mnt/"path here"

echo " *****************************************************************************" 
echo "                    DB TDO BACKUP " 
echo " *****************************************************************************" 
cd /var/log/rsync
cat barman_TDO_$(date +%F)* | tail -3

echo " *****************************************************************************" 
echo "                    LAST WALS ON TAPE " 
echo " *****************************************************************************" 
cd /mnt/"path here"
ls -ltr | tail -10

echo " *****************************************************************************" 
echo "        ########## Tape Image_noretention backup ##########" 
echo " *****************************************************************************" 
cd /var/log/rsync/CP
echo "#/"path here"
cat APP_backup_"path here"_*$(date +%F)* | tail -4
echo "
#/name here"
cat APP_backup_"path here"_*$(date +%F)* | tail -4
echo "
#/name here"
cat APP_backup_"path here"_*$(date +%F)* | tail -4


echo " *****************************************************************************" 
 
echo "              LAG SIZE " 
echo " *****************************************************************************"
sudo su - barman
barman replication-status "backup name here""
exit

EOT

echo "################################### END ######################################"
