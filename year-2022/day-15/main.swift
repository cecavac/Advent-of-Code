//
//  main.swift
//  Advent15
//
//  Created by Dragan Cecavac on 15.12.22.
//

import Foundation

let scanner = Scanner(Input.Input1)

let result1 = scanner.adjustedImpossibles(row: 2000000)
print("Result1: \(result1)")

print("Go grab a coffee, or two... and let the computer compute!")
let result2 = scanner.find(low: 0, high: 4000000)
print("Result2: \(result2)")
