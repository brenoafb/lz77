#!/bin/bash

get_file_size() {
  # du -b "$1" | awk '{print $1}' # linux
  ls -l "$1" | awk '{print $5}' # macos
}

get_ratio() {
  echo "$1 / $2" | bc -l | awk '{printf "%.4f\n", $0}'
}

export LC_NUMERIC="en_US.UTF-8"

dir=$1
tmpdir="./tmp/"

mkdir -p "$tmpdir"
echo "comparison with gzip"
echo "gzip"

echo "|Filename|Size (Bytes)|Compressed Size (Bytes)|Compression ratio|"

for file in "$dir"/*
do
  compressed_filename="$tmpdir/compressed.gz"
  base=$(basename "$file")
  gzip -c "$file" > "$compressed_filename"
  original_size=$(get_file_size $file)
  compressed_size=$(get_file_size $compressed_filename)
  ratio=$(get_ratio "$compressed_size" "$original_size")

  printf "|%s|%d|%d|%.4f|\n" "$base" "$original_size" "$compressed_size" "$ratio"

  rm "$compressed_filename"
done

echo ""
echo "mine"

echo "|Filename|Size (Bytes)|Compressed Size (Bytes)|Compression ratio|"

for file in "$dir"/*
do
  base=$(basename "$file")
  compressed_filename="$tmpdir/compressed.bin"
  ./compress.sh "$file" "$compressed_filename" > /dev/null
  original_size=$(get_file_size $file)
  compressed_size=$(get_file_size $compressed_filename)
  ratio=$(get_ratio "$compressed_size" "$original_size")

  printf "|%s|%d|%d|%.4f|\n" "$base" "$original_size" "$compressed_size" "$ratio"

  rm "$compressed_filename"
done
