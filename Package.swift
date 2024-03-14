// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWProgressView",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        .library(name: "WWProgressView", targets: ["WWProgressView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "WWProgressView", resources: [.process("Xib"), .copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
