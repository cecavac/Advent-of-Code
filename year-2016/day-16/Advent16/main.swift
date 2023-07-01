//
//  main.swift
//  Advent16
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let result1 = Checksummer.getChecksum(input: Input.Input1, to: 272)
print("Result1: \(result1)")

let result2 = Checksummer.getChecksum(input: Input.Input1, to: 35651584)
print("Result2: \(result2)")
