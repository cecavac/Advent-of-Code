//
//  main.swift
//  Advent17
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let fridge = Fridge(for: Input.Input1, limit: 150)

let result = fridge.fittingCombinations()
print("Result1: \(result.0)")
print("Result2: \(result.1)")
