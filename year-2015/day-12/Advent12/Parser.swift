//
//  Parser.swift
//  Advent12
//
//  Created by Dragan Cecavac on 25.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Parser {
    public static func add(_ input: String) -> Int {
        var result = 0
        var numberizedInput = ""
        let char0: Character = "0"
        let char9: Character = "9"

        for character in input {
            let nextElement:String

            if character == "-" || (character.asciiValue! >= char0.asciiValue! && character.asciiValue! <= char9.asciiValue!) {
                nextElement = String(character)
            } else {
                nextElement = " "
            }

            numberizedInput += String(nextElement)
        }

        let numberInput = numberizedInput.split(separator: " ")
        for number in numberInput {
            result += Int(String(number))!
        }

        return result
    }

    public static func addNonRed(_ input: String) -> Int {
        var state:[Character] = []
        var inObject = false
        var charArray = Array(input)

        for i in 0..<charArray.count {
            switch charArray[i] {
            case "{":
                inObject = true
                state += [charArray[i]]
            case "[":
                inObject = false
                state += [charArray[i]]
            case "}", "]":
                state.remove(at: state.count - 1)
                if state.count > 0 {
                    let rolledBackState = state[state.count - 1]
                    inObject = rolledBackState == "{"
                }
            default:
                ()
            }

            if i < charArray.count - 2 {
                let redTest = String(charArray[i]) + String(charArray[i + 1]) + String(charArray[i + 2])
                if inObject && redTest == "red" {
                    var level = 0

                    // Clear to the left all the way to {
                    for j in (0...i).reversed() {
                        if charArray[j] == "{" {
                            if level == 0 {
                                break
                            }
                            level -= 1
                        } else if charArray[j] == "}" {
                            level += 1
                        }

                        charArray[j] = " "
                    }

                    // Clear to the right all the way to }
                    for j in i..<charArray.count {
                        if charArray[j] == "{" {
                            level += 1
                        } else if charArray[j] == "}" {
                            if level == 0 {
                                break
                            }
                            level -= 1
                        }

                        charArray[j] = " "
                    }
                }
            }
        }

        return add(String(charArray))
    }
}
