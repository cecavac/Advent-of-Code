//
//  main.swift
//  Advent21
//
//  Created by Dragan Cecavac on 21.12.21.
//

import Foundation

var diracDice = DiracDice(Input.Input1)
let result1 = diracDice.play()
print("Result1: \(result1)")

var quantumDiracDice = QuantumDiracDice(Input.Input1)
let result2 = quantumDiracDice.play()
print("Result2: \(result2)")
