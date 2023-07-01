//
//  main.swift
//  Advent5
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let jumper1 = Jumper(Input.Input1)
let result1 = jumper1.run()
print("Result1: \(result1)")

let jumper2 = Jumper(Input.Input1)
let result2 = jumper2.weirdRun()
print("Result2: \(result2)")
