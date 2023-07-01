//
//  Missile.swift
//  Advent17
//
//  Created by Dragan Cecavac on 17.12.21.
//

import Foundation

class Missile {
    var positionX = 0
    var positionY = 0
    var velocityX: Int
    var velocityY: Int
    var highestYReached = 0

    let targetX1: Int
    let targetX2: Int
    let targetY1: Int
    let targetY2: Int

    init(vx: Int, vy: Int, targetX1: Int, targetX2: Int, targetY1: Int, targetY2: Int) {
        velocityX = vx
        velocityY = vy
        self.targetX1 = targetX1
        self.targetX2 = targetX2
        self.targetY1 = targetY1
        self.targetY2 = targetY2
    }

    func tick() {
        positionX += velocityX
        positionY += velocityY

        if velocityX > 0 {
            velocityX -= 1
        } else if velocityX < 0 {
            velocityX += 1
        }

        velocityY -= 1

        highestYReached = max(highestYReached, positionY)
    }

    func isWithinTargetArea() -> Bool {
        return positionX >= targetX1 && positionX <= targetX2 && positionY >= targetY1 && positionY <= targetY2
    }

    func approaching() -> Bool {
        if positionX < targetX1 && velocityX <= 0 {
            return false
        }

        if positionX > targetX2 {
            return false
        }

        if positionY < targetY1 && velocityY < 0 {
            return false
        }

        return true
    }
}
