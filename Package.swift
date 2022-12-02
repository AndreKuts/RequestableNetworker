// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networker",
	platforms: [
		.macOS(.v10_15),
		.iOS(.v13)
	],
    products: [
        .library(
            name: "Networker",
            targets: ["Networker"]),
    ],
    dependencies: [
	],
    targets: [
        .target(
            name: "Networker",
            dependencies: []),
        .testTarget(
            name: "NetworkerTests",
            dependencies: ["Networker"]),
    ]
)
