# SwiftSpatialite

**SpatiaLite for iOS, packaged for Swift Package Manager.**

SwiftSpatialite makes it possible to use the power of [SpatiaLite](https://www.gaia-gis.it/fossil/libspatialite/index) and its geospatial ecosystem directly from native iOS applications.

It provides a Swift Package Manager distribution of SpatiaLite together with the native libraries required for spatial database operations, making it easier to build offline-first and location-aware applications.

[![Swift](https://img.shields.io/badge/Swift-6.3-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-15%2B-lightgrey.svg)](https://developer.apple.com/ios/)
[![Xcode](https://img.shields.io/badge/Xcode-27%2B-blue.svg)](https://developer.apple.com/xcode/)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://www.swift.org/package-manager/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

---

## Why SwiftSpatialite?

SQLite is an excellent database for local data, but many applications working with geographic information need more than standard relational queries.

SpatiaLite adds a complete spatial layer to SQLite, providing support for geometries, spatial relationships, measurements and coordinate reference systems.

On iOS, however, integrating SpatiaLite can require building and linking several native dependencies.

**SwiftSpatialite packages that stack into a Swift Package Manager dependency.**

Instead of managing the native libraries yourself:

```text
Your iOS application
        │
        ├── SQLite
        ├── SpatiaLite
        ├── GEOS
        └── PROJ
```

you can depend on:

```text
Your iOS application
        │
        └── SwiftSpatialite
                │
                ├── SQLite
                ├── SpatiaLite
                ├── GEOS
                └── PROJ
```

---

## Features

* 📦 Swift Package Manager integration
* 📱 Native iOS support
* 🗄️ SQLite database with SpatiaLite
* 🌍 Spatial SQL operations
* 📍 Geometry and geographic data support
* 📐 Spatial measurements and relationships
* 🔄 Coordinate transformations through PROJ
* ⚡ Native `arm64` iOS binaries
* 🧩 Designed to work with Swift database abstractions
* 💾 Suitable for offline-first applications

---

## Requirements

| Requirement  | Version |
| ------------ | ------- |
| iOS          | 15.0+   |
| Swift        | 6.3+    |
| Xcode        | 27+     |
| Architecture | arm64   |

---

## Installation

### Xcode

In Xcode:

1. Select **File → Add Package Dependencies…**
2. Enter:

```text
https://github.com/agescura/swift-spatialite.git
```

3. Select the desired version.
4. Add the `SwiftSpatialite` product to your application target.

### Swift Package Manager

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/agescura/swift-spatialite.git",
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
            name: "SwiftSpatialite",
            package: "swift-spatialite"
        )
    ]
)
```

---

## Getting started

Import the package:

```swift
import SwiftSpatialite
```

Create a spatial database:

```swift
let database = try SpatialDatabase()
```

The database can then be used as the foundation for local spatial data operations.

For example, SpatiaLite allows spatial calculations to be performed directly inside SQLite:

```sql
SELECT ST_Distance(
    MakePoint(-0.1276, 51.5072, 4326),
    MakePoint(2.3522, 48.8566, 4326)
);
```

This approach allows spatial calculations to remain close to the data instead of moving geometry processing into the application layer.

---

## Spatial databases on iOS

A typical application architecture can use SwiftSpatialite as the local spatial database layer:

```text
┌───────────────────────────────────┐
│              iOS App              │
├───────────────────────────────────┤
│         Swift / SwiftUI           │
├───────────────────────────────────┤
│       Application Data Layer      │
├───────────────────────────────────┤
│       SQLite / SpatiaLite         │
├───────────────────────────────────┤
│          GEOS        PROJ         │
└───────────────────────────────────┘
```

This makes SwiftSpatialite particularly useful for applications that need to work with geographic data while offline.

---

## Use cases

SwiftSpatialite can be used as a foundation for applications such as:

### 🗺️ Offline maps

Store geographic data locally and perform spatial queries without requiring a network connection.

### 🥾 Outdoor applications

Store and process hiking tracks, routes, waypoints and other geographic information directly on the device.

### 🚴 Route applications

Perform local distance calculations, geometry operations and spatial queries.

### 📍 Location-based applications

Combine Core Location with spatial database queries to work with geographic datasets stored locally.

### 🧭 Navigation

Use spatial data and coordinate transformations as part of an on-device navigation system.

### 🌐 GIS applications

Use SQLite as a lightweight local spatial database for geographic datasets.

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
* Spatial relationships
* Geometry transformations
* Coordinate reference systems
* Coordinate transformations

For the complete list of spatial functions, see the [SpatiaLite documentation](https://www.gaia-gis.it/fossil/libspatialite/index).

---

## GEOS and PROJ

SwiftSpatialite brings together the native components required by the spatial stack.

### GEOS

[GEOS](https://libgeos.org/) provides the computational geometry functionality used by SpatiaLite for operations such as:

* Geometry relationships
* Intersection
* Buffering
* Distance calculations
* Geometry validity
* Spatial predicates

### PROJ

[PROJ](https://proj.org/) provides coordinate reference system and coordinate transformation functionality.

This allows geographic data using different coordinate systems to be transformed locally on the device.

---

## Database abstraction

SwiftSpatialite is designed to work alongside higher-level Swift database libraries.

An application can keep its existing database abstraction for standard relational data while using SpatiaLite for spatial operations.

For example:

```text
┌─────────────────────────────┐
│        Swift Models        │
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

This makes it possible to combine conventional application persistence with spatial SQL without introducing a separate spatial database server.

---

## Example architecture

A typical offline-first application could use:

```text
                    iOS Application
                          │
              ┌───────────┴───────────┐
              │                       │
        Application Data        Geographic Data
              │                       │
              └───────────┬───────────┘
                          │
                     SQLite DB
                          │
                     SpatiaLite
                    ┌─────┴─────┐
                    │           │
                   GEOS        PROJ
```

All spatial processing can therefore happen locally on the device.

---

## Building from source

Clone the repository:

```bash
git clone https://github.com/agescura/swift-spatialite.git
cd swift-spatialite
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

## Project structure

The repository is organized as a standard Swift Package:

```text
swift-spatialite/
│
├── Package.swift
├── Sources/
│   └── SwiftSpatialite/
│
├── Tests/
│
├── README.md
└── LICENSE
```

The package keeps the Swift-facing API separate from the underlying native spatial libraries.

---

## Versioning

SwiftSpatialite follows [Semantic Versioning](https://semver.org/).

### Current version

**0.0.1**

The project is currently in the `0.x` development phase. APIs and package structure may evolve before the `1.0.0` release.

---

## Roadmap

The project is currently focused on providing a reliable native SpatiaLite foundation for iOS applications.

Potential future improvements include:

* [ ] Expanded Swift API
* [ ] Improved database lifecycle management
* [ ] Additional spatial convenience APIs
* [ ] More comprehensive test coverage
* [ ] Example iOS application
* [ ] Swift Package Index documentation
* [ ] Additional architectures/platforms where appropriate
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

SwiftSpatialite is released under the **MIT License**.

See [LICENSE](LICENSE) for details.

### Third-party software

SwiftSpatialite integrates and distributes third-party open-source software.

The respective licenses and copyright notices of those projects apply to their corresponding components.

* [SpatiaLite](https://www.gaia-gis.it/fossil/libspatialite/index)
* [SQLite](https://www.sqlite.org/)
* [GEOS](https://libgeos.org/)
* [PROJ](https://proj.org/)

---

## Author

Created and maintained by **[@agescura](https://github.com/agescura)**.

---

<p align="center">
  <strong>SwiftSpatialite</strong><br>
  Spatial SQLite for native iOS applications.
</p>
