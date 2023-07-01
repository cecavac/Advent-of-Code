//
//  main.swift
//  Advent13
//
//  Created by Dragan Cecavac on 13.12.21.
//

import Foundation

let manual = Maual(Input.Input1)

manual.foldOne()
let result1 = manual.countDots()
print("Result1: \(result1)")

print("Result2:")
manual.foldAll()
manual.show()
