//
//  Instruction.swift
//  Advent23
//
//  Created by Dragan Cecavac on 31.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Instruction<T: FixedWidthInteger> {

    var arg1: String?
    var arg2: String?

    init(a1: String?, a2: String?) {
        arg1 = a1
        arg2 = a2
    }

    func run(registers: Registers<T>, computer: Computer<T>) {
        assert(false, "This method must be overriden by the subclass")
    }

    func getValue(_ register: String?, registers: Registers<T>) -> T {
        if register == nil {
            print("Error - register argument nil")
            return 0
        }

        if let value = T(register!) {
            return value
        } else {
            return registers.get(register: register!)
        }
    }

    func setValue(registers: Registers<T>, register: String?, value: T) {
        if register == nil {
            print("Error - register argument nil")
            return
        }

        registers.set(register: register!, value: value)
    }

    func toggle() -> Instruction<T> {
        assert(false, "This method must be overriden by the subclass")

        return self
    }
}
