//
//  main.swift
//  Advent16
//
//  Created by Dragan Cecavac on 28.03.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let investigator = Investigator(mfcsam: Input.Data, memoryData: Input.Input1)

let result1 = investigator.findFitting()
print("Result1: \(result1!)")

let result2 = investigator.findRealFitting()
print("Result2: \(result2!)")
