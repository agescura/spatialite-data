import GRDB
import SpatiaGIS

public final class SpatialiteConnection: @unchecked Sendable {
    private let cache: UnsafeMutableRawPointer

    public init(database: Database) throws {
        guard let sqlite = database.sqliteConnection else {
            throw SpatialiteError.invalidConnection
        }

        guard let cache = spatialite_alloc_connection() else {
            throw SpatialiteError.initializationFailed
        }

        spatialite_init_ex(sqlite, cache, 0)
        self.cache = cache
    }

    deinit {
        spatialite_cleanup_ex(cache)
    }
}

public enum SpatialiteError: Error {
    case invalidConnection
    case initializationFailed
}
