//
//  main.swift
//  day-23
//
//  Created by Dragan Cecavac on 23.12.24.
//

import Foundation

let network = Network(Input.Input)

let result1 = network.triple()
print("Result1: \(result1)")

let result2 = network.password()
print("Result2: \(result2)")
