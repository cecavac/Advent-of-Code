//
//  Rope.swift
//  Advent09
//
//  Created by Dragan Cecavac on 09.12.22.
//

import Foundation

class Rope {
    var knots: [Knot]
    var positions = Set<String>()

    init(knotCount: Int) {
        knots = Array(repeating: Knot(i: 0, j: 0), count: knotCount)
        positions.insert(knots[0].hash())
    }

    func walk(_ input: String) -> Int {
        for line in input.split(separator: "\n") {
            let elements = line.split(separator: " ")
            let direction = String(elements[0])
            let steps = Int(String(elements[1]))!

            var offsetI = 0
            var offsetJ = 0

            if direction == "U" {
                offsetI = 1
            } else if direction == "D" {
                offsetI = -1
            } else if direction == "R" {
                offsetJ = 1
            } else if direction == "L" {
                offsetJ = -1
            } else {
                print("Unknown direction \(direction)")
                return -1
            }

            for _ in 0..<steps {
                knots[0].i += offsetI
                knots[0].j += offsetJ

                for i in 1..<knots.count{
                    knots[i] = moveTail(head: knots[i - 1 ], tail: knots[i])
                }
                positions.insert(knots[knots.count - 1].hash())
            }
        }

        return positions.count
    }

    func moveTail(head: Knot, tail: Knot) -> Knot {
        var newTail = tail
        let distanceI = abs(head.i - tail.i)
        let distanceJ = abs(head.j - tail.j)

        if (distanceI > 1 && distanceJ >= 1) || (distanceI >= 1 && distanceJ > 1) {
            newTail.i += (head.i - tail.i) / distanceI
            newTail.j += (head.j - tail.j) / distanceJ
        } else if distanceI > 1 {
            newTail.i += (head.i - tail.i) / distanceI
        } else if distanceJ > 1 {
            newTail.j += (head.j - tail.j) / distanceJ
        }

        return newTail
    }
}
