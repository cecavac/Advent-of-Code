//
//  Lights.swift
//  Advent18
//
//  Created by Dragan Cecavac on 29.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Lights {
    private let width: Int
    private let height: Int
    private var matrix: [[Bool]] = Array(repeating: Array(repeating: false, count: 100), count: 100)

    init(_ input:String) {
        let lines = input.split(separator: "\n")
        height = lines.count
        width = lines[0].count

        for i in 0..<height {
            let line = Array(lines[i])
            for j in 0..<width {
                if line[j] == "#" {
                    matrix[i][j] = true
                }
            }
        }
    }

    private func activateCorners() {
        matrix[0][0] = true
        matrix[0][width - 1] = true
        matrix[height - 1][0] = true
        matrix[height - 1][width - 1] = true
    }

    private func animate() {
        let matrixCopy = matrix
        for i in 0..<height {
            for j in 0..<width {
                var liveNeighbors = 0

                if i > 0 && matrixCopy[i - 1][j] {
                    liveNeighbors += 1
                }

                if i < (height - 1) && matrixCopy[i + 1][j] {
                    liveNeighbors += 1
                }

                if j > 0 && matrixCopy[i][j - 1] {
                    liveNeighbors += 1
                }

                if j < (width - 1) && matrixCopy[i][j + 1] {
                    liveNeighbors += 1
                }

                if i > 0 && j > 0 && matrixCopy[i - 1][j - 1] {
                    liveNeighbors += 1
                }

                if i > 0 && j < (width - 1) && matrixCopy[i - 1][j + 1] {
                    liveNeighbors += 1
                }

                if i < (height - 1) && j > 0 && matrixCopy[i + 1][j - 1] {
                    liveNeighbors += 1
                }

                if i < (height - 1) && j < (width - 1) && matrixCopy[i + 1][j + 1] {
                    liveNeighbors += 1
                }

                if matrixCopy[i][j] {
                    matrix[i][j] = liveNeighbors == 2 || liveNeighbors == 3
                } else {
                    matrix[i][j] = liveNeighbors == 3
                }
            }
        }
    }

    public func animate(times ticks: Int, stuck cornersOn: Bool) -> Int {
        var result = 0

        if cornersOn {
            activateCorners()
        }
        for _ in 0..<ticks {
            animate()
            if cornersOn {
                activateCorners()
            }
        }

        for i in 0..<height {
            for j in 0..<width {
                if matrix[i][j] {
                    result += 1
                }
            }
        }

        return result
    }
}
