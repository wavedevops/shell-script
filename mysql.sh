#!/bin/bash

#source common.sh
#
#dnf install mysql-server -y &>>$LOGFILE
#VALIDATE $? "Installing MySQL Server"
#
#systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "Enabling MySQL Server"
#
#systemctl start mysqld &>>$LOGFILE
#VALIDATE $? "Starting MySQL Server"
#
## mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
## VALIDATE $? "Setting up root password"
#
##Below code will be useful for idempotent nature
#mysql -h mysql.chowdary.cloud -uroot -pExpenseApp@1 -e 'show databases;' &>>$LOGFILE
#if [ $? -ne 0 ]
#then
#    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
#    VALIDATE $? "MySQL Root password Setup"
#else
#    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
#fi
##  mysql_secure_installation --set-root-pass ExpenseApp@1 &>>LOGFILE


#!/bin/bash

LOGFILE=/var/log/mysql_install.log

# Function to validate the execution of commands
VALIDATE() {
  if [ $1 -eq 0 ]; then
    echo "$2... SUCCESS" &>>$LOGFILE
  else
    echo "$2... FAILURE" &>>$LOGFILE
    exit 1
  fi
}

# Check if the script is run as root
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
else
  echo "You are super user."
fi

# Install MySQL Server
dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySQL Server"

# Enable MySQL service
systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling MySQL Server"

# Start MySQL service
systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting MySQL Server"

# Check if the MySQL root password is set by trying to list databases
mysql -h localhost -uroot -pExpenseApp@1 -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]; then
    # If the root password isn't set or is incorrect, set it using mysql_secure_installation
    echo -e "\nSetting up MySQL root password..."
    mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
    VALIDATE $? "MySQL Root password Setup"
else
    echo "MySQL Root password is already set... SKIPPING" &>>$LOGFILE
fi

echo "MySQL installation and setup is complete."
