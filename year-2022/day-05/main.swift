//
//  main.swift
//  Advent05
//
//  Created by Dragan Cecavac on 05.12.22.
//

import Foundation

let crane = Crane(Input.Input1)

let result1 = crane.move(multiple: false)
print("Result1: \(result1)")

let result2 = crane.move(multiple: true)
print("Result2: \(result2)")
