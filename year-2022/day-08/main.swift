//
//  main.swift
//  Advent08
//
//  Created by Dragan Cecavac on 08.12.22.
//

import Foundation

let trees = Trees(Input.Input1)

let result1 = trees.visible()
print("Result1: \(result1)")

let result2 = trees.scores()
print("Result2: \(result2)")
