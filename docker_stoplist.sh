#!/bin/bash

purge=0
while IFS=$'\t' read -r id image
do
	if grep "^${image}\:" $0;
	then
 		echo "Stop and remove: $id"
		docker rm -f "$id"
		purge="1"
	fi
done <<< $(docker ps --format "{{.ID}}\t{{.Image}}")

if [ $purge -eq "1" ] 
then
	docker system prune -fa
fi

exit 0

# stop list images
olebedev/socks5:latest
andrey01/softether:4.38-9760-2
