#!/bin/bash

LOGFILE=/var/log/mysql_remove.log

# Function to validate the success or failure of each command
VALIDATE() {
  if [ $1 -ne 0 ]; then
    echo "$2 - Failed" | tee -a $LOGFILE
    exit 1
  else
    echo "$2 - Success" | tee -a $LOGFILE
  fi
}

# Stopping MySQL Server
echo "Stopping MySQL Server..." | tee -a $LOGFILE
systemctl stop mysqld &>>$LOGFILE
VALIDATE $? "Stopping MySQL Server"

# Disabling MySQL Server
echo "Disabling MySQL Server..." | tee -a $LOGFILE
systemctl disable mysqld &>>$LOGFILE
VALIDATE $? "Disabling MySQL Server"

# Removing MySQL Server
echo "Removing MySQL Server and dependencies..." | tee -a $LOGFILE
dnf remove mysql-server -y &>>$LOGFILE
VALIDATE $? "Removing MySQL Server"

# Removing MySQL Data
echo "Removing MySQL data directories..." | tee -a $LOGFILE
rm -rf /var/lib/mysql /etc/my.cnf &>>$LOGFILE
VALIDATE $? "Removing MySQL data directories"

# Cleaning up unused packages
echo "Cleaning up unused packages..." | tee -a $LOGFILE
dnf autoremove -y &>>$LOGFILE
VALIDATE $? "Cleaning up unused packages"

echo "MySQL Server removal completed successfully!" | tee -a $LOGFILE
