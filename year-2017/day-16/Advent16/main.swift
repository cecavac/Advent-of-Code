//
//  main.swift
//  Advent16
//
//  Created by Dragan Cecavac on 12.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let rave = Rave()
let result1 = rave.dance(moves: Input.Input1)
print("Result1: \(result1)")

let result2 = rave.stateAfter(cycles: 1000000000, moves: Input.Input1)
print("Result2: \(result2)")
