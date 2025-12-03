//
//  main.swift
//  day-03
//
//  Created by Dragan Cecavac on 03.12.25.
//

import Foundation

let energy = Energy(Input.Input)

let result1 = energy.calculate(elements: 2)
print("Result1: \(result1)")

let result2 = energy.calculate(elements: 12)
print("Result2: \(result2)")
