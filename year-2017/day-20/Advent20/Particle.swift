//
//  Particle.swift
//  Advent20
//
//  Created by Dragan Cecavac on 14.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Particle {
    var position: Vector3D
    var velocity: Vector3D
    var acceleration: Vector3D

    init(position p: Vector3D, velocity v: Vector3D, acceleration a: Vector3D) {
        position = p
        velocity = v
        acceleration = a
    }

    var totalAcceleration: Int {
        return acceleration.absoluteValue
    }

    private static func getIntersections(p0_1: Int, v0_1: Int, a_1: Int,
                                   p0_2: Int, v0_2: Int, a_2: Int) -> [Int] {
        var results: [Int] = []

        // Physics claims:
        // x(t) == x0 + v0 * t + (1/2) * a * t^2
        //
        // Find the common t for 2 x points:
        // x1(t) = x2(t)
        // x0_1 + v0_1 * t + (1/2) * a_1 * t^2 = x0_2 + v0_1 * t + (1/2) * a_2 * t^2
        // Get it to square equation form: A * X^2 + B * X + C = 0
        // t^2 * (a_1 - a2) / 2 + t * (v0_1 - v0_2) + x0_1 - x0_2
        // A = (a_1 - a2) / 2
        // B = v0_1 - v0_2
        // C = x0_1 - x0_2
        // And solve it like a typical square equation

        let A = Float(a_1 - a_2) / 2
        let B = Float(v0_1 - v0_2)
        let C = Float(p0_1 - p0_2)

        if A == 0 && B == 0 {
            // use -1 as universal "colliding all the time"
            results.append(-1)

            return results
        }

        if A == 0 {
            // B * t + C = 0
            // t = -C / B
            let result0 = -C / B

            // Ignore the results in the past and non whole value results
            if result0 >= 0 && Float(Int(result0)) == result0 {
                results.append(Int(result0))
            }

            return results
        }

        let squaredComponent = B * B - 4 * A * C
        if squaredComponent < 0 {
            // Complex results == no intersections
            return results
        }

        let rootedComponent = squaredComponent.squareRoot()

        let result1 = (-B - rootedComponent) / (2 * A)

        // Ignore the results in the past and non whole value results
        if result1 >= 0 && Float(Int(result1)) == result1 {
            results.append(Int(result1))
        }

        let result2 = (-B + rootedComponent) / (2 * A)
        // Ignore the results in the past  and non whole value results
        if result2 >= 0 && Float(Int(result2)) == result2 {
            results.append(Int(result2))
        }

        return results
    }

    public func failingIsColliding(particle: Particle) -> Bool {
        let resultsX = Particle.getIntersections(p0_1: position.x, v0_1: velocity.x, a_1: acceleration.x, p0_2: particle.position.x, v0_2: particle.velocity.x, a_2: particle.acceleration.x)
        let resultsY = Particle.getIntersections(p0_1: position.y, v0_1: velocity.y, a_1: acceleration.y, p0_2: particle.position.y, v0_2: particle.velocity.y, a_2: particle.acceleration.y)
        let resultsZ = Particle.getIntersections(p0_1: position.z, v0_1: velocity.z, a_1: acceleration.z, p0_2: particle.position.z, v0_2: particle.velocity.z, a_2: particle.acceleration.z)

        for resultX in resultsX {
            for resultY in resultsY {
                for resultZ in resultsZ {
                    if resultX == -1 && resultY == resultZ {
                        return true
                    }

                    if resultY == -1 && resultX == resultZ {
                        return true
                    }

                    if resultZ == -1 && resultX == resultY {
                        return true
                    }

                    if resultX == -1 && resultY == -1 {
                        return true
                    }

                    if resultX == -1 && resultZ == -1 {
                        return true
                    }

                    if resultY == -1 && resultZ == -1 {
                        return true
                    }

                    if resultX == resultY &&
                        resultX == resultZ {
                        return true
                    }
                }
            }
        }

        return false
    }

    public func isColliding(particle: Particle) -> Bool {
        return position.x == particle.position.x &&
                position.y == particle.position.y &&
                position.z == particle.position.z
    }

    public func tick() {
        velocity = velocity + acceleration
        position = position + velocity
    }
}
