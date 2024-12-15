//
//  main.swift
//  day-15
//
//  Created by Dragan Cecavac on 15.12.24.
//

import Foundation

let warehouse = Warehouse(Input.Input, stretch: false)
warehouse.walk()
let result1 = warehouse.score()
print("Result1: \(result1)")

let warehouse2 = Warehouse(Input.Input, stretch: true)
warehouse2.walk()
let result2 = warehouse2.score()
print("Result2: \(result2)")
