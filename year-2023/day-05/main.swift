//
//  main.swift
//  day-05
//
//  Created by Dragan Cecavac on 05.12.23.
//

import Foundation

let agriculture = Agriculture(Input.Input1)

let result1 = agriculture.lowestLocation()
print("Result1: \(result1)")

let result2 = agriculture.actuallyLowestLocation()
print("Result2: \(result2)")
