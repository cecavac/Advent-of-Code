//
//  main.swift
//  day-09
//
//  Created by Dragan Cecavac on 09.12.25.
//

import Foundation

let tiles = Tiles(Input.Input)

let result1 = tiles.findLargest(validByDefault: true)
print("Result1: \(result1)")

let result2 = tiles.findLargest(validByDefault: false)
print("Result2: \(result2)")
