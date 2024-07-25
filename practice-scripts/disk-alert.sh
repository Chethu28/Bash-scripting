#!/bin/bash

THERSHOLD=10
PARTITION='/dev/xvda1'
MAIL='chethanreddy.mp@gmail.com'

USAGE=$(df -h | grep /dev/xvda1 | awk 'NR==1' | awk '{print $5}' | sed 's/%//')

if [ $USAGE -gt $THERSHOLD ];
then 
        echo "Disk usage on $PARTITION is at ${USAGE}%, which exceeds the threshold of ${THRESHOLD}%." | mail -s "Disk Usage Alert" "$MAIL"
fi
