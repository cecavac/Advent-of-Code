//
//  main.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.23.
//

import Foundation

let poker1 = Poker(Input.Input1, jIsJoker: false)
let result1 = poker1.score()
print("Result1: \(result1)")

let poker2 = Poker(Input.Input1, jIsJoker: true)
let result2 = poker2.score()
print("Result2: \(result2)")
