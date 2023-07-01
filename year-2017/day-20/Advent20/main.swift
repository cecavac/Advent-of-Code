//
//  main.swift
//  Advent20
//
//  Created by Dragan Cecavac on 14.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let gpuHelper = GPUHelper(Input.Input1)

let result1 = gpuHelper.foreverClosest
print("Result1: \(result1)")

let result2 = gpuHelper.nonCollidingCount
print("Result2: \(result2)")
