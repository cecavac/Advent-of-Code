//
//  Energy.swift
//  day-03
//
//  Created by Dragan Cecavac on 03.12.25.
//

class Energy {
    let levels: Array<Array<Int>>

    init(_ data: String) {
        levels = data.split(separator: "\n")
            .map { line in
                line.compactMap { Int(String($0)) }
            }
    }

    func findMax(level: Array<Int>, elements: Int) -> Int {
        var current = level
        var result = 0

        for i in 1...elements {
            let range = 0..<(current.count + i - elements)
            let max = current[range].max()!
            result *= 10
            result += max

            let index = current.firstIndex(of: max)!
            current.removeFirst(index + 1)
        }

        return result
    }

    func calculate(elements: Int) -> Int {
        return levels.map { findMax(level: $0, elements: elements) }
            .reduce(0, +)
    }
}
