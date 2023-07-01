//
//  main.swift
//  Advent06
//
//  Created by Dragan Cecavac on 06.12.21.
//

import Foundation

let fishCounter = FishCounter(Input.Input1)

let result1 = fishCounter.wait(days: 80)
print("Result1: \(result1)")

let result2 = fishCounter.wait(days: 256 - 80)
print("Result2: \(result2)")

