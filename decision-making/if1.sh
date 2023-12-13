#!/bin/bash

read -p "Enter the Num:" num

if [ $num -gt 100 ] 
then 
   echo "entered into if block"
   sleep 3
   echo "$num is greater than 100"
else  
   echo "$num is less than 100"
fi

