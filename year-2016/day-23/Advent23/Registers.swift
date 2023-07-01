//
//  Registers.swift
//  Advent23
//
//  Created by Dragan Cecavac on 31.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Registers <T: FixedWidthInteger> {
    var a: T
    var b: T
    var c: T
    var d: T
    var ip: T

    init(start value: T) {
        a = value
        b = value
        c = value
        d = value
        ip = value
    }

    func get(register: String) -> T {
        switch register {
        case "a":
            return a
        case "b":
            return b
        case "c":
            return c
        case "d":
            return d
        default:
            print("Error getValue element: \(register)")
            return a
        }
    }

    func set(register: String, value: T) {
        switch register {
        case "a":
            a = value
        case "b":
            b = value
        case "c":
            c = value
        case "d":
            d = value
        default:
            print("Error getValue element: \(register)")
        }
    }
}
