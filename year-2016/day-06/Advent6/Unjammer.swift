//
//  Unjammer.swift
//  Advent6
//
//  Created by Dragan Cecavac on 03.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Unjammer {
    private(set) var result1 = ""
    private(set) var result2 = ""

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        let length = lines[0].count

        var dictionaries = Array<[Character:Int]>()
        for _ in 0..<length {
            let dictionary: [Character:Int] = [:]
            dictionaries.append(dictionary)
        }

        for line in lines {
            for i in 0..<length {
                let characters = Array(String(line))
                if let count = dictionaries[i][characters[i]] {
                    dictionaries[i][characters[i]] = count + 1
                } else {
                    dictionaries[i][characters[i]] = 1
                }
            }
        }

        for i in 0..<length {
            var bestCharacter: Character = " "
            var maxCount = Int.min

            var worstCharacter: Character = " "
            var minCount = Int.max

            for (character, count) in dictionaries[i] {
                if count > maxCount {
                    maxCount = count
                    bestCharacter = character
                }

                if count < minCount {
                    minCount = count
                    worstCharacter = character
                }
            }

            result1 += String(bestCharacter)
            result2 += String(worstCharacter)
        }
    }
}
