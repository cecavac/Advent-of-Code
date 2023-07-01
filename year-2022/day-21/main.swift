//
//  main.swift
//  Advent21
//
//  Created by Dragan Cecavac on 21.12.22.
//

import Foundation

let monkeys1 = Monkeys(Input.Input1)
let result1 = monkeys1.getRoot()
print("Result1: \(result1)")

let monkeys2 = Monkeys(Input.Input1)
let result2 = monkeys2.getHumn()!
print("Result2: \(result2)")
