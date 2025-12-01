//
//  main.swift
//  day-01
//
//  Created by Dragan Cecavac on 01.12.25.
//

import Foundation

let safe = Safe(Input.Input)
safe.unlock()

let result1 = safe.zero
print("Result1: \(result1)")

let result2 = safe.rollingZero
print("Result2: \(result2)")
