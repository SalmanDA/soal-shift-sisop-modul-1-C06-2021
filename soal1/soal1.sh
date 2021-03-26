#!/bin/sh
########################
#KELOMPOK C06 SISOP 2021
#SOAL NOMOR 1 - Praktikum 1
#Achmad Fadillah 155
#Salman Damai Alfariq 159
#Ishaq Adheltyo 167
#########################

#NOMOR 1A dan NOMOR 1B

#while read line
#do
#	echo $line;
#	i=$((i + 1));

#done < $location/syslog.log
#echo $i;

#grep "ERROR" $location/syslog.log
#echo "Count Error: "; grep "ERROR" $location/syslog.log | grep -i -c "ERROR"

#End of NOMOR 1A and 1B

#NOMOR 1D

echo "Error,Count" >> error_message.csv
i="0";
for Line in `grep "ERROR" syslog.log | sed 's/.*ERROR \(.*\) (.*/\1,/g' | sort | uniq -c | sort -nr`
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

#End of NOMOR 1D

#NOMOR 1E
declare -A userError;
declare -a orders;
e="0";

for eLine in `grep "ERROR" syslog.log | sed 's/.*(\(.*\)).*/\1/g' | sort | uniq -c`
do 
	if [[ "$eLine" =~ [0-9] ]];
       then
               e=$eLine
       else
              userError[$eLine]=$e; orders+=($eLine)
      fi

done

echo "Username,INFO,ERROR" >> user_statistic.csv
x="0";
for uLine in `grep 'INFO\|ERROR' syslog.log | sed 's/.*(\(.*\)).*/\1/g' | sort | uniq -c`
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

#End of NOMOR 1E
