#!/bin/bash

filepath=$1
if [ -z "$filepath" ]; then
    echo "Usage: $0 <filepath>"
    exit 1
fi

filepath_without_k6_start_folder=./${filepath#./.k6/}
npm run test $filepath_without_k6_start_folder