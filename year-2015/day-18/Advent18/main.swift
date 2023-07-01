//
//  main.swift
//  Advent18
//
//  Created by Dragan Cecavac on 29.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let lights1 = Lights(Input.Input1)
let result1 = lights1.animate(times: 100, stuck: false)
print("Result1: \(result1)")

let lights2 = Lights(Input.Input1)
let result2 = lights2.animate(times: 100, stuck: true)
print("Result2: \(result2)")
