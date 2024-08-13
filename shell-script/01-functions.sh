#!/bin/bash

# Check if the script is being run as root
ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo "You should run this script as root user or with sudo privileges."
  exit 1
fi

# Function to check the status of the last executed command
StatusCheck() {
  if [ $1 -eq 0 ]; then
    echo -e "Status = \e[32mSUCCESS\e[0m"
  else
    echo -e "Status = \e[31mFAILURE\e[0m"
    exit 1
  fi
}

# Define log file location
LOGFILE=/tmp/mysql.log

# Install MySQL and check the status
echo "Installing nginx"
dnf install nginx -y &>>$LOGFILE
StatusCheck $?

echo "sleep 30 seconds"
sleep 30
StatusCheck $?

# Remove MySQL and check the status
echo "Removing nginx "
yum remove nginx -y &>>$LOGFILE
StatusCheck $?
