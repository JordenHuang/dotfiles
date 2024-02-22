#!/bin/bash

counter=5

: '
echo "Generate $counter random numbers:"
while [ $counter -gt 0 ]
do
    counter=$(($counter - 1))
    echo "Random number: $(($RANDOM % 100 + 1))"
done
'

# Generate system's gesture
system_gesture=$(( $RANDOM % 3 + 1))

echo "Paper Scissor Stone!"
echo "1 - Paper"
echo "2 - Scissors"
echo "3 - Stone"

# Ask the user to input, and check its validity
valid=0
while [ $valid -ne 1 ]
do
    echo "Enter your gesture:"
    read user_gesture
    valid=1
    if [ $user_gesture -lt 1 ] || [ $user_gesture -gt 3 ]
    then
        echo "You didn't enter an appropriate choice, please enter again!"
        valid=0
    fi
done


echo "Your choise:         $user_gesture"
echo "The system's choise: $system_gesture"

result=0
case $user_gesture in
    1) if [ $system_gesture -eq 1 ]
    then
        result=0
    elif [ $system_gesture -eq 3 ]
    then
        result=1
    else
        result=-1
        fi;;

    2) if [ $system_gesture -eq 2 ]
    then
        result=0
    elif [ $system_gesture -eq 1 ]
    then
        result=1
    else
        result=-1
        fi;;

    3) if [ $system_gesture -eq 3 ]
    then
        result=0
    elif [ $system_gesture -eq 2 ]
    then
        result=1
    else
        result=-1
    fi
esac

case $result in
    -1) echo "You lose";;
    0) echo "Game tie";;
    1) echo "You win"
esac
