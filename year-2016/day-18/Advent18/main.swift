//
//  main.swift
//  Advent18
//
//  Created by Dragan Cecavac on 29.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let room1 = Room(Input.Input1, rows: 40)
let result1 = room1.numberOfSafeTiles
print("Result1: \(result1)")

let room2 = Room(Input.Input1, rows: 400000)
let result2 = room2.numberOfSafeTiles
print("Result2: \(result2)")

