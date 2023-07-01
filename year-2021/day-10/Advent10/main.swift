//
//  main.swift
//  Advent10
//
//  Created by Dragan Cecavac on 10.12.21.
//

import Foundation

let parser = Parser()

let result1 = parser.parse(Input.Input1)
print("Result1: \(result1)")

let result2 = parser.autocpmplete()
print("Result2: \(result2)")
