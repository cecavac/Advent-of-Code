//
//  Room.swift
//  Advent18
//
//  Created by Dragan Cecavac on 29.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Room {
    var fields: [[Character]] = []
    var numberOfSafeTiles = 0

    init(_ input: String, rows: Int) {
        var observedRow = Array(input)
        countSafeTiles(row: observedRow)

        for _ in 1..<rows {
            var newRow: [Character] = []

            for i in 0..<observedRow.count {
                var c1: Character
                if i > 0 {
                    c1 = observedRow[i - 1]
                } else {
                    c1 = "."
                }

                let c2 = observedRow[i]

                var c3: Character
                if i < observedRow.count - 1 {
                    c3 = observedRow[i + 1]
                } else {
                    c3 = "."
                }

                let element = determineType(a: c1, b: c2, c: c3)
                newRow.append(element)
            }

            observedRow = newRow
            countSafeTiles(row: observedRow)
        }
    }

    private func determineType(a: Character, b: Character, c: Character) -> Character {
        if (a == "^" && b == "^" && c == ".") ||
            (a == "." && b == "^" && c == "^") ||
            (a == "^" && b == "." && c == ".") ||
            (a == "." && b == "." && c == "^") {
            return "^"
        } else {
            return "."
        }
    }

    private func countSafeTiles(row input: [Character]) {
        for element in input {
            if element == "." {
                numberOfSafeTiles += 1
            }
        }
    }
}
