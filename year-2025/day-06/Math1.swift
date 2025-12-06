//
//  Math1.swift
//  day-06
//
//  Created by Dragan Cecavac on 06.12.25.
//

class Math1 {
    let numbers: Array<Array<Int>>
    let operations: Array<String>

    init(_ data: String) {
        var lines = data.split(separator: "\n")

        operations = lines.removeLast()
            .split(separator: " ")
            .map { String($0) }

        numbers = lines.map { line in
            line.split(separator: " ")
                .compactMap { Int(String($0)) }
        }
    }

    func sum() -> Int {
        var results = numbers[0]
        for i in 1..<numbers.count {
            for j in results.indices {
                if operations[j] == "*" {
                    results[j] *= numbers[i][j]
                } else {
                    results[j] += numbers[i][j]
                }
            }
        }

        return results.reduce(0, +)
    }
}
