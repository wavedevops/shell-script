#!/bin/bash

N='\e[0m'
R='\e[31m'
G='\e[32m'
Y='\e[33m'

DISK_SPACE=$(df -hT | grep xfs)
DISK_THRESHOL="70"

while IFS= read -r line
do
   USAGE=$(echo $line | awk -F " " '{print $6F}' | cut -d '%' -f1) 
   FOLDER=$(echo $line | awk -F " " '{print $NF}')
   if [ $USAGE -ge $DISK_THRESHOL ]
   then
       echo -e " $Y $FOLDER $N is more than $G $DISK_THRESHOL $N, current usage is :$R $USAGE $N"
   fi
done <<< $DISK_SPACE