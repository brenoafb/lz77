var encoder = LZ77Encoder(input: "cabracadabrarrarrad", bufferSize: 7)
let encoded = encoder.encode()
print(encoded)
var decoder = LZ77Decoder(tokens: encoded)

//print(decoder.decodeToken(buffer: "", token: encoded[0]))
//print(decoder.decodeToken(buffer: "c", token: encoded[1]))
//print(decoder.decodeToken(buffer: "ca", token: encoded[2]))

let decoded = decoder.decode()
print(decoded)
//encoder.current = 7
//encoder.printWindow()
//var match = encoder.step()
//print("match: \(match)")
//
//encoder.printWindow()
//match = encoder.step()
//print("match: \(match)")
//
//encoder.printWindow()
//match = encoder.step()
//print("match: \(match)")
//
//encoder.printWindow()
