#!/bin/bash
echo "Hello All"
echo -e "\033[32;2m********************************************************************************
                              || DELHI DO-1 Server analysis  ||
********************************************************************************\033[m"

for ip in '10.178.17.44' '10.178.17.45' '10.178.17.6' '10.178.17.11' '10.178.17.12' '10.178.17.10' '10.178.17.21' '10.178.17.22' '10.178.17.20' '10.178.17.34' '10.178.17.35' '10.178.17.36' '10.178.17.37' '10.178.17.38' '10.178.17.39' '10.153.5.25' '10.153.5.54'; 
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

 
export SSHPASS=Lic@doa011#
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  do_admin@10.178.17.10 <<EOT

echo " *****************************************************************************" 
echo "              SERVICE STATUS" 
echo " *****************************************************************************"
#sudo service --status-all

echo "
************* AGENCYSYNCH STATUS "
sudo service agencysynch status

echo "
************* SYNCH STATUS "
sudo service synch status

echo "
************* DOCKETSERVICE STATUS "
sudo service DocketService status

echo "
************* JBOSS-EAP-RHEL STATUS "
sudo service jboss-eap-rhel status

echo "
************* MI_ARCHIVALOFEDIFIBONDS STATUS "
sudo service MI_ArchivalOfEdigiBonds status

echo "
************* RSYSLOG.SERVICE STATUS "
sudo systemctl status rsyslog.service |grep active

echo "
************* UPLOADARCHIVAL STATUS "
sudo service uploadarchival status

echo "
************* EPOLICYINSERT STATUS "
sudo service epolicyinsert status

echo "
************* IRDOCDOWNLOAD STATUS "
sudo service irdocdownload status

echo "
************* NEWGENLDAP STATUS "
sudo systemctl status NewgenLdap | grep -i active

echo "
************* NEWGENWRAPPER STATUS "
ps -ef | grep -i wrapper

echo "
************* SMS STATUS "
ps -ef | grep -i sms

echo "
************* THUMBNAILSCHEDULE STATUS "
ps -ef | grep -i thumbnailschedule

echo "
************* SCHEDULER STATUS "
ps -ef | grep -i scheduler

echo "
************* NEWGENALARM STATUS "
ps -ef | grep -i alarm

echo "   service check done   "


echo " *****************************************************************************" 
echo "                    APP CLUSTER STATUS " 
echo " *****************************************************************************"
sudo pcs status

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
#ps -aux --sort=-%cpu | head -10 | awk '{printf $1;$2;$3;$4;$11}' | column -t

echo " *****************************************************************************" 
echo "                    APP CLUSTER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs |sort -h -k5 |nl 

EOT


echo -e "\033[33;1m******************************************************************************                                     || DATA-BASE SERVER || 
******************************************************************************\033[m"
export SSHPASS=Lic@doa011#
sshpass -e ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no do_admin@10.178.17.20 <<EOT
echo " *****************************************************************************" 
echo "                    SERVICE STATUS " 
echo " *****************************************************************************" 
systemctl status node_exporter.service |grep -E 'Active|Main'
systemctl status postgresql-10.service |grep -E 'Active| postgresql-10.service'

echo " *****************************************************************************" 
echo "                    DB CLUSTER STATUS " 
echo " *****************************************************************************" 
sudo pcs status 

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

#echo " *****************************************************************************"
#echo "                    TOP 10 Processes -  cpu & mem uses  "
#echo " *****************************************************************************"
#ps -aux --sort=-%cpu |head -10 |awk '{printf $1,$2,$3,$4,$11}' |column -t

echo " *****************************************************************************" 
echo "                    DB CLUSTER PARTITION STATUS " 
echo " *****************************************************************************" 
df -h -x tmpfs |sort -h -k5 |nl 

echo -e "\033[32;1m ************************* base & Pg_wals ************************* \033[m"
sudo du -sch /dbdata1/data/base

sudo du -sch /dbdata1/data/pg_wal

echo " *****************************************************************************" 
echo "                    PDB Connection - SYNCH - DT_count - MI_count  " 
echo " *****************************************************************************" 

echo -e "********** \033[33;1m PDB Connection \033[m "
sudo su - postgres
pdbcon=\$(psql -d division_011 -t -A -c "select count (*) from pdbconnection;")
echo "\$pdbcon"
if [ "\$pdbcon" -gt 1000 ]; then
    echo "pdbconnection count is greater than 1000 ===> \$pdbcon"
    psql -d division_011 -c "truncate pdbconnection;"
    pdbcon2=\$(psql -d division_011 -t -A -c "select count (*) from pdbconnection;")
    echo "\$pdbcon2"
    echo "count of pdbconnection now is \$pdbcon2"
else
    echo "pdbconnection is \$pdbcon and below 1000"
fi

echo -e "********** \033[33;1m Synch_count \033[m "
synch=\$(psql -d division_011 -t -A -c "select count (*) from pdbsynchtable;")
echo "\$synch"
echo "synch count is \$synch"

echo -e "********** \033[33;1m DT_Count \033[m "
dtcount=\$(psql -d division_011 -t -A -c "select count (*) from pdbsynchtable where requesttype='T';")
echo "\$dtcount"
echo "dtcount is \$dtcount"

echo -e "********** \033[33;1m MI_count \033[m "
micount=\$(psql -d division_011 -t -A -c "select count (*) from miepolicytable;")
echo "\$micount"
echo "mi_count is \$micount"

EOT

echo -e "\033[32;2m############################## Script execution completed ##############################\033[m"
