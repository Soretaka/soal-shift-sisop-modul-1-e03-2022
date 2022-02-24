#!/bin/bash
flag=1
lines=0
unamelist=[]
while read line
do
     mod=$(($lines%2))
     if [ $mod -eq 0 ]
     then
     unamelist[$index]="$line"
     ((index++))
     echo "unamelist masukin:$line di $index"
     fi
((lines++))
done < 'user.txt'
echo "masukan username: "
read username
echo "masukan password: "
read -s password
#echo -e "uname: $username\npassword: $password"
#checking password
if [ ${#password} -ge 8 ]
then
     if ! [[ "$password" =~ [^a-zA-Z0-9] ]]; then
          if [[ "$password" =~ [?=.*a-z] ]]; then
               if [[ "$password" =~ [?=.*A-Z] ]]; then
                    if [[ "$password" =~ [?=.*0-9] ]]; then
                         echo "VALID"
                    else
                         echo "ga ada angka"
                         flag=0
                    fi
               else
                    echo "ga ada huruf besar"
                    flag=0
               fi
          else
               echo "ga ada huruf kecil"
               flag=0
          fi
     else
          echo "ga alphanumeric bro"
          flag=0
     fi
else
     flag=0
     echo "kurang panjang bro"
fi

if [ "$username" == "$password" ]
then
     echo "loh sama"
     flag=0
fi
#done

#checking username
for i in "${unamelist[@]}"
do
     if [ "$i" == "$username" ]
     then
          echo "loh udah ada usernamenya"
          echo -n "$(date +'%m/%d/%Y %H:%M:%S ')" >> log.txt
          echo "REGISTER: ERROR User already exists" >> log.txt
          flag=0
     fi
done
if [ $flag -eq 1 ]
then
     echo -n "$(date +'%m/%d/%Y %H:%M:%S ')" >> log.txt
     echo "REGISTER: INFO User $username registered successfully" >> log.txt
else
     echo "regis gagal"
fi
#echo -e "$username\n$password" >> user.txt
