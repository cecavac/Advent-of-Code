//
//  main.swift
//  day-17
//
//  Created by Dragan Cecavac on 17.12.23.
//

import Foundation

let small = SmallCrucible(Input.Input1)
let result1 = small.path()
print("Result1: \(result1)")

let big = BigCrucible(Input.Input1)
let result2 = big.path()
print("Result2: \(result2)")
