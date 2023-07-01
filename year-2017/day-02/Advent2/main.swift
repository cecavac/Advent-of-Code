//
//  main.swift
//  Advent2
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let checksummer = Checksummer(Input.Input1)

let result1 = checksummer.getChecksum()
print("Result1: \(result1)")

let result2 = checksummer.getDividibleChecksum()
print("Result2: \(result2)")
