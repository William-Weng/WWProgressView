// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWProgressView",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "WWProgressView", targets: ["WWProgressView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "WWProgressView", dependencies: [], resources: [.process("Xib")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
