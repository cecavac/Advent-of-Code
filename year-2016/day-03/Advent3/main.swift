//
//  main.swift
//  Advent3
//
//  Created by Dragan Cecavac on 01.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let inspector1 = Inspector(rawInput: Input.Input1)
let result1 = inspector1.validCount
print("Result1: \(result1)")

let inspector2 = Inspector(rotatedInput: Input.Input1)
let result2 = inspector2.validCount
print("Result2: \(result2)")
