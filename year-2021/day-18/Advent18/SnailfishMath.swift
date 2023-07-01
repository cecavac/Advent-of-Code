//
//  SnailfishMath.swift
//  Advent18
//
//  Created by Dragan Cecavac on 18.12.21.
//

import Foundation

class SnailFishMath {
    let initialInput: String

    init(_ input: String) {
        initialInput = input
    }

    func reduce() -> Int{
        let lines = initialInput.split(separator: "\n")
        var register = SnailfishNumber(String(lines[0]))

        if lines.count > 1 {
            for i in 1..<lines.count {
                let newNumber = SnailfishNumber(String(lines[i]))
                register = register.add(newNumber)
                register.fullyReduce()
            }
        }

        return register.magnitude
    }

    func highestMagnitude() -> Int {
        var result = 0
        let lines = initialInput.split(separator: "\n")

        for i in lines.indices {
            for j in lines.indices {
                var register = SnailfishNumber(String(lines[i]))
                register = register.add(SnailfishNumber(String(lines[j])))
                register.fullyReduce()
                result = max(result, register.magnitude)
            }
        }

        return result
    }
}
