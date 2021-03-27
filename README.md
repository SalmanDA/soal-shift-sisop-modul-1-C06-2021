# soal-shift-sisop-modul-1-C06-2021

## Laporan Soal Nomor 1 :

### 1A
Dalam soal kami diminta untuk mengumpulkan informasi yang ada di file syslog.log. Informasi yang diperlukan jenis log, pesan log, dan username pada setiap baris log. Untuk menyelesaikan soal ini kami memakai bantuan REGEX dan GREP.

### 1B
Dalam soal 1b kami diminta menampilkan pesan error beserta jumlah kemunculannya. Dalam poin ini kami filtering menggunakan grep, kemudian gunakan fitur count untuk menghitung jumlah kemunculannya.

### 1C
Dalam soal 1c kami diminta untuk menampilkan jumlah kemunculan ERROR dan INFO untuk setiap usernya. Pada poin ini kami menggunakan bantuan filter grep untuk mencari string antara "ERROR\|INFO" kemudian di filter dengan sed untuk mengambil username, setelah itu pakai fitur sort and count.

### 1D
Dalam soal 1d diminta apa yang didapatkan di poin b, dituliskan kedalam file error_message.csv dengan header Error,Count yang kemudian diikuti pesan error dan di urutkan berdasar jumlah kemunculan dari error yang terbanyak. Step yang kami jalankan :

- Gunakan `echo` untuk print header kemudian masukan kedalam file error_message.csv
- Deklarasi sebuah variabel untuk menyimpan baris grep nanti
- untuk filtering soal yang diminta kami menggunakan `grep` kemudian string `"ERROR"` terhadap file yang diinginkan (syslog.log) kemudian gunakan fitur sed dengan filter `'s/.*` untuk mengambil string, kemudian `ERROR` mengambil string mulai dari setelah ERROR untuk mengambil tipe error, filter `\(.*)` untuk mengambil string tanpa syarat, regex `(.*` untuk batasan akhir pengambilan string, regex `/\1/g'` untuk menutup filtering. kemudian gunakan fitur sort, uniq -c untuk mengurutkan dan mengeluarkan nilai jumlah setelah string di groupping, diakhir ditambah sort -nr untuk menugrutkan mulai dari yang terbanyak.
- kami menggunakan for dengan variabel untuk looping hasil grep diatas line per line, kemudian pakai if else untuk kondisi, jika line tersebut angka maka simpan di variabel untuk hasil count tipe error tersebut, jika line itu mengandung "," maka kata tersebut termasuk akhir kalimat jadi di echo tipe error dan jumlahnya, jika line tersebut hanya mengandung huruf biasa echo kalimat tanpa new line.
- jika semua semua di looping hasilnya diinput kedalam file error_message.csv

### 1E
Dalam soal 1e diminta untuk menampilkan apa yang didapat di poin c, kemudian dituliskan ke file user_statistic.csv dengan header Username,INFO,ERROR berdasarkan username secara ascending.

