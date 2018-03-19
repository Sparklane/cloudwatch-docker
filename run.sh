#!/bin/bash

CRON=${CRON:-"*/5 * * * *"}
OPTIONS=${OPTIONS:-"--mem-util --swap-util --auto-scaling"}

echo "$CRON /opt/aws-scripts-mon/mon-put-instance-data.pl $OPTIONS" >> /etc/crontabs/root
cat /etc/crontabs/root 
crond -l 2 -f