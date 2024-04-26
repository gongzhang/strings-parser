// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringsParser",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "StringsParser",
            targets: ["StringsParser"]),
    ],
    targets: [
        .target(
            name: "StringsParser",
            path: "Sources"),
        .testTarget(
            name: "StringsParserTests",
            dependencies: ["StringsParser"],
            path: "Tests"),
    ]
)
