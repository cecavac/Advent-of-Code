//
//  FishCounter.swift
//  Advent06
//
//  Created by Dragan Cecavac on 06.12.21.
//

import Foundation

class FishCounter {
    var stages = [Int](repeating: 0, count: 9)

    init(_ input: String) {
        let values = input.split(separator: ",")
        for value in values {
            stages[Int(String(value))!] += 1
        }
    }

    func wait(days: Int) -> Int {
        for _ in 0..<days {
            let fishGivingBirth = stages.remove(at: 0)

            stages[6] += fishGivingBirth
            stages.append(fishGivingBirth)
        }

        return stages.reduce(0, +)
    }
}
