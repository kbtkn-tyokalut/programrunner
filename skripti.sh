#!/bin/bash

# Check if at least 2 arguments are passed (program, filename)
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 program [flags...] filename"
  exit 1
fi

# Extract the last argument as filename
FILENAME="${@: -1}"

# Extract program name
PROGRAM="$1"

# Determine if there are any flags provided
if [ "$#" -gt 2 ]; then
  # Extract flags (all arguments except the first and the last)
  FLAGS="${@:2:$#-2}"
else
  # No flags provided
  FLAGS=""
fi

# Verify the file exists
if [ ! -f "$FILENAME" ]; then
  echo "Error: File '$FILENAME' not found."
  exit 1
fi

# Iterate over each line in the file
while IFS= read -r line; do
  # Execute the program with or without flags for each entry (line) in the file
  if [ -n "$FLAGS" ]; then
    $PROGRAM $FLAGS "$line"
  else
    $PROGRAM "$line"
  fi
done < "$FILENAME"

