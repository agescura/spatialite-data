import SwiftUI
import SpatiaLiteData
import SQLiteData
import Dependencies

@main struct MyApp: App {
    init() {
        prepareDependencies {
            try! $0.bootstrapDatabase()
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension DependencyValues {
    mutating func bootstrapDatabase() throws {
        let url = FileManager.default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("CaseStudies.sqlite")

        try FileManager.default.createDirectory(
            at: url.deletingLastPathComponent(),
            withIntermediateDirectories: true
        )

        let database = try SpatialDatabase(
            path: url.path
        )

        var migrator = DatabaseMigrator()

        migrator.registerMigration("spatialMetadata") { db in
            try db.execute(
                sql: "SELECT InitSpatialMetaData()"
            )
        }

        try migrator.migrate(database.writer)

        self.spatialDatabase = database
        self.defaultDatabase = database.writer
    }
}

enum Schema {
    static func migrate(_ migrator: inout DatabaseMigrator) {
        migrator.registerMigration("v1") { db in
            try db.execute(
                sql: "SELECT InitSpatialMetaData()"
            )
        }
    }
}
