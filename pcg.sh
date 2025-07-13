#!/bin/bash

echo -e "\033[32;3m ----------welcome to package_check and installation wizard\033[m"
echo

# Check if podman-docker is installed
package=$(rpm -qa | grep -i podman-docker | cut -d'-' -f1)

if [ "$package" = "podman" ]; then
    echo -e "\033[33;3m $package is already installed in your machine \033[m"
    echo
else
    # Ask user if they want to install podman-docker
    read -p "podman-docker is not found or needs to be removed. Do you want to install podman-docker now? If yes, press Y (Y/N): " i
    if [ "$i" = "Y" ] 
        # Install Docker (assuming you want to install Docker instead of podman-docker)
        dnf install podman-docker -y
        
        # Check if installation was successful
        if [ $? -eq 0 ]; then
            echo -e "\033[33;3m podman-docker successfully installed on your system \033[m"
        else
            echo -e "\033[31m Installation failed. Please check the error messages above. \033[m"
        fi
    fi

    # Ask user if they want to uninstall podman-docker
    read -p "Do you want to uninstall podman-docker? If yes, press Y or N: " i
    if [ "$i" = "Y" ]; then
        dnf remove podman-docker -y
        
        # Check if removal was successful
        if [ $? -eq 0 ]; then
            echo -e "\033[33;3m podman-docker successfully uninstalled from your system \033[m"
        else
            echo -e "\033[31m Uninstallation failed. Please check the error messages above. \033[m"
        fi
    fi
fi

