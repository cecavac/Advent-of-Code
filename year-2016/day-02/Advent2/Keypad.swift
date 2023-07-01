//
//  Keypad.swift
//  Advent2
//
//  Created by Dragan Cecavac on 01.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Keypad {
    private let keypad = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    private var positionI = 1
    private var positionJ = 1
    private(set) var result = ""

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            for movement in line {
                switch movement {
                case "U":
                    positionI -= 1
                case "D":
                    positionI += 1
                case "L":
                    positionJ -= 1
                case "R":
                    positionJ += 1
                default:
                    print("Error movement: \(movement)")
                }

                positionI = max(positionI, 0)
                positionI = min(positionI, keypad.count - 1)
                positionJ = max(positionJ, 0)
                positionJ = min(positionJ, keypad.count - 1)
            }

            result += String(keypad[positionI][positionJ])
        }
    }
}
