//
//  main.swift
//  Advent16
//
//  Created by Dragan Cecavac on 15.12.22.
//

import Foundation

let pipeline = Pipeline(Input.Input1)
let result1 = pipeline.explore()
print("Result1: \(result1)")

let pipeline2 = Pipeline(Input.Input1)
let result2 = pipeline2.pairExplore()
print("Result2: \(result2)")
