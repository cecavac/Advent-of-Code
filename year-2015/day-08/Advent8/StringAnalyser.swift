//
//  StringAnalyser.swift
//  Advent8
//
//  Created by Dragan Cecavac on 01.02.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class StringAnalyser {
    private static func analyse(literal input: String) -> (stringCharCount: Int, memoryCharCount: Int) {
        var result = (input.count, input.count)

        // Discount starting and ending quote characters
        result.0 -= 2
        result.1 -= 2

        for character in input {
            if character == "\\" || character == "\"" {
                result.1 += 1
            } else if character == "\t" {
                result.0 -= 2
                result.1 += 1
            }
        }

        return result
    }

    public static func analyse(_ input: String) -> (stringCharCount: Int, memoryCharCount: Int) {
        var result = (0, 0)
        let lines = input.split(separator: "\n")
        for line in lines {
            let literalResult = analyse(literal: String(line))
            result.0 += literalResult.0
            result.1 += literalResult.1
        }

        return result
    }

    public static func expand(_ input: String) -> String {
        var result = ""

        for character in input {
            if character == "\\" || character == "\"" {
                result = "\(result)\\\(character)"
            } else if character == "\t" {
                result = "\(result)\\t"
            }else {
                result = "\(result)\(character)"
            }
        }

        return result
    }
}
