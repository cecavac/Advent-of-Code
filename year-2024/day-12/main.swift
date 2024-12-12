//
//  main.swift
//  day-12
//
//  Created by Dragan Cecavac on 12.12.24.
//

import Foundation

let example1 = Field(Input.Example1)
let example2 = Field(Input.Example2)
let example3 = Field(Input.Example3)
let example4 = Field(Input.Example4)
let example5 = Field(Input.Example5)

print(example1.result2 == 80)
print(example2.result2 == 436)
print(example3.result2 == 1206)
print(example4.result2 == 236)
print(example5.result2 == 368)

let field = Field(Input.Input)
print("Result1: \(field.result1)")
print("Result2: \(field.result2)")
