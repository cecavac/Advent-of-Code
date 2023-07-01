//
//  main.swift
//  Advent18
//
//  Created by Dragan Cecavac on 12.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let musicBox = MusicBox(Input.Input1)
musicBox.play()
let result1 = musicBox.result
print("Result1: \(result1)")

let result2 = Orchestrator.run(Input.Input1)
print("Result2: \(result2)")
