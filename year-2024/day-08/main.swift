//
//  main.swift
//  day-08
//
//  Created by Dragan Cecavac on 08.12.24.
//

import Foundation

let locator = Locator(Input.Input)

let result1 = locator.locate(resonate: false)
print("Result1: \(result1)")

let result2 = locator.locate(resonate: true)
print("Result2: \(result2)")
