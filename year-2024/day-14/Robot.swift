//
//  Robot.swift
//  day-14
//
//  Created by Dragan Cecavac on 14.12.24.
//

class Robot {
    var px: Int
    var py: Int
    let vx: Int
    let vy: Int

    let width: Int
    let height: Int

    init(_ data: String, width: Int, height: Int) {
        let adjustedString = data.replacingOccurrences(of: ",", with: " ")
            .replacingOccurrences(of: "=", with: " ")
        let elements = adjustedString.split(separator: " ")

        px = Int(String(elements[1]))!
        py = Int(String(elements[2]))!
        vx = Int(String(elements[4]))!
        vy = Int(String(elements[5]))!

        self.width = width
        self.height = height
    }

    func tick() {
        px += vx + width
        px %= width

        py += vy + height
        py %= height
    }

    func quadrant() -> Int {
        let middleX = width / 2
        let middleY = height / 2

        if py < middleY {
            if px < middleX {
                return 0
            } else if px > middleX {
                return 1
            }
        } else if py > middleY {
            if px < middleX {
                return 2
            } else if px > middleX {
                return 3
            }
        }

        return -1
    }
}
