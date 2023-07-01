//
//  Formula.swift
//  Advent7
//
//  Created by Dragan Cecavac on 15.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Formula {
    private(set) var inputs: [String] = []
    let output: String
    let operation: String
    private(set) var value: UInt16?
    private(set) var operandValue: UInt16?
    private var rawInput: String

    public init?(for input: String) {
        rawInput = input
        let coreSplitIndex = input.index(of: " -> ")!
        let coreSplitOffsetedIndex = input.index(coreSplitIndex, offsetBy: 4)
        let outputSubsequence = input.suffix(from: coreSplitOffsetedIndex)
        output = String(outputSubsequence)

        if (input.contains("AND")) {
            operation = "AND"

            let inputIndex = input.index(of: " ")!
            let inputSubsequence = input[input.startIndex..<inputIndex]
            inputs.append(String(inputSubsequence))

            let offset = operation.count + 2
            let input2Index = input.index(inputIndex, offsetBy: offset)
            let input2Subsequence = input[input2Index..<coreSplitIndex]
            inputs.append(String(input2Subsequence))
        } else if (input.contains("OR")) {
            operation = "OR"

            let inputIndex = input.index(of: " ")!
            let inputSubsequence = input[input.startIndex..<inputIndex]
            inputs.append(String(inputSubsequence))

            let offset = operation.count + 2
            let input2Index = input.index(inputIndex, offsetBy: offset)
            let input2Subsequence = input[input2Index..<coreSplitIndex]
            inputs.append(String(input2Subsequence))
        } else if (input.contains("LSHIFT")) {
            operation = "LSHIFT"

            let inputIndex = input.index(of: " ")!
            let inputSubsequence = input[input.startIndex..<inputIndex]
            inputs.append(String(inputSubsequence))

            let offset = operation.count + 2
            let input2Index = input.index(inputIndex, offsetBy: offset)
            let input2Subsequence = input[input2Index..<coreSplitIndex]
            operandValue = UInt16(input2Subsequence)
        } else if (input.contains("RSHIFT")) {
            operation = "RSHIFT"

            let inputIndex = input.index(of: " ")!
            let inputSubsequence = input[input.startIndex..<inputIndex]
            inputs.append(String(inputSubsequence))

            let offset = operation.count + 2
            let input2Index = input.index(inputIndex, offsetBy: offset)
            let input2Subsequence = input[input2Index..<coreSplitIndex]
            operandValue = UInt16(input2Subsequence)
        } else if (input.contains("NOT")) {
            operation = "NOT"

            let offset = operation.count + 1
            let inputIndex = input.index(input.startIndex, offsetBy: offset)
            let inputSubsequence = input[inputIndex..<coreSplitIndex]
            inputs.append(String(inputSubsequence))
        } else {
            operation = "NONE"
            let valueString = input.prefix(upTo: coreSplitIndex)
            value = UInt16(valueString)
        }

        if operation == "AND" && inputs[0] == "hf" && inputs[1] == "hl" {
            print("A")
        }

        if operation == "AND" && inputs[0] == "l" && inputs[1] == "r" {
            print("A")
        }
    }

    public func calculate(_ map: [String:UInt16]) -> Bool {
        if operation == "AND" && inputs[0] == "l" && inputs[1] == "r" {
            print("A")
        }

        switch (operation) {
        case "AND":
            if let a = map[inputs[0]] {
                if let b = map[inputs[1]] {
                    value = a & b
                }
            }
        case "OR":
            if let a = map[inputs[0]] {
                if let b = map[inputs[1]] {
                    value = a | b
                }
            }
        case "RSHIFT":
            if let a = map[inputs[0]] {
                value = a >> operandValue!
            }
        case "LSHIFT":
            if let a = map[inputs[0]] {
                value = a << operandValue!
            }
        case "NOT":
            if let a = map[inputs[0]] {
                value = ~a
            }
        default:
            let coreSplitIndex = rawInput.index(of: " -> ")!
            let inputElement = rawInput.prefix(upTo: coreSplitIndex)
            if let a = map[String(inputElement)] {
                value = a;
                return true
            }

            return false
        }

        return value != nil
    }
}
