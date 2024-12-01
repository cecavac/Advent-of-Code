//
//  Locator.swift
//  day-01
//
//  Created by Dragan Cecavac on 01.12.24.
//

class Locator {
    var left = Array<Int>()
    var right = Array<Int>()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let elements = line.split(separator: " ")
            left.append(Int(String(elements[0]))!)
            right.append(Int(String(elements[1]))!)
        }

        left.sort()
        right.sort()
    }

    var totalDistance: Int {
        return left.enumerated()
            .map { index, leftNumber in abs(leftNumber - right[index])}
            .reduce(0, +)
    }

    var similarityScore: Int {
        return left.map { leftNumber in
            leftNumber * right.filter { $0 == leftNumber }.count
        }.reduce(0, +)
    }
}
