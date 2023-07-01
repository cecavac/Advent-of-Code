//
//  Parser.swift
//  Advent9
//
//  Created by Dragan Cecavac on 10.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Parser {
    var cleanStream = ""
    var removed = 0

    init(_ input: String) {
        let inputArray = Array(input)
        var i = 0
        var garbage = false

        while i < inputArray.count {
            if inputArray[i] == "!" {
                i += 2
                continue
            }

            if garbage {
                if inputArray[i] == ">" {
                    garbage = false
                } else {
                    removed += 1
                }
            } else {
                if inputArray[i] == "<" {
                    garbage = true
                } else {
                    cleanStream.append(inputArray[i])
                }
            }

            i += 1
        }
    }

    public func countGroups() -> Int {
        var result = 0
        var level = 0

        for char in cleanStream {
            if char == "{" {
                level += 1
                result += level
            } else if char == "}" {
                level -= 1
            }
        }

        return result
    }
}
