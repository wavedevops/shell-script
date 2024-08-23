#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
if [ $1 -ne 0 ]
then
  echo -e "$2...$R FAILURE $N"
  exit 1
else
  echo -e "$2...$G SUCCESS $N"
fi
}

if [ $USERID -ne 0 ]
then
  echo "Please run this script with root access."
  exit 1 # manually exit if error comes.
else
  echo "You are super user."
fi


dnf install nginx -y &>>$LOGFILE
VALIDATE $? "install nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "enable nginx"

systemctl restart nginx &>>$LOGFILE
VALIDATE $? "restart nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATE $? "remove old html file "

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "download frontend zip"

cd /usr/share/nginx/html &>>$LOGFILE
unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "Extracting frontend code"

### RHEL
#check your repo and path
#cp /home/ec2-user/shell-script/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
#VALIDATE $? "Copied expense conf"

## centos
cp /root/shell-script/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copied expense conf"

systemctl enable nginx &>>$LOGFILE
systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarted nginx"
