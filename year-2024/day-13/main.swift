//
//  main.swift
//  day-13
//
//  Created by Dragan Cecavac on 13.12.24.
//

import Foundation

let contraption = Contraption(Input.Input)

let result1 = contraption.tokens(boosted: false)
print("Result1: \(result1)")

let result2 = contraption.tokens(boosted: true)
print("Result2: \(result2)")
