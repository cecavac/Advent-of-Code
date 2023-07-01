//
//  main.swift
//  Advent24
//
//  Created by Dragan Cecavac on 24.12.21.
//

import Foundation

let alu = ALU()
alu.process()

let result1 = alu.result(max: true)
print("Result1: \(result1)")

let result2 = alu.result(max: false)
print("Result2: \(result2)")
