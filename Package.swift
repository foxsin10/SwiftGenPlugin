// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGenPlugin",
    products: [
        .plugin(name: "SwiftGenPlugin", targets: ["SwiftGenPlugin"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PluginTest",
            dependencies: [],
            resources: [
                .process("Media.xcassets")
            ],
            swiftSettings: [
                .define("SWIFT_PACKAGE")
            ],
            plugins: [
                "SwiftGenPlugin"
            ]
        ),
        .testTarget(
            name: "PluginTestTests",
            dependencies: ["PluginTest"]),
        .plugin(
            name: "SwiftGenPlugin",
            capability: .buildTool(),
            dependencies: [
                "swiftgen"
            ],
            path: "./Plugins"
        ),
        .binaryTarget(
            name: "swiftgen",
            url: "https://github.com/nicorichard/SwiftGen/releases/download/6.5.1/swiftgen.artifactbundle.zip",
            checksum: "a8e445b41ac0fd81459e07657ee19445ff6cbeef64eb0b3df51637b85f925da8"
        )
    ]
)
