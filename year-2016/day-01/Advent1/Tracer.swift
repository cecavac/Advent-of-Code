//
//  Tracer.swift
//  Advent1
//
//  Created by Dragan Cecavac on 26.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Tracer {
    var i = 0
    var j = 0

    private var locationHash: String {
        return "\(i)_\(j)";
    }

    enum Direction {
        case Up, Down, Left, Right
    }

    var direction = Direction.Up
    var visited = Set<String>()

    private func move(command cmd: String, value val: Int) {
        switch cmd {
        case " R":
            switch direction {
            case .Up:
                direction = .Right
            case .Down:
                direction = .Left
            case .Left:
                direction = .Up
            case .Right:
                direction = .Down
            }
        case " L":
            switch direction {
            case .Up:
                direction = .Left
            case .Down:
                direction = .Right
            case .Left:
                direction = .Down
            case .Right:
                direction = .Up
            }
        default:
            print("Error cmd \(cmd)")
        }

        for _ in 0..<val {
            switch direction {
            case .Up:
                j += 1
            case .Down:
                j -= 1
            case .Left:
                i -= 1
            case .Right:
                i += 1
            }

            if (result2 == Int.max && visited.contains(locationHash)) {
                result2 = result1
            }

            visited.insert(locationHash)
        }
    }

    init(_ input: String) {
        visited.insert(locationHash)

        let expandedInput = " " + input
        let elements = expandedInput.split(separator: ",")
        for element in elements {
            let commandString = String(element.prefix(2))
            let splitIndex = element.index(element.startIndex, offsetBy: 2)
            let valueString = element.suffix(from: splitIndex)
            let value = Int(valueString)!
            move(command: commandString, value: value)
        }
    }

    public var result1: Int {
        get {
            return abs(i) + abs(j)
        }
    }

    private(set) var result2 = Int.max
}
