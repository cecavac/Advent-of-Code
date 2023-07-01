//
//  ImprovedGrid.swift
//  Advent22
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class ImprovedGrid : Grid {
    override init(_ input: String) {
        super.init(input)
    }

    public func reverse() {
        switch direction {
        case .Up:
            direction = .Down
        case .Down:
            direction = .Up
        case .Left:
            direction = .Right
        case .Right:
            direction = .Left
        }
    }

    override public func run(for bursts: Int) -> Int {
        for _ in 0..<bursts {
            let hash = Grid.hash(i: i, j: j)

            if let element = grid[hash] {
                switch element {
                case ".":
                    grid[hash] = "W"
                    turn(left: true)
                case "W":
                    grid[hash] = "#"
                    infectedCount += 1
                case "#":
                    grid[hash] = "F"
                    turn(left: false)
                case "F":
                    grid[hash] = "."
                    reverse()
                default:
                    print("Error gride element @ \(hash): \(element)")
                }
            } else {
                grid[hash] = "W"
                turn(left: true)
            }

            move()
        }

        return infectedCount
    }
}
