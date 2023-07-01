//
//  main.swift
//  Advent21
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let scrambler = Scrambler(do: Input.Input1, for: "abcdefgh")
let result1 = scrambler.result
print("Result1: \(result1)")

let unscrambler = Unscrambler(do: Input.Input1, for: "fbgdceah")
let result2 = unscrambler.result
print("Result2: \(result2)")
