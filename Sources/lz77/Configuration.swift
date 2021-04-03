import Foundation

struct Configuration: Codable {
  let bufferSize: Int
  let lookaheadBufferSize: Int
  let minMatchLength: Int
  let maxMatchLength: Int
}

let defaultConfiguration = Configuration(bufferSize: 255,
                                         lookaheadBufferSize: 255,
                                         minMatchLength: 1,
                                         maxMatchLength: 255)
