//
//  Link.swift
//  day-25
//
//  Created by Dragan Cecavac on 25.12.23.
//

import Foundation

class Link {
    static var id = 0
    var id: Int
    var wire1: String
    var wire2: String

    init(wire1: String, wire2: String) {
        self.id = Link.id
        Link.id += 1

        self.wire1 = wire1
        self.wire2 = wire2
    }
}
