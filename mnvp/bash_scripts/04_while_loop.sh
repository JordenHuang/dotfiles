#!/bin/bash

filename=testfile
t=0

if [ ! -f $filename ]
then
    echo "Creating $filename..."
    touch $filename
    echo "Done"
    sleep 2
fi



while [ -f $filename ]
do
    echo "As of $(date), the $filename exists"
    t=$(($t + 1))
    sleep 1

    if [ $t -eq 10 ]
    then
        rm $filename
    fi
done

echo "As of $(date), the $filename is missing"
