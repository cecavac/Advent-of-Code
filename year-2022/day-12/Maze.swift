//
//  Maze.swift
//  Advent12: Based on AoC 2016 Day13
//
//  Created by Dragan Cecavac on 27.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Maze {

    var fields = [String:Character]()
    var w = [String:Int]()
    var d = [String:Int]()

    var startHash = ""
    var endHash = ""
    var aHashes = [String]()
    let inverted: Bool

    func hash(_ x: Int, _ y: Int) -> String {
        return "\(x)#\(y)"
    }

    func hash(_ x: String, _ y: String) -> String {
        return "\(x)#\(y)"
    }

    init(_ input: String, inverted: Bool) {
        self.inverted = inverted
        let lines = input.split(separator: "\n")
        for i in lines.indices {
            let lineArray = Array(String(lines[i]))
            for j in lineArray.indices {
                fields[hash(i, j)] = lineArray[j]
                if lineArray[j] == "S" {
                    startHash = hash(i, j)
                } else if lineArray[j] == "E" {
                    endHash = hash(i, j)
                } else if lineArray[j] == "a" {
                    aHashes.append(hash(i, j))
                }
            }
        }

        initWeights(height: lines.count, width: lines[0].count)
        dijkstra()
    }

    private func calculateHeight(current: Character, next: Character) -> Int {
        var result: Int
        let actualCurrent: Character
        let actualNext: Character

        if inverted {
            actualCurrent = next
            actualNext = current
        } else {
            actualCurrent = current
            actualNext = next
        }

        if actualCurrent == "S" {
            result = Int(actualNext.asciiValue!) - Int(Character("a").asciiValue!)
        } else if actualNext == "E" {
            result = Int(Character("z").asciiValue!) - Int(actualCurrent.asciiValue!)
        } else if actualNext == "S" || actualCurrent == "E" {
            result = 1
        } else {
            result = Int(actualNext.asciiValue!) - Int(actualCurrent.asciiValue!)
        }

        if result <= 1 {
            return result
        } else {
            return Int.max
        }
    }

    private func initWeights(height: Int, width: Int) {
        for i in 0..<height {
            for j in 0..<width {
                let offsets = [
                    (0, 1),     // right
                    (0, -1),    // left
                    (1, 0),     // down
                    (-1, 0)     // up
                ]

                let fromHash = hash(i, j)
                if let currentVal = fields[fromHash] {
                    for offset in offsets {
                        let offsetI = i + offset.0
                        let offsetJ = j + offset.1
                        if offsetI >= 0 && offsetI < height && offsetJ >= 0 && offsetJ < width {
                            let toHash = hash(offsetI, offsetJ)
                            if let destinationVal = fields[toHash] {
                                let pathHash = hash(fromHash,toHash)
                                w[pathHash] = calculateHeight(current: currentVal, next: destinationVal)
                            }
                        }
                    }
                }
            }
        }
    }

    private func dijkstra() {
        if inverted {
            startHash = endHash
        }

        var s = Set<String>()
        s.insert(startHash)

        for (key, _) in fields {
            if key == startHash {
                continue
            }

            var distance: Int
            let pathHash = hash(startHash, key)

            if let heightChange = w[pathHash] {
                if heightChange <= 1 {
                    distance = 1
                } else {
                    distance = Int.max
                }
            } else {
                distance = Int.max
            }

            d[key] = distance
        }

        for (fromKey, _) in fields {
            if fromKey == startHash {
                continue
            }

            var minD = Int.max
            var selectedHash = ""

            for (toKey, value) in d {
                if !s.contains(toKey) {
                    if value < minD {
                        minD = value
                        selectedHash = toKey
                    }
                }
            }

            if minD == Int.max {
                break
            }

            s.insert(selectedHash)
            for (toKey, _) in fields {
                if !s.contains(toKey) {
                    let pathHash = hash(selectedHash, toKey)
                    if let distance = w[pathHash] {
                        if distance != Int.max && d[selectedHash]! + 1 < d[toKey]! {
                            d[toKey] = d[selectedHash]! + 1
                        }
                    }
                }
            }
        }
    }

    public func distanceToEnd() -> Int {
        return d[endHash]!
    }

    public func distanceToA() -> Int {
        return aHashes.map { d[$0]! }.min()!
    }
}
