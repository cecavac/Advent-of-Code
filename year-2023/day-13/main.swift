//
//  main.swift
//  day-13
//
//  Created by Dragan Cecavac on 13.12.23.
//

import Foundation

let mirrorField = MirrorField(Input.Input1)

let result1 = mirrorField.reflections()
print("Result1: \(result1)")

let result2 = mirrorField.smudgeReflections()
print("Result2: \(result2)")
