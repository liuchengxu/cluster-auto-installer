#!/usr/bin/env bash

SPARK_DOWNLOAD_URL=https://d3kbcqa49mib13.cloudfront.net/spark-2.2.0-bin-hadoop2.7.tgz
SPARK_TGZ=${SPARK_DOWNLOAD_URL##*/} # spark-2.2.0-bin-hadoop2.7.tgz
SPARK_VER=${SPARK_TGZ%%.tgz}        # spark-2.2.0-bin-hadoop2.7

if [ ! -d /usr/local/spark ]; then
    [ ! -f /tmp/$SPARK_TGZ ] && wget -P /tmp --no-check-certificate $SPARK_DOWNLOAD_URL
    tar -zxf /tmp/$SPARK_TGZ -C /usr/local
    mv /usr/local/$SPARK_VER /usr/local/spark
else
    echo ">>>> /usr/local/spark already exists."
fi


