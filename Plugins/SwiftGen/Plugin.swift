import Foundation
import PackagePlugin

@main
struct SwiftGenPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        let swiftGenConfigFile = context.package.directory.appending("swiftgen.yml")

        let swiftGenOutputsDir = context.pluginWorkDirectory.appending("SwiftGenOutputs")
        try FileManager.default.createDirectory(atPath: swiftGenOutputsDir.string, withIntermediateDirectories: true)
        let swiftGenPath = try context.tool(named: "swiftgen").path

        // the Assets.swift file will be generated at
        // .build/plugins/outputs/plugintest/PluginTest/SwiftGenPlugin/SwiftGenOutputs
        // and will be compiled as part of the package
        Diagnostics.remark(swiftGenConfigFile.string)
        Diagnostics.remark(swiftGenOutputsDir.string)
        Diagnostics.remark(swiftGenPath.string)

        return [
            .prebuildCommand(
            displayName: "Running SwiftGen",
            executable: swiftGenPath,
            arguments: [
                "config",
                "run",
                "--verbose",
                "--config", "\(swiftGenConfigFile)"
            ],
            environment: [
                "PROJECT_DIR": "\(context.package.directory)",
                "TARGET_NAME": "\(target.name)",
                "DERIVED_SOURCES_DIR": "\(swiftGenOutputsDir)",
            ],
            outputFilesDirectory: swiftGenOutputsDir)
        ]
    }
}
