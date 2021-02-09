#!/usr/bin/env bash

##### Config #####
SOURCE_DIR="/input"
OUTPUT_DIR="/output"

AAX_FILE="$@"

##### Code ######

# Die function
die () {
    echo >&2 "[ERROR] The job ended in error."
    echo "[ERROR] $@"
    exit 1
}

if [ -z "${AAX_FILE}" ]; then
   die "No input aax file provided."
fi

if [ ! -f "${SOURCE_DIR}/${AAX_FILE}" ]; then
  echo "${SOURCE_DIR}/${AAX_FILE}"
  ls /input
  die "The file can not be found."
fi

check1=`which ffmpeg`
if [ "$check1" = "" ]
then
    die "ffmpeg is missing -> e.g.: apt-get install ffmpeg"
fi

check1=`which ffprobe`
if [ "$check1" = "" ]
then
    die "ffmpeg is missing -> e.g.: apt-get install ffmpeg"
fi

CHECKSUM=$(ffprobe "${SOURCE_DIR}/${AAX_FILE}" 2>&1 |grep checksum|sed 's/^.*== //'g)

if [ -z "${CHECKSUM}" ]; then
    die "No checksum found."
fi

echo "Searching for activation bytes..."
RCRACK=$(./rcrack . -h "${CHECKSUM}")
#echo "${RCRACK}"
ACTIVATION_BYTES=$(echo "${RCRACK}"|grep "hex:"|sed 's/^.*hex://g')
echo "Your Activation bytes are: ${ACTIVATION_BYTES}"

echo "Retrieving cover"
ffmpeg -y -v quiet -i "${SOURCE_DIR}/${AAX_FILE}" "cover.png"

echo "Converting to audio..."
set -x
ffmpeg -activation_bytes "${ACTIVATION_BYTES}" -i "${SOURCE_DIR}/${AAX_FILE}" -vn -c:a copy "./temp.m4a"
#ffmpeg -activation_bytes "${ACTIVATION_BYTES}" -i "${SOURCE_DIR}/${AAX_FILE}" -threads 4 -vn -y -acodec aac -strict -2 -map_metadata 0 -map_metadata:s:a 0:s:a -ac 1 "${OUTPUT_DIR}/${AAX_FILE%.*}.m4a"
set +x

if [ -f "./cover.png" ]; then
   set -x
   ffmpeg -y -v quiet -stats -r 1 -loop 1 -i "./cover.png" -i "./temp.m4a" -c:a copy -shortest "${OUTPUT_DIR}/${AAX_FILE%.*}.m4a"
   set +x
else
   echo "No cover was found."
   cp -v ./temp.m4a "${OUTPUT_DIR}/${AAX_FILE%.*}.m4a"
fi

