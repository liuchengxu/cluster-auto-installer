#!/usr/bin/env bash

# Vim8
apt install software-properties-common
add-apt-repository ppa:jonathonf/vim
apt update
apt install vim

apt install git expect openssh-server

# Install Java8
apt install openjdk-8-jre openjdk-8-jdk

# Set JAVA_HOME
JAVA_PATH=$(update-alternatives --list java)
JAVA_HOME=${JAVA_PATH%/jre/bin*}
echo "export JAVA_HOME=$JAVA_HOME" >> "$HOME/.bashrc"
