import PackageDescription

let package = Package(
    name: "Basic", 
    dependencies: [
        .Package(url: "https://github.com/IBM-Swift/Kitura-router.git", versions: Version(0,2,0)..<Version(0,3,0)),
    ]
)
