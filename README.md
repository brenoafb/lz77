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
