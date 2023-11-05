import ProjectDescription

let bundleId = "dev.nazmul.tuisty"
let version = "0.0.1"
let bundleVersion = "1"
let iOSTargetVersion = "17.0"
let basePath = "Targets/Tuisty"
let projectName = "Tuisty"
let appName = "TuistyApp"

let appTarget = Target(
    name: appName,
    platform: .iOS,
    product: .app,
    bundleId: bundleId,
    deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: .iphone),
    infoPlist: makeInfoPlist(),
    sources: ["\(basePath)/Sources/**"],
    resources: ["\(basePath)/Resources/**"],
    settings: baseSettings()
)

let project = Project(
    name: projectName,
    settings: Settings.settings(configurations: makeConfigurations()),
    targets: [appTarget],
    additionalFiles: ["README.md"]
)

func makeInfoPlist(merging other: [String: Plist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: Plist.Value] = [
        "UIApplicationSceneManifest": ["UIApplicationSupportsMultipleScenes": true],
        "UILaunchScreen": [],
        "UISupportedInterfaceOrientations": "UIInterfaceOrientationPortrait",
        "CFBundleShortVersionString": "\(version)",
        "CFBundleVersion": "\(bundleVersion)",
        "CFBundleDisplayName": "($APP_DISPLAY_NAME)"
    ]

    other.forEach { key, value in
        extendedPlist[key] = value
    }

    return InfoPlist.extendingDefault(with: extendedPlist)
}

func makeConfigurations() -> [Configuration] {
    let debug = Configuration.debug(name: "Debug", xcconfig: "Configs/Debug.xcconfig")
    let release = Configuration.debug(name: "Release", xcconfig: "Configs/Release.xcconfig")
    return [debug, release]
}

func baseSettings() -> Settings {
    let settings = SettingsDictionary()
    return Settings.settings(
        base: settings,
        configurations: [],
        defaultSettings: .recommended
    )
}

