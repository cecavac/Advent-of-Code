//
//  main.swift
//  Advent6
//
//  Created by Dragan Cecavac on 06.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let debugger = Debugger(Input.Input1)
let result = debugger.findRepeatingState()

print("Result1: \(result.0)")
print("Result2: \(result.1)")
