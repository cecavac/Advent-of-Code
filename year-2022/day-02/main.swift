//
//  main.swift
//  Advent02
//
//  Created by Dragan Cecavac on 02.12.22.
//

import Foundation

let game = Game(Input.Input1)

let result1 = game.assumedScore()
print("Result1: \(result1)")

let result2 = game.actualScore()
print("Result2: \(result2)")
