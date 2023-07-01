//
//  CrabNavy.swift
//  Advent07
//
//  Created by Dragan Cecavac on 07.12.21.
//

import Foundation

class CrabNavy {
    var positions = [Int]()

    init(_ input: String) {
        let values = input.split(separator: ",")
        for value in values {
            positions.append(Int(String(value))!)
        }
    }

    func fuelToMiddle(uniformSpending: Bool) -> Int {
        let minimum = positions.min()!
        let maximum = positions.max()!

        var bestFuel = Int.max
        for testPosition in minimum...maximum {
            var fuel = 0
            for position in positions {
                let distance = abs(position - testPosition)

                if uniformSpending {
                    fuel += distance
                } else {
                    fuel += distance * (1 + distance) / 2
                }
            }
            bestFuel = min(bestFuel, fuel)
        }

        return bestFuel
    }
}
