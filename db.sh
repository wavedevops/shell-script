#!/bin/bash

# Get the current user ID
USERID=$(id -u)
# Check if the user is root (user ID 0)
if [ "$USERID" -ne 0 ]; then
  echo "Please run this script with root access."
  exit 1
else
  echo "You are super user."
fi



# Define color codes for output
R="\e[31m"   # Red
G="\e[32m"   # Green
Y="\e[33m"   # Yellow
N="\e[0m"    # Reset color (No color)

# Now you can use these variables and color codes in your script


# Define the VALIDATE function
VALIDATE(){
  if [ "$1" -ne 0 ]; then
    echo -e "$2...$R FAILURE $N"
    exit 1
  else
    echo -e "$2...$G SUCCESS $N"
  fi
}


TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log

dnf install mysql-server -y &>>LOGFILE
VALIDATE $? "install mysql"

systemctl enable mysqld &>>LOGFILE
VALIDATE $? "enable mysql server"

systemctl start mysqld &>>LOGFILE
VALIDATE $? "start mysql server"

#mysql_secure_installation --set-root-pass ExpenseApp@1
#VALIDATE $? "setup mysql server root password"

mysql -h 172.31.94.9 -uroot -pExpenseApp@1 -e 'show databases;' &>>LOGFILE
if [ $? -eq 0 ]; then
  echo -e "$Y mysql already exists $N"
else
  mysql_secure_installation --set-root-pass ExpenseApp@1 &>>LOGFILE
  VALIDATE $? "setup mysql root password"
fi
