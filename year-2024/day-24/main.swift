//
//  main.swift
//  day-24
//
//  Created by Dragan Cecavac on 24.12.24.
//

import Foundation

let circuit = Circuit(Input.Input)
circuit.process()
let result1 = circuit.zValue()!
print("Result1: \(result1)")

let swapper = Swapper(Input.Input)
let result2 = swapper.fix()
print("Result2: \(result2)")
