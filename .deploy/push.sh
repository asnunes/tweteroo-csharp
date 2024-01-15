#!/bin/bash

pk_filepath=/tmp/pk

# Add private key to ssh-agent
touch $pk_filepath
echo "$PK" > $pk_filepath
chmod 600 $pk_filepath

# Add the server to known_hosts
mkdir -p ~/.ssh
eval $(ssh-agent -s)
chmod 700 $pk_filepath
touch ~/.ssh/config

# create tar_path if it doesn't exist
ssh -o StrictHostKeyChecking=no -i $pk_filepath $DEPLOY_USER@$DEPLOY_HOST "mkdir -p $TAR_PATH"

# Copy the Docker image tarballs to the server
scp -o StrictHostKeyChecking=no -i $pk_filepath $TMP_DIR/*.tar $DEPLOY_USER@$DEPLOY_HOST:$TAR_PATH
