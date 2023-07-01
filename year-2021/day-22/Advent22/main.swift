//
//  main.swift
//  Advent22
//
//  Created by Dragan Cecavac on 22.12.21.
//

import Foundation

let reactor1 = Reactor(Input.Input)
let result1 = reactor1.run(coreRun: true)
print("Result1: \(result1.0)")

let reactor2 = Reactor(Input.Input)
let result2 = reactor2.run(coreRun: false)
print("Result2: \(result2.0)")
