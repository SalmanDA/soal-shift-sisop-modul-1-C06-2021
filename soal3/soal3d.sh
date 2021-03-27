#!/bash/bin

a=$(date +"%d%m%Y")


zip -r -P $a Koleksi.zip Kucing_* Kelinci_*
rm -r Kucing_* Kelinci_*
