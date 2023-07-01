//
//  Calibrator.swift
//  Advent25
//
//  Created by Dragan Cecavac on 03.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Calibrator {
    private static func run(baseA: Int) -> Bool {
        var b: Int
        let d = baseA + 9 * 282
        var a = d

        for i in 0..<100 {
            b = a % 2
            a = a / 2

            if b != i % 2 {
                return false
            }

            if a == 0 {
                a = d
            }
        }

        return true
    }

    public static func run() -> Int {
        for i in 0..<Int.max {
            if run(baseA: i) {
                return i
            }
        }

        return -1
    }
}
