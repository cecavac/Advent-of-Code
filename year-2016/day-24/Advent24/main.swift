//
//  main.swift
//  Advent24
//
//  Created by Dragan Cecavac on 01.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let maze = Maze(Input.Input1)

let result1 = maze.shortestDistance(returning: false)
print("Result1: \(result1)")

let result2 = maze.shortestDistance(returning: true)
print("Result2: \(result2)")
