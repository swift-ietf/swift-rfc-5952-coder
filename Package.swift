// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-rfc-5952-coder",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "RFC 5952 Coder",
            targets: ["RFC 5952 Coder"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-ascii.git", branch: "main", traits: ["Parser", "Serializer"]),
        .package(url: "https://github.com/swift-atoms/swift-serializer.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-4291.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-4291-coder.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-4648.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5952.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-span.git", branch: "main", traits: ["Iterator"]),
        .package(url: "https://github.com/swift-atoms/swift-ratio.git", branch: "main", traits: ["Bit", "Ordinal", "Difference"]),
    ],
    targets: [
        .target(
            name: "RFC 5952 Coder",
            dependencies: [
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "RFC 4291", package: "swift-rfc-4291"),
                .product(name: "RFC 4291 Coder", package: "swift-rfc-4291-coder"),
                .product(name: "RFC 4648", package: "swift-rfc-4648"),
                .product(name: "RFC 5952", package: "swift-rfc-5952"),
                .product(name: "Serializer", package: "swift-serializer"),
            ]
        ),
        .testTarget(
            name: "RFC 5952 Coder Tests",
            dependencies: [
                "RFC 5952 Coder",
                .product(name: "ASCII", package: "swift-ascii"),
                .product(name: "RFC 4291", package: "swift-rfc-4291"),
                .product(name: "RFC 4291 Coder", package: "swift-rfc-4291-coder"),
                .product(name: "RFC 5952", package: "swift-rfc-5952"),
                .product(name: "Serializer", package: "swift-serializer"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
