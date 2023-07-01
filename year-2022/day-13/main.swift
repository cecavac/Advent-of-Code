//
//  main.swift
//  Advent13
//
//  Created by Dragan Cecavac on 13.12.22.
//

import Foundation

let packets = Packets(Input.Input1)

let result1 = packets.compare()
print("Result1: \(result1)")

let result2 = packets.sort()
print("Result2: \(result2)")
