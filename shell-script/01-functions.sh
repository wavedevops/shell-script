#!/bin/bash

USERID=$(id -u)
SCRIPTNAME=$(echo $0 | cut -d "." -f )
LOGFILE=/tmp/$SCRIPTNAME.log

W="\e[0m"
R="\e[31m"
G="\e[32m"

VALIDAATE(){
  if [ $1 -ne 0 ];
  then
    echo "$2 ...$R FAILURE $W"
    exit 1
  else
    echo "$2 ...$R SUCCESS $W"
  fi
}


if [ $USERID -ne 0 ];
then
  echo "your a not sudo privilege"
  exit 1
else
  echo "your a supper user"
fi

dnf install git -y &>>$LOGFILE
VALIDAATE $? "installing git"

dnf remove git -y  &>>$LOGFILE
VALIDAATE $? "installing git"
