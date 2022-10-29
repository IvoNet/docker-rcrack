#!/usr/bin/env bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
docker run \
   --platform=linux/amd64 \
   -it \
   --rm \
   -v "$(pwd):/input:ro" \
   -v "$(pwd):/output:rw" \
   ivonet/rcrack:latest "$@"
IFS=$SAVEIFS
