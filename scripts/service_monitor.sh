#!/bin/bash

CRON_STATUS=$(systemctl is-active cron)

if [ "$CRON_STATUS" = "inactive" ]; then
    /home/ubuntu/toolkit/scripts/alert.sh "Cron is inactive. Starting Cron service....."
    sudo systemctl restart cron
else
    echo "Cron is active"
fi

