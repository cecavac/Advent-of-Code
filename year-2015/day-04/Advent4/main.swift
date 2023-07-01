//
//  main.swift
//  Advent4
//
//  Created by Dragan Cecavac on 06.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let result1 = Hasher.findFirstWithNLeadingZeros(for: Inputs.Input1, zeros: 5)
print("Result1: \(result1)")

let result2 = Hasher.findFirstWithNLeadingZeros(for: Inputs.Input1, zeros: 6)
print("Result2: \(result2)")
