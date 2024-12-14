//
//  main.swift
//  day-14
//
//  Created by Dragan Cecavac on 14.12.24.
//

import Foundation

let height = 103
let width = 101

let restroom1 = Restroom(Input.Input, width: width, height: height)
restroom1.tick(count: 100)
let result1 = restroom1.sum()
print("Result1: \(result1)")

let restroom2 = Restroom(Input.Input, width: width, height: height)
let result2 = restroom2.findChristmasTree()
print("Result2: \(result2)")
