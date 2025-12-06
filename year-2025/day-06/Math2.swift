//
//  Math2.swift
//  day-06
//
//  Created by Dragan Cecavac on 06.12.25.
//

class Math2 {
    let numbers: Array<Array<Int>>
    let operations: Array<String>

    init(_ data: String) {
        var lines = data.split(separator: "\n")

        operations = lines.removeLast()
            .split(separator: " ")
            .map { String($0) }

        let breakLine: Array<Character> = Array(repeating: Character(" "), count: lines.count)
        var transposedLines = Array(repeating: Array<Character>(), count: lines[0].count)
        for line in lines {
            let array = Array(String(line))
            for j in array.indices {
                transposedLines[j].append(array[j])
            }
        }

        var transposedNumbers = Array<Array<Int>>()
        transposedNumbers.append(Array<Int>())
        for line in transposedLines {
            if line == breakLine {
                transposedNumbers.append(Array<Int>())
                continue
            }

            let rowIndex = transposedNumbers.count - 1
            let numberString = line.filter { $0 != " " }
                .map { String($0) }.joined()
            transposedNumbers[rowIndex].append(Int(numberString)!)
        }

        numbers = transposedNumbers
    }

    func sum() -> Int {
        var results = operations.map {
            if $0 == "*" {
                return 1
            } else {
                return 0
            }
        }

        for i in numbers.indices {
            for j in numbers[i].indices {
                if operations[i] == "*" {
                    results[i] *= numbers[i][j]
                } else {
                    results[i] += numbers[i][j]
                }
            }
        }

        return results.reduce(0, +)
    }
}
