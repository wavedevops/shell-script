#!/bin/bash

source common.sh


SOURCE_DIRECTORY=/tmp/app-logs
if [ -d $SOURCE_DIRECTORY ]
then
  echo -e " $G source directory exists $N "
else
  echo -e "$R source directory doesn't exits $N "
  exit 1
fi
FILES=$( find "$SOURCE_DIRECTORY" -name '*.log' -mtime +14)

while IFS= read -r line
do
  echo deleting file $line
  rm -rf $line
done <<< $FILES



#touch -d "2024-08-01 00:00:00" backend.log
#touch -d "2024-08-01 00:00:00" mysql.log
#touch -d "2024-08-01 00:00:00" prasad.log
#touch -d "2024-08-01 00:00:00" hari.log
#touch -d "2024-08-01 00:00:00" chandra.log