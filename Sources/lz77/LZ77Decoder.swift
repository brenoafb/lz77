import Foundation

struct LZ77Decoder {
  let tokens: [LZ77Tuple]
  var buffer: [UInt8] = []

  mutating func decode() -> [UInt8] {
    for token in tokens {
      decodeToken(token)
    }
    
    return buffer
  }
  
  mutating func decodeToken(_ token: LZ77Tuple) {
    
    var startIndex = buffer.index(buffer.endIndex, offsetBy: -Int(token.offset))
    
    for _ in 0 ..< token.length {
      buffer.append(buffer[startIndex])
      startIndex = buffer.index(after: startIndex)
    }
    
    if let b = token.byte {
      buffer.append(b)
    }
  }
}
