//
//  main.swift
//  Advent04
//
//  Created by Dragan Cecavac on 04.12.22.
//

import Foundation

let plan = CleaningPlan(Input.Input1)

let result1 = plan.fullOverlapCount()
print("Result1: \(result1)")

let result2 = plan.overlapCount()
print("Result2: \(result2)")
