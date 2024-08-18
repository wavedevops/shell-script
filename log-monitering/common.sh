#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
if [ $1 -ne 0 ]
then
  echo -e "$2...$R FAILURE $N"
  exit 1
else
  echo -e "$2...$G SUCCESS $N"
fi
}

if [ $USERID -ne 0 ]
then
  echo " $R Please run this script with root access. $N"
  exit 1 # manually exit if error comes.
else
  echo " $S You are super user. $N "
fi

