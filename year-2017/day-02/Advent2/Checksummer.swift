//
//  Checksummer.swift
//  Advent2
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Checksummer {
    var data: [[Int]] = []

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let numbers = line.split(separator: " ")
            var row = Array<Int>()

            for number in numbers {
                row.append(Int(String(number))!)
            }

            data.append(row)
        }
    }

    public func getChecksum() -> Int {
        var result = 0

        for row in data {
            var maxElement = Int.min
            var minElement = Int.max

            for element in row {
                maxElement = max(maxElement, element)
                minElement = min(minElement, element)
            }

            result += maxElement - minElement
        }

        return result
    }

    public func getDividibleChecksum() -> Int {
        var result = 0

        for row in data {
            var found = false

            for i in 0..<row.count {
                for j in 0..<row.count {
                    if i == j {
                        continue
                    }

                    if row[i] % row[j] == 0 {
                        result += row[i] / row[j]
                        found = true
                    }
                }

                if found {
                    break
                }
            }
        }

        return result
    }
}
