//
//  Grid.swift
//  Advent22
//
//  Created by Dragan Cecavac on 17.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Grid {
    var i: Int
    var j: Int
    var grid: [String:Character] = [:]
    var direction = Direction.Up
    var infectedCount = 0

    enum Direction {
        case Up
        case Down
        case Left
        case Right
    }

    public static func hash(i: Int, j: Int) -> String {
        return "\(i)#\(j)"
    }

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        i = lines.count / 2
        j = lines[0].count / 2

        for k in 0..<lines.count {
            let row = Array(lines[k])
            for l in 0..<row.count {
                let hash = Grid.hash(i: k, j: l)
                grid[hash] = row[l]
            }
        }
    }

    public func turn(left: Bool) {
        switch direction {
        case .Up:
            if left {
                direction = .Left
            } else {
                direction = .Right
            }
        case .Down:
            if left {
                direction = .Right
            } else {
                direction = .Left
            }
        case .Left:
            if left {
                direction = .Down
            } else {
                direction = .Up
            }
        case .Right:
            if left {
                direction = .Up
            } else {
                direction = .Down
            }
        }
    }

    public func move() {
        switch direction {
        case .Up:
            i -= 1
        case .Down:
            i += 1
        case .Left:
            j -= 1
        case .Right:
            j += 1
        }
    }

    public func run(for bursts: Int) -> Int {
        for _ in 0..<bursts {
            let hash = Grid.hash(i: i, j: j)

            if let element = grid[hash] {
                switch element {
                case ".":
                    grid[hash] = "#"
                    infectedCount += 1
                    turn(left: true)
                case "#":
                    grid[hash] = "."
                    turn(left: false)
                default:
                    print("Error gride element @ \(hash): \(element)")
                }
            } else {
                grid[hash] = "#"
                infectedCount += 1
                turn(left: true)
            }

            move()
        }

        return infectedCount
    }
}
