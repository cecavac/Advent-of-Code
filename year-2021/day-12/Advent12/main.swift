//
//  main.swift
//  Advent12
//
//  Created by Dragan Cecavac on 12.12.21.
//

import Foundation

let caveSystem = CaveSystem(Input.Input1)

let result1 = caveSystem.explore(visitTwice: false)
print("Result1: \(result1)")

let result2 = caveSystem.explore(visitTwice: true)
print("Result2: \(result2)")
