#!/bin/bash
a=0
execdate=`date +%d%m%Y`
tmpfilename="/tmp/""$execdate""_UploadPingRes.txt"
#Get the IP of the PC to ping
echo  "Enter the IP of the Destination PC or server to Ping: "
read DestIP
> "$tmpfilename"
echo "Dest IP :  ""$DestIP" >> $tmpfilename
echo "Packet Size : 2048" >> $tmpfilename


until [ $a -gt 150 ]
do
#	echo "Dest IP :  ""$DestIP" >> $tmpfilename
#	echo "Packet Size : 2048" >> $tmpfilename
	echo "Started at : " `date` >> $tmpfilename
	ping -c 1000 -s 2048 -i 0.005 $DestIP 
	echo "Iteration no $a" >> $tmpfilename
	#>> "/tmp/UploadPingRes.txt"
	echo "Completed at : " `date` >> $tmpfilename
	a=`expr $a + 1`
done

#for i in 1 to 100; do ping -c 100 -s 2048 $DestIP >> "/tmp/UploadPingRes.txt";done;

