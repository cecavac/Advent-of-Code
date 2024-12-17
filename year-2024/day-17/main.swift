//
//  main.swift
//  day-17
//
//  Created by Dragan Cecavac on 17.12.24.
//

import Foundation
import Darwin

let computer = Computer(Input.Input)

let result1 = computer.fastRun()
print("Result1: \(result1)")

let result2 = computer.selfOutput()
print("Result2: \(result2)")
