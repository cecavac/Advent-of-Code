//
//  Launcher.swift
//  Advent17
//
//  Created by Dragan Cecavac on 17.12.21.
//

import Foundation

class Launcher {
    let x1: Int
    let x2: Int
    let y1: Int
    let y2: Int
    var possibilities = 0

    init(_ input: String) {
        let elements1 = input.split(separator: " ")
        let elements21 = elements1[2].split(separator: ",")
        let elements31 = elements21[0].split(separator: "=")
        let elements41 = elements31[1].split(separator: ".")
        x1 = Int(String(elements41[0]))!
        x2 = Int(String(elements41[1]))!

        let elements22 = elements1[3].split(separator: "=")
        let elements32 = elements22[1].split(separator: ".")
        y1  = Int(String(elements32[0]))!
        y2  = Int(String(elements32[1]))!
    }

    func getLowestVX() -> Int? {
        for i in 0..<x1 {
            let distance = (1 + i) * i / 2
            if distance >= x1 {
                return i
            }
        }

        return nil
    }

    func launch() -> Int {
        let lowestVX = getLowestVX()!
        let highestVX = x2
        var highestYReached = 0

        for startVX in lowestVX...highestVX {
            for startVY in y1...highestVX {
                let missile = Missile(vx: startVX, vy: startVY, targetX1: x1, targetX2: x2, targetY1: y1, targetY2: y2)

                while missile.approaching() {
                    missile.tick()
                    if missile.isWithinTargetArea() {
                        highestYReached = max(highestYReached, missile.highestYReached)
                        possibilities += 1
                        break
                    }
                }
            }
        }

        return highestYReached
    }
}
