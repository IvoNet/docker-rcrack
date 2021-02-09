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

# License
## DON'T BE A DICK PUBLIC LICENSE

> Version 1.1, December 2016

> Copyright (C) 2021 ivonet

Everyone is permitted to copy and distribute verbatim or modified
copies of this license document.

> DON'T BE A DICK PUBLIC LICENSE
> TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

1. Do whatever you like with the original work, just don't be a dick.

   Being a dick includes - but is not limited to - the following instances:

 1a. Outright copyright infringement - Don't just copy this and change the name.
 1b. Selling the unmodified original with no work done what-so-ever, that's REALLY being a dick.
 1c. Modifying the original work to contain hidden harmful content. That would make you a PROPER dick.

2. If you become rich through modifications, related works/services, or supporting the original work,
share the love. Only a dick would make loads off this work and not buy the original work's
creator(s) a pint.

3. Code is provided with no warranty. Using somebody else's code and bitching when it goes wrong makes
you a DONKEY dick. Fix the problem yourself. A non-dick would submit the fix back.
