#!/bin/bash
no=12


	for i in 1 2 3 4 5 6 7 8 9
	do
		if [ $no -eq $i ]
		then 
		echo "NO  $no  is found!!!!!!"
	else
		echo  "$no is not found!!!"
	

		break
	fi
	
done

