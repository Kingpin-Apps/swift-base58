// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SwiftBase58",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(
            name: "SwiftBase58",
            targets: ["SwiftBase58"]
        ),
    ],
    dependencies: [
        // Big integer arithmetic used by the Base58 implementation
        .package(url: "https://github.com/attaswift/BigInt.git", .upToNextMinor(from: "5.3.0")),
        // Provides Crypto-compatible APIs on non-Apple platforms.
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.15.1"),
    ],
    targets: [
        .target(
            name: "SwiftBase58",
            dependencies: [
                .product(name: "BigInt", package: "BigInt"),
                // Link swift-crypto on every non-Apple platform where it ships
                // (Apple platforms use CryptoKit). Without this, `sha256` — used
                // by `base58CheckEncode/Decode` — hits a runtime `fatalError`.
                .product(
                    name: "Crypto",
                    package: "swift-crypto",
                    condition: .when(platforms: [.linux, .android, .wasi, .windows, .openbsd])
                ),
            ]
        ),
        .testTarget(
            name: "SwiftBase58Tests",
            dependencies: ["SwiftBase58"]
        ),
    ]
)
