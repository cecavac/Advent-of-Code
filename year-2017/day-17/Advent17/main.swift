//
//  main.swift
//  Advent17
//
//  Created by Dragan Cecavac on 12.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let spinlock = Spinlock(offset: Input.Input1, cycles: 2017)
let result1 = spinlock.getElement(after: 2017)
print("Result1: \(result1)")

let fakeSpinlock = FakeSpinlock(offset: Input.Input1, cycles: 50 * 1000 * 1000)
let result2 = fakeSpinlock.result
print("Result2: \(result2)")
