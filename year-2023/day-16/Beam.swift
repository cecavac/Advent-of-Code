//
//  Beam.swift
//  day-16
//
//  Created by Dragan Cecavac on 16.12.23.
//

import Foundation

class Beam {
    var matrix = [[Character]]()
    var lights: [[Light]]
    let width: Int
    let height: Int

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            matrix.append(Array(String(line)))
        }
        height = matrix.count
        width = matrix[0].count
        lights = Array(repeating: Array(repeating: Light(), count: width), count: height)
    }

    func isValidPosition(_ i: Int, _ j: Int) -> Bool {
        return i >= 0 && i < height && j >= 0 && j < width
    }

    func canMove(_ i: Int, _ j: Int, _ direction: Direction) -> Bool {
        return isValidPosition(i, j) && !lights[i][j].directions.contains(direction)
    }

    func spread(_ startI: Int, _ startJ: Int, _ startDirection: Direction) {
        var i = startI
        var j = startJ
        var direction = startDirection

        if !isValidPosition(i, j) {
            return
        }
        lights[i][j].energize(direction: direction)

        while true {
            if matrix[i][j] == "|" &&
                        (direction == .LEFT || direction  == .RIGHT) {
                if canMove(i - 1, j, Direction.UP) {
                    spread(i - 1, j, Direction.UP)
                }
                if canMove(i + 1, j, Direction.DOWN) {
                    spread(i + 1, j, Direction.DOWN)
                }
                return
            }  else if matrix[i][j] == "-" &&
                        (direction == .UP || direction  == .DOWN) {
                if canMove(i, j - 1, Direction.LEFT) {
                    spread(i, j - 1, Direction.LEFT)
                }
                if canMove(i, j + 1, Direction.RIGHT) {
                    spread(i, j + 1, Direction.RIGHT)
                }
                return
            } else if matrix[i][j] == "/" || matrix[i][j] == "\\" {
                direction = direction.handleCorner(field: matrix[i][j])
            }

            let offsets = direction.offsets()
            i += offsets.0
            j += offsets.1

            if canMove(i, j, direction) {
                lights[i][j].energize(direction: direction)
            } else {
                return
            }
        }
    }

    func tryFourDirections(_ i: Int, _ j: Int) -> Int {
        var result = 0
        let directions: [Direction] = [.UP, .LEFT, .DOWN, .RIGHT]

        for direction in directions {
            lights = Array(repeating: Array(repeating: Light(), count: width), count: height)
            result = max(result, energized(startI: i, startJ: j, direction: direction))
        }

        return result
    }

    func energized(startI: Int = 0, startJ: Int = 0, direction: Direction = .RIGHT) -> Int {
        spread(startI, startJ, Direction.RIGHT)

        return lights.map{
            $0.filter { $0.energized() }.count
        }.reduce(0, +)
    }

    func bestEnergized() -> Int {
        var result = 0

        for i in 0..<height {
            result = max(result, tryFourDirections(i, 0))
            result = max(result, tryFourDirections(i, width - 1))
        }
        for j in 0..<width {
            result = max(result, tryFourDirections(0, j))
            result = max(result, tryFourDirections(height - 1, j))
        }

        return result
    }
}
