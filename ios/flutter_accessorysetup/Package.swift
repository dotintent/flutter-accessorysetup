// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_accessorysetup",
    platforms: [
        .iOS("18.0")
    ],
    products: [
        .library(
            name: "flutter-accessorysetup",
            // type: .dynamic,
            targets: ["flutter_accessorysetup", "flutter_accessorysetup_swift"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "flutter_accessorysetup",
            publicHeadersPath: "public_headers",
            linkerSettings: [
                .linkedFramework("AccessorySetupKit"),
                .linkedFramework("Foundation"),
                .unsafeFlags(["-fvisibility=default"])
            ]
        ),
        .target(
            name: "flutter_accessorysetup_swift",
            dependencies: [],
            resources: [],
            linkerSettings: [
                .linkedFramework("AccessorySetupKit"),
                .linkedFramework("UIKit"),
                .linkedFramework("Security"),
                .linkedFramework("Foundation"),
            ]
        )
    ]
)
