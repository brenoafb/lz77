# LZ77

LZ77 compressor written in Swift

## Usage

This project uses the Swift package manager.
Build with =swift build=.

To compress a file, run `swift run lz77 -c <input-file> <compressed-file>`.

To decompress a file, run `swift run lz77 -d <compressed-file> <output-file>`.

## Configuration

You can provide custom parameters for the encoder in the `configuration.json` file.

```
{
  "bufferSize": 255,
  "lookaheadBufferSize": 255,
  "minMatchLength": 1,
  "maxMatchLength": 255
}
```

For this implementation, the maximum value for each parameter is 255.

## Compression/Decompression Scripts

There are two scripts -- `compress.sh` and `decompress.sh` -- that combine
the LZ77 encoder with a [Huffman tree encoder](https://github.com/brenoafb/hhuff).
The Huffman encoder is implemented in Haskell and can be installed with
the stack too by using `stack install` in that project's directory.

## Analysis Scripts

The `extract_data.sh` and `plot.py` scripts are intended to be used
for extracting data concerning the distribution of lengths and offsets
in the LZ77 compressed files.

Example usage:

```bash
$ swift run lz77 input.txt compressed.lz77
$ ./extract_data.sh compressed.lz77  # extracts lengths and offsets
$ python3 plot.py lengths_compressed.lz77
$ python3 plot.py offsets_compressed.lz77
```
