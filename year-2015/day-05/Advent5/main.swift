//
//  main.swift
//  Advent5
//
//  Created by Dragan Cecavac on 12.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

var result1 = 0
var result2 = 0
let stringArray = Inputs.Input1.split(separator: "\n")
for string in stringArray {
    if String(string).isNice() {
        result1 += 1
    }

    if String(string).isReallyNice() {
        result2 += 1
    }
}

print("Result1 \(result1)")
print("Result2 \(result2)")
