//
//  Locator.swift
//  day-08
//
//  Created by Dragan Cecavac on 08.12.24.
//

class Locator {
    let map: [[Character]]
    var antennas = Set<Character>()
    var antinodes = [String:Bool]()

    init(_ data: String) {
        map = data.split(separator: "\n")
            .map { Array(String($0)) }

        for row in map {
            for char in row {
                if char != "." {
                    antennas.insert(char)
                }
            }
        }
    }

    func getPositions(antenna: Character) -> [(Int, Int)] {
        var positions = [(Int, Int)]()

        for i in map.indices {
            for j in map[0].indices {
                if map[i][j] == antenna {
                    positions.append((i, j))
                }
            }
        }

        return positions
    }

    func markAntinodes(position: (Int, Int), distance: (Int, Int), resonate: Bool) {
        var antinode = position
        if !resonate {
            antinode.0 -= distance.0
            antinode.1 -= distance.1
        }

        while withinBounds(i: antinode.0, j: antinode.1) {
            antinodes["\(antinode.0)#\(antinode.1)"] = true
            if !resonate {
                break
            }

            antinode.0 -= distance.0
            antinode.1 -= distance.1
        }
    }

    func locate(resonate: Bool) -> Int {
        for antenna in antennas {
            let positions = getPositions(antenna: antenna)

            for p1 in positions.indices {
                if p1 == positions.count - 1 {
                    continue
                }

                for p2 in (p1 + 1)...(positions.count - 1) {
                    let distanceI = positions[p2].0 - positions[p1].0
                    let distanceJ = positions[p2].1 - positions[p1].1

                    markAntinodes(position: positions[p1], distance: (distanceI, distanceJ), resonate: resonate)
                    markAntinodes(position: positions[p2], distance: (-distanceI, -distanceJ), resonate: resonate)
                }
            }
        }

        return antinodes.count
    }

    func withinBounds(i: Int, j: Int) -> Bool {
        return i >= 0 && i < height && j >= 0 && j < width
    }

    var height: Int {
        return map.count
    }

    var width: Int {
        return map[0].count
    }
}
