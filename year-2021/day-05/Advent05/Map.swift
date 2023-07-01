//
//  Map.swift
//  Advent05
//
//  Created by Dragan Cecavac on 05.12.21.
//

import Foundation

class Map {
    var map = [String:Int]()

    init(_ input: String, withDiagonals : Bool) {
        let lines = input.split(separator: "\n")
        for line in lines {
            let components = line.split(separator: " ")
            let leftPoint = components[0].split(separator: ",")
            let rightPoint = components[2].split(separator: ",")
            let leftX = Int(String(leftPoint[0]))!
            let leftY = Int(String(leftPoint[1]))!
            let rightX = Int(String(rightPoint[0]))!
            let rightY = Int(String(rightPoint[1]))!

            if leftX == rightX || leftY == rightY {
                for i in min(leftX, rightX)...max(leftX, rightX) {
                    for j in min(leftY, rightY)...max(leftY, rightY) {
                        let hash = "\(i)#\(j)"
                        if let value = map[hash] {
                            map[hash] = value + 1
                        } else {
                            map[hash] = 1
                        }
                    }
                }
            } else if withDiagonals {
                var directionX: Int
                if rightX < leftX {
                    directionX = 1
                } else {
                    directionX = -1
                }

                var directionY: Int
                if rightY < leftY {
                    directionY = 1
                } else {
                    directionY = -1
                }

                let length = abs(leftX - rightX)
                for n in 0...length {
                    let x = rightX + (directionX * n)
                    let y = rightY + (directionY * n)

                    let hash = "\(x)#\(y)"
                    if let value = map[hash] {
                        map[hash] = value + 1
                    } else {
                        map[hash] = 1
                    }
                }
            }
        }
    }

    func getOverlaps() -> Int {
        return map.filter({ $0.value > 1 }).count
    }
}
