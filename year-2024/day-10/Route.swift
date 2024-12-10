//
//  Route.swift
//  day-10
//
//  Created by Dragan Cecavac on 10.12.24.
//

class Route {
    let map: [[Int]]
    let height: Int
    let width: Int

    let deltas = [(0, 1), (0, -1), (1, 0), (-1, 0)]

    init(_ map: [[Int]]) {
        self.map = map
        height = map.count
        width = map[0].count
    }

    func trails(i: Int, j: Int) -> Set<String> {
        let value = map[i][j]
        var result = Set<String>()

        for delta in deltas {
            let offsetI = i + delta.0
            let offsetJ = j + delta.1

            if exists(i: offsetI, j: offsetJ) {
                if value != 8 {
                    if map[offsetI][offsetJ] == value + 1 {
                        result.formUnion(trails(i: offsetI, j: offsetJ))
                    }
                } else {
                    if map[offsetI][offsetJ] == 9 {
                        result.insert("\(offsetI)#\(offsetJ)")
                    }
                }
            }
        }

        return result
    }

    func trailheads(i: Int, j: Int) -> Int {
        var result = 0
        let value = map[i][j]

        for delta in deltas {
            let offsetI = i + delta.0
            let offsetJ = j + delta.1

            if exists(i: offsetI, j: offsetJ) {
                if value != 8 {
                    if map[offsetI][offsetJ] == value + 1 {
                        result += trailheads(i: offsetI, j: offsetJ)
                    }
                } else {
                    if map[offsetI][offsetJ] == 9 {
                        result += 1
                    }
                }
            }
        }

        return result
    }

    func exists(i: Int, j: Int) -> Bool {
        return i >= 0 && i < height && j >= 0 && j < width
    }
}
