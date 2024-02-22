#!/bin/bash

for num in {1..3}
do
    echo $num
    sleep $num
    echo $(date) >> time.txt
done
echo >> time.txt


for i in {1..5}; do
    for j in {1..5}; do
        if [ $j -le $i ]; then
            echo -n "▮"
        fi
    done
    echo
done

if [ $i -eq 5 ];
then echo "i equals to 5"
else echo "i NOT equals to 5"
fi
