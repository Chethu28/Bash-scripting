#!/bin/bash 

SERVICE_NAME='httpd'

if [ $UID -eq 0 ]
then 
        if systemctl is-active --quiet $SERVICE_NAME 
        then 
                echo "$SERVICE_NAME is running "
        else
                echo "$SERVICE_NAME is not running"
                systemctl start $SERVICE_NAME
        fi 
else 
        echo "Please run the script using root user"
        exit 1
fi
