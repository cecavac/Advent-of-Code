//
//  Maze.swift
//  Advent17
//
//  Created by Dragan Cecavac on 28.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation
import CryptoKit

class Maze {
    struct Position {
        var i: Int
        var j: Int
    }

    var longestLength = 0
    var shortestLength = Int.max
    var shortestPath = ""
    let originalKey: String
    let bound = 4

    init(key: String) {
        originalKey = key
    }

    private static func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

    private func isOpen(_ character: Character) -> Bool {
        return  character == "b" ||
                character == "c" ||
                character == "d" ||
                character == "e" ||
                character == "f"
    }

    private func rush(key: String, location: Position) {
        if location.i == bound - 1 && location.j == bound - 1 {
            let length = key.count - originalKey.count

            if shortestLength > length {
                shortestLength = length
                shortestPath = String(key.suffix(shortestLength))
            }

            if longestLength < length {
                longestLength = length
            }

            return
        }

        let hash = Array(Maze.MD5(string: key))

        if isOpen(hash[0]) && location.i > 0 {
            let newKey = key + "U"
            var newLocation = location
            newLocation.i -= 1

            rush(key: newKey, location: newLocation)
        }

        if isOpen(hash[1]) && location.i < bound - 1 {
            let newKey = key + "D"
            var newLocation = location
            newLocation.i += 1

            rush(key: newKey, location: newLocation)
        }

        if isOpen(hash[2]) && location.j > 0 {
            let newKey = key + "L"
            var newLocation = location
            newLocation.j -= 1

            rush(key: newKey, location: newLocation)
        }

        if isOpen(hash[3]) && location.j < bound - 1 {
            let newKey = key + "R"
            var newLocation = location
            newLocation.j += 1

            rush(key: newKey, location: newLocation)
        }
    }

    func rush() -> (String, Int) {
        let start = Position(i: 0, j: 0)
        rush(key: originalKey, location: start)

        return (shortestPath, longestLength)
    }
}
