//
//  main.swift
//  Advent14
//
//  Created by Dragan Cecavac on 14.12.22.
//

import Foundation

let sandflow = Waterfall(Input.Input1)

sandflow.flow()
let result1 = sandflow.sandCount
print("Result1: \(result1)")


sandflow.support()
sandflow.flow()
let result2 = sandflow.sandCount
print("Result2: \(result2)")
