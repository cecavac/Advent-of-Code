//
//  main.swift
//  Advent11
//
//  Created by Dragan Cecavac on 11.12.21.
//

import Foundation

let octopusCave1 = OctopusCave(Input.Input1)
let result1 = octopusCave1.tick(count: 100)
print("Result1: \(result1)")

let octopusCave2 = OctopusCave(Input.Input1)
let result2 = octopusCave2.bigFlash()
print("Result2: \(result2)")
