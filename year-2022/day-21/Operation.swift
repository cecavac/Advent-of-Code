//
//  Operation.swift
//  Advent21
//
//  Created by Dragan Cecavac on 21.12.22.
//

import Foundation

class Operation {
    let id: String
    let operand1: String?
    let operand2: String?
    let operation: String?
    var value: Int?

    init(_ input: String) {
        let elements = input.replacingOccurrences(of: ":", with: "").split(separator: " ")
        id = String(elements[0])
        if elements.count == 2 {
            value = Int(String(elements[1]))!
            operand1 = nil
            operation = nil
            operand2 = nil
        } else {
            operand1 = String(elements[1])
            operation = String(elements[2])
            operand2 = String(elements[3])
            value = nil
        }
    }

    func calculate(value1: Int?, value2: Int?) {
        if let val1 = value1, let val2 = value2 {
            if operation! == "+" {
                value = val1 + val2
            } else if operation! == "-" {
                value = val1 - val2
            } else if operation! == "*" {
                value = val1 * val2
            } else if operation! == "/" {
                value = val1 / val2
            } else {
                print("Unknown operation \(operation!)")
            }

        }
    }

    func calculateReverse(value1: Int, target: Int) -> Int? {
        if operation! == "+" {
            return target - value1
        } else if operation! == "-" {
            return value1 - target
        } else if operation! == "*" {
            return target / value1
        } else if operation! == "/" {
            return value1 / target
        } else {
            print("Unknown operation \(operation!)")
            return nil
        }
    }

    func calculateReverse(value2: Int, target: Int) -> Int? {
        if operation! == "+" {
            return target - value2
        } else if operation! == "-" {
            return target + value2
        } else if operation! == "*" {
            return target / value2
        } else if operation! == "/" {
            return target * value2
        } else {
            print("Unknown operation \(operation!)")
            return nil
        }
    }
}
