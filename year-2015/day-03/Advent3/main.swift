//
//  main.swift
//  Advent3
//
//  Created by Dragan Cecavac on 05.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let visitTracker = VisitTracker()
let result1 = visitTracker.visitedHousesCount(for: Inputs.Input1)
print("Result1: \(result1)")

let improvedVisitTracker = ImprovedVisitTracker()
let result2 = improvedVisitTracker.visitedHousesCount(for: Inputs.Input1)
print("Result2: \(result2)")
