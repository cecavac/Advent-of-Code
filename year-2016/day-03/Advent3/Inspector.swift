//
//  Inspector.swift
//  Advent3
//
//  Created by Dragan Cecavac on 01.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Inspector {
    private(set) var validCount = 0

    init(rawInput input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            let data = line.split(separator: " ")
            let a = Int(data[0])!
            let b = Int(data[1])!
            let c = Int(data[2])!

            if (a + b > c &&
                b + c > a &&
                a + c > b) {
                validCount += 1
            }
        }
    }

    convenience init(rotatedInput input: String) {
        var rawInput = ""
        var counter = 0

        for i in 0..<3 {
            let lines = input.split(separator: "\n")

            for line in lines {
                let data = line.split(separator: " ")
                rawInput += data[i] + " "

                counter += 1
                if (counter % 3 == 0) {
                    rawInput += "\n"
                }
            }
        }

        self.init(rawInput: rawInput)
    }
}
