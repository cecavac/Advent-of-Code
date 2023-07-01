//
//  main.swift
//  Advent05
//
//  Created by Dragan Cecavac on 04.12.21.
//

import Foundation

var map1 = Map(Input.Input1, withDiagonals: false)
let result1 = map1.getOverlaps()
print("Result1: \(result1)")

var map2 = Map(Input.Input1, withDiagonals: true)
let result2 = map2.getOverlaps()
print("Result2: \(result2)")
