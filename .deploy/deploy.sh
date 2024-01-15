#!/bin/bash

# get all the tar files
tar_files=$(ls $TAR_PATH/*.tar)

# load each tar file into docker
for tar_file in $tar_files
do
    docker load -i $TAR_PATH/$tar_file
done

# remove the tar files
rm $TAR_PATH/*.tar

# restart the docker containers
cd $DEPLOY_PATH
make down && make up
