#!/bin/bash


# Variable Declaration
#SVC="httpd"
TEMPDIR="/tmp/web"
#PACKAGE="wget zip unzip "
ART_URL="https://www.tooplate.com/zip-templates/2133_moso_interior.zip"
ART="2133_moso_interior"

yum --help > /dev/null

if [ $? -eq 0 ]
then
   # seeting variables for centos
   SVC="httpd"
   PACKAGE="wget zip unzip httpd"
   # Installing Dependencies
   echo "#########################################"
   echo "Installing Dependencies"
   echo "#########################################"
   sudo yum install $PACKAGE -y > /dev/null

   # Start and enable the httpd service
   echo "#########################################"
   echo " Start and enable the $SVC service"
   echo "#########################################"
   echo
   sudo systemctl start $SVC
   sudo systemctl enable $SVC

   #Creating temp Directory
   echo "#########################################"
   echo "creating temp directory"
   echo "#########################################"
   echo 
   mkdir $TEMPDIR
   cd $TEMPDIR
   wget $ART_URL
   unzip $ART.zip > /dev/null
   sudo cp -r $ART/* /var/www/html


   # Bounce Service
   echo "########################################"
   echo "Restarting $SVC service"
   echo "########################################"
   systemctl restart $SVC
   echo

   # Clean Up
   echo "########################################"
   echo "Removing Temporary Files"
   echo "########################################"
   rm -rf $TEMPDIR
   echo
 else
   # seeting variables for ubuntu
   SVC="apache2"
   PACKAGE="wget zip unzip apache2"
   # Installing Dependencies
   echo "#########################################"
   echo "Installing Dependencies"
   echo "#########################################"
   sudo apt update
   sudo apt install $PACKAGE -y > /dev/null

   # Start and enable the httpd service
   echo "#########################################"
   echo " Start and enable the $SVC service"
   echo "#########################################"
   echo
   sudo systemctl start $SVC
   sudo systemctl enable $SVC

   #Creating temp Directory
   echo "#########################################"
   echo "creating temp directory"
   echo "#########################################"
   echo 
   mkdir $TEMPDIR
   cd $TEMPDIR
   wget $ART_URL
   unzip $ART.zip > /dev/null
   sudo cp -r $ART/* /var/www/html


   # Bounce Service
   echo "########################################"
   echo "Restarting $SVC service"
   echo "########################################"
   systemctl restart $SVC
   echo

   # Clean Up
   echo "########################################"
   echo "Removing Temporary Files"
   echo "########################################"
   rm -rf $TEMPDIR
   echo
fi
