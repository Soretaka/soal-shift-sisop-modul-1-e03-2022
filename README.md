# Soal-shift-sisop-modul-1-E03-2022
Daniel Hermawan - 5025201087 
Florentino Benedictus - 5025201222
Anak Agung Yatestha Parwata - 5025201234

Angota:

1. Daniel Hermawan (5025201087)
2. Florentino Benedictus (5025201222)
3. Anak Agung Yatestha Parwata (5025201234)

## Soal no 1
Soal no 1 menyuruh kita untuk membuat sistem login dengan register. Register terdapat dalam file register.sh dan sistem login terdapat pada file main.sh. Setiap akun memiliki username dan password dan akun disimpan dalam user.txt. Password memiliki ketentuan sebagai berikut:

1.Minimal 8 karakter 

2.Memiliki minimal 1 huruf kapital dan 1 huruf kecil

4.Alphanumeric

5.Tidak boleh sama dengan username 

### register.sh

```bash
flag=1
lines=0
unamelist=[]
if ! [[ -d "users" ]]
then
    mkdir users
fi
if ! [[ -f "users/user.txt" ]]
then
    touch users/user.txt
fi
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
done < './users/user.txt'
``` 
potongan kode diatas dalam file register.sh berfungsi sebagai untuk membaca username yang ada dalam file users.txt, dimana variabel flag digunakan untuk menandakan registrasi berhasil atau tidak, variabel lines digunakan untuk penanda apakah dia username atau password (username jika baris genap, password jika baris ganjil (baris dengan zero indexing)), dan variabel unamelist digunakan untuk menyimpan username yang sudah ada di user.txt

```bash
done < './users/user.txt'
echo "masukan username: "
read username
echo "masukan password: "
read -s password
```
digunakan untuk membaca username dan password

```bash
if ! [ "$username" == "$password" ]
then
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
else
     flog=0
     echo "username dan password sama"
fi
```

digunakan untuk mengecek apakah password sudah sesuai dengan persyaratan

```bash
for i in "${unamelist[@]}"
do
     if [ "$i" == "$username" ]
     then
          echo -n "$(date +'%m/%d/%Y %H:%M:%S ')" >> log.txt
          echo "REGISTER: ERROR User already exists" >> log.txt
          flag=0
     fi
done
```

digunakan untuk mengecek apakah username sudah ada di dalam user.txt atau belum

```bash
if [ $flag -eq 1 ]
then
     echo -n "$(date +'%m/%d/%Y %H:%M:%S ')" >> log.txt
     echo "REGISTER: INFO User $username registered successfully" >> log.txt
     echo -e "$username\n$password" >> ./users/user.txt
else
     echo "regis gagal"
fi
```

digunakan untuk mengecek apakah registrasi berhasil atau tidak, jika berhasil akan dimasukan kedalam log dan user, jika tidak maka pengguna akan diberitahu regis gagal.

### main.sh

```bash
lines=0
unamelist=[]
passlist=[]
if ! [[ -d "users" ]]
then
    mkdir users
fi
if ! [[ -f "users/user.txt" ]]
then
    touch users/user.txt
fi
while read line
do
     mod=$(($lines%2))
     if [ $mod -eq 0 ]
     then
     unamelist[$index]="$line"
     ((index++))
     #echo "unamelist ke $index adalah $line"
     else
     passlist[$passindex]="$line"
     ((passindex++))
     #echo "pass ke $passindex adalah $line"
     fi
((lines++))
done < './users/user.txt'
```

baris tersebut berfungsi untuk membaca username dan password yang ada dalam user.txt, dimana lines digunakan sebagai penanda apakah baris tersebut username atau password (username jika baris genap, password jika baris ganjil (baris dengan zero indexing)), unamelist digunakan untuk menyimpan username, passlist digunakan untuk menyimpan password, index untuk menyimpan index username, dan passindex untuk menyimpan index password.

```bash
flaglogin=0
echo "silahkan login: "
echo "masukan username: "
read username
echo "masukan password: "
read -s password
```

baris tersebut berfungsi untuk menerima input username dan password dari pengguna, variabel flaglogin kedepannya digunakan sebagai penanda apakah pengguna berhasil login atau tidak.

```bash
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
        echo "password salah!"
    fi
((index++))
done
```

baris tersebut berfungsi untuk mengecek apakah username dan password pengguna sesuai dengan yang ada di user.txt, jika pengguna berhasil login maka flaglogin diganti menjadi 1.

```bash
if [ $flaglogin == 1 ]
then
    echo "masukan command sir: "
    read com num
```

baris tersebut berfungsi untuk mengecek apakah pengguna berhasil login? jika iya maka akan menerima input command sesuai dengan soal, dan jika tidak maka tidak akan ada yang terjadi.

```bash
    if [ "$com" == "att" ] 
        then
            grep -wc "LOGIN.*$username\|$username.*LOGIN" ./log.txt
```
Jika command yang diberikan adalah "att", maka pengguna akan menerima berapa kali username pengguna mencoba login baik yang berhasil mapun tidak berhasil, karena pada log setiap percobaan login memiliki kata "LOGIN:" maka kita dapat mengecek berapa banyak kombinasi kata "LOGIN: " digabung dengan username pengguna menggunakan grep.

