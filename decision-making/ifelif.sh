#!/bin/bash

read -p "Enter the Num:" num

if [ $num -gt 100 ] 
then 
   echo "entered into if block"
   sleep 3
   echo "$num is greater than 100"
elif [ $num -eq 100 ]
then
   echo "entered into elif block"
   sleep 3
   echo "$num is equal to 100"
else  
   echo "entered into else block"
   sleep 3
   echo "$num is less than 100"
fi

