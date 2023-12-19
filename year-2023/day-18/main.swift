//
//  main.swift
//  day-18
//
//  Created by Dragan Cecavac on 18.12.23.
//

import Foundation

let barber1 = Barber(Input.Input1, alternative: false)
let result1 = barber1.trim()
print("Result1: \(result1)")


let barber2 = Barber(Input.Input1, alternative: true)
let result2 = barber2.trim()
print("Result2: \(result2)")
