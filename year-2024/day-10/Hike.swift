//
//  Hike.swift
//  day-10
//
//  Created by Dragan Cecavac on 10.12.24.
//

class Hike {
    let map: [[Int]]

    init(_ data: String) {
        map = data.split(separator: "\n")
            .map { line in
                Array(String(line)).map{ Int(String($0))! }
            }

    }

    func trails() -> Int {
        var result = 0

        for i in map.indices {
            for j in map[0].indices {
                if map[i][j] == 0 {
                    result += Route(map).trails(i: i, j: j).count
                }
            }
        }

        return result
    }

    func trailheads() -> Int {
        var result = 0

        for i in map.indices {
            for j in map[0].indices {
                if map[i][j] == 0 {
                    result += Route(map).trailheads(i: i, j: j)
                }
            }
        }

        return result
    }
}
