//
//  Xmas.swift
//  day-04
//
//  Created by Dragan Cecavac on 04.12.24.
//

class Xmas {
    let matrix: [[Character]]
    let height: Int
    let width: Int

    init(_ data: String) {
        matrix = data.split(separator: "\n").map { Array(String($0)) }
        height = matrix.count
        width = matrix[0].count
    }

    func exists(direction: [(Int, Int)]) -> Bool {
        for element in direction {
            if element.0 < 0
                || element.0 >= height
                || element.1 < 0
                || element.1 >= width {
                return false
            }
        }
        return true
    }

    func eightWaysDirections(i iExternal: Int, j jExternal: Int) -> [[(Int, Int)]] {
        var directions = [
            [(0, 0), (0, 1), (0, 2), (0, 3)], // right
            [(0, 0), (0, -1), (0, -2), (0, -3)], // left
            [(0, 0), (1, 0), (2, 0), (3, 0)], // down
            [(0, 0), (-1, 0), (-2, 0), (-3, 0)], // up
            [(0, 0), (1, 1), (2, 2), (3, 3)], // down right
            [(0, 0), (1, -1), (2, -2), (3, -3)], // down left
            [(0, 0), (-1, 1), (-2, 2), (-3, 3)], // up right
            [(0, 0), (-1, -1), (-2, -2), (-3, -3)], // up left
        ]

        for i in directions.indices {
            for j in directions[i].indices {
                directions[i][j].0 += iExternal
                directions[i][j].1 += jExternal
            }
        }

        return directions
    }

    func xShapedDirections(i iExternal: Int, j jExternal: Int) -> [[(Int, Int)]] {
        var directions = [
            [(0, 0), (-1, -1), (1, -1), (-1, 1), (1, 1)], // "A", "M", "M", "S", "S"
            [(0, 0), (-1, 1), (1, 1), (-1, -1), (1, -1)], // "A", "S", "S", "M", "M"
            [(0, 0), (-1, -1), (-1, 1), (1, 1), (1, -1)], // "A", "M", "S", "S", "M"
            [(0, 0), (1, 1), (1, -1), (-1, -1), (-1, 1)], // "A", "S", "S", "M", "M"
        ]

        for i in directions.indices {
            for j in directions[i].indices {
                directions[i][j].0 += iExternal
                directions[i][j].1 += jExternal
            }
        }

        return directions
    }

    func find(useXShape: Bool) -> Int {
        var result = 0

        let border = 3
        let pattern: [Character]
        if useXShape {
            pattern = ["A", "M", "M", "S", "S"]
        } else {
            pattern = ["X", "M", "A", "S"]
        }
        for i in (0 - border)...(height + border) {
            for j in (0 - border)...(width + border) {
                let directions: [[(Int, Int)]]
                if useXShape {
                    directions = xShapedDirections(i: i, j: j)
                } else {
                    directions = eightWaysDirections(i: i, j: j)
                }

                for direction in directions {
                    if exists(direction: direction) {
                        let chars = direction.map{ matrix[$0.0][$0.1] }
                        if chars == pattern {
                            result += 1
                        }
                    }
                }
            }
        }

        return result
    }
}
