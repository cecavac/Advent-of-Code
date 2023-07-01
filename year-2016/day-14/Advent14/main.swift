//
//  main.swift
//  Advent14
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let hasher = Hasher(Input.Input1)

let result1 = hasher.find(index:64, keyStretching: false)
let result2 = hasher.find(index:64, keyStretching: true)

print("Result1: \(result1)")
print("Result2: \(result2)")
