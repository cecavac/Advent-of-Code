//
//  main.swift
//  Advent12
//
//  Created by Dragan Cecavac on 11.12.22.
//

import Foundation

let maze1 = Maze(Input.Input1, inverted: false)
let result1 = maze1.distanceToEnd()
print("Result1: \(result1)")

let maze2 = Maze(Input.Input1, inverted: true)
let result2 = maze2.distanceToA()
print("Result2: \(result2)")
