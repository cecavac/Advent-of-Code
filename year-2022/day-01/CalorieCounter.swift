//
//  CalorieCounter.swift
//  Advent01
//
//  Created by Dragan Cecavac on 01.12.22.
//

import Foundation

class CalorieCounter {
    static func count(_ input: String, backpacks: Int) -> Int {
        var calories = [Int]()

        for elfInput in input.split(separator: "\n\n") {
            let items = elfInput.split(separator: "\n")
            calories.append(items.map { Int(String($0))! }.reduce(0, +))
        }

        return calories.sorted().reversed()[0..<backpacks].reduce(0, +)
    }
}
