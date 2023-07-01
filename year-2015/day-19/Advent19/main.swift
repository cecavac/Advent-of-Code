//
//  main.swift
//  Advent19
//
//  Created by Dragan Cecavac on 30.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let pfizer = Pfizer(for: Input.Input12, with: Input.Input11)

let result1 = pfizer.calibrate()
print("Result1: \(result1)")

let result2 = pfizer.produce()
print("Result2: \(result2)")
