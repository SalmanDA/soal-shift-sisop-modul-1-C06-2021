# soal-shift-sisop-modul-1-C06-2021

## Laporan Soal Nomor 1 :

### 1A
Dalam soal kami diminta untuk mengumpulkan informasi yang ada di file syslog.log. Informasi yang diperlukan jenis log, pesan log, dan username pada setiap baris log. Untuk menyelesaikan soal ini kami memakai bantuan GREP dan SED dengan menggunakan REGEX.

- Gunakan grep kemudian pilih pattern yang mengandung INFO atau ERROR
- gunakan sed dengan s command, hilangkan string sebelum dan ":"

```grep "INFO\|ERROR" syslog.log | sed 's/.*: \(.*\).*/\1/g'```

### 1B
Dalam soal 1b kami diminta menampilkan pesan error beserta jumlah kemunculannya. Dalam poin ini kami filtering menggunakan grep, kemudian gunakan fitur count untuk menghitung jumlah kemunculannya.

```
grep "ERROR" $location/syslog.log
echo "Count Error: "; grep "ERROR" $location/syslog.log | grep -i -c "ERROR"
```

### 1C
Dalam soal 1c kami diminta untuk menampilkan jumlah kemunculan ERROR dan INFO untuk setiap usernya. Pada poin ini kami menggunakan bantuan filter grep untuk mencari string antara "ERROR\|INFO" kemudian di filter dengan sed untuk mengambil username, setelah itu pakai fitur sort and count.

```#grep 'INFO\|ERROR' syslog.log | sed 's/.*(\(.*\)).*/\1/g' | sort | uniq -c```

### 1D
Dalam soal 1d diminta apa yang didapatkan di poin b, dituliskan kedalam file error_message.csv dengan header Error,Count yang kemudian diikuti pesan error dan di urutkan berdasar jumlah kemunculan dari error yang terbanyak. Step yang kami jalankan :

- Gunakan `echo` untuk print header kemudian masukan kedalam file error_message.csv

```echo "Error,Count" >> error_message.csv```

- Deklarasi sebuah variabel untuk menyimpan baris grep nanti

```i="0";```

- untuk filtering soal yang diminta kami menggunakan `grep` kemudian string `"ERROR"` terhadap file yang diinginkan (syslog.log) kemudian gunakan fitur sed dengan filter `'s/.*` untuk replace string, kemudian `ERROR` mengambil string mulai dari setelah ERROR untuk mengambil tipe error, filter `\(.*)` untuk mengambil string tanpa syarat, regex `(.*` untuk batasan akhir pengambilan string, regex `/\1/g'` untuk replace dengan string kosong dan menutup filtering. kemudian gunakan fitur sort, uniq -c untuk mengurutkan dan mengeluarkan nilai jumlah setelah string di groupping, diakhir ditambah sort -nr untuk menugrutkan mulai dari yang terbanyak.

```for Line in `grep "ERROR" syslog.log | sed 's/.*ERROR \(.*\) (.*/\1,/g' | sort | uniq -c | sort -nr` ```

- kami menggunakan for dengan variabel untuk looping hasil grep diatas line per line, kemudian pakai if else untuk kondisi, jika line tersebut angka maka simpan di variabel untuk hasil count tipe error tersebut, jika line itu mengandung "," maka kata tersebut termasuk akhir kalimat jadi di echo tipe error dan jumlahnya, jika line tersebut hanya mengandung huruf biasa echo kalimat tanpa new line.
- jika semua semua di looping hasilnya diinput kedalam file error_message.csv

```
do
        if [[ "$Line" =~ [0-9] ]];
        then
                i=$Line
        elif [[ "$Line" == *","* ]];
        then
                echo "${Line}${i}"
        else
                echo -n "${Line} " 
        fi
done >> error_message.csv
```

### 1E
Dalam soal 1e diminta untuk menampilkan apa yang didapat di poin c, kemudian dituliskan ke file user_statistic.csv dengan header Username,INFO,ERROR berdasarkan username secara ascending.

- pertama untuk memulai mengerjakan soal kami menggunakan array yang menggunakan key string (userError) untuk menyimpan error yang dibuat oleh user, kemudian array orders untuk menyimpan key secara urut agar bisa digunakan pada array userError

```
declare -A userError;
declare -a orders;
e="0";
```

