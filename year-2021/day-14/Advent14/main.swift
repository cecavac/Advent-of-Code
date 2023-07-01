//
//  main.swift
//  Advent14
//
//  Created by Dragan Cecavac on 14.12.21.
//

import Foundation

let polymerization = Polymerization(Input.Input1)
polymerization.train()

let result1 = polymerization.smartTick(count: 10)
print("Result1: \(result1)")

let result2 = polymerization.smartTick(count: 40)
print("Result1: \(result2)")
