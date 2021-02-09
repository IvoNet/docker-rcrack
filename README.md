# inAudible-NG tables

Plugin for RainbowCrack to recover your own Audible activation data (activation_bytes) in an offline manner.

You need to recover or retrieve your "activation_bytes" only once. This single "activation_bytes" value will work for all your .aax files.

# Prerequisites

- Docker
- ffmpeg

# Usage 

ffprobe AUDIBLE_AUDIO.aax 2>&1 |grep checksum|sed 's/^.*== //'g

docker run -it --rm ivonet/rcrack:latest CHECKSUM
docker run
