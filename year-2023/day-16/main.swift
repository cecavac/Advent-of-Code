//
//  main.swift
//  day-16
//
//  Created by Dragan Cecavac on 16.12.23.
//

import Foundation

let beam = Beam(Input.Input1)
let result1 = beam.energized()
print("Result1: \(result1)")

let result2 = beam.bestEnergized()
print("Result2: \(result2)")
