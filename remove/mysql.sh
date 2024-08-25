#!/bin/bash

#LOGFILE=/var/log/mysql_remove.log
#
## Function to validate the success or failure of each command
#VALIDATE() {
#  if [ $1 -ne 0 ]; then
#    echo "$2 - Failed" | tee -a $LOGFILE
#    exit 1
#  else
#    echo "$2 - Success" | tee -a $LOGFILE
#  fi
#}
#
## Stopping MySQL Server
#echo "Stopping MySQL Server..." | tee -a $LOGFILE
#systemctl stop mysqld &>>$LOGFILE
#VALIDATE $? "Stopping MySQL Server"
#
## Disabling MySQL Server
#echo "Disabling MySQL Server..." | tee -a $LOGFILE
#systemctl disable mysqld &>>$LOGFILE
#VALIDATE $? "Disabling MySQL Server"
#
## Removing MySQL Server
#echo "Removing MySQL Server and dependencies..." | tee -a $LOGFILE
#dnf remove mysql-server -y &>>$LOGFILE
#VALIDATE $? "Removing MySQL Server"
#
## Removing MySQL Data
#echo "Removing MySQL data directories..." | tee -a $LOGFILE
#rm -rf /var/lib/mysql /etc/my.cnf &>>$LOGFILE
#VALIDATE $? "Removing MySQL data directories"
#
## Cleaning up unused packages
#echo "Cleaning up unused packages..." | tee -a $LOGFILE
#dnf autoremove -y &>>$LOGFILE
#VALIDATE $? "Cleaning up unused packages"
#
#echo "MySQL Server removal completed successfully!" | tee -a $LOGFILE



#LOGFILE=/var/log/mysql_remove.log
#
## Function to validate the execution of commands
#VALIDATE() {
#  if [ $1 -eq 0 ]; then
#    echo "$2 - SUCCESS" &>>$LOGFILE
#  else
#    echo "$2 - FAILED" &>>$LOGFILE
#    exit 1
#  fi
#}
#
## Stop MySQL service
#systemctl stop mysqld &>>$LOGFILE
#VALIDATE $? "Stopping MySQL Server"
#
## Disable MySQL service
#systemctl disable mysqld &>>$LOGFILE
#VALIDATE $? "Disabling MySQL Server"
#
## Remove MySQL packages
#dnf remove mysql-server mysql -y &>>$LOGFILE
#VALIDATE $? "Removing MySQL packages"
#
## Remove MySQL data directory
#rm -rf /var/lib/mysql &>>$LOGFILE
#VALIDATE $? "Removing MySQL data directory"
#
## Remove MySQL configuration files
#rm -rf /etc/my.cnf /etc/mysql /etc/my.cnf.d /etc/mysql.d /etc/my.cnf.* &>>$LOGFILE
#VALIDATE $? "Removing MySQL configuration files"
#
## Remove MySQL logs
#rm -rf /var/log/mysql* &>>$LOGFILE
#VALIDATE $? "Removing MySQL logs"
#
## Optionally, remove any MySQL user accounts created
#userdel -r mysql &>>$LOGFILE
#VALIDATE $? "Removing MySQL user account"
#
## Clean up dnf caches
#dnf clean all &>>$LOGFILE
#VALIDATE $? "Cleaning up DNF caches"
#
## Remove MySQL root password entry from the system
## This is optional and only if you wish to remove any saved credentials
#unset MYSQL_ROOT_PASSWORD &>>$LOGFILE
#VALIDATE $? "Removing MySQL root password from the environment"
#
#echo "MySQL has been completely removed from the system." &>>$LOGFILE


# Stop MySQL service
systemctl stop mysqld

# Start MySQL in safe mode, bypassing password authentication
mysqld_safe --skip-grant-tables &

# Log in to MySQL as root without a password
mysql -u root

# Once logged in, reset the root password
USE mysql;
UPDATE user SET authentication_string=PASSWORD('ExpenseApp@1') WHERE User='root';
FLUSH PRIVILEGES;
EXIT;

# Stop the safe mode MySQL service
killall mysqld_safe

# Restart MySQL service normally
systemctl start mysqld
