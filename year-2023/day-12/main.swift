//
//  main.swift
//  day-12
//
//  Created by Dragan Cecavac on 12.12.23.
//

import Foundation

let factory1 = Factory(Input.Input1, unfold: false)
let result1 = factory1.possibilities()
print("Result1: \(result1)")

let factory2 = Factory(Input.Input1, unfold: true)
let result2 = factory2.possibilities()
print("Result2: \(result2)")