```bash
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
```
Jika command yang diberikan adalah "dl", maka kita mengecek terlebih dahulu apakah file dengan format YYYY-MM-DD_username.zip sudah ada? jika belum maka kita membuat sebuah directory dengan format YYYY-MM-DD_username, jika sudah maka kita unzip terlebih dahulu file tersebut menggunakan unzip -p, lalu hapus file folder.zip tersebut. Setelah itu, kita menghitung ada berapa banyak file yang ada didalam folder untuk melanjutkan penamaan file yang didownload, setelah itu, kita hanya perlu melakukan looping untuk mendownload file, lalu kita zip directory tersebut.

```bash
            else
            echo "belum tau perintah :("
            fi
```
digunakan jika command yang dimasukan pengguna diluar command att dan dl.

### kendala
tidak ada

## Soal no 3
Dalam soal ini, kita diminta untuk membuat program yang memonitor ram dan size directory `/home/{user}` dengan cara memasukkan metrics kedalam file log secara periodik.
 
### minute_log.sh 
```bash
folder="metrics_agg_$(TZ=Asia/Jakarta date -d '1 hour ago' +'%Y%m%d%H')"
file="metrics_$(TZ=Asia/Jakarta date +'%Y%m%d%H%M%S')"
```
 
Script bash yang pertama (`minute_log.sh`) akan memasukkan metrics ke dalam file dengan format `metrics_{YmdHms}.log` setiap menitnya. Script ini juga akan membuat folder dalam directory log dengan format `metrics_agg_$(YmdH)` dengan nilai H merupakan 1 jam sebelum script dijalankan. Tujuannya agar file log yang digenerate tiap menit tidak berceceran.
 
```bash
echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" >> /home/"$user"/log/$folder/"$file.log"
 
free -m | awk '/[0-9]+/{for (i=2; i<NF; i++) printf $i ","; print $NF}' ORS="," >> /home/"$user"/log/$folder/"$file.log"
du -sh /home/"$user" | awk '/[0-9]+/{print $2","$1}' >> /home/"$user"/log/$folder/"$file.log"
 
chown "$user" "/home/"$user"/log/$folder"
```
 
Untuk menyesuaikan formatting dari soal, maka kita perlu untuk memodifikasi Field Separator (FS) dan Record Separator (RS) yang ada ketika akan memasukkan metrics ke file log. Selanjutnya, kita menggunakan chown agar log hanya dapat dibaca user.<br/><br/>
 
Karena `minute_log.sh` harus dijalankan tiap menit, kita dapat menambahkan line berikut pada crontab (`crontab -e`):
 
```
* * * * * /{path minute_log.sh}
```
 
### aggregate_minutes_to_hourly_log.sh 
Script bash yang kedua (`aggregate_minutes_to_hourly_log.sh`) akan menggabungkan file log yang dibuat `minute_log.sh` dan akan menyimpan nilai minimum, maximum, dan rata-rata tiap metrics setiap jam. Caranya adalah dengan membaca seluruh file log yang berada dalam folder `metrics_agg_$(YmdH)`.
 
```bash
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
```
 
Untuk mendapatkan nilai average, kita dapat mencatat index, yaitu jumlah file log yang terdapat dalam folder. Selanjutnya kita juga akan mencatat nilai sum/total dari masing-masing metrics yang kemudian akan dibagi dengan index untuk mendapatkan nilai average.
 
```bash
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
```
```bash
file_dir="/home/$user/log/$folder"
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$file_dir.log"
echo "minimum,${mem_total_sorted[0]},${mem_used_sorted[0]},${mem_free_sorted[0]},${mem_shared_sorted[0]},${mem_buff_sorted[0]},${mem_available_sorted[0]},${swap_total_sorted[0]},${swap_used_sorted[0]},${swap_free_sorted[9]},$path_dir,${path_size_sorted[0]}M" >> "$file_dir.log"
echo "maximum,${mem_total_sorted[$index]},${mem_used_sorted[$index]},${mem_free_sorted[$index]},${mem_shared_sorted[$index]},${mem_buff_sorted[$index]},${mem_available_sorted[$index]},${swap_total_sorted[$index]},${swap_used_sorted[$index]},${swap_free_sorted[$index]},$path_dir,${path_size_sorted[$index]}M" >> "$file_dir.log"
echo "average,$mem_total_avg,$mem_used_avg,$mem_free_avg,$mem_shared_avg,$mem_buff_avg,$mem_available_avg,$swap_total_avg,$swap_used_avg,$swap_free_avg,$path_dir,$path_size_avg""M" >> "$file_dir.log"
 
chown "$user" "$file_dir.log"
```
 
Selanjutnya, untuk mendapat nilai minimum dan maximum kita dapat menyimpan masing-masing value metrics ke dalam array lalu melakukan sort sehingga nilai minimum masing-masing metrics akan berada pada index paling awal dan nilai maximum masing-masing metrics akan berada pada index paling akhir. Kita juga akan menggunakan chown agar log hanya dapat dibaca user.<br/><br/>
 
Agar `aggregate_minutes_to_hourly_log.sh` dapat dijalankan tiap jam, kita dapat menambahkan line berikut pada crontab:
 
```
0 * * * * /{path aggregate_minutes_to_hourly_log.sh}
```
 
### Evaluasi Soal No. 3
Sebaiknya kedua file script bash diletakkan pada `/home/{user}` . Alasannya untuk menghindari error akibat permission access yang menyebabkan crontab tidak berjalan.
