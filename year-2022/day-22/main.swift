//
//  main.swift
//  Advent22
//
//  Created by Dragan Cecavac on 22.12.22.
//

import Foundation

let monkeyMap1 = MonkeyMap(Input.Input1)
monkeyMap1.walk()
let result1 = monkeyMap1.score()
print("Result1: \(result1)")

let monkeyMap2 = MonkeyMap(Input.Input1)
monkeyMap2.walk(hint: Input.Input1Hint, visualize: false)
let result2 = monkeyMap2.score()
print("Result2: \(result2)")
