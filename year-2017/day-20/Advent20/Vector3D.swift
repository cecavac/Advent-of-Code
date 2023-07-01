//
//  Vector3D.swift
//  Advent20
//
//  Created by Dragan Cecavac on 14.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

struct Vector3D {
    var x: Int
    var y: Int
    var z: Int

    static func +(vector1: Vector3D, vector2: Vector3D) -> Vector3D {
        let x = vector1.x + vector2.x
        let y = vector1.y + vector2.y
        let z = vector1.z + vector2.z

        return Vector3D(x: x, y: y, z: z)
    }

    var absoluteValue: Int {
        return abs(x) + abs(y) + abs(z)
    }
}
