//
//  main.swift
//  Advent12
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let channel = Channel(Input.Input1)

let result1 = channel.getFirstGroupElements(removeElements: false)
print("Result1: \(result1)")

let result2 = channel.getGroupCount()
print("Result2: \(result2)")
