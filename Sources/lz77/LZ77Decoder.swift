import Foundation

struct LZ77Decoder {
  let tokens: [LZ77Tuple]
  var buffer = ""
  
  mutating func decode() -> String {
    for token in tokens {
      guard token.0 != nil else {
        return buffer
      }
      
      decodeToken(token)
      print(buffer)
    }
    
    return buffer
  }
  
  mutating func decodeToken(_ token: LZ77Tuple) {
    
    let offset = token.1
    let length = token.2
    
    var startIndex = buffer.index(buffer.endIndex, offsetBy: -offset)
    
    for _ in 0 ..< length {
      buffer.append(buffer[startIndex])
      startIndex = buffer.index(after: startIndex)
    }
    
    if let c = token.0 {
      buffer.append(String(c))
    }
  }
}
