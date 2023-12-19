//
//  Collection.swift
//  day-19
//
//  Created by Dragan Cecavac on 19.12.23.
//

import Foundation

struct Collection {
    var x = Interval()
    var m = Interval()
    var a = Interval()
    var s = Interval()

    func total() -> Int {
        return x.total() * m.total() * a.total() * s.total()
    }

    mutating func remove(section: (Int, Int), type: String) {
        switch type {
        case "x":
            x.remove(section: section)
        case "m":
            m.remove(section: section)
        case "a":
            a.remove(section: section)
        case "s":
            s.remove(section: section)
        default:
            fatalError("Unknown type")
        }

    }

}
