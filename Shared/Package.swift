// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package: Package = .init(
    name: .shared,
    platforms: [.iOS],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .sharedProduct
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .lottiePackageDependency,
        .nukePackageDependency
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .sharedTarget,
        .sharedTestTarget
    ]
)

fileprivate extension Product {

    static let sharedProduct: Product = .library(name: .shared,
                                               targets: [.shared])
}

fileprivate extension Package.Dependency {

    static let nukePackageDependency: Package.Dependency = package(url: "https://github.com/kean/Nuke",
                                                                   exact: "12.5.0")

    static let lottiePackageDependency: Package.Dependency = package(url: "https://github.com/airbnb/lottie-spm", exact: "4.4.1")

    static let swiftLintPackageDependency: Package.Dependency = package(url: "https://github.com/realm/SwiftLint",
                                                                        exact: "0.54.0")
}

fileprivate extension String {

    // MARK: Folders
    static let shared: String = "Shared"

    // MARK: Packages
    static let lottie: String = "Lottie"
    static let lottieSpm: String = "lottie-spm"
    static let nuke: String = "Nuke"

    static let swiftLint: String = "SwiftLint"

    // MARK: Plugins
    static let swiftLintPlugin: String = "SwiftLintPlugin"

    var testTarget: String { "\(self)Tests" }
}

fileprivate extension SupportedPlatform {

    static let iOS: SupportedPlatform = .iOS(.v15)
}

fileprivate extension Target {

    static let sharedTarget: Target = target(name: .shared,
                                             dependencies: [.lottieDependency,
                                                            .nukeDependency])

    static let sharedTestTarget: Target = testTarget(name: .shared.testTarget,
                                                     dependencies: [.sharedDependency])
}

fileprivate extension Target.Dependency {

    static let lottieDependency: Target.Dependency = product(name: .lottie,
                                                             package: .lottieSpm)

    static let nukeDependency: Target.Dependency = byName(name: .nuke)

    static let sharedDependency: Target.Dependency = byName(name: .shared)
}

fileprivate extension Target.PluginUsage {

    static let swiftLintPlugin: Target.PluginUsage = plugin(name: .swiftLintPlugin,
                                                            package: .swiftLint)
}

