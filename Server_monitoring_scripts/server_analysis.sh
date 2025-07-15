#!/bin/bash
#Author Gaurav Bharadwaj


DCAPP="Your_server_IP"
DRAPP="IP"
DCDB="IP"
DRDB="IP"
PASSWORD="PASSWD"

echo -e "\033[33;5m********************************************************************************
                              || Your Server analysis  report ||
********************************************************************************\033[m"
for ip in 'all server ip want to pin; 
do
    ping "$ip" -c1 > /dev/null
    if [ $? -eq 0 ]; then
        echo "node $ip is up"
    else
        echo "DOWN !!! node $ip is DOWN !!!"
    fi
done
echo -e "\033[33;1m********************************************************************************
                              || APP SERVER ||
********************************************************************************\033[m"
 
export SSHPASS="$PASSWORD"
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  $DCAPP <<EOT
echo " *****************************************************************************" 
echo "              SERVICE STATUS" 
echo " *****************************************************************************"
date
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

echo
echo
echo
echo "*******************************************************************************"
echo
echo -e "\033[33;3m ********** Status of Your Webpage **********\033[m"
echo
echo
URL="website URL Paste Here"
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $STATUS -ne 200 ]; then
        echo "webpage down !!! Code: $STATUS"
else
        echo -e "\033[33;3m ********** Your webpage is up and working fine **********\033[m"

fi
echo
echo "*******************************************************************************"
echo
echo
echo " *****************************************************************************" 
echo "                    APP CLUSTER STATUS " 
echo " *****************************************************************************"
sudo pcs status |awk 'NF > 0'
echo
echo " *****************************************************************************" 
echo "                    APP CLUSTER  MEMORY STATUS" 
echo " *****************************************************************************" 
free -h | grep -i mem 
free -h | grep -i mem | awk '{printf "Memory used percentage : %.2f%\n",(\$3/\$2*100)}'
echo " *****************************************************************************" 
echo "                    APP CLUSTER CPU UTILIZE DETAIL" 
echo " *****************************************************************************" 
top -b -n 1  | grep Cpu
mpstat -u 2 5 | grep -i average | awk '{printf "CPU used percentage: %.2f%\n",(100-\$12)}'
#echo " *****************************************************************************"
#echo "                    TOP 10 Processes -  cpu & mem uses  "
#echo " *****************************************************************************"
#ps -aux --sort=-%cpu | head -10 | column -t |awk '{print $1,$2,$3,$4,$9,$10,$11}'
echo
echo " *****************************************************************************" 
echo "                    APP CLUSTER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs |sort -k5 -h |tail -n +2|nl
EOT
echo
echo -e "\033[33;1m******************************************************************************
                    || DATA-BASE SERVER || 
******************************************************************************\033[m"
export SSHPASS="$PASSWORD"
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $DCDB <<EOT
echo
echo " *****************************************************************************" 
echo "                    SERVICE STATUS " 
echo " *****************************************************************************" 
systemctl status node_exporter.service |grep -E 'Active|Main'
echo
systemctl status postgresql-10.service |grep -E 'Active| postgresql-10.service'
echo
echo " *****************************************************************************
		      DB CLUSTER STATUS  
       *****************************************************************************" 
sudo pcs status 
echo
echo " *****************************************************************************" 
echo "                    DB CLUSTER  MEMORY STATUS" 
echo " *****************************************************************************" 
free -h | grep -i mem 
free -h | grep -i mem | awk '{printf "Memory used percentage : %.2f%\n",(\$3/\$2*100)}'
echo " *****************************************************************************" 
echo "                    DB CLUSTER CPU UTILIZE DETAIL" 
echo " *****************************************************************************" 
top -b -n 1  | grep Cpu 
mpstat -u 2 5 | grep -i average | awk '{printf "CPU used percentage: %.2f%\n",(100-\$12)}'
echo
echo " *****************************************************************************" 
echo "                    DB CLUSTER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs |sort -k5 -h |tail -n +2 |nl
echo
echo -e "\033[32;1m ************************* base & Pg_wals ************************* \033[m"
sudo du -sch /path
sudo du -sch /path
echo
echo " *****************************************************************************" 
echo "                    PDB Connection - SYNCH - DT_count - MI_count  " 
echo " *****************************************************************************" 
echo -e "********** \033[33;1m PDB Connection \033[m "
sudo su - postgres
pdbcon=\$(psql -d  -t -A -c select count (*) from pdbconnection;")
echo "\$pdbcon"
if [ "\$pdbcon" -gt 1000 ]; then
    echo "pdbconnection count is greater than 1000 ===> \$pdbcon"
    psql -d  -c "truncate pdbconnection;"
    pdbcon2=\$(psql -d  -t -A -c "select count (*) from pdbconnection;")
    echo "\$pdbcon2"
    echo "count of pdbconnection now is \$pdbcon2"
else
    echo "pdbconnection is \$pdbcon and below 1000"
fi
echo -e "********** \033[33;1m Synch_count \033[m "
synch=\$(psql -d  -t -A -c "select count (*) from pdbsynchtable;")
echo "\$synch"
echo "synch count is \$synch"
echo -e "********** \033[33;1m DT_Count \033[m "
dtcount=\$(psql -d  -t -A -c "select count (*) from pdbsynchtable where requesttype='T';")
echo "\$dtcount"
echo "dtcount is \$dtcount"
echo -e "********** \033[33;1m MI_count \033[m "
micount=\$(psql -d  -t -A -c "select count (*) from miepolicytable;")
echo "\$micount"
echo "mi_count is \$micount"
echo
if [ $(date +%H) -lt 12 ]; then
echo -e "\033[33;3m*****************************************Policy Upload Details********************************** \033[m"
psql -d  -t -A -c "select batchnumber, uploadstarttime, uploadendtime, remarks from public.usr_0_upload_log_history where date(dvdinsertstarttime) = current_date - interval '1 day';" |sed 's/|/ | /g'
echo "*********************************************************************************************"
fi
echo
EOT

DCPAR="/dev / /usr /home /boot /usr/local /var /var/tmp /var/log /var/log/audit /tmp "

DRPAR="/dev / /usr /home /boot /usr/local /var /var/tmp /var/log /var/log/audit /tmp "

DCDBPAR="/dev / /usr /home /tmp /boot /usr/local /var /var/tmp /var/log /var/log/audit "

DRDBPAR="/dev / /usr /home /tmp /boot /usr/local /var /var/tmp /var/log /var/log/audit "

DF1_TMP="/tmp/df1_output.txt"
DF2_TMP="/tmp/df2_output.txt"
DF3_TMP="/tmp/df3_output.txt"
DF4_TMP="/tmp/df4_output.txt"

export SSHPASS="$PASSWORD"
#DCAPP
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $DCAPP \ "df -h --output=size,used,avail,pcent,target $DCPAR" > "$DF1_TMP"

#DRAPP
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $DRAPP \ "df -h --output=size,used,avail,pcent,target $DRPAR" > "$DF2_TMP"

#DCDB
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $DCDB \ "df -h --output=size,used,avail,pcent,target $DCDBPAR" > "$DF3_TMP"

#DRDB
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $DRDB \ "df -h --output=size,used,avail,pcent,target $DRDBPAR" > "$DF4_TMP"

echo -e "\033[33;3m**********Comparison of DC & DR Servers Partition \033[m"
echo "------------dc-----------------------------------------------dr--------------------"
paste "$DF1_TMP" "$DF2_TMP" | pr -t -e20
echo
echo -e "\033[33;3m--------Comparison of DC & DR (DB) servers Partition \033[m"
echo "------------dc-----------------------------------------------dr--------------------"
paste "$DF3_TMP" "$DF4_TMP" | pr -t -e20
echo
date
rm   "$DF1_TMP" "$DF2_TMP" "$DF3_TMP" "$DF4_TMP" 

echo -e "\033[32;2m############################## Script execution completed ##############################\033[m"
