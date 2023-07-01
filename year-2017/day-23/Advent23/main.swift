//
//  main.swift
//  Advent23
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let tablet = Tablet(Input.Input1)
let result1 = tablet.run()
print("Result1: \(result1)")

let realTablet = RealTablet()
let result2 = realTablet.run()
print("Result2: \(result2)")
