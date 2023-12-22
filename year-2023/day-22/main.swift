//
//  main.swift
//  day-22
//
//  Created by Dragan Cecavac on 22.12.23.
//

import Foundation

print("CPU goes brrrrrr!")

let tetris = Tetris(Input.Input1)
let (result1, result2) = tetris.play()

print("Result1: \(result1)")
print("Result2: \(result2)")
