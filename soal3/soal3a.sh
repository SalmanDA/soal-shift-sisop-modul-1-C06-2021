#!/bin/bash

#looping
a=0

declare -a array_compare[23]
while [ $a -lt 23 ]
do
	let b=$a+1
	wget -o Foto.log -O /home/iamfadilahmad/uwu/Koleksi_$b 'http://loremflickr.com/320/240/kitten'
	array_compare[$a]=$(awk 'NR==10{print $3}' Foto.log)
	echo ${array_compare[a]}

	#if [ $a -gt 0 ]
	#then	let c=$a-1
	#	while [ $c -ge 0 ]
	#	do	if [ "${array_compare[$a]}" = "${array_compare[$c]}" ];
	#		then	rm -v "Koleksi_b"
	#		echo $c
	#		echo $a
	#		echo $b
	#		let b=$b-1
	#		fi
	#	done
	#fi 
	a=$((a+1))
done



