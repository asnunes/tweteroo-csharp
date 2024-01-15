#!/bin/bash

# Get the current commit SHA
image_name="tweteroo-csharp-migrate"
latest_tag="$image_name:latest"

# Build the Docker image and tag it with the commit SHA
docker build -t $latest_tag .

# Save the Docker image to a tarball
mkdir -p $TMP_DIR

docker save -o $TMP_DIR/$image_name-latest.tar $latest_tag