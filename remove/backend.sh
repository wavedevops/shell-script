#!/bin/bash

LOGFILE=/var/log/remove_expense_app.log

# Function to validate the success or failure of each command
VALIDATE() {
  if [ $1 -ne 0 ]; then
    echo "$2 - Failed" | tee -a $LOGFILE
    exit 1
  else
    echo "$2 - Success" | tee -a $LOGFILE
  fi
}

# Stopping and disabling the backend service
echo "Stopping and disabling backend service..." | tee -a $LOGFILE
systemctl stop backend &>>$LOGFILE
VALIDATE $? "Stopping backend service"
systemctl disable backend &>>$LOGFILE
VALIDATE $? "Disabling backend service"

# Removing backend service file
echo "Removing backend service file..." | tee -a $LOGFILE
rm -f /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Removing backend service file"

# Reload systemd daemon
echo "Reloading systemd daemon..." | tee -a $LOGFILE
systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Reloading systemd daemon"

# Removing application files and directories
echo "Removing application files..." | tee -a $LOGFILE
rm -rf /app &>>$LOGFILE
VALIDATE $? "Removing application files"

# Removing the expense user
echo "Removing the expense user..." | tee -a $LOGFILE
userdel expense &>>$LOGFILE
VALIDATE $? "Removing expense user"
rm -rf /home/expense &>>$LOGFILE
VALIDATE $? "Removing expense user's home directory"

# Removing Node.js
echo "Removing Node.js..." | tee -a $LOGFILE
dnf remove nodejs -y &>>$LOGFILE
VALIDATE $? "Removing Node.js"

# Disabling Node.js module
echo "Disabling Node.js module..." | tee -a $LOGFILE
dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "Disabling Node.js module"

# Removing MySQL client
echo "Removing MySQL client..." | tee -a $LOGFILE
dnf remove mysql -y &>>$LOGFILE
VALIDATE $? "Removing MySQL client"

# Cleaning up unused packages
echo "Cleaning up unused packages..." | tee -a $LOGFILE
dnf autoremove -y &>>$LOGFILE
VALIDATE $? "Cleaning up unused packages"

echo "Expense app removal completed successfully!" | tee -a $LOGFILE
