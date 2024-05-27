// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HomeFeature",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "7.0.0"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "12.0.0"),
        .package(path: "../Localization"),
        .package(path: "../DesignSystem"),
        .package(path: "../Common"),
        .package(path: "../Network")
    ],
    targets: [
        .target(
            name: "HomeFeature",
            dependencies: ["Localization", "DesignSystem", "Common", "Network"]
        ),
        .testTarget(
            name: "HomeFeatureTests",
            dependencies: ["HomeFeature", "Quick", "Nimble", "Network", "DesignSystem"]),
    ]
)
