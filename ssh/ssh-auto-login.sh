#!/usr/bin/env bash

MASTER_USERNAME="root"
MASTER_HOST="172.104.76.231"
MASTER_PWD="xixihaha2009"

DST_USERNAME="root"
DST_PWD="xixihaha2009"

# Generate pubkey in remote host
# Usage: generate_pub user host password
generate_pub() {
    local username=$1
    local host=$2
    local password=$3

    expect << EOF
spawn ssh $username@$host "mkdir -p ~/.ssh; cd ~/.ssh; rm ./id_rsa*; ssh-keygen -t rsa"
while 1 {
    expect {
        "*assword:"                            { send "$password\n" }
        "yes/no*"                              { send "yes\n"       }
        "Enter file in which to save the key*" { send "\n"          }
        "Enter passphrase*"                    { send "\n"          }
        "Enter same passphrase again:"         { send "\n"          }
        "Overwrite (y/n)"                      { send "y\n"         }
        eof                                    { exit               }
    }
}
EOF
}

# Fetch id_rsa.pub from remote host to local
# Usage: get_pub user host password
get_pub() {
    local username=$1
    local host=$2
    local password=$3

    expect << EOF
spawn scp $username@$host:~/.ssh/id_rsa.pub /tmp
expect {
    "*assword:" { send "$password\n"; exp_continue }
    "yes/no*"   { send "yes\n"      ; exp_continue }
    eof         { exit                             }
}
EOF
}

# Append id_rsa.pub to authorized_keys in remote host
# Usage: append_pub user host password
append_pub() {
    src_pub="$(cat /tmp/id_rsa.pub)"

    local username=$1
    local host=$2
    local password=$3

    expect << EOF
spawn ssh $username@$host "mkdir -p ~/.ssh; echo $src_pub >> ~/.ssh/authorized_keys; chmod 600 ~/.ssh/authorized_keys"
expect {
    "*assword:" { send "$password\n"; exp_continue }
    "yes/no*"   { send "yes\n"      ; exp_continue }
    eof         { exit                             }
}
EOF
}

generate_pub  $MASTER_USERNAME $MASTER_HOST $MASTER_PWD
get_pub       $MASTER_USERNAME $MASTER_HOST $MASTER_PWD

append_pub    $MASTER_USERNAME $MASTER_HOST $MASTER_PWD

for slave in $(cat slaves.txt); do
    append_pub    $DST_USERNAME $slave $DST_PWD
done
