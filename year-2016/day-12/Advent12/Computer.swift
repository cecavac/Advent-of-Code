//
//  Computer.swift
//  Advent12
//
//  Created by Dragan Cecavac on 26.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Computer {
    var instruction: [String] = []
    var ip = 0
    var a = 0, b = 0, c = 0, d = 0

    init(_ input: String, registerC: Int) {
        c = registerC

        let lines = input.split(separator: "\n")
        for line in lines {
            instruction.append(String(line))
        }
    }

    func getValue(_ element: String) -> Int {
        if let value = Int(element) {
            return value
        } else {
            switch element {
            case "a":
                return a
            case "b":
                return b
            case "c":
                return c
            case "d":
                return d
            default:
                print("Error getValue element: \(element)")
                return 0
            }
        }
    }

    func setValue(_ element: String, value: Int) {
        switch element {
        case "a":
            a = value
        case "b":
            b = value
        case "c":
            c = value
        case "d":
            d = value
        default:
            print("Error setValue element: \(element)")
        }
    }

    func run() -> Int {
        while ip < instruction.count {
            let elements = instruction[ip].split(separator: " ")
            let op = String(elements[0])
            let value = getValue(String(elements[1]))

            switch(op) {
            case "cpy":
                setValue(String(elements[2]), value: value)
                ip += 1
            case "inc":
                setValue(String(elements[1]), value: value + 1)
                ip += 1
            case "dec":
                setValue(String(elements[1]), value: value - 1)
                ip += 1
            case "jnz":
                if value != 0 {
                    let offset = Int(elements[2])!
                    ip += offset
                } else {
                    ip += 1
                }
            default:
                print("Error")
                break
            }
        }

        return a
    }
}
