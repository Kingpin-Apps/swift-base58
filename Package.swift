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
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.7.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "4.5.0"),
    ],
    targets: [
        .target(
            name: "SwiftBase58",
            dependencies: [
                .product(name: "BigInt", package: "BigInt"),
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
