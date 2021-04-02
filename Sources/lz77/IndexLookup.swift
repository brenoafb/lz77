import Foundation

struct IndexLookup {
  private var dict: [UInt8:[Int]] = [:]
  let buffer: ArraySlice<UInt8>
  
  init(buffer: ArraySlice<UInt8>) {
    self.buffer = buffer
    let indices = 0..<buffer.count
    let entries = zip(self.buffer, indices)// .map { IndexEntry(character: $0, offset: $1)}
    for entry in entries {
      insertEntry(byte: entry.0, offset: entry.1)
    }
  }
  
  func lookupOffsets(byte: UInt8) -> [Int]? {
    dict[byte]
  }
  
  private mutating func insertEntry(byte: UInt8, offset: Int) {
    guard var array = dict[byte] else {
      dict[byte] = [offset]
      return
    }
    array.append(offset)
    dict.updateValue(array, forKey: byte)
  }
}

fileprivate struct IndexEntry: Hashable {
  let byte: UInt8
  let offset: Int
}
