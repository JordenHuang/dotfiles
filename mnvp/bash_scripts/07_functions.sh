#!/bin/bash

repeat_myself(){
    local counter=$1
    echo "I will repeat myself $counter times!"
    counter=$(($counter-1))
    sleep 1

    if [ $counter -gt 0 ]
    then
        repeat_myself $counter
    fi

    echo "Leaving $counter"
}

echo -n "How many times would you like to repeat? "
read times
repeat_myself $times
