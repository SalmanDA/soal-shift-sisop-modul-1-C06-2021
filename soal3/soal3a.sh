#!/bin/bash

#looping
a=0

## Looping download
while [ $a -lt 23 ]
do
	let b=$a+1
	wget -q -a Foto.log -O /home/iamfadilahmad/uwu/Koleksi_$b 'http://loremflickr.com/320/240/kitten'

	##Collecting necessary hash value to compare
	test[$a]="$(md5sum Koleksi_$b | awk '{print $1;}')"

	##Comparing
	for(( c=a-1; c>=0; c=c-1 ))
	do
		if [[ "${test[$a]}" == "${test[$c]}" ]];
		then
		rm Koleksi_$b
		b=$((b-1))
		fi
	done

	## increase counter
	a=$((a+1))
done




