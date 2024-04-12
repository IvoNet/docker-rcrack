#!/usr/bin/env bash

for file in *.aax; do
  if [ -f "${file%.aax}.m4b" ]; then
    echo "Skipping ${file%.aax}.m4b"
  else
    echo "Converting ${file%.aax}.m4b"
    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")
    docker run \
       --platform=linux/amd64 \
       -it \
       --rm \
       -v "$(pwd):/input:ro" \
       -v "$(pwd):/output:rw" \
       ivonet/rcrack:latest "$file"
    IFS=$SAVEIFS
  fi
done
