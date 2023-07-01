//
//  main.swift
//  Advent20
//
//  Created by Dragan Cecavac on 08.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let result1 = Neighbourhood.lowestHouse(with: Input.Input1)
print("Result1: \(result1)")

let result2 = Neighbourhood.lowestHouseLimited(with: Input.Input1)
print("Result2: \(result2)")
