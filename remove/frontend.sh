#!/bin/bash

LOGFILE=/var/log/remove_nginx_expense_app.log

# Function to validate the success or failure of each command
VALIDATE() {
  if [ $1 -ne 0 ]; then
    echo "$2 - Failed" | tee -a $LOGFILE
    exit 1
  else
    echo "$2 - Success" | tee -a $LOGFILE
  fi
}

# Stopping and disabling Nginx service
echo "Stopping and disabling Nginx service..." | tee -a $LOGFILE
systemctl stop nginx &>>$LOGFILE
VALIDATE $? "Stopping Nginx service"
systemctl disable nginx &>>$LOGFILE
VALIDATE $? "Disabling Nginx service"

# Removing Nginx
echo "Removing Nginx..." | tee -a $LOGFILE
dnf remove nginx -y &>>$LOGFILE
VALIDATE $? "Removing Nginx"

# Removing Nginx configuration and HTML files
echo "Removing Nginx configuration and HTML files..." | tee -a $LOGFILE
rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "Removing HTML files"
rm -f /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Removing expense Nginx configuration"

# Cleaning up unused packages
echo "Cleaning up unused packages..." | tee -a $LOGFILE
dnf autoremove -y &>>$LOGFILE
VALIDATE $? "Cleaning up unused packages"

# Reloading systemd daemon
echo "Reloading systemd daemon..." | tee -a $LOGFILE
systemctl daemon-reload &>>$LOGFILE
VALIDATE $? "Reloading systemd daemon"

echo "Nginx and related components removal completed successfully!" | tee -a $LOGFILE
