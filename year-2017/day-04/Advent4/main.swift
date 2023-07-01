//
//  main.swift
//  Advent4
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let validator = Validator(Input.Input1)

let result1 = validator.countValid()
print("Result1: \(result1)")

let result2 = validator.secureCountValid()
print("Result2: \(result2)")
