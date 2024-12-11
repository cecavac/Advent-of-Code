//
//  main.swift
//  day-11
//
//  Created by Dragan Cecavac on 11.12.24.
//

import Foundation

let plutoPebble = PlutoPebble(Input.Input)

plutoPebble.tick(count: 25)
print("Result1: \(plutoPebble.result)")

plutoPebble.tick(count: 50)
print("Result2: \(plutoPebble.result)")
