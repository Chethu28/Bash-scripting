#!/bin/bash
#
#
#input the directory name
#
read -p "enter the directory:" FOLDER
echo "$FOLDER"

#create a report file to save the output

touch report.txt

# check if the entered folder exits
#
#if folder exits, iterate to each file in the directory and get the size and last modified date of the files
#
if [ ! -d $FOLDER ]
then
        echo "please provide valid folder name"
        exit 1
else 
        for FILE in "$FOLDER"/*
        do
                SIZE=$(stat -c%s $FILE)
                MOD_DATE=$(stat -c%y $FILE)
                echo " $FILE size is $SIZE and last modified date is $MOD_DATE" >>report.txt
        done
fi

#print the content in the report file

cat report.txt
