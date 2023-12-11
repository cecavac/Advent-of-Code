//
//  main.swift
//  day-11
//
//  Created by Dragan Cecavac on 11.12.23.
//

import Foundation

let space1 = Space(Input.Input1)
space1.expand(by: 2)
let result1 = space1.paths()
print("Result1: \(result1)")

let space2 = Space(Input.Input1)
space2.expand(by: 1000000)
let result2 = space2.paths()
print("Result2: \(result2)")
