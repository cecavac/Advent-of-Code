//
//  main.swift
//  Advent13
//
//  Created by Dragan Cecavac on 11.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let firewall = Firewall(Input.Input1)

let result1 = firewall.getSeverity()
print("Result1: \(result1)")

let result2 = Sneaker.findDelay(Input.Input1)
print("Result2: \(result2)")
