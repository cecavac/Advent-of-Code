//
//  main.swift
//  Advent18
//
//  Created by Dragan Cecavac on 18.12.21.
//

import Foundation

let math = SnailFishMath(Input.Input1)

let result1 = math.reduce()
print("Result1: \(result1)")

let result2 = math.highestMagnitude()
print("Result2: \(result2)")
