#!/bin/bash

# A. Create Folder
if ! [[ -d "forensic_log_website_daffainfo_log" ]]
then
    mkdir "forensic_log_website_daffainfo_log"
else
    rm -r "forensic_log_website_daffainfo_log"
    mkdir "forensic_log_website_daffainfo_log"
fi

# B.Request per hour 
cat "log_website_daffainfo.log" | awk -F ":" 'NR!=1 {request[$3]++}
END {
        for (i in request){
            hours++
            average+=request[i]
        }
        hours-=1
        average=average/hours
        printf "Rata-rata serangan adalah sebanyak %.2f requests per jam", average
    }' > forensic_log_website_daffainfo_log/ratarata.txt

# C. Most frequent request
cat "log_website_daffainfo.log" | awk -F ":" 'NR!=1 {request[$1]++}
END {
    max=0
    for (i in request){
        if(max < request[i]){
            freqreq=i
            max=request[i]
        }
    }
    printf "IP yang paling banyak mengakses server adalah: " freqreq " sebanyak " max " requests\n"
}' >> forensic_log_website_daffainfo_log/result.txt

# D. How many "curl" user-agent request
cat "log_website_daffainfo.log" | awk '
/curl/ {++n}
END { print "ada " n " requests yang menggunakan curl sebagai user-agent\n" }'>> forensic_log_website_daffainfo_log/result.txt

# E. At 2 in the morning, give the list of the IP 
cat "log_website_daffainfo.log" | awk -F ":" '/2022:02/ { print $1 }' >> forensic_log_website_daffainfo_log/result.txt