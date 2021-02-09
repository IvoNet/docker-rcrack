SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
docker run \
   -it \
   --rm \
   -v "$(pwd):/input:ro" \
   -v "$(pwd):/output:rw" \
   ivonet/rcrack:latest "$@"
IFS=$SAVEIFS
