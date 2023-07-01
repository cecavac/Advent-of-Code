//
//  main.swift
//  Advent7
//
//  Created by Dragan Cecavac on 15.01.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

let wireTracker = WireTracker(for: Inputs.Input1)
wireTracker.spin()
if let result1 = wireTracker.get(element: "a") {
    print("Result1: \(result1)")

    let wireTracker = WireTracker(for: Inputs.Input1, change: "b", with: result1)
    wireTracker.spin()
    if let result2 = wireTracker.get(element: "a") {
        print("Result2: \(result2)")
    }
}
