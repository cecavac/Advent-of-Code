//
//  main.swift
//  day-20
//
//  Created by Dragan Cecavac on 20.12.24.
//

import Foundation

let maze = Maze(Input.Input, inverted: false)
let counterMaze = Maze(Input.Input, inverted: true)
Maze.generateCheats(maze: maze)

let result1 = Maze.spinCheats(maze: maze, counterMaze: counterMaze, range: 2...2)
print("Result1: \(result1)")

let result2 = Maze.spinCheats(maze: maze, counterMaze: counterMaze, range: 2...20)
print("Result2: \(result2)")
