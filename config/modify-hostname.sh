#!/usr/bin/env bash

# ip_hostname.txt:
# ip:hostname
for line in $(cat ip_hostname.txt); do
    ip=${line%%:*}
    hostname=${line##*:}
    ssh "root@$ip" "echo "$hostname" > /etc/hostname"
done