- untuk filtering soal yang diminta kami menggunakan `grep` kemudian string `"ERROR"` terhadap file yang diinginkan (syslog.log) kemudian gunakan fitur sed dengan filter `'s/.*` untuk subtitusi string, kemudian `(` mengambil string mulai dari setelah ( untuk username, filter `\(.*)` untuk rentang tanpa syarat, regex `).*` untuk batasan akhir pengambilan string, regex `/\1/g'` untuk replace dengan string kosong dan menutup filtering. kemudian gunakan fitur sort dan uniq -c untuk mengurutkan dan mengeluarkan nilai jumlah setelah string di groupping.

``` for eLine in `grep "ERROR" syslog.log | sed 's/.*(\(.*\)).*/\1/g' | sort | uniq -c` ```

- kami menggunakan for untuk looping hasil grep menyimpan di variable $eLine, kemudian looping dengan do & done, jika $eLine angka maka simpan di variabel $e sebagai jumlah error yang dihasilkan oleh user, kemudian jika huruf maka $eLine termasuk username dan simpan sebagai key array userError dengan value $e, tambahkan nilay array order untuk menyimpan username untuk nanti diurutkan.
- setelah filtering untuk error, kami menyiapkan tahap kedua untuk penulisan yang diminta soal, dengan echo header "Username,INFO,ERROR" kedalam file user_statistic.csv

```
do 
        if [[ "$eLine" =~ [0-9] ]];
       then
               e=$eLine
       else
              userError[$eLine]=$e; orders+=($eLine)
      fi

done
```

- kemudian setelah memasukan header, untuk data yang dibutuhkan kami menggunakan filter `grep` kemudian gunakan fitur sed dengan filter `'s/.*` untuk subtitusi string, kemudian `(` mengambil string mulai dari setelah ( untuk username, filter `\(.*)` untuk mengambil string tanpa syarat, regex `).*` untuk batasan akhir pengambilan string, regex `/\1/g'` untuk replace dengan string kosong dan menutup filtering. kemudian gunakan fitur sort dan uniq -c untuk mengurutkan dan mengeluarkan nilai jumlah setelah string di groupping.

```
echo "Username,INFO,ERROR" >> user_statistic.csv
x="0";
for uLine in `grep 'INFO\|ERROR' syslog.log | sed 's/.*(\(.*\)).*/\1/g' | sort | uniq -c`
```

- kami menggunakan for untuk looping hasil grep, menyimpan dalam variabel $uLine, kemudian looping dengan do & done, jika $uLine hanya berisi angka maka simpan di variabel $x, jika bukan maka masuk else. Dalam else deklarasikan terlebih dahulu $errorCount=0 untuk menandakan bahwa apakah user membuat error apa tidak, kemudian looping dengan for untuk mengambil key dalam array orders, looping dengan do & done dan gunakan kondisi cek apakah $key sama dengan $uLine, jika sama berarti user tersebut pernah melakukan error kemudian echo username, jumlah info yang telah dikurangi error, jumlah error. Ubah errorCount menjadi 1 sebagai tanda, supaya lebih efisien di break agar tidak perlu looping ke yang lainnya. Jika errorCount sama dengan 0 maka user tersebut tidak pernah melakukan error sehingga echo username,$x,0 karena $x sudah pasti hanya mengandung info dan error berjumlah 0
- setelah semua selesai di looping dan di echo masukan hasil kedalam file user_statistics.csv

```
do
        if [[ "$uLine" =~ [0-9] ]];
       then
               x=$uLine
       else
                errorCount=0;
                for key in ${orders[@]};
                do
                        if [[ "$key"  == "$uLine" ]];
                        then
                                echo "${uLine},$(( ${x}-${userError[${key}]} )),${userError[${key}]}"
                                errorCount=1;
                                break;
                        fi
                done

                if [ $errorCount -eq 0 ]
                then
                        echo "${uLine},${x},0"
                fi
       fi
done >> user_statistic.csv
```

## Laporan Soal Nomor 2 :

### 2A
Pada soal ini, diminta untuk menampilkan row ID terbesar dengan persentase profit terbesar. Pada pengerjaan soal ini kami menghitung besarnya persentase profit dari setiap row ID dan membandingkannya dengan row ID yang selanjutnya. 

```
cost_price=($18-$21)
profit_percentage=($21/cost_price)*100
id=$1
```

Jika ditemukan row ID yang persentase profitnya lebih besar dari persentase profit row ID yang sebelumnya, maka nilai persentase profit dan row IDnya akan disimpan ke variabel max dan maxid yang akan menjadi output dari program ini.

```
if(profit_percentage>=max)
	{
		max=profit_percentage
		maxid=id
	}
```

Berikut perintah outputnya:

```
{printf "Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%%.\n\n",maxid,max}' $data >> hasil.txt
```

### 2B
Supaya mendapatkan consumer yang melakukan transaksi pada tahun 2017, maka kami melakukan pengecekan pada kolom Order Date yang mengandung substring "17" dan negara yang bernama "Albuquerque". Jika ditemukan consumer yang melakukan order pada tahun 2017, maka nama consumer tersebut akan disimpan sebagai indeks dari array yang memiliki nilai positif. 

```
if($10~"Albuquerque" && $3~"17")
{
	array[$7]++
}
```

Saat semua tanggal pemesanan selesai diperiksa, kami keluarkan nama-nama yang dijadikan indeks array tadi menggunakan for looping.

```
{for(i in array) {print i} {printf "\n"}}' $data >> hasil.txt
```

### 2C
Kami menggunakan array untuk menyimpan banyaknya transaksi dari suatu segment consumer dengan nama segment sebagai indeksnya. Berikutnya kami mengecek setiap baris dan menambahkan nilai array dengan nama indeks dan nama segment yang sesuai. Contohnya setiap ditemukan transaksi di segment consumer, maka nilai array["Consumer"] akan bertambah. Setelah semua baris selesai diperiksa, dilakukan perbandingan antara segment Consumer, Home Office dan Corporate untuk mendapatkan segment mana yang melakukan transaksi paling kecil.

```
array[$8]++
if(array["Consumer"]<array["Home Office"])
{
	min=array["Consumer"]
	segment="Consumer"
	if(min>array["Corporate"])
	{
		segment="Corporate"
		min=array["Corporate"]
	}
}
else
{
	min=array["Home Office"]
	segment="Home Offfice"
	if(min>array["Corporate"])
	{
		segment="Corporate"
		min=array["Corporate"]
	}
}
```

Berikut perintah outputnya:

```
{print "Tipe segmen customer yang penjualannya paling sedikit adalah",segment,"dengan",min,"transaksi.\n"}' $data >> hasil.txt
```

### 2D
Pengerjaan soal ini hampir sama dengan pengerjaan soal 2C. Pertama megidetifikasi setiap baris apakah regionnya termasuk ke Central, South, East atau West lalu menambahkan profit dari  baris tersebut ke array dengan indeks berupa nama region. 

```
array[$13]=array[$13]+$21
```

Pada akhir program, semua region dibandingkan jumlah profitnya dan yang memiliki jumlah profit paling kecil akan menjadi output.

```
min1=0
min2=0
rmin1="east"
rmin2="Central"
if(array["East"]<array["West"])
{
	min1=array["East"]
	rmin1="East"
}
else
{
	min1=array["West"]
	rmin1="West"
}
if(array["South"]<array["Central"])
{
        min2=array["South"]
	rmin2="South"
}
        else
        {
        min2=array["Central"]
	rmin2="Central"
}
if(min2<min1)
{
        min1=min2
	rmin1=rmin2
	region=rmin1
}
```

### 2E
Output dari semua soal nomor 2 diletakkan pada file hasil.txt.


## Laporan Soal Nomor 3 :

### 3A
Didalam soal ini kita diminta untuk membuat script untuk mengunduh 23 gambar dari "https://loremflickr.com/320/240/kitten". Kita juga diminta untuk menyimpan log proses downlad file. Pengerjaan script menggunak looping while. Dikarenakan ada kemungkinan terdapat duplikat dalam proses mendownload file maka dibuatlah script tambahan untuk menghapus file duplikat. Untuk command mengunduh kita menggunakan wget. 

```wget -o Foto.log -O /home/iamfadilahmad/uwu/Koleksi_$b 'http://loremflickr.com/320/240/kitten'```

### 3B
Pada soal ini kita diminta untuk membuat cron untuk proses download dan membuat script untuk memasukkan file yang sudah di download ke dalam directory berdasarkan tanggal downlad. Di soal ini kita menggunakan bantuan MKDIR untuk membuat directory baru dan comman MV untuk memindahkan file yang sudah di download.

```
$(mkdir $(date +"%d-%m-%Y"))

$(mv Koleksi* /home/iamfadilahmad/uwu/$(date +"%d-%m-%Y"))
$(mv Foto.log /home/iamfadilahmad/uwu/$(date +"%d-%m-%Y"))
```

### 3C
Soal ini meminta kita untuk mendownload selain gambar dari soal 3A juga mendownload gambar kelinci dengan ketentuan selang-seling setiap harinya. Kita bisa menggunakan DATE untuk menentukan day of the year yang kemudian di modulo 2 untuk menentukan hari ganjil atau genap dalam tahun tersebut yang kemudian resultnya digunakan untuk menentukan gambar apa yang didownload di hari itu. Kemudian kita mengguanakan CASE untuk menentukan command mana yang digunakan di hari tersebut.

```
a=$(date "+%--j")

let mod=$a%2
```
### 3D
Pada soal ini kita diminta untuk ZIP file sebelumnya yang sudah didownload, yang kemudian kita beri password sesuai dengan tanggal zip tersebut dibuat.

### 3E
Soal ini meminta kita untuk membuat cron sesuai kriteria yang telah disebutkan, untuk proses zip kita bisa menggunakan script yang sudah ditulis di soal 3D dan unzipnya bisa kita tulis bersamaan dengan cron dengan menggunakan UNZIP diikuti pasword yang sudah dibuat diikuti rm untuk menghapus folder zip yang sudah tidak digunakan.
