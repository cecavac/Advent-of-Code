//
//  main.swift
//  day-14
//
//  Created by Dragan Cecavac on 14.12.23.
//

import Foundation

let panel1 = RockPanel(Input.Input1)
let result1 = panel1.northLoad()
print("Result1: \(result1)")

let panel2 = RockPanel(Input.Input1)
let result2 = panel2.cycleLoad()
print("Result2: \(result2)")
