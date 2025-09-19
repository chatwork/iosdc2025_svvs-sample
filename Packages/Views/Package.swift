// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Views",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Views",
            targets: ["Views"]
        ),
    ],
    dependencies: [
        .package(path: "../Entities"),
        .package(path: "../Stores"),
        .package(path: "../ViewStates"),
    ],
    targets: [
        .target(
            name: "Views",
            dependencies: [
                "Entities",
                "Stores",
                "ViewStates",
            ]
        ),
    ]
)
