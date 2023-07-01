//
//  Boulders.swift
//  Advent18
//
//  Created by Dragan Cecavac on 18.12.22.
//

import Foundation

class Boulders {
    var cubes = Set<Cube>()

    var minX = Int.max
    var maxX = Int.min
    var minY = Int.max
    var maxY = Int.min
    var minZ = Int.max
    var maxZ = Int.min

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            let cube = Cube(String(line))
            cubes.insert(cube)
            maxX = max(maxX, cube.x)
            minX = min(minX, cube.x)
            maxY = max(maxY, cube.y)
            minY = min(minY, cube.y)
            maxZ = max(maxZ, cube.z)
            minZ = min(minZ, cube.z)
        }
    }

    func adjacents(cube current: Cube, against set: Set<Cube>) -> Int {
        return set.filter { $0.isAdjacent(to: current) }.count
    }

    func nonadjacentSides() -> Int {
        return cubes.map { 6 - adjacents(cube: $0, against: cubes) }.reduce(0, +)
    }

    func collectAirCubes() -> Set<Cube> {
        var airCubes = Set<Cube>()

        for x in minX...maxX {
            for y in minY...maxY {
                for z in minZ...maxZ {
                    let airCube = Cube(x: x, y: y, z: z)
                    if !cubes.contains(airCube) {
                        airCubes.insert(airCube)
                    }
                }
            }
        }

        return airCubes
    }

    func findInternalAirCubes() -> Set<Cube> {
        // Generate a large rectangle following the air border
        var externalCubes = Set<Cube>()
        for x in (minX - 1)...(maxX + 1) {
            for z in (minZ - 1)...(maxZ + 1) {
                let externalCube1 = Cube(x: x, y: minY - 1, z: z)
                let externalCube2 = Cube(x: x, y: maxY + 1, z: z)
                externalCubes.insert(externalCube1)
                externalCubes.insert(externalCube2)
            }
        }
        for y in (minY - 1)...(maxY + 1) {
            for z in (minZ - 1)...(maxZ + 1) {
                let externalCube1 = Cube(x: minX - 1, y: y, z: z)
                let externalCube2 = Cube(x: maxX + 1, y: y, z: z)
                externalCubes.insert(externalCube1)
                externalCubes.insert(externalCube2)
            }
        }
        for x in (minX - 1)...(maxX + 1) {
            for y in (minY - 1)...(maxY + 1) {
                let externalCube1 = Cube(x: x, y: y, z: minZ - 1)
                let externalCube2 = Cube(x: x, y: y, z: maxZ + 1)
                externalCubes.insert(externalCube1)
                externalCubes.insert(externalCube2)
            }
        }

        var airCubes = collectAirCubes()

        // Combine all external air cubes layer by layer until obsidian is reached
        // and trimm it from the air cubes which are within the rectangle
        var changed: Bool
        repeat {
            changed = false
            var newExternalCubes = Set<Cube>()
            for airCube in airCubes {
                if !externalCubes.contains(airCube) &&
                    adjacents(cube: airCube, against: externalCubes) > 0 {
                    changed = true
                    newExternalCubes.insert(airCube)
                }
            }
            externalCubes = externalCubes.union(newExternalCubes)
            for newExternalCube in newExternalCubes {
                airCubes.remove(newExternalCube)
            }

        } while changed

        return airCubes
    }

    func exterior(allSides: Int) -> Int {
        var sides = allSides
        let internalAirCubes = findInternalAirCubes()

        for airCube in internalAirCubes {
            sides -= cubes.filter { airCube.isAdjacent(to: $0) }.count
        }

        return sides
    }
}
