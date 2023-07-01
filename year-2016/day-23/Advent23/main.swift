//
//  main.swift
//  Advent23
//
//  Created by Dragan Cecavac on 31.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let computer1 = Computer<Int>(Input.Input1, regDefault: 0, aStart: 7)
let result1 = computer1.run()
print("Result1: \(result1)")

let computer2 = Computer<Int>(Input.Input2, regDefault: 0, aStart: 12)
let result2 = computer2.run()
print("Result2: \(result2)")
