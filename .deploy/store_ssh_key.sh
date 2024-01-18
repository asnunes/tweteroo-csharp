#!/bin/bash

pk_filepath=/tmp/pk

# Add private key to ssh-agent
touch $pk_filepath
echo "$PK" > $pk_filepath

# Add the server to known_hosts
mkdir -p ~/.ssh
eval $(ssh-agent -s)
chmod 700 $pk_filepath
touch ~/.ssh/config