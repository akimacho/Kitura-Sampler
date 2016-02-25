import PackageDescription

let package = Package(
    name: "Logging",
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura-router.git", versions: Version(0,2,0)..<Version(0,3,0)),
        .Package(url: "https://github.com/IBM-Swift/HeliumLogger.git", versions: Version(0,2,0)..<Version(0,3,0)),
        .Package(url: "https://github.com/IBM-Swift/LoggerAPI.git", versions: Version(0,2,0)..<Version(0,3,0)),
    ]
)