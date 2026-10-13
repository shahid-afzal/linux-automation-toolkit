#!/bin/bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")

gzip -c /home/ubuntu/toolkit/logs/health.log > /home/ubuntu/toolkit/logs/health_$TIMESTAMP.log.gz

> /home/ubuntu/toolkit/logs/health.log