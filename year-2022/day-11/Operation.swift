//
//  Operation.swift
//  Advent11
//
//  Created by Dragan Cecavac on 11.12.22.
//

import Foundation

class Operation {
    var operand1: String
    var operand2: String
    var operation: String

    init(_ input: String) {
        let elements = input.split(separator: " ")
        operand1 = String(elements[3])
        operation = String(elements[4])
        operand2 = String(elements[5])
    }

    func process(value: Int) -> Int? {
        let value1: Int
        let value2: Int

        if operand1 == "old" {
            value1 = value
        } else {
            value1 = Int(String(operand1))!
        }
        if operand2 == "old" {
            value2 = value
        } else {
            value2 = Int(String(operand2))!
        }

        if operation == "+" {
            return value1 + value2
        } else if operation == "*" {
            return value1 * value2
        } else {
            print("Unknown operation \(operation)")
            return nil
        }
    }
}
