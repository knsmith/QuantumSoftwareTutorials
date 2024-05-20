#!/bin/bash

# Check if two binary names were provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_binary1> <path_to_binary2>"
    exit 1
fi

# Function to run a binary and time its execution
run_and_time() {
    local binary=$1
    local start_time=$(date +%s%N)  # Start time in nanoseconds

    # Run the binary
    $binary
    local status=$?

    if [ $status -ne 0 ]; then
        echo "$binary failed with exit code $status"
        return $status
    fi

    local end_time=$(date +%s%N)  # End time in nanoseconds
    local duration=$(( (end_time - start_time) / 1000000 ))  # Duration in milliseconds
    echo "$binary completed in $duration ms"
}

# Run and time each binary
run_and_time "$1"
run_and_time "$2"



