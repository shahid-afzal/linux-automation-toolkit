#!/bin/bash

source /home/ubuntu/toolkit/config/settings.conf

TIMESTAMP=$(date +%"Y-%m-%d_%H-%M")

tar -czf /home/ubuntu/toolkit/backups/backup_etc_$TIMESTAMP.tar.gz $BACKUP_TARGET

if [ $? -eq 0 ]; then
    echo "Backup Sucessfull"
else 
    /home/ubuntu/toolkit/scripts/alert.sh "Failed to backup ${BACKUP_TARGET}"
fi