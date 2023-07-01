//
//  Permutation.swift
//  Advent13
//
//  Created by Dragan Cecavac on 26.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Permutation {
    private var array:[String]
    private(set) var limit = 1
    private var index = 0
    private var permutations:[[Int]] = []
    private var bookkeeper:Set<String> = Set()

    init (_ input:[String]) {
        array = input

        for i in 1...array.count {
            limit *= i
        }

        while permutations.count != limit {
            var candidates:[Int] = []
            var permutation:[Int] = []
            var bookkeeperKey = ""

            for i in 0..<array.count {
                candidates += [i]
            }

            for _ in 0..<array.count {
                let index = Int.random(in: 0..<candidates.count)
                let element = candidates.remove(at: index)
                permutation += [element]
                bookkeeperKey += String(element)
            }

            if !bookkeeper.contains(bookkeeperKey) {
                permutations += [permutation]
                bookkeeper.insert(bookkeeperKey)
            }
        }
    }

    public func next() -> [String] {
        var result:[String] = []
        index += 1
        index %= limit
        let permutation = permutations[index]

        for i in permutation {
            result += [array[i]]
        }

        return result
    }
}
