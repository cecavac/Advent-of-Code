//
//  tgl.swift
//  Advent23
//
//  Created by Dragan Cecavac on 01.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class tgl<T: FixedWidthInteger>: Instruction<T> {

    override func run(registers: Registers<T>, computer: Computer<T>) {
        let offset = getValue(arg1, registers: registers)
        let ip = offset + registers.ip
        computer.toggle(ip: Int(ip))

        registers.ip += 1
    }

    override func toggle() -> Instruction<T> {
        return inc<T>(a1: arg1, a2: arg2)
    }
}
