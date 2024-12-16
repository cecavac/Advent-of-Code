//
//  main.swift
//  day-16
//
//  Created by Dragan Cecavac on 16.12.24.
//

import Foundation

let race = Race(Input.Input)

let result1 = race.find()
print("Result1: \(result1)")

let result2 = race.places.count
print("Result2: \(result2)")
