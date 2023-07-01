//
//  main.swift
//  Advent11
//
//  Created by Dragan Cecavac on 10.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let grid = Grid()
grid.travel(path: Input.Input1)

let result1 = grid.currentDistance
print("Result1: \(result1)")

let result2 = grid.maxDistance
print("Result2: \(result2)")
