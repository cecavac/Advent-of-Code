//
//  main.swift
//  Advent16
//
//  Created by Dragan Cecavac on 16.12.21.
//

import Foundation

let packetParser = PacketParser(Input.Input1)
let result1 = packetParser.versionSum
print("Result1: \(result1)")

let result2 = packetParser.value
print("Result2: \(result2)")
