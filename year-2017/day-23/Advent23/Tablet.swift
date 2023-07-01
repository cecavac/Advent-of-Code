//
//  Tablet.swift
//  Advent23
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Tablet {
    var lastSound = -1
    var instructions: [String] = []
    var ip = 0
    var registers: [String:Int] = [:]

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            instructions.append(String(line))
        }
    }

    private func getVal(_ input: String) -> Int {
        if let value = Int(input) {
            return value
        } else if let value = registers[input] {
            return value
        } else {
            return 0
        }
    }

    private func setVal(register: String, value: Int) {
        registers[register] = value
    }

    public func run() -> Int{
        var result = 0

        mainLoop: while ip >= 0 && ip < instructions.count {
            let elements = instructions[ip].split(separator: " ")
            let value = getVal(String(elements[1]))

            switch elements[0] {
            case "set":
                let value2 = getVal(String(elements[2]))
                setVal(register: String(elements[1]), value: value2)

                ip += 1
            case "sub":
                let value2 = getVal(String(elements[2]))
                setVal(register: String(elements[1]), value: value - value2)

                ip += 1
            case "mul":
                let value2 = getVal(String(elements[2]))
                setVal(register: String(elements[1]), value: value * value2)

                ip += 1
                result += 1
            case "jnz":
                if value != 0 {
                    let value2 = getVal(String(elements[2]))
                    ip += value2
                } else {
                    ip += 1
                }
            default:
                print("Bad instruction opcode: \(elements[0])")
            }
        }

        return result
    }
}
