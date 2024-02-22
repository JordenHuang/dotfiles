#!/bin/bash

directory=/etc
info_file=find_info.txt
error_file=find_error.txt


echo -n "Do you really want to execute this script? (y/n/c : \"yes/no/clear log file\") "
read user_input

if [[ "$user_input" == "c" ]] || [[ "$user_input" == "C" ]]; then
    if [ -f $info_file ] && [ -f $error_file ]; then
        echo "clear log files"
        rm $info_file $error_file
    else
        echo "log file not exist"
    fi
elif [[ "$user_input" != "y" ]] && [[ "$user_input" != "Y" ]]; then
    echo "exit"
else
    find $directory -type f >$info_file 2>$error_file
    echo "done"
fi
