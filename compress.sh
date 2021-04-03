#!/bin/bash

TMPFILE="/tmp/$(date +%s).bin"
echo "LZ77 stage"
swift run lz77 -c $1 $TMPFILE
echo "Huffman stage"
hhuffman-tree-exe -b $TMPFILE $2
rm $TMPFILE
