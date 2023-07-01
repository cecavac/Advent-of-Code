//
//  main.swift
//  Advent8
//
//  Created by Dragan Cecavac on 16.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let display = Display(rows: 6, columns: 50)
display.process(data: Input.Input1)

let result1 = display.litPixelCount
print("Result1: \(result1)")

print("Result2:")
display.show()
