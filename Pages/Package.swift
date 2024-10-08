// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package: Package = .init(
    name: .pages,
    platforms: [.iOS],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .pagesProduct
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .kingFisherPackageDependency,
        .networkPackageDependency,
        .nukePackageDependency,
        .sharedPackageDependency
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .pagesTarget,
        .pagesTestTarget
    ]
)

fileprivate extension Product {

    static let pagesProduct: Product = .library(name: .pages,
                                               targets: [.pages])
}

fileprivate extension Package.Dependency {


    static let networkPackageDependency: Package.Dependency = package(path: "../Network")

    static let sharedPackageDependency: Package.Dependency = package(path: "../Shared")

    static let kingFisherPackageDependency: Package.Dependency = package(url: "https://github.com/onevcat/Kingfisher.git",
                                                                         exact: "7.10.2")

    static let nukePackageDependency: Package.Dependency = package(url: "https://github.com/kean/Nuke",
                                                                   exact: "12.5.0")

    static let swiftLintPackageDependency: Package.Dependency = package(url: "https://github.com/realm/SwiftLint",
                                                                        exact: "0.54.0")
}

fileprivate extension String {

    // MARK: Folders
    static let pages: String = "Pages"

    // MARK: Packages
    static let kingFisher: String = "Kingfisher"
    static let network: String = "Network"
    static let nuke: String = "Nuke"
    static let shared: String = "Shared"
    static let swiftLint: String = "SwiftLint"

    // MARK: Plugins
    static let swiftLintPlugin: String = "SwiftLintPlugin"

    var testTarget: String { "\(self)Tests" }
}

fileprivate extension SupportedPlatform {

    static let iOS: SupportedPlatform = .iOS(.v15)
}

fileprivate extension Target {

    static let pagesTarget: Target = target(name: .pages,
                                           dependencies: [.kingFisherDependency,
                                                          .networkDependency,
                                                          .nukeDependency,
                                                          .sharedDependency])
    static let pagesTestTarget: Target = testTarget(name: .pages.testTarget,
                                                   dependencies: [.pagesDependency])
}

fileprivate extension Target.Dependency {

    static let kingFisherDependency: Target.Dependency = byName(name: .kingFisher)
    static let networkDependency: Target.Dependency = byName(name: .network)
    static let nukeDependency: Target.Dependency = byName(name: .nuke)
    static let pagesDependency: Target.Dependency = byName(name: .pages)
    static let sharedDependency: Target.Dependency = byName(name: .shared)
}

fileprivate extension Target.PluginUsage {

    static let swiftLintPlugin: Target.PluginUsage = plugin(name: .swiftLintPlugin,
                                                            package: .swiftLint)
}

