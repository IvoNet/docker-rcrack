#!/usr/bin/env bash

if [ -z "$1" ]; then
    for aax in /input/*.aax
    do
      [[ -e "$aax" ]] || break
       ./aax_2_m4b.sh "$(basename "$aax")"
    done
else
  ./aax_2_m4b.sh "$@"
fi
rm -f ./activation_bytes 2>/dev/null
echo "Finished."
