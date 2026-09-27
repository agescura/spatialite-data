import Dependencies
import GRDB
import SQLiteData

public final class SpatialDatabase: @unchecked Sendable {
    private let dbQueue: DatabaseQueue
    private let spatialite: SpatialiteConnection
    
    public init(path: String) throws {
        let queue = try DatabaseQueue(path: path)
        
        self.dbQueue = queue
        self.spatialite = try queue.write { db in
            try SpatialiteConnection(database: db)
        }
    }
    
    public var writer: any DatabaseWriter {
        dbQueue
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

private enum SpatialDatabaseKey: DependencyKey {
    static let liveValue: SpatialDatabase? = nil
}

extension DependencyValues {
    public var spatialDatabase: SpatialDatabase? {
        get { self[SpatialDatabaseKey.self] }
        set { self[SpatialDatabaseKey.self] = newValue }
    }
}
