#!/bin/sh

# extract lengths
hexdump $1 | awk '{print $4 " " $8 " " $12 " " $16 }' | sed '/^[[:space:]]*$/d' | tr " " "\n" > "lengths_$1"
# extract offsets
hexdump $1 | awk '{print $5 " " $9 " " $13 " " $17 }' | sed '/^[[:space:]]*$/d' | tr " " "\n" > "offsets_$1"
