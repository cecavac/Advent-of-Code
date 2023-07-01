//
//  KnotCypher.swift
//  Advent10
//
//  Created by Dragan Cecavac on 10.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class KnotCypher {
    var crypto: Crypto

    init(_ input: String) {
        var finalInput = ""
        let elements = Array(input)

        for element in elements {
            let value = Character(String(element)).asciiValue!
            finalInput += "\(value),"
        }

        finalInput += "17,31,73,47,23"
        crypto = Crypto(finalInput)
    }

    public func transform() -> String {
        var result = ""

        var position = 0
        var skip = 0
        for _ in 0..<64 {
            let data = crypto.transform(start: position, skipSize: skip)
            position = data.0
            skip = data.1
        }

        for i in 0..<16 {
            var element = crypto.array[i * 16]

            for j in i * 16 + 1..<(i + 1) * 16 {
                element = element ^ crypto.array[j]
            }

            result += String(format: "%02x", element)
        }

        return result
    }
}
