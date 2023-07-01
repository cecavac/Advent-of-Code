//
//  Password.swift
//  Advent11
//
//  Created by Dragan Cecavac on 24.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Password {
    var password: String

    init(_ initialPassword: String) {
        password = initialPassword
    }

    private func incrementPassword() -> String {
        let reversedPassword = String(password.reversed())
        var reversedResult = ""
        var carry = true

        for character in reversedPassword {
            if carry == false {
                reversedResult += String(character)
                continue
            } else {
                if character == "z" {
                    reversedResult += "a"
                    carry = true
                } else {
                    let incrementedCharacter = Character(UnicodeScalar(character.asciiValue! + 1))
                    reversedResult += String(incrementedCharacter)
                    carry = false
                }
            }
        }

        return String(reversedResult.reversed())
    }

    public func condition1() -> Bool {
        var oldPrevCharacter: Character = "\0"
        var prevCharacter: Character = "\0"

        for character in password {
            let value1 = oldPrevCharacter.asciiValue!
            let value2 = prevCharacter.asciiValue!
            let value3 = character.asciiValue!

            if value1 + 1 == value2 && value2 + 1 == value3 {
                return true
            }

            oldPrevCharacter = prevCharacter
            prevCharacter = character
        }

        return false
    }

    public func condition2() -> Bool {
        return !(password.contains("i") || password.contains("o") || password.contains("l"))
    }

    public func condition3() -> Bool {
        var matchingChar: Character = "\0"
        var prevCharacter: Character = "\0"

        for character in password {
            if prevCharacter == character {
                if matchingChar == "\0" {
                    matchingChar = character
                } else {
                    if matchingChar != character {
                        return true
                    }
                }
            }

            prevCharacter = character
        }

        return false
    }

    public func isValid() -> Bool {
        return condition1() && condition2() && condition3()
    }

    public func nextPassword() -> String {
        repeat {
            password = incrementPassword()
        } while !isValid()

        return password
    }
}
