//
//  Cube.swift
//  Advent18
//
//  Created by Dragan Cecavac on 18.12.22.
//

import Foundation

struct Cube: Hashable, Equatable {
    let x: Int
    let y: Int
    let z: Int

    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }

    init(_ input: String) {
        let elements = input.split(separator: ",")
        x = Int(String(elements[0]))!
        y = Int(String(elements[1]))!
        z = Int(String(elements[2]))!
    }

    func isAdjacent(to other: Cube) -> Bool {
        return (abs(x - other.x) == 1 && abs(y - other.y) == 0 && abs(z - other.z) == 0) ||
                (abs(x - other.x) == 0 && abs(y - other.y) == 1 && abs(z - other.z) == 0) ||
                (abs(x - other.x) == 0 && abs(y - other.y) == 0 && abs(z - other.z) == 1)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }

    static func ==(lhs: Cube, rhs: Cube) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}
