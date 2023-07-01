//
//  Round.swift
//  Advent02
//
//  Created by Dragan Cecavac on 02.12.22.
//

import Foundation

struct Round {
    let first: Character
    let second: Character

    private func assumedValue(_ char: Character) -> UInt8 {
        if char.asciiValue! >= Character("X").asciiValue! {
            return char.asciiValue! - Character("X").asciiValue! + 1
        } else {
            return char.asciiValue! - Character("A").asciiValue! + 1
        }
    }

    func assumedScore() -> UInt {
        var result = assumedValue(second)

        if assumedValue(first) == assumedValue(second) {
            result += 3
        } else if (assumedValue(first) % 3 + 1) == assumedValue(second) {
            result += 6
        }

        return UInt(result)
    }

    func actualScore() -> UInt? {
        let result: UInt8

        switch second {
        case "X":
            result = (assumedValue(first) + 1) % 3 + 1
        case "Y":
            result = 3 + assumedValue(first)
        case "Z":
            result = 6 + assumedValue(first) % 3 + 1
        default:
            return nil
        }

        return UInt(result)
    }
}
