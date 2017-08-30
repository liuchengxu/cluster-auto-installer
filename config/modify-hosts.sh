#!/usr/bin/env bash

# ip_hostname.txt:
# ip:hostname
for line in $(cat ip_hostname.txt); do
    ip=${line%%:*}
    hostname=${line##*:}
    echo "$ip    $hostname" >> /etc/hosts
done

MASTER="172.104.76.231"
HOSTANME="Master"
echo  "$MASTER    $HOSTANME" >> /etc/hosts

echo "/etc/hosts has been upadted!"
