//
//  main.swift
//  day-10
//
//  Created by Dragan Cecavac on 10.12.23.
//

import Foundation

let maze = Maze(Input.Input1)
let result1 = maze.mostDistant()
print("Result1: \(result1)")

maze.patchStart()
maze.identifyLoop(result1)
let result2 = maze.nest()
print("Result2: \(result2)")
