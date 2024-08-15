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

# Get the current timestamp in the format YYYY-MM-DD-HH-MM-SS
TIMESTAMP=$(date +%F-%H-%M-%S)

# Get the script name without the extension
SCRIPT_NAME=$(echo "$0" | cut -d "." -f1)

# Set the log file path
LOGFILE=/tmp/$SCRIPT_NAME.log

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
