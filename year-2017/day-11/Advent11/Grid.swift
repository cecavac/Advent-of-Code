//
//  Grid.swift
//  Advent11
//
//  Created by Dragan Cecavac on 10.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Grid {
    var i = 0.0
    var j = 0.0
    var maxDistance = 0

    public func travel(path input: String) {
        let elements = input.split(separator: ",")

        for element in elements {
            switch String(element) {
            case "s":
                i += 1
            case "n":
                i -= 1
            case "se":
                j += 1
                i += 0.5
            case "ne":
                j += 1
                i -= 0.5
            case "sw":
                j -= 1
                i += 0.5
            case "nw":
                j -= 1
                i -= 0.5
            default:
                print("Bad direction \(elements)")
            }

            maxDistance = max(maxDistance, distance(x: i, y: j))
        }
    }

    private func distance(x: Double, y: Double) -> Int {
        let freeRide = abs(y)
        var localX = abs(x)

        let truncDouble = localX * 10
        var truncInt = Int(truncDouble)
        truncInt %= 10

        if truncInt == 5 {
            localX += 0.5
        }

        if freeRide >= localX * 2 {
            return Int(freeRide)
        } else {
            return Int(freeRide + (localX * 2 - freeRide) / 2)
        }
    }

    public var currentDistance: Int {
        return distance(x: i, y: j)
    }
}
