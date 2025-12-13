//
//  main.swift
//  day-10
//
//  Created by Dragan Cecavac on 10.12.25.
//

import Foundation

let spammer = Spammer(Input.Input)

let result1 = spammer.indicatorPresses()
print("Result1: \(result1)")

let result2 = spammer.joltagePresses()
print("Result2: \(result2)")
