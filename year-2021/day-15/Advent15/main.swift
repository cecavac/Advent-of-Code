//
//  main.swift
//  Advent15
//
//  Created by Dragan Cecavac on 15.12.21.
//

import Foundation

let pathFinder1 = PathFinder(Input.Input1, scale: 1)
let result1 = pathFinder1.endDistance()
print("Result1: \(result1)")

let pathFinder2 = PathFinder(Input.Input1, scale: 5)
let result2 = pathFinder2.endDistance()
print("Result2: \(result2)")
