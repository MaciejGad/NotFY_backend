// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "NotfyApp",
    platforms: [
        .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.115.0"),
        // 🔵 Non-blocking, event-driven networking for Swift. Used for custom executors
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.65.0"),
        // fluent ORM for Swift, used for database interactions
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        // fluent MySQL driver for database interactions
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "NotfyApp",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "NotfyAppTests",
            dependencies: [
                .target(name: "NotfyApp"),
                .product(name: "VaporTesting", package: "vapor"),
            ],
            swiftSettings: swiftSettings
        )
    ]
)

var swiftSettings: [SwiftSetting] { [
    .enableUpcomingFeature("ExistentialAny"),
] }
