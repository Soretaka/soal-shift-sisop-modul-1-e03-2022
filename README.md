# Soal-shift-sisop-modul-1-E03-2022
Daniel Hermawan - 5025201087 <br />
Florentino Benedictus - 5025201222 <br />
Anak Agung Yatestha Parwata - 5025201234 <br />

<h1> Soal no 1 </h1> <br />
Soal no 1 menyuruh kita untuk membuat sistem login dengan register. Register terdapat dalam file register.sh dan sistem login terdapat pada file main.sh. Setiap akun memiliki username dan password dan akun disimpan dalam user.txt. Password memiliki ketentuan sebagai berikut: <br />
1.Minimal 8 karakter <br />
2.Memiliki minimal 1 huruf kapital dan 1 huruf kecil <br />
4.Alphanumeric <br />
5.Tidak boleh sama dengan username <br /> <br />
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