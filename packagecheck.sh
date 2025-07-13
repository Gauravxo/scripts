#!/bin/bash
echo -e "\033[32;3m ----------welcome to package_check and installation wizard\033[m"
echo
package=$(rpm -qa |grep -i httpd |cut -d'-' -f1)
if [ $package =  "httpd" ];
then
        echo -e "\033[33;3m $package is already installed in your machine \033[m"
fi
echo

        read  -p "podman-docker now  erase from your system or NOT found do you want to install now podman-docker in your machine                                                        if yes then press y (Y/N):  " i
        if [ $i = "Y" ]; then
                dnf install docker
                systemctl enable httpd --now
                systemctl status httpd
                fi
                if [ $? -eq "0" ];
                then
                echo -e "\033[33;3m httpd Successfully installed in your system \033[m"
        fi

read -p "do you want to uninstall this package if yes then press Y or no then press N (Y/N):  " i
if [ $i = 'Y' ]; then

        dnf remove podman-docker -y
fi
       if [ $? -eq "0" ]; then
       echo -e "\033[33;3m $package Successfully uninstalled  from your system \033[m"
fi
file
