#!/bin/bash

cmd=$1
if [ -z "$cmd" ]; then
    echo "Usage: $0 <cmd>"
    exit 1
fi

if [ "$cmd" = "test" ]; then
    filepath=$2
    if [ -z "$filepath" ]; then
        echo "Usage: $0 test <filepath>"
        exit 1
    fi

    filepath_without_k6_start_folder=./${filepath#./.k6/}
    npm run test $filepath_without_k6_start_folder

    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Error: npm run test failed with exit code $exit_code"
        exit $exit_code
    fi

    exit 0
fi

if [ "$cmd" = "seed" ]; then
    npm run seed
    exit_code=$?
    if [ $exit_code -ne 0 ]; then
        echo "Error: npm run seed failed with exit code $exit_code"
        exit $exit_code
    fi

    exit 0
fi

echo "Error: unknown command $cmd"
exit 1
