//
//  Rule.swift
//  Advent21
//
//  Created by Dragan Cecavac on 16.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Rule {
    let mainPattern: String
    var array: [[Character]] = []
    var outputArray: [[Character]] = []
    var patterns: [String] = []
    let outputPattern: String

    init(_ input: String) {
        let elements = input.split(separator: " ")
        mainPattern = String(elements[0])
        outputPattern = String(elements[2])

        let lines = mainPattern.split(separator: "/")
        for line in lines {
            var row = Array<Character>()
            for char in line {
                row.append(String(char).first!)
            }
            array.append(row)
        }

        let outputLines = outputPattern.split(separator: "/")
        for line in outputLines {
            var row = Array<Character>()
            for char in line {
                row.append(String(char).first!)
            }
            outputArray.append(row)
        }

        for _ in 0..<4 {
            rotateArray()
            patterns.append(Rule.arrayToString(array))
        }
        flipArray()
        for _ in 0..<4 {
            rotateArray()
            patterns.append(Rule.arrayToString(array))
        }
    }

    public static func arrayToString(_ array: [[Character]]) -> String {
        var result = ""

        for i in 0..<array.count {
            for char in array[i] {
                result += String(char)
            }

            if i != array.count - 1 {
                result += "/"
            }
        }

        return result
    }

    private func rotateArray() {
        if array.count == 2 {
            var rotatedArray = Array(repeating: Array(repeating: Character(" "), count: 2), count: 2)

            rotatedArray[0][0] = array[0][1]
            rotatedArray[0][1] = array[1][1]
            rotatedArray[1][0] = array[0][0]
            rotatedArray[1][1] = array[1][0]

            array = rotatedArray
        } else if array.count == 3 {
            var rotatedArray = Array(repeating: Array(repeating: Character(" "), count: 3), count: 3)

            rotatedArray[0][0] = array[0][2]
            rotatedArray[0][1] = array[1][2]
            rotatedArray[0][2] = array[2][2]

            rotatedArray[1][2] = array[2][1]
            rotatedArray[2][2] = array[2][0]

            rotatedArray[2][0] = array[0][0]
            rotatedArray[2][1] = array[1][0]

            rotatedArray[1][0] = array[0][1]
            rotatedArray[1][1] = array[1][1]

            array = rotatedArray
        } else {
            print("Bad rule array size \(array.count)")
        }
    }

    private func flipArray() {
        let topRow = array[0]
        let bottomRow = array[array.count - 1]

        array[0] = bottomRow
        array[array.count - 1] = topRow
    }

    private func isMatching(input: String) -> Bool {
        for rule in patterns {
            if rule == input {
                return true
            }
        }

        return false
    }

    public func isMatching(_ input: [[Character]]) -> Bool {
        return isMatching(input: Rule.arrayToString(input))
    }
}
