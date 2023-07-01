//
//  main.swift
//  Advent13
//
//  Created by Dragan Cecavac on 26.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let table = Table(Input.Input1)
let result1 = table.getBestScore()
print("Result1: \(result1)")

table.sit()
let result2 = table.getBestScore()
print("Result2: \(result2)")
