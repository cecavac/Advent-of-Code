//
//  main.swift
//  Advent14
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let olympics = Olympics(Input.Input1)
let result = olympics.findBest(after: 2503)
print("Result1: \(result.0)")
print("Result2: \(result.1)")
