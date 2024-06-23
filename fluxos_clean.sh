#!/bin/bash

docker_check=$(docker container ls -a | egrep 'zelcash|flux' | grep -Eo "^[0-9a-z]{8,}\b" | wc -l)
resource_check=$(df | egrep 'flux' | awk '{ print $1}' | wc -l)

if [[ $docker_check != 0 ]]; then
 echo -e "${ARROW} ${CYAN}Removing containers...${NC}"
 sudo service docker restart > /dev/null 2>&1 && sleep 2
 docker container ls -a | egrep 'zelcash|flux' | grep -Eo "^[0-9a-z]{8,}\b" |
 while read line; do
   sudo docker stop $line > /dev/null 2>&1 && sleep 2
   sudo docker rm $line > /dev/null 2>&1 && sleep 2
 done
fi

if [[ $resource_check != 0 ]]; then
 echo -e "${ARROW} ${CYAN}Unmounting locked FluxOS resource${NC}" && sleep 1
 df | egrep 'flux' | awk '{ print $1}' |
 while read line; do
   sudo umount -l $line && sleep 1
 done
fi

if [[ -d /home/$USER/zelflux/ZelApps && $(find /home/$USER/zelflux/ZelApps -maxdepth 1 -mindepth 1 -type d | wc -l) -gt 1 ]]; then
 echo -e "${ARROW} ${CYAN}Cleaning FluxOS Apps directory...${NC}" && sleep 1
 APPS_LIST=($(find /home/$USER/zelflux/ZelApps -maxdepth 1 -mindepth 1 -type d -printf '%P\n'))
 LENGTH=${#APPS_LIST[@]}
 for (( j=0; j<${LENGTH}; j++ ));
 do
   if [[ "${APPS_LIST[$j]}" != "ZelShare" && "${APPS_LIST[$j]}" != "" ]]; then
     echo -e "${ARROW} ${CYAN}Apps directory removed, path: ${GREEN}/home/$USER/zelflux/ZelApps/${APPS_LIST[$j]}${NC}"
     sudo rm -rf /home/$USER/zelflux/ZelApps/${APPS_LIST[$j]}
   fi
 done
fi
