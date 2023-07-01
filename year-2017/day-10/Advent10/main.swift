//
//  main.swift
//  Advent10
//
//  Created by Dragan Cecavac on 10.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation


var crypto = Crypto(Input.Input1)
crypto.transform(start: 0, skipSize: 0)
let result1 = crypto.result
print("Result1: \(result1)")

var knotCypher = KnotCypher(Input.Input1)
let result2 = knotCypher.transform()
print("Result2: \(result2)")
