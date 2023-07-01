//
//  Router.swift
//  Advent19
//
//  Created by Dragan Cecavac on 13.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Router {
    var mash: [[Character]] = []
    var travelled = 0

    var direction = Direction.Down
    var i = 0
    var j = -1

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            var paddedLine = String(line)
            for _ in paddedLine.count..<200 {
                paddedLine += " "
            }

            mash.append(Array(paddedLine))
        }
    }

    private func move() {
        switch direction {
        case .Down:
            i += 1
        case .Up:
            i -= 1
        case .Left:
            j -= 1
        case .Right:
            j += 1
        }

        travelled += 1
    }

    private func onRoute(x: Int, y: Int) -> Bool {
        return mash[x][y] != " " && mash[x][y] != "+"
    }

    private func turn() {
        let originalDirection = direction

        switch direction {
        case .Down:
            fallthrough
        case .Up:
            if j > 0 && onRoute(x: i, y: j - 1) {
                direction = .Left
            } else if j < mash[0].count - 1 && onRoute(x: i, y: j + 1) {
                direction = .Right
            }
        case .Left:
            fallthrough
        case .Right:
            if i > 0 && onRoute(x: i - 1, y: j) {
                direction = .Up
            } else if i < mash.count - 1 && onRoute(x: i + 1, y: j) {
                direction = .Down
            }
        }

        if direction == originalDirection {
            print("Error, did not turn!")
        }
    }

    public func travel() -> String {
        var result = ""

        for k in 0..<mash[0].count {
            if mash[i][k] == "|" {
                j = k
                break
            }
        }

        while   i >= 0 && i < mash.count &&
                j >= 0 && j < mash[0].count &&
                mash[i][j] != " " {
            switch mash[i][j] {
            case "|":
                break
            case "-":
                break
            case "+":
                turn()
            default:
                result += String(mash[i][j])
            }

            move()
        }

        return result
    }
}
