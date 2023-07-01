//
//  main.swift
//  Advent15
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let recipe = Recipe(Input.Input1)

let result1 = recipe.bestScore()
print("Result1: \(result1)")

let result2 = recipe.bestScore(target: 500)
print("Result2: \(result2)")
