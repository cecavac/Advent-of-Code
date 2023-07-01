//
//  Computer.swift
//  Advent8
//
//  Created by Dragan Cecavac on 09.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Computer {
    var registers: [String:Int] = [:]
    var greatestEver = Int.min

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let elements = line.split(separator: " ")

            var valReg = 0
            var condReg = 0
            var condVal = 0
            var change = 0
            var perform = false

            if let register = registers[String(elements[0])] {
                valReg = register
            }

            if elements[1] == "inc" {
                change = Int(String(elements[2]))!
            } else if elements[1] == "dec" {
                change = -Int(String(elements[2]))!
            } else {
                print("Error operation \(elements[1])")
            }

            if let register = registers[String(elements[4])] {
                condReg = register
            }

            condVal = Int(String(elements[6]))!

            switch elements[5] {
            case "==":
                perform = condReg == condVal
            case ">=":
                perform = condReg >= condVal
            case "<=":
                perform = condReg <= condVal
            case "!=":
                perform = condReg != condVal
            case ">":
                perform = condReg > condVal
            case "<":
                perform = condReg < condVal
            default:
                print("Error comparison \(elements[5])")
            }

            if perform {
                valReg += change
                registers[String(elements[0])] = valReg

                greatestEver = max(greatestEver, valReg)
            }
        }
    }

    public var greatest: Int {
        var result = Int.min

        for (_, value) in registers {
            result = max(result, value)
        }

        return result
    }
}
