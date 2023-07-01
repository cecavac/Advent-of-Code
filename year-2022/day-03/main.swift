//
//  main.swift
//  Advent03
//
//  Created by Dragan Cecavac on 03.12.22.
//

import Foundation

let rucksacks = Rucksacks(Input.Input1)

let result1 = rucksacks.priority()
print("Result1: \(result1)")

let result2 = rucksacks.badges()
print("Result2: \(result2)")
