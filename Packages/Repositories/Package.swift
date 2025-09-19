// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repositories",
    platforms: [
        .iOS(.v26),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Repositories",
            targets: ["Repositories"]
        ),
        .library(
            name: "UnimplementedRepositories",
            targets: ["UnimplementedRepositories"]
        )
    ],
    dependencies: [
        .package(path: "../Entities"),
    ],
    targets: [
        .target(
            name: "Repositories",
            dependencies: [
                "Entities",
            ]
        ),
        .target(
            name: "UnimplementedRepositories",
            dependencies: [
                "Entities",
                "Repositories",
            ]
        ),
    ]
)
