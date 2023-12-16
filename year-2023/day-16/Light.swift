//
//  Light.swift
//  day-16
//
//  Created by Dragan Cecavac on 16.12.23.
//

import Foundation

struct Light {
    var directions = Set<Direction>()

    mutating func energize(direction: Direction) {
        directions.insert(direction)
    }

    func energized() -> Bool {
        return directions.count > 0
    }
}
