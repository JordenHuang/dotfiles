#!/bin/bash

directory=/notexist

if [ -d $directory ]
then
    echo "The exit code is: $?"
    echo "The directory: $directory exists"
    exit 0
else
    echo "The exit code is: $?"
    echo "The directory: $directory NOT found"
    exit 1
fi
