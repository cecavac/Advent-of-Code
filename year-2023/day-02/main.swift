//
//  main.swift
//  day-02
//
//  Created by Dragan Cecavac on 02.12.23.
//

import Foundation

let cubeConundrum = CubeConundrum(Input.Input1)

let result1 = cubeConundrum.validate()
print("Result1: \(result1)")

let result2 = cubeConundrum.powerSum()
print("Result2: \(result2)")
