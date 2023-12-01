//
//  main.swift
//  day-01
//
//  Created by Dragan Cecavac on 01.12.23.
//

import Foundation

let calibrator = Calibrator(Input.Input1)

let result1 = calibrator.calibrate(withReplacement: false)
print("Result1: \(result1)")

let result2 = calibrator.calibrate(withReplacement: true)
print("Result2: \(result2)")
