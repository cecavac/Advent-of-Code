//
//  main.swift
//  day-06
//
//  Created by Dragan Cecavac on 06.12.23.
//

import Foundation

let boatRace = BoatRace(Input.Input1)

let result1 = boatRace.individualWins()
print("Result1: \(result1)")

let result2 = boatRace.combinedWins()
print("Result2: \(result2)")
