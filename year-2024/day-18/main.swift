//
//  main.swift
//  day-18
//
//  Created by Dragan Cecavac on 18.12.24.
//

import Foundation

let size = 71
let maze = Maze(Input.Input, size: size, steps: 1024)
let result1 = maze.distance(to: maze.hash(x: size - 1, y: size - 1))
print("Result1: \(result1)")

let result2 = Maze.findLast(Input.Input, size: size)
print("Result2: \(result2)")
