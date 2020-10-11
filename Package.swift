// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let core = "AppleReceiptValidator"
let cli = "AppleReceiptValidatorCLI"

let package = Package(
  name: core,
  products: [
    .library(
      name: core,
      targets: [core]
    ),
    .executable(
      name: cli,
      targets: [cli]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", .revision("d3919b7b760a5d2311e5ebc67884d96e444acefd")),
  ],
  targets: [
    .target(
      name: core,
      dependencies: [],
      path: "Sources/\(core)"
    ),

    .target(
      name: cli,
      dependencies: [
        .byName(name: core),
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ],
      path: "Sources/\(cli)"
    ),
  ]
)
