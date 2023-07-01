//
//  main.swift
//  Advent2
//
//  Created by Dragan Cecavac on 01.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let keypad = Keypad(Input.Input1)
let result1 = keypad.result
print("Result1: \(result1)")

let keypad2 = Keypad2(Input.Input1)
let result2 = keypad2.result
print("Result2: \(result2)")
