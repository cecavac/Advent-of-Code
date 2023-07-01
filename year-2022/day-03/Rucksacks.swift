//
//  Rucksacks.swift
//  Advent03
//
//  Created by Dragan Cecavac on 03.12.22.
//

import Foundation

class Rucksacks {
    let data: [String]

    init(_ input: String) {
        data = input.split(separator: "\n").map { String($0) }
    }

    private func priority(char: Character) -> UInt {
        let charValue = char.asciiValue!
        let lowercase = Character("a").asciiValue!
        let uppercase = Character("A").asciiValue!

        if charValue >= lowercase {
            return UInt(charValue - lowercase + 1)
        } else {
            return UInt(charValue - uppercase + 27)
        }
    }

    func priority() -> UInt {
        var result: UInt = 0

        for entry in data {
            let array = Array(entry)
            let leftCompartment = Set<Character>(array[0..<entry.count / 2])
            let rightCompartment = Set<Character>(array[entry.count / 2..<entry.count])

            let intersection = leftCompartment.intersection(rightCompartment)
            result += intersection.map { priority(char: $0) }.reduce(0, +)
        }

        return result
    }

    func badges() -> UInt {
        var result: UInt = 0
        let rucksacks = [Set<Character>](data.map { Set<Character>($0) })

        for i in 0..<rucksacks.count / 3 {
            let badge = rucksacks[i * 3]
                        .intersection(rucksacks[i * 3 + 1])
                        .intersection(rucksacks[i * 3 + 2])
            result += priority(char: badge.first!)
        }

        return result
    }
}
