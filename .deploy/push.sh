#!/bin/bash

pk_filepath=/tmp/pk

# Add private key to ssh-agent
touch $pk_filepath
echo $PK >> $pk_filepath
eval "$(ssh-agent -s)"
chmod 600 $pk_filepath
ssh-add $pk_filepath

# create tar_path if it doesn't exist
ssh -i $pk_filepath $DEPLOY_USER@$DEPLOY_HOST "mkdir -p $AWS_TAR_PATH"

# Copy the Docker image tarballs to the server
scp -i $pk_filepath $TMP_DIR/*.tar $DEPLOY_USER@$DEPLOY_HOST:$AWS_TAR_PATH
