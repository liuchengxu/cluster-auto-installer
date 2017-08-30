#!/usr/bin/env bash

HBASE_DOWNLOAD_URL=http://apache.mirror.vexxhost.com/hbase/stable/hbase-1.2.6-bin.tar.gz
HBASE_TAR_GZ=${HBASE_DOWNLOAD_URL##*/} # hbase-1.2.6-bin.tar.gz
HBASE_VER=${HBASE_TAR_GZ%%-bin.tar.gz} # hbase-1.2.6

if [ ! -d /usr/local/hbase ]; then
    [ ! -f /tmp/$HBASE_TAR_GZ ] && wget -P /tmp --no-check-certificate $HBASE_DOWNLOAD_URL
    tar -zxf /tmp/$HBASE_TAR_GZ -C /usr/local
    mv /usr/local/$HBASE_VER /usr/local/hbase
else
    echo ">>>> /usr/local/hbase already exists."
fi
