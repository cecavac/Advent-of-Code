//
//  Debugger.swift
//  Advent6
//
//  Created by Dragan Cecavac on 06.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Debugger {
    var states = Dictionary<String,Int>()
    var banks: [Int] = []

    init(_ input: String) {
        let elements = input.split(separator: " ")
        for element in elements {
            banks.append(Int(String(element))!)
        }
    }

    private var stateHash: String {
        var result = ""

        for bank in banks {
            result += "#\(bank)"
        }

        return result
    }

    private func redistribute(from index: Int) {
        let ammount = banks[index]
        let toEach = ammount / banks.count
        var extraBlock = ammount % banks.count

        banks[index] = 0

        for i in 0..<banks.count {
            let currentIndex = (index + i + 1) % banks.count
            banks[currentIndex] += toEach
            if extraBlock > 0 {
                banks[currentIndex] += 1
                extraBlock -= 1
            }
        }
    }

    public func findRepeatingState() -> (Int, Int) {
        var tick = 0

        while states[stateHash] == nil {
            states[stateHash] = tick

            var max = Int.min
            var maxIndex = -1

            for i in 0..<banks.count {
                if max < banks[i] {
                    max = banks[i]
                    maxIndex = i
                }
            }

            redistribute(from: maxIndex)
            tick += 1
        }

        return (tick, tick - states[stateHash]!)
    }
}
