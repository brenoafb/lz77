import Foundation

struct LZ77Tuple: Codable {
  let byte: UInt8?
  let offset: UInt8
  let length: UInt8
  
  var bytes: [UInt8] {
    [byte == nil ? 0 : 1, byte ?? 0,
     offset,
     length]
  }
  
  init(bytes: [UInt8]) {
    if bytes[0] == 0 {
      byte = nil
    } else {
      byte = bytes[1]
    }

    offset = bytes[2]
    length = bytes[3]
  }
  
  init(byte: UInt8?, offset: Int, length: Int) {
    if offset > 255 {
      print("offset > 255")
    }
    if length > 255 {
      print("length > 255")
    }
    self.byte = byte
    self.offset = UInt8(offset)
    self.length = UInt8(length)
  }
}
