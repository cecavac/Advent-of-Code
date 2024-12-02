//
//  main.swift
//  day-02
//
//  Created by Dragan Cecavac on 02.12.24.
//

import Foundation

let validator = Validator(Input.Input)

let result1 = validator.safe()
print("Result1: \(result1)")

let result2 = validator.dampenedSafe()
print("Result2: \(result2)")
