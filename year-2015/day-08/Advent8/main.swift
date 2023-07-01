//
//  main.swift
//  Advent8
//
//  Created by Dragan Cecavac on 01.02.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let stringAnalyseResult1 = StringAnalyser.analyse(Inputs.Input1)
let result1 = stringAnalyseResult1.1 - stringAnalyseResult1.0
print("Result1: \(result1)")

let expandedString = StringAnalyser.expand(Inputs.Input1)
let stringAnalyseResult2 = StringAnalyser.analyse(expandedString)
let result2 = stringAnalyseResult2.1 - stringAnalyseResult1.1
print("Result2: \(result2)")
