//
//  RockPanel.swift
//  day-14
//
//  Created by Dragan Cecavac on 14.12.23.
//

import Foundation

class RockPanel {
    var matrix = [[Character]]()
    let height: Int
    let width: Int

    var cache = [String:Int]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            matrix.append(Array(String(line)))
        }

        height = matrix.count
        width=matrix[0].count
    }

    func slideNorth() {
        while true {
            var changed = false

            for i in 1..<height {
                for j in 0..<width {
                    if matrix[i][j] == "O" && matrix[i - 1][j] == "." {
                        matrix[i - 1][j] = "O"
                        matrix[i][j] = "."

                        changed = true
                    }
                }
            }

            if !changed {
                break
            }
        }
    }

    func slideWest() {
        while true {
            var changed = false

            for j in 1..<width {
                for i in 0..<height {
                    if matrix[i][j] == "O" && matrix[i][j - 1] == "." {
                        matrix[i][j - 1] = "O"
                        matrix[i][j] = "."

                        changed = true
                    }
                }
            }

            if !changed {
                break
            }
        }
    }

    func slideSouth() {
        while true {
            var changed = false

            for i in (0..<height - 1).reversed() {
                for j in 0..<width {
                    if matrix[i][j] == "O" && matrix[i + 1][j] == "." {
                        matrix[i + 1][j] = "O"
                        matrix[i][j] = "."

                        changed = true
                    }
                }
            }

            if !changed {
                break
            }
        }
    }

    func slideEast() {
        while true {
            var changed = false

            for j in (0..<width - 1).reversed() {
                for i in 0..<height {
                    if matrix[i][j] == "O" && matrix[i][j + 1] == "." {
                        matrix[i][j + 1] = "O"
                        matrix[i][j] = "."

                        changed = true
                    }
                }
            }

            if !changed {
                break
            }
        }
    }

    func spin() {
        let goal = 1000000000
        for i in 0..<goal {
            var signature = ""
            for i in 0..<height {
                signature += String(matrix[i])
            }

            if let iteration = cache[signature] {
                let cycleSize = iteration - i
                let remainingCycles = goal - i
                let reducedCycles = remainingCycles % cycleSize

                for _ in 0..<reducedCycles {
                    slideNorth()
                    slideWest()
                    slideSouth()
                    slideEast()
                }

                return
            }

            cache[signature] = i

            slideNorth()
            slideWest()
            slideSouth()
            slideEast()
        }
    }

    func northLoad() -> Int {
        var result = 0
        slideNorth()

        for i in 0..<height {
            for j in 0..<width {
                if matrix[i][j] == "O" {
                    result += height - i
                }
            }
        }

        return result
    }

    func cycleLoad() -> Int {
        var result = 0
        spin()

        for i in 0..<height {
            for j in 0..<width {
                if matrix[i][j] == "O" {
                    result += height - i
                }
            }
        }

        return result
    }
}
