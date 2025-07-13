#!/bin/bash
echo -e "\033[32;3m ----------welcome to package_check and installation wizard\033[m"
echo
package=$(rpm -qa | grep -i podman-docker | cut -d'-' -f1)

if [ "$package" = "podman" ]; then
    echo -e "\033[33;3m $package is already installed in your machine \033[m"
    echo
fi

    read -p "Do you want to uninstall podman-docker? If yes, press Y or N: " i
    if [ "$i" = "Y" ]; then
        dnf remove podman-docker -y
        if [ $? -eq 0 ]; then
            echo -e "\033[33;3m podman-docker successfully uninstalled from your system \033[m"

        fi


else

    read -p "podman-docker is not found. Do you want to install podman-docker now? If yes, press Y (Y/N): " i
    if [ "$i" = "Y" ]; then
        dnf install podman-docker -y
        if [ $? -eq 0 ]; then
            echo -e "\033[33;3m podman-docker successfully installed on your system \033[m"

        fi
     fi

fi
                 
