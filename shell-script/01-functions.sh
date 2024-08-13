#!/bin/bash

# Check if the script is being run as root
ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo "You should run this script as root user or with sudo privileges."
  exit 1
fi

# Function to check the status of the last executed command
StatusCheck() {
  if [ $1 -ne 0 ]; then
    echo -e "Status = \e[31mFAILURE\e[0m"
    exit 1
  else
    echo -e "Status = \e[32mSUCCESS\e[0m"
  fi
}

# Define log file location
LOGFILE=/tmp/mysql.log

# Install MySQL and check the status
echo "Installing MySQL"
dnf install mysql -y &>>$LOGFILE
StatusCheck $?

# Remove MySQL and check the status
echo "Removing MySQL"
yum remove mysqlll -y &>>$LOGFILE
StatusCheck $?
