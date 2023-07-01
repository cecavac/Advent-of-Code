//
//  main.swift
//  Advent07
//
//  Created by Dragan Cecavac on 07.12.21.
//

import Foundation

let crabNavy = CrabNavy(Input.Input1)

let result1 = crabNavy.fuelToMiddle(uniformSpending: true)
print("Result1: \(result1)")

let result2 = crabNavy.fuelToMiddle(uniformSpending: false)
print("Result2: \(result2)")
