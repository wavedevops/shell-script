#!/bin/bash

source common.sh


SOURCE_DIRECTORY=/tmp/app-logs
if [ -d $SOURCE_DIRECTORY ]
then
  echo " $G source directory exists $N "
else
  echo "$R source directory doesn't exits $N "
  exit 1
fi
FILES=$( find "$SOURCE_DIRECTORY" -name '*.log' -mtime +14)

while IFS= read -r line
do
  echo deleting file $line
#  rm -rf $line
done <<< $FILES