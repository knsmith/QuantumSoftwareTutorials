#!/bin/bash

# Check if three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <binary1> <binary2> <timeout_in_seconds>"
    exit 1
fi

# Assign command-line arguments to variables
binary1="$1"
binary2="$2"
timeout_seconds="$3"

# Function to run binary with timeout and report the outcome
run_binary() {
    local binary=$1
    local timeout=$2
    local start_time=$(date +%s.%N)  # Capture start time with nanosecond precision

    # Run the command with timeout
    timeout $timeout $binary
    local result=$?

    local end_time=$(date +%s.%N)  # Capture end time
    local duration=$(echo "$end_time - $start_time" | bc)  # Calculate duration

    # Determine the outcome based on the result of the timeout command
    if [ $result -eq 124 ]; then
        echo "$binary timed out after $timeout seconds."
    else
        echo "$binary completed in $duration seconds."
    fi
}

# Run and report for both binaries
run_binary "$binary1" "$timeout_seconds"
run_binary "$binary2" "$timeout_seconds"

