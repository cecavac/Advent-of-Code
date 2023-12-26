//
//  Hailstone.swift
//  day-24
//
//  Created by Dragan Cecavac on 24.12.23.
//

import Foundation

class Hailstone {
    var position = [Int]()
    var velocity = [Int]()

    init(_ input: String) {
        let processedInput = input
            .replacingOccurrences(of: "@", with: "")
            .replacingOccurrences(of: ",", with: "")
        let elements = processedInput.split(separator: " ")
        for i in 0..<3 {
            position.append(Int(String(elements[i]))!)
        }
        for i in 3..<6 {
            velocity.append(Int(String(elements[i]))!)
        }
    }

    func pathIntersects(with other: Hailstone, axis1: Int, axis2: Int) -> (Double, Double) {
        let x1 = Double(position[axis1])
        let vx1 = Double(velocity[axis1])
        let y1 = Double(position[axis2])
        let vy1 = Double(velocity[axis2])

        let x2 = Double(other.position[axis1])
        let vx2 = Double(other.velocity[axis1])
        let y2 = Double(other.position[axis2])
        let vy2 = Double(other.velocity[axis2])

        let elementu1 = vx1 * vy2 * y1
        let elementu2 = vx2 * vy1 * y2
        let elementu3 = vy1 * vy2 * (x2 - x1)
        let elementd1 = vx1 * vy2 - (vx2 * vy1)

        let y = (elementu1 - elementu2 + elementu3) / elementd1
        let x = vx1 * (y - y1) / vy1 + x1
        return (x, y)
    }

    func getTime(value: Double, axis: Int) -> Double{
        return (value - Double(position[axis]))  / Double(velocity[axis])
    }
}
