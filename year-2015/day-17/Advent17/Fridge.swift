//
//  Fridge.swift
//  Advent17
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Fridge {
    private var containers: [Int] = []
    private var limit: Int
    private var combinations: [[Int]] = []

    init(for input: String, limit storage: Int) {
        let lines = input.split(separator: "\n")
        for line in lines {
            containers.append(Int(line)!)
        }

        limit = storage
    }

    private func iterate() {
        combinations = []

        for i in 0..<containers.count {
            let indexes = [i]
            let stored = containers[i]

            if stored == limit {
                combinations.append(indexes)
            } else if stored < limit {
                iterate(indexes: indexes, stored: stored)
            }
        }
    }

    private func iterate(indexes originalIndexes:[Int], stored originalStored: Int) {
        var lowerBound = 0
        for i in originalIndexes {
            lowerBound = max(lowerBound, i)
        }

        for i in lowerBound..<containers.count {
            if originalIndexes.contains(i) {
                continue
            }

            var indexes = originalIndexes
            var stored = originalStored
            indexes.append(i)
            stored += containers[i]

            if stored == limit {
                combinations.append(indexes)
            } else if stored < limit {
                iterate(indexes: indexes, stored: stored)
            }
        }
    }

    public func fittingCombinations() -> (Int, Int) {
        var uniqueCombinations: [[Int]] = []
        iterate()
        for combination in combinations {
            var sortedCombination = combination
            sortedCombination.sort { $0 < $1 }
            if !uniqueCombinations.contains(sortedCombination) {
                uniqueCombinations.append(sortedCombination)
            }
        }

        var minimalCombination = Int.max
        var minimalCombinationsCount = 0
        for combination in uniqueCombinations {
            minimalCombination = min(minimalCombination, combination.count)
        }
        for combination in uniqueCombinations {
            if combination.count == minimalCombination {
                minimalCombinationsCount += 1
            }
        }

        return (uniqueCombinations.count, minimalCombinationsCount)
    }
}
