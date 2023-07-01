//
//  Knot.swift
//  Advent09
//
//  Created by Dragan Cecavac on 09.12.22.
//

import Foundation

struct Knot {
    var i: Int
    var j: Int

    func hash() -> String {
        return "\(i)#\(j)"
    }
}
