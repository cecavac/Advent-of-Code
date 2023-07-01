//
//  Maze.swift
//  Advent13
//
//  Created by Dragan Cecavac on 27.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Maze {
    var height: Int
    var width: Int

    var pointZero: Int = 0
    var keyPoints = Set<Int>()
    var keyPointDistance: [Int:Int] = [:]
    var fields: [Int:Int] = [:]
    var w = Set<Int>()
    var d: [Int:Int] = [:]
    var t: [Int:Int] = [:]

    var shortestPath = Int.max

    func hash(x: Int, y: Int) -> Int {
        return x * 1000 + y
    }

    init(_ input: String) {
        var i = 0

        let lines = input.split(separator: "\n")

        height = lines.count
        width = lines[0].count

        for line in lines {
            var j = -1

            for char in line {
                j += 1

                switch char {
                case "#":
                    continue
                case ".":
                    fields[hash(x: i, y: j)] = -1
                default:
                    fields[hash(x: i, y: j)] = Int(String(char))!
                }
            }

            i += 1
        }

        initWeights()
        initKeyPointDistance()
    }

    private func initWeights() {
        for i in 0..<height {
            for j in 0..<width {
                let hash1 = hash(x: i, y: j)
                if fields[hash1] != nil {
                    if i > 0 {
                        let hash2 = hash(x: i - 1, y: j)
                        if fields[hash2] != nil {
                            let hash3 = hash1 * 1000000 + hash2
                            w.insert(hash3)
                        }
                    }

                    if i < height - 1 {
                        let hash2 = hash(x: i + 1, y: j)
                        if fields[hash2] != nil {
                            let hash3 = hash1 * 1000000 + hash2
                            w.insert(hash3)
                        }
                    }

                    if j > 0 {
                        let hash2 = hash(x: i, y: j - 1)
                        if fields[hash2] != nil {
                            let hash3 = hash1 * 1000000 + hash2
                            w.insert(hash3)
                        }
                    }

                    if j < width - 1 {
                        let hash2 = hash(x: i, y: j + 1)
                        if fields[hash2] != nil {
                            let hash3 = hash1 * 1000000 + hash2
                            w.insert(hash3)
                        }
                    }
                }
            }
        }
    }

    private func initKeyPointDistance() {
        for i in 0..<height {
            for j in 0..<width {
                if let field = fields[hash(x: i, y: j)] {
                    if field >= 0 {
                        keyPoints.insert(hash(x: i, y: j))

                        if field == 0 {
                            pointZero = hash(x: i, y: j)
                        }
                    }
                }
            }
        }

        for field in keyPoints {
            dijkstra(start: field)

            for field2 in keyPoints {
                if field != field2 {
                    let hash = field * 1000 + field2
                    keyPointDistance[hash] = d[field2]
                }
            }
        }
    }

    private func dijkstra(start startHash:Int) {
        var s = Set<Int>()
        s.insert(startHash)

        d = [:]
        t = [:]

        for (key, _) in fields {
            if key == startHash {
                continue
            }

            var distance: Int
            let hash3 = startHash * 1000000 + key

            if w.contains(hash3) {
                distance = 1
                t[key] = 1
            } else {
                distance = Int.max
                t[key] = 0
            }

            d[key] = distance
        }

        for (key, _) in fields {
            if key == startHash {
                continue
            }

            var minD = Int.max
            var minHash = Int.max

            for (key, value) in d {
                if !s.contains(key) {
                    if value < minD {
                        minD = value
                        minHash = key
                    }
                }
            }

            if minD == Int.max {
                break
            }

            s.insert(minHash)
            for (key2, _) in fields {
                if !s.contains(key2) {
                    var distance = Int.max
                    let hash3 = minHash * 1000000 + key2

                    if w.contains(hash3) {
                        distance = 1

                        if d[minHash]! + distance < d[key2]! {
                            d[key2] = d[minHash]! + distance
                            t[key2] = minHash
                        }
                    }
                }
            }
        }
    }

    private func shortestDistance(start: Int, visited: Set<Int>, returning: Bool) -> Int {
        var best = Int.max

        if visited.count == keyPoints.count {
            if returning {
                let hash = start * 1000 + pointZero
                return keyPointDistance[hash]!
            } else {
                return 0
            }
        }

        for field in keyPoints {
            if !visited.contains(field) {
                var localVisited = visited
                localVisited.insert(field)

                let distanceHash = start * 1000 + field
                let distance = shortestDistance(start: field, visited: localVisited, returning: returning) + keyPointDistance[distanceHash]!

                best = min(best, distance)
            }
        }

        return best
    }

    public func shortestDistance(returning: Bool) -> Int {
        var visited = Set<Int>()

        visited.insert(pointZero)
        return shortestDistance(start: pointZero, visited: visited, returning: returning)
    }
}
