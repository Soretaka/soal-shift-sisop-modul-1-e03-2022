# Soal-shift-sisop-modul-1-E03-2022
Daniel Hermawan - 5025201087 
Florentino Benedictus - 5025201222
Anak Agung Yatestha Parwata - 5025201234

Anggota:

1. Daniel Hermawan (5025201087)
2. Florentino Benedictus (5025201222)
3. Anak Agung Yatestha Parwata (5025201234)

## Soal no 1
Dikerjakan oleh **Anak Agung Yatestha Parwata (5025201234)**

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

hasil run:

![image](https://drive.google.com/uc?export=view&id=1zWw47rA8gHC51pnM8BYlGFOSCSptvIGN)
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

hasil run:

![image](https://drive.google.com/uc?export=view&id=1aHAcLVdAXZiecelt7I3NbMfIhnPG3Y7F)
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

hasil run:

![image](https://drive.google.com/uc?export=view&id=1VTPQWeReSzNxQXnV00RdPN9IkpxoQ0YF)
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

hasil run:

![image](https://drive.google.com/uc?export=view&id=1DgBEnkYDa8i2Fb1_3djtwyIvee7dKB_F)
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

hasil run:

![image](https://drive.google.com/uc?export=view&id=12AQQh8eFtKw3DKi8EbWX1zPKzenib4i4)
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

hasil run:

![image](https://drive.google.com/uc?export=view&id=1q5B4uZnVlxcK053Cm1Evl7NvNn7atFd7)

```bash
if [ $flaglogin == 1 ]
then
    echo "masukan command sir: "
    read com num
```

baris tersebut berfungsi untuk mengecek apakah pengguna berhasil login? jika iya maka akan menerima input command sesuai dengan soal, dan jika tidak maka tidak akan ada yang terjadi.

hasil run:

![image](https://drive.google.com/uc?export=view&id=1EJKVjkEvmiufNKKNYjMue0MhGu2nI864)
```bash
    if [ "$com" == "att" ] 
        then
            grep -wc "LOGIN.*$username\|$username.*LOGIN" ./log.txt
```
Jika command yang diberikan adalah "att", maka pengguna akan menerima berapa kali username pengguna mencoba login baik yang berhasil mapun tidak berhasil, karena pada log setiap percobaan login memiliki kata "LOGIN:" maka kita dapat mengecek berapa banyak kombinasi kata "LOGIN: " digabung dengan username pengguna menggunakan grep.

hasil run:

![image](https://drive.google.com/uc?export=view&id=1g5bdA6IdkQnB2-14RPetSBqjX8OFsJ0c)
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

hasil run:

![image](https://drive.google.com/uc?export=view&id=1Sc5ClxlkqcXe6BrzHKEmBZzVU1KSuETf)

![image](https://drive.google.com/uc?export=view&id=1vzo3qI6zNAPXRsuELjeDOZAEjwCI84yD)

![image](https://drive.google.com/uc?export=view&id=1MPNVcvzXPhnzX5748EfbqqhhbqxzvAPj)
```bash
            else
            echo "belum tau perintah :("
            fi
```
digunakan jika command yang dimasukan pengguna diluar command att dan dl.

### kendala
tidak ada

## Soal no 2
Dikerjakan oleh **Daniel Hermawan (5025201087) dan Anak Agung Yatestha Parwata (5025201234)**  

Di soal nomor 2, kita diberikan sebuah log website daffainfo dengan nama **file log_website_daffainfo.log**. Kita diminta untuk mengolah dan mengekstrak beberapa data yang terdapat pada log tersebut seperti :  
     1. Membuat folder bernama forensic_log_website_daffainfo_log terlebih dahulu.  

     2. Menghitung rata-rata request yang terjadi setiap jam.  

     3. Mengeluarkan IP yang paling sering melakukan request.  

     4. Menghitung berapa banyak request yang menggunakan user-agent curl.  

     5. Mengekstrak semua alamat IP yang melakukan request pada jam 2 pagi tanggal 22.  


### Membuat Folder forensic_log_website_daffainfo_log 
```bash
if ! [[ -d "forensic_log_website_daffainfo_log" ]]
then
    mkdir "forensic_log_website_daffainfo_log"
else
    rm -r "forensic_log_website_daffainfo_log"
    mkdir "forensic_log_website_daffainfo_log"
fi
```
Pertama, kode diatas akan berjalan yang berfungsi untuk membuat folder dengan nama **forensic_log_website_daffainfo_log**. Terdapat beberapa kondisional untuk beberapa kasus seperti jika folder tersebut sudah ada maka akan dihapus dan dibuat folder yang baru dan kosong. Jika tidak ada folder dengan nama serupa, maka akan langsung dibuat.  

**Hasil run :**
![eksekusi script](https://drive.google.com/uc?export=view&id=1EVO1tHh3EYRcpwlZfIFJArvkB4OsS1hx)  
Eksekusi script soal2_forensic_dapos.sh

![folder created](https://drive.google.com/uc?export=view&id=1QZY15m-vemz0LzsjKvubiQMXF1FD5CwA)  
Folder forensic_log_website_daffainfo_log dibuat

![request rate per hour](https://drive.google.com/uc?export=view&id=1Rgsfg8qb0H6Xvg3LNjzCzj9Cnn9CZ6vQ)  
Rata-rata request per jam

![result.txt result](https://drive.google.com/uc?export=view&id=1Pfpv8u3WISlB9Y7Y44Vv-5KFnzV1SHl4)  
IP dengan jumlah request terbanyak, request user-agent curl, dan IP yang request pada jam 2 pagi tanggal 22


### Rata-rata request per jam
```bash
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
```
Selanjutnya, kode diatas akan berjalan yang berguna untuk menghitung rata-rata request tiap jam. Kode tersebut akan mengekstrak informasi rekam jejak waktu yang akan dijumlahkan serta dibagi dengan rentang waktu yang tercatat. Setelah didapatkan rata-rata request per jam, hasilnya akan dicetak dan disimpan di folder forensic_log_website_daffainfo_log dengan nama file **ratarata.txt**.

## IP dengan request paling banyak
```bash
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
```
Ketiga, kode diatas digunakan untuk mendata alamat IP yang melakukan request dan menghitung berapa banyak request yang dilakukan oleh alamat IP tersebut. Setelah itu akan dicari alamat IP yang melakukan paling banyak lalu hasilnya akan dimasukkan ke folder **forensic_log_website_daffainfo_log** dengan nama file **result.txt**.

## Request dengan user-agent curl
```bash
cat "log_website_daffainfo.log" | awk '
/curl/ {++n}
END { print "ada " n " requests yang menggunakan curl sebagai user-agent\n" }'>> forensic_log_website_daffainfo_log/result.txt
```
Berikutnya, akan dilakukan pencarian request yang memiliki user-agent bernama curl dimana setiap ditemukan kata **curl** di baris log akan menambahkan variabel **n** sebanyak 1. Setelah proses penelusuran dan telah di total di variabel **n**, akan dimasukkan hasilnya ke dalam folder **forensic_log_website_daffainfo_log** dengan nama file **result.txt**. Namun, karena nama file **result.txt** telah dibuat sebelumnya dan kita menggunakan simbol **>>**, makan hasil dari kode diatas akan digabungnya dengan isi dari folder **result.txt** yang telah dibuat sebelumnya.

## IP yang melakukan request pada jam 2 pagi tanggal 22
```bash
cat "log_website_daffainfo.log" | awk -F ":" '
/2022:02/ { print $1 }' >> forensic_log_website_daffainfo_log/result.txt
```
Terakhir, kode diatas berfungsi untuk mengekstrak alamat IP yang melakukan request pada pukul 2 pagi tanggal 22 yang dapat dilihat dari rekam jejak waktu di tiap baris log dengan pola **2022:02** yang berarti tahun 2022 pad pukul 2 pagi. Setelah alamat IP di ekstrak, kemudian akan disimpan di folder **forensic_log_website_daffainfo_log** dengan digabungkan di file **result.txt** yang sebelumnya sudah dibuat. 


## Soal no 3
Dikerjakan oleh **Anak Agung Yatestha Parwata (5025201234),Florentino Benedictus (5025201222)**

Dalam soal ini, kita diminta untuk membuat program yang memonitor ram dan size directory `/home/{user}` dengan cara memasukkan metrics kedalam file log secara periodik.
 
### minute_log.sh 
```bash
folder="metrics_agg_$(TZ=Asia/Jakarta date -d '1 hour ago' +'%Y%m%d%H')"
file="metrics_$(TZ=Asia/Jakarta date +'%Y%m%d%H%M%S')"
```
 
Script bash yang pertama (`minute_log.sh`) akan memasukkan metrics ke dalam file dengan format `metrics_{YmdHms}.log` setiap menitnya. Script ini juga akan membuat folder dalam directory log dengan format `metrics_agg_$(YmdH)` dengan nilai H merupakan 1 jam sebelum script dijalankan. Tujuannya agar file log yang digenerate tiap menit tidak berceceran.
hasil run:

![image](https://drive.google.com/uc?export=view&id=1V9WT60LMudbqioMkB0GYzV9A2s4WU_HJ)
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

hasil run:

![image](https://drive.google.com/uc?export=view&id=1H-5ThDY22i7VADrI15Qbpew88eB0Fol1)

Agar `aggregate_minutes_to_hourly_log.sh` dapat dijalankan tiap jam, kita dapat menambahkan line berikut pada crontab:
 
```
0 * * * * /{path aggregate_minutes_to_hourly_log.sh}
```
 
### Evaluasi Soal No. 3
Sebaiknya kedua file script bash diletakkan pada `/home/{user}` . Alasannya untuk menghindari error akibat permission access yang menyebabkan crontab tidak berjalan.
