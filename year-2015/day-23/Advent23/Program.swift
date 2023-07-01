//
//  Program.swift
//  Advent23
//
//  Created by Dragan Cecavac on 11.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation
class Program {
    private var a: Int
    private var b: Int
    private var pc = 0
    private var instructions = Array<Instruction>()

    init(_ input: String, registerA: Int, registerB: Int) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let instruction = Instruction(String(line))
            instructions.append(instruction)
        }

        a = registerA
        b = registerB
    }

    public func execute() -> Int {
        while pc >= 0 && pc < instructions.count {
            pc += instructions[pc].execute(registerA: &a, registerB: &b)
        }

        return b
    }
}
