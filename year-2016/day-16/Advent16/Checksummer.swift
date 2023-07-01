//
//  Checksummer.swift
//  Advent16
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Checksummer {
    private static func dragonCurve(input a: String) -> String {
        let reversedInput = a.reversed()
        var invertedReversedInput = String()

        for c in reversedInput {
            if c == "0" {
                invertedReversedInput.append("1")
            } else if c == "1" {
                invertedReversedInput.append("0")
            } else {
                print("Error checksum element \(c)")
            }
        }

        let b = invertedReversedInput

        return "\(a)0\(b)"
    }

    private static func growData(input data: String, to lenght: Int) -> String {
        var result = data

        while result.count < lenght {
            result = dragonCurve(input: result)
        }

        return String(result.prefix(lenght))
    }

    private static func trimData(_ input: String) -> String {
        var result = String()
        let data = Array(input)

        for i in 0..<data.count / 2 {
            if data[i * 2] == data[i * 2 + 1] {
                result.append("1")
            } else {
                result.append("0")
            }
        }

        return result
    }

    public static func getChecksum(input data: String, to lenght: Int) -> String {
        var checksum = growData(input: data, to: lenght)

        repeat {
            checksum = trimData(checksum)
        } while checksum.count % 2 == 0

        return checksum
    }
}
