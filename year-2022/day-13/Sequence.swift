//
//  Sequence.swift
//  Advent13
//
//  Created by Dragan Cecavac on 13.12.22.
//

import Foundation

class Sequence {
    static var idGen = 0
    let id: Int
    let base: String

    init(_ input: String) {
        base = input

        id = Sequence.idGen
        Sequence.idGen += 1
    }

    func getCurrentLevel(input: String) -> [String] {
        var level = 0
        var adjustedInput = ""
        var inputArray = Array(input)
        if inputArray[0] == "[" {
            inputArray.removeFirst()
            inputArray.removeLast()
        }

        for c in inputArray {
            if c == "[" {
                level += 1
            } else if c == "]" {
                level -= 1
            }

            if c == "," && level == 0 {
                adjustedInput += " "
            } else {
                adjustedInput += "\(c)"
            }
        }

        return adjustedInput.split(separator: " ").map { String($0) }
    }

    func isNumber(_ string: String) -> Bool {
        if let _ = Int(string) {
            return true
        } else {
            return false
        }
    }

    func isList(_ string: String) -> Bool {
        return string.count > 0 && string.first! == "["
    }

    func compare(with other: Sequence) -> Bool {
        if let result = compare(input1: base, input2: other.base) {
            return result
        } else {
            print("Default false")
            return false
        }
    }

    func compare(input1: String, input2: String) -> Bool? {
        let currentLevel1 = getCurrentLevel(input: input1)
        let currentLevel2 = getCurrentLevel(input: input2)

        if input1.count > 0 && input2 == "" {
            return false
        }

        if input2.count > 0 && input1 == "" {
            return true
        }

        for i in currentLevel1.indices {
            if i == currentLevel2.count {
                return false
            }

            if let a = Int(currentLevel1[i]), let b = Int(currentLevel2[i]) {
                if a < b {
                    return true
                } else if a > b {
                    return false
                }
            } else if let a = Int(currentLevel1[i]) {
                if let result = compare(input1: "[\(a)]", input2: currentLevel2[i]) {
                    return result
                }
            } else if let b = Int(currentLevel2[i]) {
                if let result = compare(input1: currentLevel1[i], input2: "[\(b)]") {
                    return result
                }
            } else {
                if let result = compare(input1: currentLevel1[i], input2: currentLevel2[i]) {
                    return result
                }
            }
        }

        if input2.count > input1.count {
            return true
        }

        return nil
    }
}
