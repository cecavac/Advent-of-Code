//
//  main.swift
//  day-22
//
//  Created by Dragan Cecavac on 22.12.24.
//

import Foundation

let exchange = Exchange(Input.Input)

let result1 = exchange.collect()
print("Result1: \(result1)")

let result2 = exchange.bestPrice()
print("Result2: \(result2)")
