//
//  main.swift
//  Advent9
//
//  Created by Dragan Cecavac on 22.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let decompresser = Decompresser()

let result1 = decompresser.process(input: Input.Input1).count
print("Result1: \(result1)")

let result2 = decompresser.expandProcess(input: Input.Input1, depth: 3)
print("Result2: \(result2)")
