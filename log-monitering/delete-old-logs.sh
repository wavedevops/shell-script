#!/bin/bash

N="\e[0m"
R="\e[31m]"
G="\e[32m"

SOURCE_DIRECTORY=/tmp/app-logs

if [ -d $SOURCE_DIRECTORY ]
then
     echo -e "$G source directory already exists $N"
else
     echo -e "$R $SOURCE_DIRECTORY does not exits $N"
     exit 1
fi

FILES=$( find $SOURCE_DIRECTORY -name '*.log' -mtime +14)

while IFS= read -r line
do
    echo "Deleting file: $line"
    rm -rf $line
done <<< $FILES