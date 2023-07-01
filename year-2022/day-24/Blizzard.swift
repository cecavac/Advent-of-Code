//
//  Blizzard.swift
//  Advent24
//
//  Created by Dragan Cecavac on 24.12.22.
//

import Foundation

struct Blizzard {
    var i: Int
    var j: Int

    let direction: Character
    let minI: Int
    let maxI: Int
    let minJ: Int
    let maxJ: Int

    mutating func move() {
        switch direction {
        case "^":
            i -= 1
            if i <= minI {
                i = maxI - 1
            }
        case ">":
            j += 1
            if j >= maxJ {
                j = minJ + 1
            }
        case "v":
            i += 1
            if i >= maxI {
                i = minI + 1
            }
        case "<":
            j -= 1
            if j <= minJ {
                j = maxJ - 1
            }
        default:
            print("Unknown direction \(direction)")
        }
    }
}
