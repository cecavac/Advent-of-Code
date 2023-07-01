//
//  main.swift
//  Advent14
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let defragmenter = Defragmenter(Input.Input1)

let result1 = defragmenter.usedCount
print("Result1: \(result1)")

let result2 = defragmenter.groupCounter
print("Result2: \(result2)")
