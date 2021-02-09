# rcrack - Audible aax 2 m4b converter

This docker image has been based on the ivonet/mediatools image
with the addition of having the [rcrack](https://github.com/inAudible-NG/tables) tool installed

Now if you have an Audible account and want to have your books available offline
without the irritating DRM on it you can use this tool.

# Prerequisites

- Docker

# Usage 

- Put your aax file in a folder and open a terminal there
- run the following command replacing file.aax with your file
- it should do the rest.
- in the first volume is where the aax file must be
- the second volume is where the m4b file will be written to.

```shell
docker run -it --rm \
   -v "$(pwd):/input:ro" \
   -v "$(pwd):/output:rw" \
   ivonet/rcrack:latest file.aax
```
