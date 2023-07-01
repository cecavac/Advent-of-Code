//
//  Computer.swift
//  Advent12
//
//  Created by Dragan Cecavac on 26.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Computer<T: FixedWidthInteger> {
    var instruction: [Instruction<T>] = []

    var registers:Registers<T>

    init(_ input: String, regDefault regStart: T, aStart a: T) {
        registers = Registers<T>(start: regStart)
        registers.a = a

        let lines = input.split(separator: "\n")
        for line in lines {
            let elements = line.split(separator: " ")
            let op = String(elements[0])
            var arg1: String? = nil
            var arg2: String? = nil

            arg1 = String(elements[1])
            if elements.count == 3 {
                arg2 = String(elements[2])
            }

            switch op {
            case "inc":
                let inst = inc<T>(a1: arg1, a2: arg2)
                instruction.append(inst)
            case "dec":
                let inst = dec<T>(a1: arg1, a2: arg2)
                instruction.append(inst)
            case "cpy":
                let inst = cpy<T>(a1: arg1, a2: arg2)
                instruction.append(inst)
            case "jnz":
                let inst = jnz<T>(a1: arg1, a2: arg2)
                instruction.append(inst)
            case "tgl":
                let inst = tgl<T>(a1: arg1, a2: arg2)
                instruction.append(inst)
            case "mul":
                let inst = mul<T>(a1: arg1, a2: arg2)
                instruction.append(inst)
            default:
                print("Error opcode \(op)")
            }
        }
    }

    func run() -> T {
        while registers.ip < instruction.count {
            let inst = instruction[Int(registers.ip)]
            inst.run(registers: registers, computer: self)
        }

        return registers.a
    }

    func toggle(ip: Int) {
        if ip > 0 && ip < instruction.count {
            let newInst = instruction[ip].toggle()
            instruction.remove(at: ip)
            instruction.insert(newInst, at: ip)
        }
    }
}
