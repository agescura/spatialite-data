import GRDB
import SQLiteData

public final class SpatialDatabase {
    private let dbQueue: DatabaseQueue
    
    private var spatialite: SpatialiteConnection?
    
    public init() throws {
        let queue = try DatabaseQueue()

        self.dbQueue = queue

        try queue.write { db in
            self.spatialite = try SpatialiteConnection(database: db)

            try db.execute(
                sql: "SELECT InitSpatialMetaData()"
            )
        }
    }
    
    public func prepareSpatialData() {
        prepareDependencies {
            $0.defaultDatabase = self.dbQueue
        }
    }
    
    public func read<T>(
        _ body: (Database) throws -> T
    ) throws -> T {
        try dbQueue.read(body)
    }

    public func write<T>(
        _ body: (Database) throws -> T
    ) throws -> T {
        try dbQueue.write(body)
    }
}
