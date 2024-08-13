#!/bin/bash

ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo You should run this script as root user or with sudo privileges.
  exit 1
fi

StatusCheck() {
  if [ $1 -eq 0 ]; then
    echo -e Status = "\e[32mSUCCESS\e[0m"
  else
    echo -e Status = "\e[31mFAILURE\e[0m"
    exit 1
  fi
}

#SCRIPT_NAME=$(echo $0 | cut -d "." -f )
LOGFILE=/tmp/mysql.log

echo "installing mysql"
dnf install mysql -y &>>$LOGFILE
StatusCheck $?

echo "removeing mysql"
yum remove mysqlllD -y  &>>$LOGFILE
StatusCheck $?
