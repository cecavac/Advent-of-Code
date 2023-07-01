//
//  main.swift
//  Advent24
//
//  Created by Dragan Cecavac on 11.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let organizer = Organizer(Input.Input1)

let result1 = organizer.split(by: 3)
print("Result1: \(result1)")

let result2 = organizer.split(by: 4)
print("Result2: \(result2)")
