# SpatiaLiteData

**Spatial SQLite for Swift and Apple platforms.**

SpatiaLiteData provides a Swift Package Manager integration for [SpatiaLite](https://www.gaia-gis.it/fossil/libspatialite/index), bringing spatial database capabilities to native Swift applications.

It combines a Swift-facing API with a native SpatiaLite-based spatial engine, allowing applications to store, query and process geographic data locally using SQLite and spatial SQL.

[![Swift](https://img.shields.io/badge/Swift-6.4-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-16%2B-lightgrey.svg)](https://developer.apple.com/ios/)
[![Xcode](https://img.shields.io/badge/Xcode-27%2B-blue.svg)](https://developer.apple.com/xcode/)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://www.swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## Why SpatiaLiteData?

SQLite is an excellent embedded database, but applications working with geographic data often need more than conventional relational queries.

[SpatiaLite](https://www.gaia-gis.it/fossil/libspatialite/index) extends SQLite with spatial capabilities, including geometries, spatial relationships, measurements and coordinate reference systems.

Using those capabilities directly from an Apple application traditionally requires dealing with native libraries and their build configuration.

**SpatiaLiteData packages the spatial stack as a Swift Package Manager dependency.**

Instead of managing the native spatial components independently:

```text
Your Swift application

        │
        ├── SQLite
        ├── SpatiaLite
        ├── GEOS
        └── PROJ
```

you can depend on:

```text
Your Swift application

        │
        └── SpatiaLiteData
                │
                └── Internals
                        │
                        ├── SpatiaLite
                        ├── GEOS
                        └── PROJ
```

This makes spatial database functionality available as part of a regular Swift Package Manager dependency.

---

## Features

* 📦 Swift Package Manager integration
* 🗄️ SQLite + SpatiaLite spatial database capabilities
* 🌍 Spatial SQL operations
* 📍 Geographic geometry support
* 📐 Spatial measurements and relationships
* 🔄 Coordinate reference systems and transformations
* ⚡ Native Apple-platform binaries
* 🧩 Integration with Swift database abstractions
* 💾 Suitable for offline-first applications
* 🗺️ Designed for applications working with geographic data

---

## Supported Platforms

| Platform | Minimum version |
| -------- | --------------- |
| iOS      | 16.0+           |
| macOS    | 13.0+           |
| tvOS     | 16.0+           |
| watchOS  | 9.0+            |

### Toolchain

| Requirement           | Version             |
| --------------------- | ------------------- |
| Swift                 | 6.4+                |
| Swift Package Manager | Included with Swift |
| Xcode                 | 27+                 |

---

## Installation

### Xcode

In Xcode:

1. Select **File → Add Package Dependencies…**
2. Enter:

```text
https://github.com/agescura/spatialite-data.git
```

3. Select the desired version.
4. Add the **SpatiaLiteData** product to your target.

### Swift Package Manager

Add the package dependency:

```swift
dependencies: [
    .package(
        url: "https://github.com/agescura/spatialite-data.git",
        from: "0.0.1"
    )
]
```

Then add the product to your target:

```swift
.target(
    name: "MyApp",
    dependencies: [
        .product(
            name: "SpatiaLiteData",
            package: "spatialite-data"
        )
    ]
)
```

---

## Getting Started

Import the package:

```swift
import SpatiaLiteData
```

SpatiaLiteData provides a Swift-facing layer for working with SQLite and SpatiaLite.

Spatial operations can be expressed using SQL:

```sql
SELECT ST_Distance(
    MakePoint(-0.1276, 51.5072, 4326),
    MakePoint(2.3522, 48.8566, 4326)
);
```

The main advantage of this approach is that geographic operations can be performed close to the data rather than requiring geometries to be transferred to application-level Swift code.

---

## Spatial Database Architecture

A typical application can use SpatiaLiteData as its local geographic data layer:

```text
┌─────────────────────────────────────┐
│             Swift App               │
├─────────────────────────────────────┤
│          Swift / SwiftUI            │
├─────────────────────────────────────┤
│        Application Data Layer       │
├─────────────────────────────────────┤
│       SQLite / SpatiaLite           │
├─────────────────────────────────────┤
│        Native Spatial Engine        │
│          GEOS        PROJ           │
└─────────────────────────────────────┘
```

This architecture is particularly useful for applications that need to work with geographic data without depending on a remote spatial database.

---

## Use Cases

### 🗺️ Offline Maps

Store geographic datasets locally and perform spatial queries without a network connection.

### 🥾 Outdoor Applications

Store and process:

* Tracks
* Routes
* Waypoints
* Points of interest
* Geographic datasets

directly on the device.

### 🚴 Route Applications

Perform local operations such as:

* Distance calculations
* Spatial relationships
* Geometry operations
* Route analysis

### 📍 Location-Based Applications

Combine [Core Location](https://developer.apple.com/documentation/corelocation) with local spatial queries to work with geographic datasets on-device.

### 🧭 Navigation

Use spatial data as part of an on-device navigation engine, including route matching, proximity queries and geographic calculations.

### 🌐 GIS Applications

Use SQLite as an embedded spatial database for geographic datasets and GIS-oriented applications.

---

## Spatial SQL

Because SpatiaLite extends SQLite, spatial functionality can be accessed through SQL.

Depending on the operation, applications can work with:

* Points
* LineStrings
* Polygons
* Multi-geometries
* Bounding boxes
* Distances
* Intersections
* Spatial predicates
* Geometry transformations
* Coordinate reference systems
* Coordinate transformations

See the [SpatiaLite documentation](https://www.gaia-gis.it/fossil/libspatialite/index) for the complete set of spatial functionality.

---

## GEOS and PROJ

SpatiaLiteData relies on the native spatial ecosystem provided by SpatiaLite and its associated libraries.

### GEOS

[GEOS](https://libgeos.org/) provides computational geometry functionality used for operations such as:

* Geometry relationships
* Intersection
* Buffering
* Distance calculations
* Geometry validity
* Spatial predicates

### PROJ

[PROJ](https://proj.org/) provides coordinate reference system and coordinate transformation functionality.

This makes it possible to transform geographic data between coordinate systems locally on the device.

---

## Swift Database Integration

SpatiaLiteData is designed to work alongside Swift database abstractions.

The package can be used alongside [SQLiteData](https://github.com/pointfreeco/sqlite-data), allowing applications to combine conventional application persistence with spatial capabilities.

A possible architecture is:

```text
┌─────────────────────────────┐
│        Swift Models         │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│      Application Layer      │
└──────────────┬──────────────┘
               │
        ┌──────┴──────┐
        ▼             ▼
   Relational      Spatial
     queries       queries
        │             │
        └──────┬──────┘
               ▼
        SQLite / SpatiaLite
```

This allows an application to keep its existing Swift data model while using spatial SQL for geographic operations.

---

## Package Architecture

The package separates the public Swift API from the underlying native spatial implementation:

```text
SpatiaLiteData
│
├── SpatiaLiteData
│   └── Public Swift API
│
└── Internals
    └── Native spatial implementation
```

The `Internals` target contains the implementation details required by the public package and keeps the native spatial dependencies behind the package's public API.

---

## Building From Source

Clone the repository:

```bash
git clone https://github.com/agescura/spatialite-data.git
cd spatialite-data
```

Build the package:

```bash
swift build
```

Run the tests:

```bash
swift test
```

---

## Project Structure

```text
spatialite-data/
│
├── Package.swift
├── Sources/
│   ├── SpatiaLiteData/
│   └── Internals/
│
├── Tests/
│
└── README.md
```

---

## Versioning

SpatiaLiteData follows [Semantic Versioning](https://semver.org/).

### Current version

**0.0.1**

The project is currently in the `0.x` development phase. APIs and package structure may evolve before a `1.0.0` release.

---

## Roadmap

The project is currently focused on providing a reliable native spatial database foundation for Swift applications.

Potential future improvements include:

* [ ] Expanded Swift spatial API
* [ ] More spatial convenience APIs
* [ ] Improved database lifecycle management
* [ ] More comprehensive test coverage
* [ ] Example iOS application
* [ ] Swift Package Index documentation
* [ ] Additional Apple platforms and architectures where appropriate
* [ ] Stable `1.0.0` API

The roadmap may evolve as the package matures.

---

## Contributing

Contributions are welcome.

If you find a bug, have a feature request or want to improve the project:

1. Open an issue describing the problem or proposal.
2. Fork the repository.
3. Create a feature branch.
4. Make your changes.
5. Run the test suite.
6. Open a pull request.

For larger changes, opening an issue first is recommended so the proposed approach can be discussed.

---

## License

SpatiaLiteData is released under the **MIT License**.

See [LICENSE](LICENSE) for details.

### Third-Party Software

SpatiaLiteData builds on open-source projects including:

* [SpatiaLite](https://www.gaia-gis.it/fossil/libspatialite/index)
* [SQLite](https://www.sqlite.org/)
* [GEOS](https://libgeos.org/)
* [PROJ](https://proj.org/)
* [SQLiteData](https://github.com/pointfreeco/sqlite-data)
* [StructuredQueries](https://github.com/pointfreeco/swift-structured-queries)

The respective licenses and copyright notices of these projects apply to their corresponding components.

---

## Author

Created and maintained by **[@agescura](https://github.com/agescura)**.

---

<p align="center">
  <strong>SpatiaLiteData</strong><br>
  Spatial SQLite for Swift.
</p>

