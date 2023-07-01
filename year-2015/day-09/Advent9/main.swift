//
//  main.swift
//  Advent9
//
//  Created by Dragan Cecavac on 22.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let router = Router(for: Input.Input1)

let result1 = router.calculateDistance(minimize: true)
print("Result1: \(result1)")

let result2 = router.calculateDistance(minimize: false)
print("Result2: \(result2)")
