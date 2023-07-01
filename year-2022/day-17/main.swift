//
//  main.swift
//  Advent17
//
//  Created by Dragan Cecavac on 17.12.22.
//

import Foundation

let tetris1 = Tetris()
let result1 = tetris1.fall(jets: Input.Input1, count: 2022).totalHeight
print("Result1: \(result1)")

let tetris2 = Tetris()
let result2 = tetris2.pleaseTheElephants(jets: Input.Input1)
print("Result2: \(result2)")
