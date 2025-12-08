//
//  main.swift
//  day-08
//
//  Created by Dragan Cecavac on 08.12.25.
//

import Foundation


let circuit = Circuit(Input.Input)

let result1 = circuit.group(count: 1000)
print("Result1: \(result1)")

let result2 = circuit.findLast()
print("Result2: \(result2)")
