//
//  Pickpackaging.swift
//  Advent19
//
//  Created by Dragan Cecavac on 29.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Pickpackaging {
    public static func GetTheMaster(count: Int) -> Int {
        var set: [Int] = []

        for i in 1...count {
            set.append(i)
        }

        while set.count > 1 {
            var newSet: [Int] = []

            let extraElement = set.count % 2 == 1

            for i in 0..<set.count / 2 {
                newSet.append(set[i * 2])
            }

            if extraElement {
                newSet.append(set.last!)
                newSet.remove(at: 0)
            }

            set = newSet
        }

        return set[0]
    }

    public static func GetTheTrueMaster(count: Int) -> Int {
        var set: [Int] = []

        for i in 1...count {
            set.append(i)
        }

        while set.count > 1 {
            var newSet: [Int] = []
            var expelled = Set<Int>()
            var cnt = set.count
            var offset = 0

            for i in 0..<set.count / 2 {
                if !expelled.contains(i) {
                    var skipElement = offset + cnt / 2
                    skipElement += i
                    skipElement %= set.count

                    expelled.insert(skipElement)

                    cnt -= 1
                    offset += 1
                }
            }

            for i in set.count / 2 + 1..<set.count {
                if !expelled.contains(i) {
                    newSet.append(set[i])
                }
            }

            for i in 0...set.count / 2 {
                if !expelled.contains(i) {
                    newSet.append(set[i])
                }
            }

            set = newSet
        }

        return set[0]
    }
}
