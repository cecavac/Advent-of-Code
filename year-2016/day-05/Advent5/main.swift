//
//  main.swift
//  Advent5
//
//  Created by Dragan Cecavac on 02.05.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

print("Cracking password 1 and password 2, please wait.")
let unlocker = Unlocker(Input.Input1)

let result1 = unlocker.result1
print("Result1: \(result1)")

let result2 = unlocker.result2
print("Result2: \(result2)")
