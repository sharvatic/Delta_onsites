#!/bin/bash
k=1
House_num=$(awk 'NR>1 {print $2}' cityrec.txt)
for line in $House_num
do
(( k=k+1 ))

dist=$(sed "${k}q;d" cityrec.txt | awk '{print $3}')
city=$(sed "${k}q;d" cityrec.txt | awk '{print $4}')

if grep -q "$line $dist $city" Output.txt
then
  continue
fi

grep "$line $dist $city" cityrec.txt >New.txt
status=$(awk '{print $6}' New.txt)

i=0
sum=0
for stat in $status
do
((i=i+1))

if [ $stat == "No" ]
then
amt=$(sed "${i}q;d" New.txt | awk '{print $5}')
sum=`expr $sum + $amt`
fi
done
# Calculated sum of not paid incomes

tax=$(echo "$sum/5" | bc -l )

tax2=$(printf "%.2f" $tax)

echo "$line $dist $city $tax2" >>Output.txt

done
