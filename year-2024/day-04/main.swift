//
//  main.swift
//  day-04
//
//  Created by Dragan Cecavac on 04.12.24.
//

import Foundation

let xmas = Xmas(Input.Input)

let result1 = xmas.find(useXShape: false)
print("Result1: \(result1)")

let result2 = xmas.find(useXShape: true)
print("Result2: \(result2)")
