//
//  Line.swift
//  day-18
//
//  Created by Dragan Cecavac on 18.12.23.
//

import Foundation

struct Line: Equatable {
    let start: Point
    let end: Point
    let direction: Character

    var length: Int {
        switch direction {
        case "U":
            return abs(start.i - end.i) + 1
        case "L":
            return abs(start.j - end.j) + 1
        case "D":
            return abs(end.i - start.i) + 1
        case "R":
            return abs(end.j - start.j) + 1
        default:
            fatalError("Unknown direction")
        }
    }
}
