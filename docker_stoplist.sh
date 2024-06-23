#!/bin/bash

purge=0
while IFS=$'\t' read -r id image name
do
	if grep "^${image%%:*}\:" $0;
	then
 		echo "Stop and remove: $id"
		docker rm -f "$id"
  		if [ -d "/home/$USER/zelflux/ZelApps/${name}" ]
    		then
	  		echo "Clean Apps: ${name}"
	 		sudo umount -l "/home/$USER/zelflux/ZelApps/${name}"
	   		sudo rm -rf "/home/$USER/zelflux/ZelApps/${name}"
		fi
  		purge="1"
	fi
done <<< $(docker ps --format "{{.ID}}\t{{.Image}}\t{{.Names}}")

if [ $purge -eq "1" ] 
then
	docker system prune -fa
fi

exit 0

# stop list images
olebedev/socks5:latest
andrey01/softether:4.38-9760-2
