//
//  main.swift
//  Advent1
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let captcha = Captcha(Input.Input1)

let result1 = captcha.getNextSum(shiftHalf: false)
print("Result1: \(result1)")

let result2 = captcha.getNextSum(shiftHalf: true)
print("Result2: \(result2)")
