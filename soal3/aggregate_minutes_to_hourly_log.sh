
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
list=($(awk '{print}' <<< `ls -r "/home/$user/log/$folder"`))
index=0

mem_total_avg=0
mem_used_avg=0
mem_free_avg=0
mem_shared_avg=0
mem_buff_avg=0
mem_available_avg=0
swap_total_avg=0
swap_used_avg=0
swap_free_avg=0
path_size_avg=0

for i in ${list[@]}
do
    nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $1}'))
    mem_total[$index]=$nilai
    mem_totalavg=$(($mem_totalavg+${mem_total[$index]}))
        nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $2}'))
    mem_used[$index]=$nilai
    mem_usedavg=$(($mem_usedavg+${mem_used[$index]}))
        nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $3}'))
    mem_free[$index]=$nilai
    mem_freeavg=${mem_free[$index]}
        nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $4}'))
    mem_shared[$index]=$nilai
    mem_sharedavg=$(($mem_sharedavg+${mem_shared[$index]}))
        nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $5}'))
    mem_buff[$index]=$nilai
    mem_buffavg=$(($mem_buffavg+${mem_buff[$index]}))
    nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $6}'))
    mem_available[$index]=$nilai
    mem_availableavg=$(($mem_availableavg+${mem_buff[$index]}))
        nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $7}'))
    swap_total[$index]=$nilai
    swap_totalavg=$(($swap_totalavg+${swap_total[$index]}))
        nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $8}'))
    swap_used[$index]=$nilai
    swap_usedavg=$((${swap_used[$index]}))
        nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $9}'))
    swap_free[$index]=$nilai
    swap_freeavg=$(($swap_freeavg+${swap_free[$index]}))
        path=($(cat "/home/$user/log/$folder/$i" | awk -v FS="," 'NR!=1 {print $10}'))
        nilai=($(cat "/home/$user/log/$folder/$i" | awk -v FS="[M,]" 'NR!=1 {print $11}'))
    path_size[$index]=$nilai
    path_sizeavg=$(($path_sizeavg+${path_size[$index]}))
    ((index++))
done
# echo "${mem_total[@]}"
# echo "${mem_used[@]}"
# echo "${mem_free[@]}"
# echo "${mem_shared[@]}"
# echo "${mem_buff[@]}"
# echo "${mem_available[@]}"
# echo "${swap_total[@]}"
# echo "${swap_used[@]}"
# echo "${swap_free[@]}"
# echo "${path[@]}"
# echo "${path_size[@]}"

mem_total_avg=$((mem_totalavg/index))
mem_used_avg=$((mem_usedavg/index))
mem_free_avg=$((mem_freeavg/index))
mem_shared_avg=$((mem_sharedavg/index))
mem_buff_avg=$((mem_buffavg/index))
mem_available_avg=$((mem_availableavg/index))
swap_total_avg=$((swap_totalavg/index))
swap_used_avg=$((swap_usedavg/index))
swap_free_avg=$((swap_freeavg/index))
path_size_avg=$((path_sizeavg/index))

mem_total_sorted=($(for i in "${mem_total[@]}"; do echo "$i"; done | sort -n))
mem_used_sorted=($(for i in "${mem_used[@]}"; do echo "$i"; done | sort -n))
mem_free_sorted=($(for i in "${mem_free[@]}"; do echo "$i"; done | sort -n))
mem_shared_sorted=($(for i in "${mem_shared[@]}"; do echo "$i"; done | sort -n))
mem_buff_sorted=($(for i in "${mem_buff[@]}"; do echo "$i"; done | sort -n))
mem_available_sorted=($(for i in "${mem_available[@]}"; do echo "$i"; done | sort -n))
swap_total_sorted=($(for i in "${swap_total[@]}"; do echo "$i"; done | sort -n))
swap_used_sorted=($(for i in "${swap_used[@]}"; do echo "$i"; done | sort -n))
swap_free_sorted=($(for i in "${swap_free[@]}"; do echo "$i"; done | sort -n))
path_size_sorted=($(for i in "${path_size[@]}"; do echo "$i"; done | sort -n))


((index--))
file_dir="/home/$user/log/$folder"
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$file_dir.log"
echo "minimum,${mem_total_sorted[0]},${mem_used_sorted[0]},${mem_free_sorted[0]},${mem_shared_sorted[0]},${mem_buff_sorted[0]},${mem_available_sorted[0]},${swap_total_sorted[0]},${swap_used_sorted[0]},${swap_free_sorted[9]},$path_dir,${path_size_sorted[0]}M" >> "$file_dir.log"
echo "maximum,${mem_total_sorted[$index]},${mem_used_sorted[$index]},${mem_free_sorted[$index]},${mem_shared_sorted[$index]},${mem_buff_sorted[$index]},${mem_available_sorted[$index]},${swap_total_sorted[$index]},${swap_used_sorted[$index]},${swap_free_sorted[$index]},$path_dir,${path_size_sorted[$index]}M" >> "$file_dir.log"
echo "average,$mem_total_avg,$mem_used_avg,$mem_free_avg,$mem_shared_avg,$mem_buff_avg,$mem_available_avg,$swap_total_avg,$swap_used_avg,$swap_free_avg,$path_dir,$path_size_avg""M" >> "$file_dir.log"

chown "$user" "$file_dir.log"