//
//  Analytics.swift
//  day-24
//
//  Created by Dragan Cecavac on 24.12.23.
//

import Foundation

class Analytics {
    var hailstones = [Hailstone]()

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            hailstones.append(Hailstone(String(line)))
        }
    }

    func intersections(low: Int, high: Int) -> Int {
        var result = 0

        for i in 0...(hailstones.count - 1) {
            for j in (i + 1)..<hailstones.count {
                let (x, y) = hailstones[i].pathIntersects(with: hailstones[j], axis1: 0, axis2: 1)
                if Double(low) <= x && x <= Double(high) && Double(low) <= y && y <= Double(high) {
                    let time1 = hailstones[i].getTime(value: x, axis: 0)
                    let time2 = hailstones[j].getTime(value: x, axis: 0)
                    if time1 > 0 && time2 > 0 {
                        result += 1
                    }
                }
            }
        }

        return result
    }

    func getFactors(value: Int) -> Set<Int> {
        var factors = Set<Int>()

        if value == 1 {
            factors.insert(1)
            return factors
        }

        for i in 1..<1000 {
            if value % i == 0 {
                factors.insert(i)
            }
        }

        return factors
    }

    func determineVelocity(axis: Int) -> Int {
        var distances = [Int]()
        var relativeVelocity = [Int]()

        for i in 0..<(hailstones.count - 1) {
            for j in (i + 1)..<hailstones.count {
                if hailstones[i].velocity[axis] == hailstones[j].velocity[axis] {
                    let distance = abs(hailstones[i].position[axis] - hailstones[j].position[axis])
                    distances.append(distance)
                    relativeVelocity.append(hailstones[i].velocity[axis])
                }
            }
        }

        var velocityCandidates = [Set<Int>]()
        for i in distances.indices {
            let factors = getFactors(value: distances[i])
            var candidates = Set<Int>()
            for factor in factors {
                let candidate1 = relativeVelocity[i] - factor
                let candidate2 = relativeVelocity[i] + factor
                candidates.insert(candidate1)
                candidates.insert(candidate2)
            }
            velocityCandidates.append(candidates)
        }

        var velocity = velocityCandidates[0]
        for i in 1..<velocityCandidates.count {
            velocity = velocity.intersection(velocityCandidates[i])
        }

        return velocity.first!
    }

    func shoot() -> Int {
        var velocities = [Int]()
        for i in 0..<3 {
            velocities.append(determineVelocity(axis: i))
        }

        var startPositions: [Int?] = [nil, nil, nil]
        let referenceHailstone = hailstones[0]

        for hailstone in hailstones {
            for i in 0..<3 {
                if hailstone.velocity[i] == velocities[i] {
                    startPositions[i] = hailstone.position[i]
                }
            }
        }

        for i in 0..<3 {
            if startPositions[i] == nil {
                if startPositions[(i + 1) % 3] != nil {
                    let j = (i + 1) % 3

                    let time = (referenceHailstone.position[j] - startPositions[j]!) / (velocities[j] - referenceHailstone.velocity[j])
                    startPositions[i] = referenceHailstone.position[i] + time * referenceHailstone.velocity[i] - time * velocities[i]
                } else if startPositions[(i + 1) % 3] != nil {
                    let j = (i + 2) % 3

                    let time = (referenceHailstone.position[j] - startPositions[j]!) / (velocities[j] - referenceHailstone.velocity[j])
                    startPositions[i] = referenceHailstone.position[i] + time * referenceHailstone.velocity[i] - time * velocities[i]
                } else {
                    fatalError("Incompatible input")
                }
            }
        }

        return startPositions.map { $0! }.reduce(0, +)
    }
}
