import Foundation

typealias LZ77Tuple = (Character?, Int, Int)

struct LZ77Encoder {
  let input: String
  let bufferSize: Int
  var current = 0
  
  var bufferStart: Int {
    current - bufferSize
  }
  var currentIndex: String.Index {
    input.index(input.startIndex, offsetBy: current)
  }
  var bufferStartIndex: String.Index? {
    if bufferStart < 0 {
      return input.startIndex
    } else {
      return input.index(input.startIndex, offsetBy: bufferStart)
    }
  }
  var buffer: Substring? {
    guard let bufferStartIndex = bufferStartIndex else {
      return nil
    }
    
    return input[bufferStartIndex ..< currentIndex]
  }
  
  var debugDescription: String {
    "|\(buffer ?? "")|\(input[currentIndex..<input.endIndex])"
  }
  
  mutating func encode() -> [LZ77Tuple] {
    var tokens: [LZ77Tuple] = []
  
    var token = step()
    
    while (token.0 != nil) {
      tokens.append(token)
      token = step()
    }
    
    return tokens
  }
  
  mutating func step() -> LZ77Tuple {
    print(debugDescription)
    guard currentIndex < input.endIndex else {
      return (nil, 0, 0)
    }
    
    guard var pointer = findInBuffer() else {
      let curr = input[currentIndex]
      advance()
      return (curr, 0, 0)
    }
    
    let offset = Int(input.distance(from: pointer, to: currentIndex))
    var matchLength: Int = 0
    
    while (currentIndex < input.endIndex && input[currentIndex] == input[pointer]) {
      pointer = input.index(after: pointer)
      advance()
      matchLength += 1
    }
    
    if (currentIndex == input.endIndex) {
      return (nil, offset, matchLength)
    }
    
    let c = input[currentIndex]
    advance()
    return (c, offset, matchLength)
  }
  
  mutating func advance() {
    current += 1
  }
  
  func printWindow(offset: Int) {
    let endIndex = input.index(currentIndex, offsetBy: offset)
    print("|\(buffer ?? "")|\(input[currentIndex..<endIndex])")
  }
  
  func findInBuffer() -> String.Index? {
    if currentIndex >= input.endIndex {
      return nil
    }
    return buffer?.firstIndex(of: input[currentIndex])
  }
}

//extension LZ77Encoder: CustomDebugStringConvertible {
//  var debugDescription: String {
//    "|\(buffer ?? "")|\(input[currentIndex..<input.endIndex])"
//  }
//}
