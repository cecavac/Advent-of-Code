//
//  main.swift
//  Advent1
//
//  Created by Dragan Cecavac on 04.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let result1 = FloorCounter.calculateFloors(for: Inputs.Input1)
print("Result1: \(result1)")

let result2 = FloorCounter.findFirstBasementIteration(for: Inputs.Input1)
print("Result2: \(result2)")
