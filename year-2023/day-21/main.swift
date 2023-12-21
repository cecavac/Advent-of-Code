//
//  main.swift
//  day-21
//
//  Created by Dragan Cecavac on 21.12.23.
//

import Foundation

let garden = Garden(Input.Input1)

let result1 = garden.count(steps: 64)
print("Result1: \(result1)")

let result2 = garden.possibilities(steps: 26501365)
print("Result2: \(result2)")
