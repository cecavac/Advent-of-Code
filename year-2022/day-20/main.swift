//
//  main.swift
//  Advent20
//
//  Created by Dragan Cecavac on 20.12.22.
//

import Foundation

let mixer1 = Mixer(Input.Input1, decriptionKey: nil)
let result1 = mixer1.mix(cycles: 1)
print("Result1: \(result1)")

let mixer2 = Mixer(Input.Input1, decriptionKey: 811589153)
let result2 = mixer2.mix(cycles: 10)
print("Result2: \(result2)")
