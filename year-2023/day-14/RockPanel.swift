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
        for i in 1..<height {
            for j in 0..<width {
                if matrix[i][j] == "O" && matrix[i - 1][j] == "." {
                    var newI = i
                    for z in (0..<i).reversed() {
                        if matrix[z][j] == "." {
                            newI = z
                        } else {
                            break
                        }
                    }

                    let temp = matrix[newI][j]
                    matrix[newI][j] = matrix[i][j]
                    matrix[i][j] = temp

                }
            }
        }
    }

    func slideWest() {
        for j in 1..<width {
            for i in 0..<height {
                if matrix[i][j] == "O" && matrix[i][j - 1] == "." {
                    var newJ = j
                    for z in (0..<j).reversed() {
                        if matrix[i][z] == "." {
                            newJ = z
                        } else {
                            break
                        }
                    }

                    let temp = matrix[i][newJ]
                    matrix[i][newJ] = matrix[i][j]
                    matrix[i][j] = temp
                }
            }
        }
    }

    func slideSouth() {
        for i in (0..<height - 1).reversed() {
            for j in 0..<width {
                if matrix[i][j] == "O" && matrix[i + 1][j] == "." {
                    var newI = i
                    for z in i + 1..<height {
                        if matrix[z][j] == "." {
                            newI = z
                        } else {
                            break
                        }
                    }

                    let temp = matrix[newI][j]
                    matrix[newI][j] = matrix[i][j]
                    matrix[i][j] = temp
                }
            }
        }
    }

    func slideEast() {
        for j in (0..<width - 1).reversed() {
            for i in 0..<height {
                if matrix[i][j] == "O" && matrix[i][j + 1] == "." {
                    var newJ = j
                    for z in j + 1..<width {
                        if matrix[i][z] == "." {
                            newJ = z
                        } else {
                            break
                        }
                    }

                    let temp = matrix[i][newJ]
                    matrix[i][newJ] = matrix[i][j]
                    matrix[i][j] = temp
                }
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
