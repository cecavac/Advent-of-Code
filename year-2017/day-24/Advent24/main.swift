//
//  main.swift
//  Advent24
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let bridge = Bridge(Input.Input1)
let result1 = bridge.findBest()
print("Result1: \(result1)")

let longBridge = LongBridge(Input.Input1)
let result2 = longBridge.findLongest()
print("Result2: \(result2)")
