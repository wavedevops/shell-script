#!/bin/bash

#USERID=$(id -u)
#TIMESTAMP=$(date +%F-%H-%M-%S)
#SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
#LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
#R="\e[31m"
#G="\e[32m"
#Y="\e[33m"
#N="\e[0m"
#
#VALIDATE(){
#   if [ $1 -ne 0 ]
#   then
#        echo -e "$2...$R FAILURE $N"
#        exit 1
#    else
#        echo -e "$2...$G SUCCESS $N"
#    fi
#}
#
#if [ $USERID -ne 0 ]
#then
#    echo "Please run this script with root access."
#    exit 1 # manually exit if error comes.
#else
#    echo "You are super user."
#fi
#
#for i in $@
#do
#    echo "package to install: $i"
#    dnf list installed $i &>>$LOGFILE
#    if [ $? -eq 0 ]
#    then
#        echo -e "$i already installed...$Y SKIPPING $N"
#    else
#        dnf install $i -y &>>$LOGFILE
#        VALIDATE $? "Installation of $i"
#    fi
#done
#
#for i in $@
#do
#    echo "package to install: $i"
#    dnf list installed $i &>>$LOGFILE
#    if [ $? -eq 0 ]
#    then
#        echo -e "$i already installed...$Y SKIPPING $N"
#    else
#        dnf install $i -y &>>$LOGFILE
#        VALIDATE $? "Installation of $i"
#    fi
#done



# Check if the script is being run as root
ID=$(id -u)
if [ $ID -ne 0 ]; then
  echo "You should run this script as root user or with sudo privileges."
  exit 1
fi

# Function to check the status of the last executed command
StatusCheck() {
  if [ $1 -eq 0 ]; then
    echo -e "Status = \e[32mSUCCESS\e[0m"  # Green color for success
  else
    echo -e "Status = \e[31mFAILURE\e[0m"  # Red color for failure
    exit 1
  fi
}

# Define log file location
LOGFILE=/tmp/hari.log
# Install MySQL and check the status
echo "Installing MySQL"
dnf install mysql -y &>>$LOGFILE
StatusCheck $?


echo "sleep 5 seconds"
sleep 5
StatusCheck $?

# Intentionally incorrect command to demonstrate FAILURE status
echo "Removing MySQL (with incorrect command)"
yum remove mysqllll -y &>>$LOGFILE
StatusCheck $?
