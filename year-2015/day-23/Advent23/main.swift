//
//  main.swift
//  Advent23
//
//  Created by Dragan Cecavac on 11.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let program1 = Program(Input.Input1, registerA: 0, registerB: 0)
let result1 = program1.execute()
print("Result1: \(result1)")

let program2 = Program(Input.Input1, registerA: 1, registerB: 0)
let result2 = program2.execute()
print("Result2: \(result2)")
