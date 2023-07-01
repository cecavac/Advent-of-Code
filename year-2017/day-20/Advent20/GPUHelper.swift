//
//  GPUHelper.swift
//  Advent20
//
//  Created by Dragan Cecavac on 14.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class GPUHelper {
    var particles: [Particle] = []

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var parsableLine = ""

            for char in line {
                if char == "<" || char == ">" || char == "," {
                    parsableLine += " "
                } else {
                    parsableLine += String(char)
                }
            }

            let elements = parsableLine.split(separator: " ")
            let p = Vector3D(x: Int(elements[1])!, y: Int(elements[2])!, z: Int(elements[3])!)
            let v = Vector3D(x: Int(elements[5])!, y: Int(elements[6])!, z: Int(elements[7])!)
            let a = Vector3D(x: Int(elements[9])!, y: Int(elements[10])!, z: Int(elements[11])!)

            particles.append(Particle(position: p, velocity: v, acceleration: a))
        }
    }

    public var lowestAcceleration: Int {
        var result = Int.max

        for particle in particles {
            result = min(result, particle.totalAcceleration)
        }

        return result
    }

    public var foreverClosest: Int {
        let targetAcceleration = lowestAcceleration

        for i in 0..<particles.count {
            if particles[i].totalAcceleration == targetAcceleration {
                /*
                 * There's only one particle with the minimal acceleration,
                 * otherwise, from those sharing this value, we would have to select
                 * the one with th lowest velocity.
                 */
                return i
            }
        }

        return -1
    }

    public var failingNonCollidingCount: Int {
        var colliding = Set<Int>()

        for i in 0..<particles.count {
            for j in i + 1..<particles.count {
                if colliding.contains(i) || colliding.contains(j) {
                    continue
                } else {
                    if particles[i].isColliding(particle: particles[j]) {
                        colliding.insert(i)
                        colliding.insert(j)
                    }
                }
            }
        }

        return particles.count - colliding.count
    }

    public var nonCollidingCount: Int {
        for _ in 0..<100 {
            var toBeRemovedSet = Set<Int>()
            var toBeRemoved = Array<Int>()

            for i in 0..<particles.count {
                for j in i + 1..<particles.count {
                    if particles[i].isColliding(particle: particles[j]) {
                        if !toBeRemovedSet.contains(i) {
                            toBeRemovedSet.insert(i)
                            toBeRemoved.append(i)
                        }
                        if !toBeRemovedSet.contains(j) {
                            toBeRemovedSet.insert(j)
                            toBeRemoved.append(j)
                        }
                    }
                }
            }

            for removeIndex in toBeRemoved.sorted().reversed() {
                particles.remove(at: removeIndex)
            }

            for i in 0..<particles.count {
                particles[i].tick()
            }
        }

        return particles.count
    }
}
