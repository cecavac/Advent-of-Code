//
//  main.swift
//  Advent23
//
//  Created by Dragan Cecavac on 23.12.22.
//

import Foundation

let elfCrowd1 = ElfCrowd(Input.Input1)
let _ = elfCrowd1.move(cycles: 10)
let result1 = elfCrowd1.groundCovered()
print("Result1: \(result1)")

let elfCrowd2 = ElfCrowd(Input.Input1)
let result2 = elfCrowd2.move(cycles: nil)
print("Result2: \(result2)")
