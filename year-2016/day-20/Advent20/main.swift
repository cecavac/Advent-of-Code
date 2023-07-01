//
//  main.swift
//  Advent20
//
//  Created by Dragan Cecavac on 30.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let dhcp = DHCP(Input.Input1)

let result1 = dhcp.firstNonblacklisted
print("Result1: \(result1)")

let result2 = dhcp.allowed
print("Result2: \(result2)")
