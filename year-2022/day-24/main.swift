//
//  main.swift
//  Advent24
//
//  Created by Dragan Cecavac on 24.12.22.
//

import Foundation

let basin = Basin(Input.Input1)
basin.preCacheMaps()
let result1 = basin.walk(pickupSnacks: false)
print("Result1: \(result1)")

let basin2 = Basin(Input.Input1)
basin2.preCacheMaps()
let result2 = basin2.walk(pickupSnacks: true)
print("Result2: \(result2)")
