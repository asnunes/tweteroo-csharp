#!/bin/bash

filepath=$1
if [ -z "$filepath" ]; then
    echo "Usage: $0 <path-to-file>"
    exit 1
fi

# should start with test/ or ./test/
if [[ ! $filepath =~ ^(\.\/)?test\/.* ]]; then
    echo "File path should start with test/ or ./test/"
    exit 1
fi

# should end with ./test/*.js
if [[ ! $filepath =~ ^(\.\/)?test\/.*\.js$ ]]; then
    echo "File path should be a .js file in the test/ directory"
    exit 1
fi

# should end with .js
if [[ ! $filepath =~ \.js$ ]]; then
    echo "File path should end with .js"
    exit 1
fi

echo "Building $filepath"
npm run build:dev -- --env=entry=$filepath
exit_code=$?
if [ $exit_code -ne 0 ]; then
    echo "Build failed"
    exit $exit_code
fi

echo "Running $filepath"
filename=$(basename -- "$filepath")

k6 run dist/$filename