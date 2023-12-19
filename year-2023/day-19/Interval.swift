//
//  Interval.swift
//  day-19
//
//  Created by Dragan Cecavac on 19.12.23.
//

import Foundation

struct Interval {
    var values  = Set<Int>()

    init() {
        for i in 1...4000 {
            values.insert(i)
        }
    }

    func total() -> Int {
        values.count
    }

    mutating func remove(section: (Int, Int)) {
        for value in section.0...section.1 {
            values.remove(value)
        }
    }
}
