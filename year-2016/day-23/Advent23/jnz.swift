//
//  jnz.swift
//  Advent23
//
//  Created by Dragan Cecavac on 31.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class jnz<T: FixedWidthInteger>: Instruction<T> {

    override func run(registers: Registers<T>, computer: Computer<T>) {
        let value = getValue(arg1, registers: registers)
        let offset = getValue(arg2, registers: registers)

        if value != 0 {
            registers.ip += offset
        } else {
            registers.ip += 1
        }
    }

    override func toggle() -> Instruction<T> {
        return cpy<T>(a1: arg1, a2: arg2)
    }
}
