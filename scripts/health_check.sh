#!/bin/bash
source /home/ubuntu/toolkit/config/settings.conf


echo "===SYSTEM HEALTH CHECK ==="

echo "Uptime"
uptime 

echo "Disk usage"
df -h

echo "Memory usage"
free -h

echo "CPU usage"
top -bn1 | head -n 10

CURRENT_DISK=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$CURRENT_DISK" -ge "$DISK_WARNING_THRESHOLD" ]; then
    /home/ubuntu/toolkit/scripts/alert.sh "Disk usage is at ${CURRENT_DISK}%!"
else
    echo "Disk usage is normal: ${CURRENT_DISK}%"
fi