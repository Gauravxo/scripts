#!/bin/bash
read -p "Please Enter Your age Here -- " age
read -p "enter your country -- " country
if [ $age -gt 18 ] && [ $country = india ] 
then
	echo "Yes Buddy---You can vote"
else
	echo "You are not eledgile to vote try after 18 or you are not a citizen of india"
fi
