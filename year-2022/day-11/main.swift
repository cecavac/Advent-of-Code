//
//  main.swift
//  Advent11
//
//  Created by Dragan Cecavac on 11.12.22.
//

import Foundation

let monkeyBusiness1 = MonkeyBusiness(Input.Input1)
let result1 = monkeyBusiness1.normalRun()
print("Result1: \(result1)")

let monkeyBusiness2 = MonkeyBusiness(Input.Input1)
let result2 = monkeyBusiness2.desperateRun()
print("Result2: \(result2)")
