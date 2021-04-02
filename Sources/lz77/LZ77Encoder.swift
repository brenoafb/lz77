import Foundation

struct LZ77Encoder: CustomDebugStringConvertible {
  let input: [UInt8]
  let bufferSize: Int
  let lookaheadBufferSize: Int
  var current = 0
  
  private var bufferStart: Int {
    max(0, current - bufferSize)
  }
  
  private var lookaheadBufferEnd: Int {
    min(input.count, current + lookaheadBufferSize)
  }
  
  private var buffer: ArraySlice<UInt8> {
    return input[bufferStart ..< current]
  }
  
  private var indexLookup: IndexLookup {
    IndexLookup(buffer: buffer)
  }
  
  private var lookaheadBuffer: ArraySlice<UInt8> {
    return input[current ..< lookaheadBufferEnd]
  }
  
  var debugDescription: String {
    "|\(buffer)|\(input[current..<input.endIndex])"
  }
  
  mutating func encode() -> [LZ77Tuple] {
    var tokens: [LZ77Tuple] = []
    
    var token = step()
    
    while (token.byte != nil) {
      tokens.append(token)
      token = step()
    }
    
    tokens.append(token)
    
    return tokens
  }
  
  private mutating func step() -> LZ77Tuple {
    guard current < input.endIndex else {
      return LZ77Tuple(byte: nil, offset: 0, length: 0)
    }
    
    guard var pointer = findInBuffer() else {
      let curr = input[current]
      advance()
      return LZ77Tuple(byte: curr, offset: 0, length: 0)
    }
    
    let offset = current - pointer
    var matchLength: Int = 0
    
    while (matchLength < 255 && current < input.count && input[current] == input[pointer]) {
      pointer += 1
      advance()
      matchLength += 1
    }
    
    if (current == input.count) {
      return LZ77Tuple(byte: nil, offset: offset, length: matchLength)
    }
    
    let b = input[current]
    advance()
    return LZ77Tuple(byte: b, offset: offset, length: matchLength)
  }
  
  private mutating func advance() {
    current += 1
  }
  
  func printWindow(offset: Int) {
    let endIndex = min(current + offset, input.count)
    print("|\(buffer)|\(input[current..<endIndex])")
  }
  
  private func findInBuffer() -> Int? {
    if current >= input.endIndex {
      return nil
    }
    return longestPrefixIndex()
  }
  
  private func longestPrefixIndex() -> Int? {
    var startIndex: Int? = nil
    var length: Int? = nil
    
    guard let offsets = indexLookup.lookupOffsets(byte: input[current]) else {
      return nil
    }
    
    for offset in offsets {
      let index = bufferStart + offset
      
      let matchLength = prefixLength(startingAt: index)
      
      if length == nil || matchLength >= length! {
        startIndex = index
        length = matchLength
      }
      
    }
    
    return startIndex
  }
  
  private func prefixLength(startingAt backIndex: Int) -> Int {
    var matchLength = 0
    var index0 = current
    var index1 = backIndex
    while index0 < lookaheadBufferEnd && input[index0] == input[index1] {
      matchLength += 1
      index0 = input.index(after: index0)
      index1 = input.index(after: index1)
    }
    return matchLength
  }
}
