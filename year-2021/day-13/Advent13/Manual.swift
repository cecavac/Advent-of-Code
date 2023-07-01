//
//  Manual.swift
//  Advent13
//
//  Created by Dragan Cecavac on 13.12.21.
//

import Foundation

class Maual {
    var maxI = 0
    var maxJ = 0
    var page: [[Character]]
    var folds: [(String, Int)] = []

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            if line.contains(",") {
                let coordinates = line.split(separator: ",")
                maxI = max(maxI, Int(String(coordinates[1]))! + 1)
                maxJ = max(maxJ, Int(String(coordinates[0]))! + 1)
            } else {
                let marker: String
                if line.contains("x") {
                    marker = "x"
                } else {
                    marker = "y"
                }

                let foldParts = line.split(separator: "=")
                let value = Int(String(foldParts[1]))!

                folds.append((marker, value))
            }
        }

        page = Array(repeating: Array(repeating: ".", count: maxJ), count: maxI)

        for line in lines {
            if line.contains(",") {
                let coordinates = line.split(separator: ",")
                let i = Int(String(coordinates[1]))!
                let j = Int(String(coordinates[0]))!
                page[i][j] = "#"
            }
        }
    }

    func show() {
        for i in 0..<maxI {
            var row = ""
            for j in 0..<maxJ {
                row += "\(page[i][j])"
            }
            print(row)
        }
    }

    func foldHorizontally(at: Int) {
        for j in (at + 1)..<maxJ {
            for i in 0..<maxI {
                if page[i][j] == "#" {
                    page[i][(2 * at) - j] = "#"
                }
            }
        }

        maxJ = at
    }

    func foldVertically(at: Int) {
        for i in (at + 1)..<maxI {
            for j in 0..<maxJ {
                if page[i][j] == "#" {
                    page[(2 * at) - i][j] = "#"
                }
            }
        }

        maxI = at
    }

    func foldOne() {
        if folds[0].0 == "x" {
            foldHorizontally(at: folds[0].1)
        } else {
            foldVertically(at: folds[0].1)
        }

        folds.remove(at: 0)
    }

    func foldAll () {
        while folds.count > 0 {
            foldOne()
        }
    }

    func countDots() -> Int {
        var result = 0

        for i in 0..<maxI {
            for j in 0..<maxJ {
                if page[i][j] == "#" {
                    result += 1
                }
            }
        }

        return result
    }
}
