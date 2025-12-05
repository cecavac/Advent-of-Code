//
//  main.swift
//  day-05
//
//  Created by Dragan Cecavac on 05.12.25.
//

import Foundation

let inventory = Inventory(Input.Input)

let result1 = inventory.countFresh()
print("Result1: \(result1)")

let result2 = inventory.allFresh()
print("Result2: \(result2)")
