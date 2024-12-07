//
//  main.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.24.
//

import Foundation

let calibrator = Calibrator(Input.Input)

let result1 = calibrator.calibrate(extended: false)
print("Result1: \(result1)")

let result2 = calibrator.calibrate(extended: true)
print("Result2: \(result2)")
