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
potongan kode diatas terdapat dalam file main.sh dan register.sh dimana fungsinya sama yaitu untuk membaca username dan password yang ada dalam file users.txt