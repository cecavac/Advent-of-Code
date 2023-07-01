//
//  main.swift
//  Advent17
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let maze = Maze(key: Input.Input1)
let result = maze.rush()
print("Result1: \(result.0)")
print("Result2: \(result.1)")
