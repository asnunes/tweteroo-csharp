#!/bin/bash

# create tar_path if it doesn't exist
ssh -o StrictHostKeyChecking=no -i $PK_PATH $DEPLOY_USER@$DEPLOY_HOST "mkdir -p $TAR_PATH"

# Copy the Docker image tarballs to the server
scp -o StrictHostKeyChecking=no -i $PK_PATH $TMP_DIR/*.tar $DEPLOY_USER@$DEPLOY_HOST:$TAR_PATH
