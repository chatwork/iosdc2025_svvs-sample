// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Stores",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Stores",
            targets: ["Stores"]
        ),
        .library(
            name: "UnimplementedStores",
            targets: ["UnimplementedStores"]
        ),
    ],
    dependencies: [
        .package(path: "../Entities"),
        .package(path: "../Repositories"),
    ],
    targets: [
        .target(
            name: "Stores",
            dependencies: [
                "Entities",
                "Repositories",
            ]
        ),
        .target(
            name: "UnimplementedStores",
            dependencies: [
                "Entities",
                "Stores",
                .product(name: "UnimplementedRepositories", package: "Repositories"),
            ]
        ),
    ]
)
