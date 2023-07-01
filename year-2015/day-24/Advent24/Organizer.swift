//
//  Organizer.swift
//  Advent24
//
//  Created by Dragan Cecavac on 11.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Organizer {
    var packages = Array<Int>()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            packages.append(Int(line)!)
        }
    }

    public func dig(data: Set<Int>, depth: Int, score: Int, sum: Int, target: Int) -> Int {
        if depth == 0 {
            if sum == target {
                return score
            } else {
                return Int.max
            }
        }

        if sum > target {
            return Int.max
        }

        var bestScore = Int.max

        for package in packages {
            if data.contains(package) {
                continue
            }

            var dataCopy = data
            dataCopy.insert(package)
            let digResult = dig(data: dataCopy, depth: depth - 1, score: score * package, sum: sum + package, target: target)
            bestScore = min(bestScore, digResult)
        }

        return bestScore
    }

    public func split(by compartments: Int) -> Int {
        packages.sort(by: { $0 > $1 })

        var sum = 0
        for package in packages {
            sum += package
        }

        let target = sum / compartments
        var sum1 = 0
        var elements = 0

        for package in packages {
            if sum1 >= target {
                break
            }

            sum1 += package
            elements += 1
        }

        for depth in elements..<packages.count {
            let bestScore = dig(data: Set<Int>(), depth: depth, score: 1, sum: 0, target: target)

            if bestScore != Int.max {
                return bestScore
            }
        }

        return 0
    }
}
