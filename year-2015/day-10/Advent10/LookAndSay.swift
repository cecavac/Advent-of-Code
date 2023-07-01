//
//  LookAndSay.swift
//  Advent10
//
//  Created by Dragan Cecavac on 23.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class LookAndSay {
    public static func getAnswer(_ input: String) -> String {
        var count = 0
        var currentCharacter:Character = "\0"
        var result = ""

        for character in input {
            if character == currentCharacter {
                count += 1
            } else {
                // Not first entry
                if count > 0 {
                    result += "\(count)\(currentCharacter)"
                }

                currentCharacter = character
                count = 1
            }
        }

        result += "\(count)\(currentCharacter)"

        return result
    }

    public static func getRepeatedAnswer(_ input: String, count n: Int) -> Int {
        var result = input

        for _ in 0..<n {
            result = getAnswer(result)
        }

        return result.count
    }
}
