import Foundation

func readConfiguation(configurationFilename: String = "configuration.json") -> Configuration {
  let url = URL(fileURLWithPath: configurationFilename)
  guard let contents = try? String(contentsOf: url),
        let data = contents.data(using: .utf8),
        let configuration = try? JSONDecoder().decode(Configuration.self, from: data)
  else {
    return defaultConfiguration
  }
  
  return configuration
}

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
  let configuration = readConfiguation()
  compress(inputFilename, outputFilename, configuration)
case "-d":
  decompress(inputFilename, outputFilename)
default:
  print("Invalid option: \(option)")
  exit(0)
}

func compress(_ inputFilename: String, _ outputFilename: String, _ configuration: Configuration) {
  let inputData = try! Data(contentsOf: URL(fileURLWithPath: inputFilename))
  let contents: [UInt8] = Array(inputData)
  var lz77Encoder = LZ77Encoder(input: contents, configuration: configuration)
  let encoded = lz77Encoder.encode()
  print("encoded.count: \(encoded.count)")
  
  let bytes = encoded.flatMap { $0.bytes }
  
  let data = Data(bytes)
  
  try! data.write(to: URL(fileURLWithPath: outputFilename))
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
}
