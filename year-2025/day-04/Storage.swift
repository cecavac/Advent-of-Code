//
//  Storage.swift
//  day-04
//
//  Created by Dragan Cecavac on 04.12.25.
//

class Storage {
    var area: Array<Array<Character>>
    var totalRemoved = 0

    init(_ data: String) {
        area = data.split(separator: "\n")
            .map { Array(String($0)) }
    }

    func isValid(i: Int, j: Int) -> Bool {
        return i >= 0 && i < area.count
        && j >= 0 && j < area.first!.count
    }

    func getNeighbors(i: Int, j: Int) -> [(Int, Int)] {
        var neighbors = [(Int,Int)]()
        let offsets = [
            (0, 1),
            (0, -1),
            (1, 0),
            (-1, 0),
            (1, 1),
            (1, -1),
            (-1, 1),
            (-1, -1),
        ]

        for offset in offsets {
            let offsetI = i + offset.0
            let offsetJ = j + offset.1
            if isValid(i: offsetI, j: offsetJ) && area[offsetI][offsetJ] == "@" {
                neighbors.append((offsetI, offsetJ))
            }
        }
        return neighbors
    }

    func getAccessible() -> [[Character]] {
        var accesible: [[Character]] = Array(repeating: Array(repeating: "?", count: area.first!.count), count: area.count)
        for i in area.indices {
            for j in area.first!.indices {
                if area[i][j] == "@" {
                    let neighbors = getNeighbors(i: i, j: j)
                    if neighbors.count < 4 {
                        accesible[i][j] = "@"
                    }
                }
            }
        }
        return accesible
    }

    func removeElements() -> Int {
        let accesible = getAccessible()
        var removed = 0
        for i in accesible.indices {
            for j in accesible.first!.indices {
                if accesible[i][j] == "@" {
                    removed += 1
                    area[i][j] = "."
                }
            }
        }

        totalRemoved += removed
        return removed
    }

    func removeAll() -> Int {
        while removeElements() != 0 {}
        return totalRemoved
    }
}
