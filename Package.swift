// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BMK2024",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BMK2024",
            targets: ["BMK2024"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BMK2024"),
        .testTarget(
            name: "BMK2024Tests",
            dependencies: ["BMK2024", .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.15.3")]),

    ]
)
