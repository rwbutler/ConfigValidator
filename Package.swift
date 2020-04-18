// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Config Validator",
    platforms: [
        .macOS("10.13")
    ],
    products: [
        .executable(
            name: "config-validator",
            targets: ["Config Validator"]
        )
    ],
    targets: [
        .target(
            name: "Config Validator",
            path: "Sources/config-validator/"
        )
    ]
)
