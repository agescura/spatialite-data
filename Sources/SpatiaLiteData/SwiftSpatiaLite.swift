@_exported import SpatiaGIS
import SQLiteData
import GRDB

public enum SwiftSpatiaLite {
    public static let version = "0.1.0"

    public static func testSQLiteConnection(_ db: Database) -> Bool {
        db.sqliteConnection != nil
    }
}
