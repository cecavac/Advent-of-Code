//
//  Garden.swift
//  day-21
//
//  Created by Dragan Cecavac on 21.12.23.
//

import Foundation

class Garden {
    var matrix = [[Character]]()
    var steps = [[Int]]()

    var startI = 0
    var startJ = 0
    var height = 0
    var width = 0

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for i in lines.indices {
            let lineArray = Array(String(lines[i]))
            for j in lineArray.indices {
                if lineArray[j] == "S" {
                    startI = i
                    startJ = j
                }
            }
            matrix.append(lineArray)
        }

        height = lines.count
        width = lines[0].count

        steps = Array(repeating: Array(repeating: 0, count: width), count: height)
        steps[startI][startJ] = 1
        matrix[startI][startJ] = "."
    }

    func move() {
        var newSteps = Array(repeating: Array(repeating: 0, count: width), count: height)

        for i in 0..<height {
            for j in 0..<width {
                var maxSteps = 0
                let offsets = [
                    (0, 1),     // right
                    (0, -1),    // left
                    (1, 0),     // down
                    (-1, 0)     // up
                ]
                for offset in offsets {
                    let offsetI = i + offset.0
                    let offsetJ = j + offset.1
                    if offsetI >= 0 && offsetI < height && offsetJ >= 0 && offsetJ < width {
                        if (matrix[i][j] == "." && matrix[offsetI][offsetJ] == ".") {
                            maxSteps = max(maxSteps, steps[offsetI][offsetJ])
                        }
                    }
                }
                newSteps[i][j] = maxSteps
            }
        }
        steps = newSteps
    }

    func count(steps go: Int) -> Int {
        for _ in 0..<go {
            move()
        }

        var result = 0
        for i in 0..<height {
            for j in 0..<width {
                result += steps[i][j]
            }
        }
        return result
    }

    func corners() -> Int {
        var result = 0
        let center = startI

        for i in 0..<height {
            for j in 0..<width {
                if abs(i - startI) + abs(j - startJ) > center {
                    result += steps[i][j]
                }
            }
        }

        return result
    }

    func possibilities(steps: Int) -> Int {
        let oddHelper = Garden(Input.Input1)
        let oddFieldSize = oddHelper.count(steps: height)
        let oddCorners = oddHelper.corners()

        let evenHelper = Garden(Input.Input1)
        let evenFieldSize = evenHelper.count(steps: height + 1)
        let evenCorners = evenHelper.corners()

        let furthestField = steps / height
        let oddFields = (furthestField + 1) * (furthestField + 1)
        let evenFields = furthestField * furthestField

        let oddPots = oddFieldSize * oddFields - (furthestField + 1) * oddCorners
        let evenPots = evenFieldSize * evenFields + furthestField * evenCorners
        return oddPots + evenPots
    }
}
