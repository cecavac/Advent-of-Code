//
//  Gondola.swift
//  day-03
//
//  Created by Dragan Cecavac on 03.12.23.
//

import Foundation

class Gondola {
    private var data = [[Character]]()
    private var numbers = Set<Number>()

    private var height: Int {
        data.count
    }

    private var width: Int {
        data[0].count
    }

    init(_ input: String) {
        let lines = input.split(separator: "\n").map { String($0) }
        for line in lines {
            data.append(Array(line))
        }

        for i in 0..<height {
            for j in 0..<width {
                if isNumber(i: i, j: j) {
                    numbers.insert(getNumber(i: i, j: j))
                }
            }
        }
    }

    private func isWithinBounds(i: Int, j: Int) -> Bool {
        return i >= 0 && i < height && j >= 0 && j < width
    }

    private func isNumber(i: Int, j: Int) -> Bool {
        return isWithinBounds(i: i, j: j) && Int(String(data[i][j])) != nil
    }

    private func isSpecialChar(i: Int, j: Int) -> Bool {
        return isWithinBounds(i: i, j: j) && !isNumber(i: i, j: j) && data[i][j] != "."
    }

    private func getNumber(i: Int, j: Int) -> Number {
        var start = j
        while isNumber(i: i, j: start - 1) {
            start -= 1
        }

        var end = j
        while isNumber(i: i, j: end + 1) {
            end += 1
        }

        var value = 0
        for numberJ in start...end {
            value *= 10
            value += Int(String(data[i][numberJ]))!
        }

        return Number(i: i, startJ: start, endJ: end, value: value)
    }

    private func getSurroundingNumbers(i: Int, j: Int) -> Set<Number> {
        var numbers = Set<Number>()

        for offsetI in  (i - 1)...(i + 1) {
            for offsetJ in  (j - 1)...(j + 1) {
                if isNumber(i: offsetI, j: offsetJ) {
                    numbers.insert(getNumber(i: offsetI, j: offsetJ))
                }
            }
        }

        return numbers
    }

    private func isSurroundedBySpecialCharacter(number: Number) -> Bool {
        for i in (number.i - 1)...(number.i + 1) {
            for j in (number.startJ - 1)...(number.endJ + 1) {
                if isSpecialChar(i: i, j: j) {
                    return true
                }
            }
        }
        return false
    }

    func partNumbers() -> Int {
        return numbers
            .filter { isSurroundedBySpecialCharacter(number: $0) }
            .map{ $0.value }
            .reduce(0, +)
    }

    func gearRatio() -> Int {
        var result = 0

        for i in 0..<height {
            for j in 0..<width {
                if data[i][j] == "*" {
                    let surroundingNumbers = getSurroundingNumbers(i: i, j: j)
                    if surroundingNumbers.count == 2 {
                        result += surroundingNumbers.map { $0.value }.reduce(1, *)
                    }
                }
            }
        }

        return result
    }
}
