#!/bin/bash

lines=$(ls -l $1 | wc -l)

if [ $# -ne 1 ]; then
    echo "The number of arguments needs to be EXACTLY one"
    echo "Please enter again"
    exit 1
fi

echo "There are $((lines - 1)) items in the $1 directory"
