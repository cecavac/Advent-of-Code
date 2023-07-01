//
//  Board.swift
//  Advent04
//
//  Created by Dragan Cecavac on 04.12.21.
//

import Foundation

class Board {
    struct Number {
        let value: Int
        var drawn = false
    }

    private var numbers = [[Number]]()
    var won = false
    var score = 0

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var row = [Number]()
            let values = line.split(separator: " ")
            for value in values {
                let number = Number(value: Int(String(value))!)
                row.append(number)
            }
            numbers.append(row)
        }
    }

    private func calculateScore(winningNumber: Int) {
        var sumOfUnmatched = 0

        for i in numbers.indices {
            for j in numbers.first!.indices {
                if !numbers[i][j].drawn {
                    sumOfUnmatched += numbers[i][j].value
                }
            }
        }

        score = sumOfUnmatched * winningNumber
    }

    private func findCombination(row: Int, column: Int) -> Bool {
        var rowMatch = true
        var columnMatch = true

        for z in numbers.first!.indices {
            rowMatch = rowMatch && numbers[row][z].drawn
            columnMatch = columnMatch && numbers[z][column].drawn
        }

        return rowMatch || columnMatch
    }

    func draw(_ value: Int) {
        for i in numbers.indices {
            for j in numbers.first!.indices {
                if numbers[i][j].value == value {
                    numbers[i][j].drawn = true
                    if findCombination(row: i, column: j) {
                        won = true
                        calculateScore(winningNumber: value)
                    }
                    return
                }
            }
        }
    }
}
