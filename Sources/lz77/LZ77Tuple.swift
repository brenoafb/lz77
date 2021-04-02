import Foundation

struct LZ77Tuple: Codable {
  let byte: UInt8?
  let offset: UInt8
  let length: UInt8
  
//  var bytes: [UInt8] {
//    [byte == nil ? 0 : 1, byte ?? 0,
//     UInt8(offset >> 1), UInt8(offset & 0x00ff),
//     UInt8(length >> 1), UInt8(length & 0x00ff)]
//  }
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
    
//    offset = (UInt16(bytes[2]) << 1) | UInt16(bytes[3])
//    length = (UInt16(bytes[4]) << 1) | UInt16(bytes[5])
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
//    self.offset = UInt16(offset)
//    self.length = UInt16(length)
    self.offset = UInt8(offset)
    self.length = UInt8(length)
  }
}
