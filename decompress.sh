#!/bin/bash

TMPFILE="/tmp/$(date +%s).bin"
echo "Huffman stage"
hhuffman-tree-exe -B $1 $TMPFILE
echo "LZ77 stage"
swift run lz77 -d $TMPFILE $2
rm $TMPFILE
