//
//  mul.swift
//  Advent23
//
//  Created by Dragan Cecavac on 01.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class mul<T: FixedWidthInteger>: Instruction<T> {

    override func run(registers: Registers<T>, computer: Computer<T>) {
        let value = getValue(arg1, registers: registers) * getValue(arg2, registers: registers)
        setValue(registers: registers, register: "a", value: value)

        registers.ip += 1
    }
}
