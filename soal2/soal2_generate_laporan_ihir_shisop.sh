#!/bin/bash
data="Laporan-TokoShiSop.tsv"
awk -F "\t" '
BEGIN {max=0;maxid=0} {
	cost_price=($18-$21)
	profit_percentage=($21/cost_price)*100
	id=$1
	if(profit_percentage>=max)
	{
		max=profit_percentage
		maxid=id
	}
} END {printf "Transaksi terakhir dengan profit percentage terbesar yaitu %d dengan persentase %.2f%%.\n\n",maxid,max}' $data >> hasil.txt

awk -F "\t" '
BEGIN {print "Daftar nama customer di Albuquerque pada tahun 2017 antara lain:"}{
	if($10~"Albuquerque" && $3~"17")
	{
		array[$7]++
	}
}END {for(i in array) {print i} {printf "\n"}}' $data >> hasil.txt

awk -F "\t" '
BEGIN {segment="Consumer";min=0}{
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
} END {print "Tipe segmen customer yang penjualannya paling sedikit adalah",segment,"dengan",min,"transaksi.\n"}' $data >> hasil.txt


awk -F "\t" '
BEGIN {region="Central"}{
	array[$13]=array[$13]+$21
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
} END {print "Wilayah bagian (region) yang memiliki total keuntungan (profit) yang paling sedikit adalah",region,"dengan total keuntungan",min1}' $data >> hasil.txt
