//
//  Neighbourhood.swift
//  Advent20
//
//  Created by Dragan Cecavac on 08.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Neighbourhood {
    private static func packages(for houseNumber: Int) -> Int {
        var result = houseNumber * 10
        let top = houseNumber / 2

        for i in 1...top {
            if houseNumber % i == 0 {
                result += i * 10
            }
        }

        return result
    }

    public static func lowestHouse(with gifts: Int) -> Int {
        var low = 1
        var top = 2 * 3 * 4 * 5 * 8 * 9

        var index = 9
        while packages(for: top) <= gifts {
            index += 1
            top *= index
        }

        var oldTop = top

        while true {
            if low + 1 == top {
                return top
            }

            let mid = (low + top) / 2
            let midPackages = packages(for: mid)

            if midPackages >= gifts {
                if oldTop - 100  > top {
                    oldTop = top
                }
                top = mid
            } else {
                low = mid
            }
        }
    }

    public static func lowestHouseLimited(with gifts: Int) -> Int {
        var index = 1
        var log:[Int:Int] = [:]
        var lowestHouse = Int.max

        while true {
            for i in 1...50 {
                let house = index * i
                if let packages = log[house] {
                    let newPackages = packages + index * 11
                    log[house] = newPackages

                    if (newPackages >= gifts) {
                        lowestHouse = min(lowestHouse, house)

                        if index >= lowestHouse {
                            return lowestHouse
                        }
                    }
                } else {
                    log[house] = index * 11
                }

                if i == 1 {
                    // clean no longer used
                    log[house] = nil
                }
            }

            index += 1
        }
    }
}
