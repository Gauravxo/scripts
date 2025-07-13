read -p "do you want to uninstall this package if yes then press Y or no then press N (Y/N):  " i
if [ $i = 'Y' ];
then
	dnf remove podman-docker -y

	if [ echo $? = "0" ];
        echo -e "\033[33;3m $package Successfully uninstalled  from your system \033[m"
fi
