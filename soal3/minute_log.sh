#!/bin/bash
user=$(whoami)
if ! [[ -d /home/"$user"/log ]]
then
    mkdir /home/"$user"/log
fi
folder="metrics_agg_$(TZ=Asia/Jakarta date -d '1 hour ago' +'%Y%m%d%H')"
file="metrics_$(TZ=Asia/Jakarta date +'%Y%m%d%H%M%S')"
if ! [[ -d /home/"$user"/log/$folder ]]
    then
        mkdir /home/"$user"/log/$folder
fi
#minute_log.sh
echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" >> /home/"$user"/log/$folder/"$file.log"

free -m | awk '/[0-9]+/{for (i=2; i<NF; i++) printf $i ","; print $NF}' ORS="," >> /home/"$user"/log/$folder/"$file.log"
du -sh /home/"$user" | awk '/[0-9]+/{print $2","$1}' >> /home/"$user"/log/$folder/"$file.log"

chown "$user" "/home/"$user"/log/$folder"