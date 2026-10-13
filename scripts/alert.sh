#!/bin/bash

# $1 is the first argument passed to the script
MESSAGE=$1
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# 1. Log the event (as required by your diagram)
echo "[$TIMESTAMP] CRITICAL ALERT: $MESSAGE" >> /home/ubuntu/toolkit/logs/alerts.log

# Print a loud, red alert to the terminal
echo -e "\e[31m🚨 DEV-OPS ALERT: $MESSAGE 🚨\e[0m"