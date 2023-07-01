//
//  main.swift
//  Advent20
//
//  Created by Dragan Cecavac on 20.12.21.
//

import Foundation

let enchancer = Enhancer(Input.Input1)

enchancer.process(ticks: 2)
let result1 = enchancer.pixels.count
print("Result1: \(result1)")

enchancer.process(ticks: 48)
let result2 = enchancer.pixels.count
print("Result2: \(result2)")
