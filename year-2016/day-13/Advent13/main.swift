//
//  main.swift
//  Advent13
//
//  Created by Dragan Cecavac on 27.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let maze = Maze(Input.Input1)

let result1 = maze.distance(to: maze.hash(x: 31, y: 39))
print("Result1: \(result1)")

let result2 = maze.pointsReachable(by: 50)
print("Result2: \(result2)")
