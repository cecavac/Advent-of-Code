//
//  Space.swift
//  day-11
//
//  Created by Dragan Cecavac on 11.12.23.
//

import Foundation

class Space {
    var matrix = [[Character]]()
    var weights: [[Int]]
    var width: Int
    var height: Int
    var points = [(Int, Int)]()

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            let lineArray = Array(String(line))
            matrix.append(lineArray)
        }

        height = matrix.count
        width = matrix[0].count
        weights = Array(repeating: Array(repeating: 1, count: width), count: height)

        findPoints()
    }

    private func findPoints() {
        for i in 0..<height {
            for j in 0..<width {
                if matrix[i][j] == "#" {
                    points.append((i, j))
                }
            }
        }
    }

    func expand(by increase: Int) {
        for i in (0..<height).reversed() {
            var empty = true
            for j in 0..<width {
                if matrix[i][j] == "#" {
                    empty = false
                    break
                }
            }
            if empty {
                for j in 0..<width {
                    weights[i][j] *= increase
                }
            }
        }

        for j in (0..<width).reversed() {
            var empty = true
            for i in 0..<height {
                if matrix[i][j] == "#" {
                    empty = false
                    break
                }
            }
            if empty {
                for i in 0..<height {
                    weights[i][j] *= increase
                }
            }
        }
    }

    func paths() -> Int {
        var result = 0

        var selectedPairs = [((Int, Int), (Int, Int))]()
        for i in 0..<(points.count - 1) {
            for j in (i + 1)..<points.count {
                selectedPairs.append(((points[i].0, points[i].1), (points[j].0, points[j].1)))
            }
        }

        for selectedPair in selectedPairs {
            let first = selectedPair.0
            let second = selectedPair.1

            var distance = 0
            for i in min(first.0, second.0)..<max(first.0, second.0) {
                distance += weights[i][first.1]
            }
            for j in min(first.1, second.1)..<max(first.1, second.1) {
                distance += weights[first.0][j]
            }
            result += distance
        }

        return result
    }
}
