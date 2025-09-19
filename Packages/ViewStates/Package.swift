// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewStates",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "ViewStates",
            targets: ["ViewStates"]
        ),
    ],
    dependencies: [
        .package(path: "../Entities"),
        .package(path: "../Repositories"),
        .package(path: "../Stores"),
    ],
    targets: [
        .target(
            name: "ViewStates",
            dependencies: [
                "Entities",
                "Stores"
            ]
        ),
        .testTarget(
            name: "ViewStatesTests",
            dependencies: [
                "Entities",
                "Repositories",
                "Stores",
                .product(name: "UnimplementedStores", package: "Stores"),
                "ViewStates",
            ]
        ),
    ]
)
