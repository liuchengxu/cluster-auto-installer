#!/usr/bin/env bash

HADOOP_DOWNLOAD_URL=https://mirrors.cnnic.cn/apache/hadoop/common/stable/hadoop-2.7.3.tar.gz
HADOOP_TAR_GZ=${HADOOP_DOWNLOAD_URL##*/} # hadoop-2.7.3.tar.gz
HADOOP_VER=${HADOOP_TAR_GZ%%.tar.gz}     # hadoop-2.7.3


if [ ! -d /usr/local/hadoop ]; then
    [ ! -f /tmp/$HADOOP_TAR_GZ ] && wget -P /tmp --no-check-certificate $HADOOP_DOWNLOAD_URL
    tar -zxf /tmp/$HADOOP_TAR_GZ -C /usr/local
    mv /usr/local/$HADOOP_VER /usr/local/hadoop
else
    echo ">>>> /usr/local/hadoop already exists."
fi


[ -z "${HADOOP_HOME}" ] && echo "export HADOOP_HOME=/usr/local/hadoop" >> "$HOME/.bashrc"
[ -z "${HADOOP_COMMON_LIB_NATIVE_DIR}" ] && echo "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> "$HOME/.bashrc"


# Set JAVA_HOME in hadoop-env.sh
JAVA_PATH=$(update-alternatives --list java)
JAVA_HOME=${JAVA_PATH%/jre/bin*}
HADOOP_ENV=/usr/local/hadoop/etc/hadoop/hadoop-env.sh
[ -f $HADOOP_ENV ] && echo "export JAVA_HOME=$JAVA_HOME" >> "$HADOOP_ENV"
