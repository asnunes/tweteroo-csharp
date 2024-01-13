#!/bin/bash

# Get the current commit SHA
current_sha=$(git rev-parse HEAD)

# Build the Docker image and tag it with the commit SHA
docker build -t tweteroo-csharp:$current_sha -t tweteroo-csharp:latest .