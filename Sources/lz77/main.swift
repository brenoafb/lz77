import Foundation

//let input = "Oh look at this chap he is like Oh look at this chap he thinks he is so cool wtf look at this chap"
//var lz77Encoder = LZ77Encoder(input: input, bufferSize: 8, lookaheadBufferSize: 8)
//let encoded = lz77Encoder.encode()
//print(encoded)
//print("\(input.count) vs \(encoded.count)")
//
//var lz77Decoder = LZ77Decoder(tokens: encoded)
//let decoded = lz77Decoder.decode()
//print(decoded)
//
//if decoded != input {
//  print("Warning: decode != input")
//}



if CommandLine.argc != 4 {
  print("Please provide option, input and output filenames")
  print("Example: -c input.txt compressed.bin")
  exit(0)
}

let option = CommandLine.arguments[1]
let inputFilename = CommandLine.arguments[2]
let outputFilename = CommandLine.arguments[3]

switch option {
case "-c":
  compress(inputFilename, outputFilename)
case "-d":
  decompress(inputFilename, outputFilename)
default:
  print("Invalid option: \(option)")
  exit(0)
}

func compress(_ inputFilename: String, _ outputFilename: String) {
  let inputData = try! Data(contentsOf: URL(fileURLWithPath: inputFilename))
  let contents: [UInt8] = Array(inputData)
  var lz77Encoder = LZ77Encoder(input: contents, bufferSize: 255, lookaheadBufferSize: 255)
  let encoded = lz77Encoder.encode()
  print("encoded.count: \(encoded.count)")
  
  let bytes = encoded.flatMap { $0.bytes }
  
  let data = Data(bytes)
  
  try! data.write(to: URL(fileURLWithPath: outputFilename))
//  print("Data size: \(data.count)")
//  print("Huffman encoding stage")
//  let huffman = Huffman()
//  let compressedData = huffman.compressData(data: data)
//  print("Compressed data size: \(compressedData.count)")
//  print("Writing output file")
//  let url = URL(fileURLWithPath: outputFilename)
//  try! compressedData.write(to: url)
}

func decompress(_ inputFilename: String, _ outputFilename: String) {
  let data = try! Data(contentsOf: URL(fileURLWithPath: inputFilename))
  let bytes: [UInt8] = Array(data)
  var tuples: [LZ77Tuple] = []
  
  for i in 0..<data.count/4 {
    let tupleBytes = Array(bytes[4*i ..< 4*(i+1)])
    let tuple = LZ77Tuple(bytes: tupleBytes)
    tuples.append(tuple)
  }
  
  var lz77Decoder = LZ77Decoder(tokens: tuples)
  let decoded = lz77Decoder.decode()
  
  let writeData = Data(decoded)
  
  try! writeData.write(to: URL(fileURLWithPath: outputFilename))
  
//  let array = data.withUnsafeBytes { (pointer: UnsafePointer<UInt32>) -> [UInt32] in
//    let buffer = UnsafeBufferPointer(start: pointer, count: data.count/4)
//    return [UInt32](buffer)
//  }
  
}
