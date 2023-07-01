//
//  main.swift
//  Advent22
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let grid = Grid(Input.Input1)
let result1 = grid.run(for: 10 * 1000)
print("Result1: \(result1)")

let improvedGrid = ImprovedGrid(Input.Input1)
let result2 = improvedGrid.run(for: 10 * 1000 * 1000)
print("Result2: \(result2)")
