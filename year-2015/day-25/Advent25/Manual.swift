//
//  Manual.swift
//  Advent25
//
//  Created by Dragan Cecavac on 12.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Manual {
    public static func getCode(row i: Int, column j: Int) -> Int {
        let diagonalCount = i + j - 1
        let topMostDiagonalElement = (2 + (diagonalCount - 1) * 1) * diagonalCount / 2
        let index = topMostDiagonalElement - (i - 1)

        var current = 20151125
        var past = current

        for _ in 1..<index {
            current = (past * 252533) % 33554393
            past = current
        }

        return current
    }
}
