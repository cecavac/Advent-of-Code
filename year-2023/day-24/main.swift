//
//  main.swift
//  day-24
//
//  Created by Dragan Cecavac on 24.12.23.
//

import Foundation

let inator = Analytics(Input.Input1)

let result1 = inator.intersections(low: 200000000000000, high: 400000000000000)
print("Result1: \(result1)")

let result2 = inator.shoot()
print("Result2: \(result2)")
