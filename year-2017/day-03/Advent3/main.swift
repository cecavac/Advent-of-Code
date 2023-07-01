//
//  main.swift
//  Advent3
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let spiralMemory = SpiralMemory()

let result1 = spiralMemory.getDistance(of: Input.Input1)
print("Result1: \(result1)")

let result2 = spiralMemory.getNext(after: Input.Input1)
print("Result2: \(result2)")
