//
//  Unlocker.swift
//  Advent5
//
//  Created by Dragan Cecavac on 03.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation
import CryptoKit

class Unlocker {
    private(set) var result1 = ""
    private(set) var result2 = ""

    init(_ input: String) {
        var checkList = 0
        var counter = 0
        var passwordBuffer = Array<Character>(repeating: "*", count: 8)

        while checkList != 0b11111111 {
            let data = "\(input)\(counter)"
            let hash = Unlocker.md5Hash(data)

            if hash.starts(with: "00000") {
                // Result 1
                if result1.count < 8 {
                    let characterIndex = hash.index(hash.startIndex, offsetBy: 5)
                    result1 = result1 + String(hash[characterIndex])

                    var output = result1
                    for _ in 0..<(8 - result1.count){
                        output = output + "*"
                    }

                    print("Password 1: \(output)")
                }

                // Result 2
                let positionIndex = hash.index(hash.startIndex, offsetBy: 5)
                let position = Unlocker.hexAsciiToValue(hash[positionIndex])
                if position >= 0 && position <= 7 {
                    let bitMask = 1 << position

                    if checkList & bitMask == 0 {
                        checkList |= bitMask

                        let characterIndex = hash.index(hash.startIndex, offsetBy: 6)
                        passwordBuffer[position] = hash[characterIndex]

                        print("Password 2: \(String(passwordBuffer))")
                    }
                }
            }

            counter += 1
        }

        result2 = String(passwordBuffer)
    }

    private static func hexAsciiToValue(_ character: Character) -> Int {
        var result: UInt8
        let numericOffsetCharacter: Character = "0"
        let numericAsciiOffset = numericOffsetCharacter.asciiValue!

        let alphaOffsetCharacter:Character = "a"
        let alphaOffset = alphaOffsetCharacter.asciiValue!

        let characterValue = character.asciiValue!
        if characterValue >= alphaOffset {
            result = 10 + characterValue - alphaOffset
        } else {
            result = characterValue - numericAsciiOffset
        }

        return Int(result)
    }

    private static func md5Hash(_ input: String) -> String {
        var data = Array<UInt8>()

        for character in input {
            data.append(character.asciiValue!)
        }

        let digest = Insecure.MD5.hash(data: data).description
        let elements = digest.split(separator: " ")
        return String(elements[2])
    }
}
