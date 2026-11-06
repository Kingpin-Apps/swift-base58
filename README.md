# SwiftBase58

This is a fork of the [Base58Swift](https://github.com/keefertaylor/Base58Swift) project that adds Linux compatibility.

Base58Swift is a Swift library that implements Base58 / Base58Check encodings for cryptocurrencies. It is based off of [go-base-58](https://github.com/jbenet/go-base58) with some added functions.

## Installation

### Swift Package Manager

Add the following to the `dependencies` section of your `Package.swift` file:

```swift
.package(url: "https://github.com/Kingpin-Apps/swift-base58.git", from: "0.2.0")
```

## Usage

SwiftBase58 provides a static namespace, `Base58`, with encoding and decoding functions. Decoding returns `nil` for invalid input.

To encode / decode in Base58:
```swift
let bytes: [UInt8] = [255, 254, 253, 252]

let encodedString = Base58.base58Encode(bytes)
let decodedBytes = Base58.base58Decode(encodedString)!

print(encodedString) // 7YXVWT
print(decodedBytes)  // [255, 254, 253, 252]
```

To encode / decode in Base58Check:
```swift
let bytes: [UInt8] = [255, 254, 253, 252]

let encodedString = Base58.base58CheckEncode(bytes)
let decodedBytes = Base58.base58CheckDecode(encodedString)!

print(encodedString) // jpUz5f99p1R
print(decodedBytes)  // [255, 254, 253, 252]
```

### Decoding untrusted input

Decoding cost grows quadratically with input length. When decoding strings from users or the network, pass `maxDecodedLength` so oversized input is rejected before any work is done:

```swift
// 21-byte payload, e.g. a Bitcoin P2PKH address (version byte + 20-byte hash)
guard let payload = Base58.base58CheckDecode(userInput, maxDecodedLength: 21) else {
    // invalid characters, bad checksum, too short, or too long
    return
}
```

For `base58CheckDecode`, `maxDecodedLength` is the payload length and excludes the 4-byte checksum.

## License

MIT

