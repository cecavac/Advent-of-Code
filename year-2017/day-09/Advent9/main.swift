//
//  main.swift
//  Advent9
//
//  Created by Dragan Cecavac on 10.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let parser = Parser(Input.Input1)

let result1 = parser.countGroups()
print("Result1: \(result1)")

let result2 = parser.removed
print("Result2: \(result2)")
