//
//  main.swift
//  Advent15
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let comparator1 = Comparator(Input.Input1)
let result1 = comparator1.getMatches()
print("Result1: \(result1)")

let comparator2 = Comparator(Input.Input1)
let result2 = comparator2.getSpecialMatches()
print("Result2: \(result2)")
