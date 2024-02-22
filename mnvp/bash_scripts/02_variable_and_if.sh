#!/bin/bash

command=/usr/bin/htop

if [ -f $command ]
then
    echo "$command is available, start running..."
    sleep 2
    $command
else
    echo "$command NOT found, installing it..."
    sleep 1
    sudo apt install $command
fi
