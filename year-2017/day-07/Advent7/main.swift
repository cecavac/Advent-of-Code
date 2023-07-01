//
//  main.swift
//  Advent7
//
//  Created by Dragan Cecavac on 07.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let tree = Tree(Input.Input1)

let result1 = tree.findRoot().name
print("Result1: \(result1)")

let result2 = tree.findProperWeight()
print("Result2: \(result2)")
