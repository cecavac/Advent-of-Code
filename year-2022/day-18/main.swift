//
//  main.swift
//  Advent18
//
//  Created by Dragan Cecavac on 18.12.22.
//

import Foundation

let boulders = Boulders(Input.Input1)

let result1 = boulders.nonadjacentSides()
print("Result1: \(result1)")

let result2 = boulders.exterior(allSides: result1)
print("Result2: \(result2)")
