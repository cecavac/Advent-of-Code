//
//  main.swift
//  Advent11
//
//  Created by Dragan Cecavac on 24.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let password = Password(Input.Input1)
let result1 = password.nextPassword()
print("Result1: \(result1)")
let result2 = password.nextPassword()
print("Result2: \(result2)")
