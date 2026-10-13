#!/bin/bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")

find /tmp -type f -mtime +7 -exec rm -f {} \;

if [ $? -eq 0 ]; then
    echo "Successfully deleted the temp files on ${TIMESTAMP}"
else    
    /home/ubuntu/toolkit/scripts/alert.sh "Failed to remove the temp files"
fi 