//
//  Instruction.swift
//  Advent23
//
//  Created by Dragan Cecavac on 11.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Instruction {
    private let opcode: String
    private let register: String
    private let offset: Int?

    init(_ input: String) {
        let words = input.split(separator: " ")

        opcode = String(words[0])
        register = String(words[1])

        if words.count == 3 {
            let offsetData = String(words[2])
            let offsetValue = Int(offsetData.suffix(offsetData.count - 1))!
            if offsetData.prefix(1) == "-" {
                offset = -offsetValue
            } else {
                offset = offsetValue
            }
        } else {
            offset = nil
        }
    }

    public func execute(registerA a: inout Int, registerB b: inout Int) -> Int {
        var registerValue: Int;

        if register == "a" || register == "a," {
            registerValue = a
        } else {
            registerValue = b
        }

        switch opcode {
        case "hlf":
            registerValue /= 2
        case "tpl":
            registerValue *= 3
        case "inc":
            registerValue += 1
        case "jmp":
            return Int(register)!
        case "jie":
            if registerValue % 2 == 0 {
                return offset!
            } else {
                return 1
            }
        case "jio":
            if registerValue == 1 {
                return offset!
            } else {
                return 1
            }
        default:
            print("Error opcode \(opcode)")
        }

        if register == "a" {
            a = registerValue
        } else {
            b = registerValue
        }

        return 1
    }
}
