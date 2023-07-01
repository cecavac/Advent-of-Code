//
//  main.swift
//  Advent09
//
//  Created by Dragan Cecavac on 09.12.22.
//

import Foundation

let rope1 = Rope(knotCount: 2)
let result1 = rope1.walk(Input.Input1)
print("Result1: \(result1)")

let rope2 = Rope(knotCount: 10)
let result2 = rope2.walk(Input.Input1)
print("Result2: \(result2)")
