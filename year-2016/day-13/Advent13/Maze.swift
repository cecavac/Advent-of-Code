//
//  Maze.swift
//  Advent13
//
//  Created by Dragan Cecavac on 27.07.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Maze {
    static let n = 55

    var fields = Set<Int>()
    var w = Set<Int>()
    var d: [Int:Int] = [:]
    var t: [Int:Int] = [:]

    var x:Int

    func hash(x: Int, y: Int) -> Int {
        return x * 1000 + y
    }

    init(_ input: Int) {
        x = input

        for i in 0..<Maze.n {
            for j in 0..<Maze.n {
                var binaryOnes = 0
                var base = i*i + 3*i + 2*i*j + j + j*j
                base += x

                for _ in 0..<32 {
                    let lastBinaryDigit = base & 1
                    binaryOnes += lastBinaryDigit

                    base >>= 1
                }

                if binaryOnes % 2 == 0 {
                    fields.insert(hash(x: i, y: j))
                }
            }
        }

        initWeights()
        dijkstra()
    }

    private func initWeights() {
        for i in 0..<Maze.n {
            for j in 0..<Maze.n {
                let hash1 = hash(x: i, y: j)
                if fields.contains(hash1) {
                    if i > 0 {
                        let hash2 = hash(x: i - 1, y: j)
                        if fields.contains(hash2) {
                            let hash3 = hash1 * 1000000 + hash2
                            w.insert(hash3)
                        }
                    }

                    if i < Maze.n - 1 {
                        let hash2 = hash(x: i + 1, y: j)
                        if fields.contains(hash2) {
                            let hash3 = hash1 * 1000000 + hash2
                            w.insert(hash3)
                        }
                    }

                    if j > 0 {
                        let hash2 = hash(x: i, y: j - 1)
                        if fields.contains(hash2) {
                            let hash3 = hash1 * 1000000 + hash2
                            w.insert(hash3)
                        }
                    }

                    if j < Maze.n - 1 {
                        let hash2 = hash(x: i, y: j + 1)
                        if fields.contains(hash2) {
                            let hash3 = hash1 * 1000000 + hash2
                            w.insert(hash3)
                        }
                    }
                }
            }
        }
    }

    private func dijkstra() {
        let start_hash = hash(x: 1, y: 1)

        var s = Set<Int>()
        s.insert(start_hash)

        for field in fields {
            if field == start_hash {
                continue
            }

            var distance: Int
            let hash3 = start_hash * 1000000 + field

            if w.contains(hash3) {
                distance = 1
                t[field] = 1
            } else {
                distance = Int.max
                t[field] = 0
            }

            d[field] = distance
        }

        for field in fields {
            if field == start_hash {
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
            for field2 in fields {
                if !s.contains(field2) {
                    var distance = Int.max
                    let hash3 = minHash * 1000000 + field2

                    if w.contains(hash3) {
                        distance = 1

                        if d[minHash]! + distance < d[field2]! {
                            d[field2] = d[minHash]! + distance
                            t[field2] = minHash
                        }
                    }
                }
            }
        }
    }

    public func distance(to target_hash: Int) -> Int {
        return d[target_hash]!
    }

    public func pointsReachable(by distance: Int) -> Int {
        var result = 1

        for (_, value) in d {
            if value <= distance {
                result += 1
            }
        }

        return result
    }
}
