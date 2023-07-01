//
//  Room.swift
//  Advent4
//
//  Created by Dragan Cecavac on 02.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Room {
    private static let startCharacter:Character = "a"
    private static let asciiOffset = Int(startCharacter.asciiValue!)

    public let isValid: Bool
    public let id: Int
    private(set) var name = ""

    init(_ input: String) {
        var characters = Array(repeating: 0, count: 26)
        let elements = input.split(separator: "-")

        let tailElements = elements[elements.count - 1].split(separator: "[")
        id = Int(tailElements[0])!
        let checksum = String(tailElements[1].prefix(tailElements[1].count - 1))

        for i in 0..<(elements.count - 1) {
            for character in elements[i] {
                let value = Int(character.asciiValue!) - Room.asciiOffset
                characters[value] += 1

                let realValue = (value + id) % 26
                name += Room.offsetedChar(realValue)
            }

            if i != elements.count - 2 {
                name += " "
            }
        }

        let uniqueCharacters = Set(characters)
        let uniqueSortedCharacters = Array(uniqueCharacters).sorted().reversed()
        var recreatedChecksum = ""
        var checksumCount = 0

        for value in uniqueSortedCharacters {
            for i in 0..<characters.count {
                if value == characters[i] {
                    recreatedChecksum += Room.offsetedChar(i)
                    checksumCount += 1

                    if checksumCount == 5 {
                        break;
                    }
                }
            }

            if checksumCount == 5 {
                break;
            }
        }

        isValid = checksum == recreatedChecksum
    }

    private static func offsetedChar(_ value: Int) -> String {
        return String(Character(UnicodeScalar(value + Room.asciiOffset)!))
    }

    public func isNorthPoleRelated() -> Bool {
        let words = name.split(separator: " ")
        for word in words {
            if word == "northpole" {
                return true
            }
        }

        return false
    }
}
