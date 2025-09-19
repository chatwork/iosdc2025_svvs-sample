// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chatwork",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Chatwork",
            targets: ["Chatwork"]
        ),
        .library(
            name: "ChatworkAPIClient",
            targets: ["ChatworkAPIClient"]
        ),
        .library(
            name: "ChatworkRepositories",
            targets: ["ChatworkRepositories"]
        ),
        .library(
            name: "LocalDataClient",
            targets: ["LocalDataClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2"),
        .package(path: "../Entities"),
        .package(path: "../Repositories"),
        .package(path: "../Stores"),
        .package(path: "../Views"),
        .package(path: "../ViewStates"),
    ],
    targets: [
        .target(
            name: "Chatwork",
            dependencies: [
                "ChatworkRepositories",
                "Entities",
                "Repositories",
                "Stores",
                "Views",
                "ViewStates",
            ]
        ),
        .target(
            name: "ChatworkAPIClient",
            dependencies: [
                "Entities",
            ]
        ),
        .target(
            name: "LocalDataClient",
            dependencies: [
                "Entities",
                "KeychainAccess",
            ]
        ),
        .target(
            name: "ChatworkRepositories",
            dependencies: [
                "Entities",
                "ChatworkAPIClient",
                "LocalDataClient",
                "Repositories"
            ]
        ),
    ]
)
