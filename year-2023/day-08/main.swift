//
//  main.swift
//  day-08
//
//  Created by Dragan Cecavac on 08.12.23.
//

import Foundation

let wasteland = Wasteland(Input.Input1)

let result1 = wasteland.length(start: "AAA", targets: ["ZZZ"])
print("Result1: \(result1)")

let result2 = wasteland.ghostLength()
print("Result2: \(result2)")
