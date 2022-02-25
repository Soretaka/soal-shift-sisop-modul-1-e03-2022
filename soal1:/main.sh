#!/bin/bash
lines=0
unamelist=[]
passlist=[]
while read line
do
     mod=$(($lines%2))
     if [ $mod -eq 0 ]
     then
     unamelist[$index]="$line"
     ((index++))
     echo "unamelist ke $index adalah $line"
     else
     passlist[$passindex]="$line"
     ((passindex++))
     echo "pass ke $passindex adalah $line"
     fi
((lines++))
done < './users/user.txt'

flaglogin=0
echo "silahkan login: "
echo "masukan username: "
read username
echo "masukan password: "
read -s password
index=0
for i in "${unamelist[@]}"
do
    if [ "$i" == "$username" ] && [ "${passlist[$index]}" == "$password" ]
    then
        echo -n "$(date +'%m/%d/%Y %H:%M:%S ')" >> ./log.txt
        echo "LOGIN: INFO User $username logged in" >> ./log.txt
        flaglogin=1
        break
    else
        echo -n "$(date +'%m/%d/%Y %H:%M:%S ')" >> ./log.txt
        echo "LOGIN: ERROR Failed login attempt on user $username" >> ./log.txt
    fi
((index++))
done
if [ $flaglogin == 1 ]
then
    echo "masukan command sir: "
    read com num
    if [ "$com" == "att" ] 
        then
            echo "$username"
            grep -wc "LOGIN.*$username\|$username.*LOGIN" ./log.txt
        else
            if [[ "$com" == "dl" ]]; then
            j=0
            folder=$(date +%y-%m-%d)_$username
            if ! [[ -f "$folder.zip" ]]
            then
                mkdir $folder
            else
                unzip -P $password $folder.zip
                rm $folder.zip
            fi
            bnyk=$(find $folder -type f | wc -l)
            ((bnyk++))
            let trkhir=$bnyk+$num-1
            for ((j=$bnyk; j<=trkhir; j=j+1))
                do
                    if [ $j -lt 10 ]
                    then
                        wget https://loremflickr.com/320/240 -O $folder/PIC_0$j.jpeg
                    else
                    wget https://loremflickr.com/320/240 -O $folder/PIC_$j.jpeg
                    fi
                done
                zip --password $password -r $folder.zip $folder/
                rm -r $folder
            else
            echo "belum tau perintah :("
            fi
    fi
fi
