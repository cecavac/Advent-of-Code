//
//  main.swift
//  Advent04
//
//  Created by Dragan Cecavac on 04.12.21.
//

import Foundation

var bingo = Bingo(Input.Input1)

let result1 = bingo.play()
print("Result1: \(result1)")

let result2 = bingo.playToTheEnd()
print("Result2: \(result2)")
