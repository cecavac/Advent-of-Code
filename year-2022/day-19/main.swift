//
//  main.swift
//  Advent19
//
//  Created by Dragan Cecavac on 19.12.22.
//

import Foundation

print("Buckle up, CPU's going for a spin!")

let bleuprint1 = Blueprint(Input.Input1, limit: nil)
let result1 = bleuprint1.build(minutes: 24,multiply: false)

let bleuprint2 = Blueprint(Input.Input1, limit: 3)
let result2 = bleuprint2.build(minutes: 32, multiply: true)

print("Result1: \(result1)")
print("Result2: \(result2)")
