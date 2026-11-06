# Cross-Platform Support

Understanding how SwiftBase58 works across different platforms and environments.

## Overview

SwiftBase58 is designed to work seamlessly across all Swift-supported platforms. The library uses conditional compilation to handle platform-specific differences, particularly for cryptographic operations required by Base58Check encoding.

## Supported Platforms

### Apple Platforms
- **macOS**: 10.15+ (Catalina and later)
- **iOS**: 13.0+
- **iPadOS**: 13.0+
- **tvOS**: 13.0+
- **watchOS**: 6.0+
- **visionOS**: 1.0+ (automatically supported)

### Other Platforms
- **Linux**, **Android**, **Windows**, **WASI**, **OpenBSD**: Swift 6.0+

All platforms require Swift 6.0 or later.

## Platform-Specific Implementation Details

### Cryptographic Libraries

SwiftBase58 needs SHA256 only for Base58Check checksums. It picks the implementation at compile time:

```swift
#if canImport(CryptoKit)
import CryptoKit   // Apple platforms
#elseif canImport(Crypto)
import Crypto      // swift-crypto on all other platforms
#endif
```

#### Apple Platforms (macOS, iOS, etc.)
- Uses Apple's **CryptoKit** framework
- No additional dependencies are linked

#### Linux, Android, Windows, WASI, OpenBSD
- Uses Apple's open-source **swift-crypto** package, which exposes the same `SHA256` API as CryptoKit
- Linked only on these platforms through Package.swift conditions

### Platform-Specific Package Configuration

The Package.swift uses conditional compilation to include dependencies only when needed:

```swift
.target(
    name: "SwiftBase58",
    dependencies: [
        .product(name: "BigInt", package: "BigInt"),
        // Only link swift-crypto where CryptoKit is unavailable
        .product(
            name: "Crypto",
            package: "swift-crypto",
            condition: .when(platforms: [.linux, .android, .wasi, .windows, .openbsd])
        )
    ]
)
```

## Next Steps

- Review <doc:TechnicalDetails> for implementation specifics
- Check <doc:GettingStarted> for basic usage
- Explore <doc:Base58Encoding> for API details
