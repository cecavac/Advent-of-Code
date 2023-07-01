//
//  main.swift
//  Advent22
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let grid = Grid(Input.Input1)

let result1 = grid.viablePairs()
grid.show()
print("Result1 \(result1)")

let result2 = grid.dataSteps()
print("Result2: \(result2)")
