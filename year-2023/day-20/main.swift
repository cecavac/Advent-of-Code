//
//  main.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.23.
//

import Foundation

let circuit = Circuit(Input.Input1)

let result1 = circuit.cycle()
print("Result1: \(result1)")

let result2 = circuit.rxCycle()
print("Result2: \(result2)")
