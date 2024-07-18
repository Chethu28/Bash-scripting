#!/bin/bash
#

##path to the log file

FILE="/root/access.log"

#check if the file exists
#
#if exists, get the ips in the file. sort and check the occurences of the ips by getting the count and print the most occurred ip
if [ ! -f "$FILE" ]
then
        echo " log file not found"
        exit 1
else
        echo " analyzing the log file......"
       # sleep 10
        ADDR=$( cat $FILE | awk '{print $1}' | sort | uniq -c | sort -nr | head -n 1 )
        echo "$ADDR"
fi
