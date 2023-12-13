#!/bin/bash


# creating the user given in the list

list="chethan vicky ricky suman"
for user in $list
do 
 echo "creating the user: $user"
 echo "##########################"
 useradd $user
 echo "##########################"
 id $user
done

echo "user creation completed"
