//
//  main.swift
//  Advent09
//
//  Created by Dragan Cecavac on 09.12.21.
//

import Foundation

let lavaTubes = LavaTubes(Input.Input1)

let result1 = lavaTubes.getRisk()
print("Result1: \(result1)")

let result2 = lavaTubes.getBasins()
print("Result2: \(result2)")
