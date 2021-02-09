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
ACTIVATION_BYTES=$(echo "${RCRACK}"|grep "hex:"|sed 's/^.*hex://g')
echo "Your Activation bytes are: ${ACTIVATION_BYTES}"

echo "Retrieving cover"
ffmpeg -y -v quiet -i "${SOURCE_DIR}/${AAX_FILE}" "cover.png"

echo "Converting to audio..."
set -x
ffmpeg -activation_bytes "${ACTIVATION_BYTES}" -i "${SOURCE_DIR}/${AAX_FILE}" -vn -c:a copy -map_metadata 0 -map_metadata:s:a 0:s:a -movflags use_metadata_tags "./temp.m4b"
#ffmpeg -activation_bytes "${ACTIVATION_BYTES}" -i "${SOURCE_DIR}/${AAX_FILE}" -threads 4 -vn -y -acodec aac -strict -2 -map_metadata 0 -map_metadata:s:a 0:s:a -ac 1 "${OUTPUT_DIR}/${AAX_FILE%.*}.m4b"
set +x

if [ -f "./cover.png" ]; then
   mp4art --add "./cover.png" "./temp.m4b"
   RETVAL=$?
   [ $RETVAL -eq 0 ] || die "The mp4art command failed with exit code: $RETVAL"
else
   echo "No cover was found."
fi

mv -v ./temp.m4b "${OUTPUT_DIR}/${AAX_FILE%.*}.m4b"

