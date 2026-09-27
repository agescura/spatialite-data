import Dependencies
import SpatiaLiteData
import SQLiteData
import SwiftUI
import Playgrounds
import GRDB

struct ContentView: View {
    var body: some View {
        Text("CaseStudies")
            .task {
                @Dependency(\.spatialDatabase)
                var database
                
                do {
                    guard let database else {
                        print("No SpatialDatabase")
                        return
                    }
                    
                    try database.read { db in
                        let version = try String.fetchOne(
                            db,
                            sql: "SELECT sqlite_version()"
                        )
                        
                        print("SQLite:", version ?? "nil")
                    }
                    
                    try database.read { db in
                        let result = try String.fetchOne(
                            db,
                            sql: "SELECT spatialite_version()"
                        )
                        
                        print("SpatiaLite:", result ?? "nil")
                    }
                    
                    try database.read { db in
                        let count = try Int.fetchOne(
                            db,
                            sql: "SELECT COUNT(*) FROM spatial_ref_sys"
                        )

                        print("SRID count:", count ?? 0)
                    }
                    
                    try database.read { db in
                        let tables = try String.fetchAll(
                            db,
                            sql: """
                            SELECT name
                            FROM sqlite_master
                            WHERE type = 'table'
                            ORDER BY name
                            """
                        )

                        for table in tables {
                            print(table)
                        }
                    }
                    
                    try database.read { db in
                        let rows = try Row.fetchAll(
                            db,
                            sql: """
                            SELECT *
                            FROM spatial_ref_sys
                            WHERE srid = 4326
                            """
                        )

                        for row in rows {
                            print(row["srid"] as Int)
                            print(row["auth_name"] as String)
                            print(row["ref_sys_name"] as String)
                        }
                    }
                    
                    try database.read { db in
                        let row = try Row.fetchOne(
                            db,
                            sql: """
                            SELECT
                                srid,
                                auth_name,
                                ref_sys_name
                            FROM spatial_ref_sys
                            WHERE srid = 4326
                            """
                        )

                        if let row {
                            print("SRID:", row["srid"] as Int)
                            print("Authority:", row["auth_name"] as String)
                            print("Name:", row["ref_sys_name"] as String)
                        }
                    }
                    
                    try database.read { db in
                        let point = try Row.fetchOne(
                            db,
                            sql: """
                            SELECT MakePoint(2.1686, 41.3874, 4326)
                            """
                        )

                        print(point ?? "nil")
                    }
                } catch {
                    print("Database error:", error)
                }
            }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