- pertama untuk memulai mengerjakan soal kami menggunakan array yang menggunakan key string (userError) untuk menyimpan error yang dibuat oleh user, kemudian array orders untuk menyimpan key secara urut agar bisa digunakan pada array userError
- untuk filtering soal yang diminta kami menggunakan `grep` kemudian string `"ERROR"` terhadap file yang diinginkan (syslog.log) kemudian gunakan fitur sed dengan filter `'s/.*` untuk mengambil string, kemudian `(` mengambil string mulai dari setelah ( untuk username, filter `\(.*)` untuk mengambil string tanpa syarat, regex `).*` untuk batasan akhir pengambilan string, regex `/\1/g'` untuk menutup filtering. kemudian gunakan fitur sort dan uniq -c untuk mengurutkan dan mengeluarkan nilai jumlah setelah string di groupping.
- kami menggunakan for untuk looping hasil grep menyimpan di variable $eLine, kemudian looping dengan do & done, jika $eLine angka maka simpan di variabel $e sebagai jumlah error yang dihasilkan oleh user, kemudian jika huruf maka $eLine termasuk username dan simpan sebagai key array userError dengan value $e, tambahkan nilay array order untuk menyimpan username untuk nanti diurutkan.
- setelah filtering untuk error, kami menyiapkan tahap kedua untuk penulisan yang diminta soal, dengan echo header "Username,INFO,ERROR" kedalam file user_statistic.csv
- kemudian setelah memasukan header, untuk data yang dibutuhkan kami menggunakan filter `grep` kemudian gunakan fitur sed dengan filter `'s/.*` untuk mengambil string, kemudian `(` mengambil string mulai dari setelah ( untuk username, filter `\(.*)` untuk mengambil string tanpa syarat, regex `).*` untuk batasan akhir pengambilan string, regex `/\1/g'` untuk menutup filtering. kemudian gunakan fitur sort dan uniq -c untuk mengurutkan dan mengeluarkan nilai jumlah setelah string di groupping.
- kami menggunakan for untuk looping hasil grep, menyimpan dalam variabel $uLine, kemudian looping dengan do & done, jika $uLine hanya berisi angka maka simpan di variabel $x, jika bukan maka masuk else. Dalam else deklarasikan terlebih dahulu $errorCount=0 untuk menandakan bahwa apakah user membuat error apa tidak, kemudian looping dengan for untuk mengambil key dalam array orders, looping dengan do & done dan gunakan kondisi cek apakah $key sama dengan $uLine, jika sama berarti user tersebut pernah melakukan error kemudian echo username, jumlah info yang telah dikurangi error, jumlah error. Ubah errorCount menjadi 1 sebagai tanda, supaya lebih efisien di break agar tidak perlu looping ke yang lainnya. Jika errorCount sama dengan 0 maka user tersebut tidak pernah melakukan error sehingga echo username,$x,0 karena $x sudah pasti hanya mengandung info dan error berjumlah 0
- setelah semua selesai di looping dan di echo masukan hasil kedalam file user_statistics.csv


## Laporan Soal Nomor 2 :

### 2A
Pada soal ini, diminta untuk menampilkan row ID terbesar dengan persentase profit terbesar. Pada pengerjaan soal ini kami menghitung besarnya persentase profit dari setiap row ID dan membandingkannya dengan row ID yang selanjutnya. Jika ditemukan row ID yang persentase profitnya lebih besar dari persentase profit row ID yang sebelumnya, maka nilai persentase profit dan row IDnya akan disimpan ke variabel max dan maxid yang akan menjadi output dari program ini.

### 2B
Supaya mendapatkan consumer yang melakukan transaksi pada tahun 2017, maka kami melakukan pengecekan pada kolom Order Date yang mengandung substring "17". Jika ditemukan consumer yang melakukan order pada tahun 2017, maka nama consumer tersebut akan disimpan sebagai indeks dari array yang memiliki nilai positif. Saat semua tanggal pemesanan selesai diperiksa, kami keluarkan nama-nama yang dijadikan indeks array tadi menggunakan for looping.

### 2C
Kami menggunakan array untuk menyimpan banyaknya transaksi dari suatu segment consumer dengan nama segment sebagai indeksnya. Berikutnya kami mengecek setiap baris dan menambahkan nilai array dengan nama indeks dan nama segment yang sesuai. Contohnya setiap ditemukan transaksi di segment consumer, maka nilai array["Consumer"] akan bertambah. Setelah semua baris selesai diperiksa, dilakukan perbandingan antara segment Consumer, Home Office dan Corporate untuk mendapatkan segment mana yang melakukan transaksi paling kecil.

### 2D
Pengerjaan soal ini hampir sama dengan pengerjaan soal 2C. Pertama megidetifikasi setiap baris apakah regionnya termasuk ke Central, South, East atau West lalu menambahkan profit dari  baris tersebut ke array dengan indeks berupa nama region. Pada akhir program, semua region dibandingkan jumlah profitnya dan yang memiliki jumlah profit paling kecil akan menjadi output.

### 2E
Output dari semua soal nomor 2 diletakkan pada file hasil.txt.