//
//  main.swift
//  day-23
//
//  Created by Dragan Cecavac on 23.12.23.
//

import Foundation

let hike1 = Hike(Input.Input1, climbSlopes: false)
let result1 = hike1.path()
print("Result1: \(result1)")

let hike2 = Hike(Input.Input1, climbSlopes: true)
let result2 = hike2.longPath()
print("Result2: \(result2)")
