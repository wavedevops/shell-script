#!/bin/bash
#ID=$(id -u)
#if [ $ID -ne 0 ]; then
#  echo You should run this script as root user or with sudo privileges.
#  exit 1
#fi
#
#StatusCheck() {
#  if [ $1 -eq 0 ]; then
#    echo -e Status = "\e[32mSUCCESS\e[0m"
#  else
#    echo -e Status = "\e[31mFAILURE\e[0m"
#    exit 1
#  fi
#}
USERID=$(id -u)
SCRIPTNAME=$(echo $0 | cut -d "." -f )
LOGFILE=/tmp/$SCRIPTNAME.log

VALIDAATE(){
  if [ $1 -eq 0 ]; then
    echo -e Status = "\e[32mSUCCESS\e[0m"
  else
    echo -e Status = "\e[31mFAILURE\e[0m"
    exit 1
  fi
}
if [ $USERID -ne 0 ];
then
  echo "your a not sudo privilege"
  exit 1
else
  echo "your a supper user"
fi

echo "installing git"
dnf install mysql -y &>>$LOGFILE
VALIDAATE $?

echo "removeing git"
yum remove mysql -y  &>>$LOGFILE
VALIDAATE $?

}