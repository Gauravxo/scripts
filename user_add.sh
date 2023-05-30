#!bin/bash
echo "Please insert Your User Name"
read name
useradd $name 
passwd $name
yum install lolcat*
echo "Hurrye You Have Successfully created $name user" |lolcat
