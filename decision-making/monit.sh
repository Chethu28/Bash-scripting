#!/bin/bash



#Checking the httpd service is active or not if not starting the service
echo "###############################"
ls /var/run/httpd/httpd.pid

if [ $? -eq 0 ]
then 
   echo "httpd service is running"
else
   echo "Installing the service"	
   sudo yum install httpd -y > /dev/null
   systemctl start httpd 
   if [ $? -eq 0 ]
   then 
      echo "HTTPD service started succesfully"
   else
      echo "starting httpd service failed contact the system admin"
   fi
fi

