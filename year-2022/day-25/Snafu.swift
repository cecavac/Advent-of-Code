//
//  Snafu.swift
//  Advent25
//
//  Created by Dragan Cecavac on 25.12.22.
//

import Foundation

class Snafu {
    private static func snafuToDec(_ input: String) -> UInt {
        let array = Array(input)
        var result: UInt = 0

        for i in array.indices {
            result *= 5
            if array[i] == "-" {
                result -= 1
            } else if array[i] == "=" {
                result -= 2
            } else {
                result += UInt(String(array[i]))!
            }
        }

        return result
    }

    private static func decToBase5(_ input: UInt) -> UInt {
        var result: UInt = 0
        var value = input
        var multiplier: UInt = 1

        while value > 0 {
            let currentDigit = (value % 5) * multiplier
            result += currentDigit
            value /= 5

            if value > 0 { // one bit less before overflowing
                multiplier *= 10
            }
        }

        return result
    }

    private static func decToSnafu(_ input: UInt) -> String {
        var result = ""
        var value = Snafu.decToBase5(input)
        var inDebt = false

        while value > 0 {
            var currentDigit = value % 10
            value /= 10

            if inDebt {
                currentDigit += 1
                inDebt = false
            }

            if currentDigit <= 2 {
                result = "\(currentDigit)\(result)"
            } else {
                inDebt = true
                let debt = 5 - currentDigit
                if debt == 0 {
                    result = "0\(result)"
                } else if debt == 1 {
                    result = "-\(result)"
                } else if debt == 2 {
                    result = "=\(result)"
                }
            }
        }

        if inDebt {
            result = "1\(result)"
        }

        return result
    }

    public static func process(_ input: String) -> String {
        var result: UInt = 0

        for line in input.split(separator: "\n") {
            result += snafuToDec(String(line))
        }

        return Snafu.decToSnafu(result)
    }
}
