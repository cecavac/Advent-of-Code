//
//  Keypad.swift
//  Advent2
//
//  Created by Dragan Cecavac on 01.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Keypad2 {
    private let keypad = [[" ", " ", "1", " ", " "],
                          [" ", "2", "3", "4" , " "],
                          ["5", "6", "7", "8" , "9"],
                          [" ", "A", "B", "C" , " "],
                          [" ", " ", "D", " " , " "]]
    private var positionI = 2
    private var positionJ = 0
    private(set) var result = ""

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            for movement in line {
                var newPositionI = positionI
                var newPositionJ = positionJ

                switch movement {
                case "U":
                    newPositionI -= 1
                case "D":
                    newPositionI += 1
                case "L":
                    newPositionJ -= 1
                case "R":
                    newPositionJ += 1
                default:
                    print("Error movement: \(movement)")
                }

                newPositionI = max(newPositionI, 0)
                newPositionI = min(newPositionI, keypad.count - 1)
                newPositionJ = max(newPositionJ, 0)
                newPositionJ = min(newPositionJ, keypad.count - 1)

                if (keypad[newPositionI][newPositionJ] != " ") {
                    positionI = newPositionI
                    positionJ = newPositionJ
                }
            }

            result += keypad[positionI][positionJ]
        }
    }
}
