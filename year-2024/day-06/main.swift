//
//  main.swift
//  day-06
//
//  Created by Dragan Cecavac on 06.12.24.
//

import Foundation

let tracker = Tracker(Input.Input)
tracker.walk()
let result1 = tracker.visited.count
print("Result1: \(result1)")

let result2 = Obstructor.possibilities(Input.Input)
print("Result2: \(result2)")
