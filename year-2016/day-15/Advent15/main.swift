//
//  main.swift
//  Advent15
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let discMaster1 = DiscMaster(Input.Input1, include: nil)
let result1 = discMaster1.alignmentTime()
print("Result1: \(result1)")

let disc = Disc(position: 0, positions: 11)
let discMaster2 = DiscMaster(Input.Input1, include: disc)
let result2 = discMaster2.alignmentTime()
print("Result2: \(result2)")
