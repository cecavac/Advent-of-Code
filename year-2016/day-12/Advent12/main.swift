//
//  main.swift
//  Advent12
//
//  Created by Dragan Cecavac on 26.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let computer1 = Computer(Input.Input1, registerC: 0)
let result1 = computer1.run()
print("Result1: \(result1)")

let computer2 = Computer(Input.Input1, registerC: 1)
let result2 = computer2.run()
print("Result2: \(result2)")
