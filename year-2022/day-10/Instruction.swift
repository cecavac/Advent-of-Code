//
//  Instruction.swift
//  Advent10
//
//  Created by Dragan Cecavac on 10.12.22.
//

import Foundation

class Instruction {
    private var ticks: Int
    private var operand: Int?

    init(_ input: String) {
        if input == "noop" {
            ticks = 1
            operand = nil
        } else {
            let elements = input.split(separator: " ")
            if elements[0] != "addx" {
                print("Unexpected instruction \(elements[0])")
            }
            ticks = 2
            operand = Int(String(elements[1]))!
        }
    }

    func tick(with register: Int) -> Bool {
        ticks -= 1
        return ticks == 0
    }

    func result(using register: Int) -> Int {
        if let operand = operand {
            return register + operand
        } else {
            return register
        }
    }
}
