//
//  Parser.swift
//  Advent10
//
//  Created by Dragan Cecavac on 10.12.21.
//

import Foundation

class Parser {
    private var incompleteStacks: [[Character]] = []
    private let closingPoints: [Character:Int] = [")":3, "]":57, "}":1197, ">":25137]
    private let openingPoints: [Character:Int] = ["(":1, "[":2, "{":3, "<":4]

    private func isOpening(_ char: Character) -> Bool {
        return char == "(" || char == "[" || char == "{" || char == "<"
    }

    private func matches(opening: Character, closing: Character) -> Bool {
        switch opening {
        case "(":
            return closing == ")"
        case "[":
            return closing == "]"
        case "{":
            return closing == "}"
        case "<":
            return closing == ">"
        default:
            return false
        }
    }

    func parse(_ input: String) -> Int {
        var result = 0
        let lines = input.split(separator: "\n")

        for line in lines {
            var stack = [Character]()
            var corrupted = false

            for currentChar in line {
                if isOpening(currentChar) {
                    stack.append(currentChar)
                } else {
                    if stack.count > 0 {
                        let stackElement = stack.removeLast()
                        if !matches(opening: stackElement, closing: currentChar) {
                            result += closingPoints[currentChar]!
                            corrupted = true
                            break
                        }
                    }
                }
            }

            if !corrupted {
                incompleteStacks.append(stack)
            }
        }

        return result
    }

    func autocpmplete() -> Int {
        var results: [Int] = []

        for stack in incompleteStacks {
            var result = 0
            for char in stack.reversed() {
                result *= 5
                result += openingPoints[char]!
            }
            results.append(result)
        }

        results = results.sorted { $0 < $1 }
        return results[results.count / 2]
    }
}
