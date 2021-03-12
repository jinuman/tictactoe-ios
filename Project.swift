import ProjectDescription

let projectName: String = "TicTacToe"
let deploymentTargetVersion: String = "11.0"

// MARK: - Actions

let targetActions = [
    TargetAction.post(
        path: "Scripts/SwiftlintRunScript.sh",
        arguments: [],
        name: "SwiftLint"
    )
]


// MARK: - Settings

let appTargetSettings = Settings(
    base: [
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)",
    ]
)
let frameworkTargetSettings = Settings(
    base: [
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)",
    ]
)
let testsTargetSettings = Settings(
    base: [
        "ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES": "$(inherited)"
    ]
)


// MARK: - Project

let project = Project(
    name: "\(projectName)",
    targets: [
        Target(
            name: "\(projectName)",
            platform: .iOS,
            product: .app,
            bundleId: "com.jinuman.\(projectName)",
            deploymentTarget: .iOS(targetVersion: deploymentTargetVersion, devices: .iphone),
            infoPlist: InfoPlist(stringLiteral: "Projects/\(projectName)/Supporting Files/\(projectName)-Info.plist"),
            sources: ["Projects/\(projectName)/Sources/**"],
            resources: ["Projects/\(projectName)/Resources/**"],
            actions: targetActions,
            dependencies: [
                .cocoapods(path: "."),
            ],
            settings: appTargetSettings
        ),
        Target(
            name: "\(projectName)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "com.jinuman.\(projectName)Tests",
            infoPlist: .default,
            sources: ["Projects/\(projectName)/Tests/**"],
            dependencies: [
                .target(name: "\(projectName)"),
            ],
            settings: testsTargetSettings
        )
    ]
)
