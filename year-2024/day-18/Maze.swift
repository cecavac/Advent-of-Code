//
//  Maze.swift
//  day-18
//
//  Based on: AoC 2016 Day 13
//  Created by Dragan Cecavac on 18.12.24.
//

import Foundation

class Maze {
    var map: [[Character]]
    let size: Int

    var fields = Set<Int>()
    var w = Set<Int>()
    var d: [Int:Int] = [:]
    var t: [Int:Int] = [:]

    func hash(x: Int, y: Int) -> Int {
        return x * 1000 + y
    }

    init(_ data: String, size: Int, steps: Int) {
        map  = Array(repeating: Array(repeating: ".", count: size), count: size)
        self.size = size

        let lines = data.split(separator: "\n")
        for step in 0..<steps {
            let elements = lines[step].split(separator: ",")
            let j = Int(String(elements[0]))!
            let i = Int(String(elements[1]))!
            map[i][j] = "#"
        }


        for i in 0..<size {
            for j in 0..<size {
                if map[i][j] == "." {
                    fields.insert(hash(x: i, y: j))
                }
            }
        }

        initWeights()
        dijkstra()
    }

    private func initWeights() {
        for i in 0..<size {
            for j in 0..<size {
                let hash1 = hash(x: i, y: j)
                if fields.contains(hash1) {
                    for delta in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                        let nextI = i + delta.0
                        let nextJ = j + delta.1
                        if nextI >= 0 && nextI < size && nextJ >= 0 && nextJ < size {
                            let hash2 = hash(x: nextI, y: nextJ)
                            if fields.contains(hash2) {
                                let hash3 = hash1 * 1000000 + hash2
                                w.insert(hash3)
                            }
                        }
                    }
                }
            }
        }
    }

    private func dijkstra() {
        let start_hash = hash(x: 0, y: 0)

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

    public static func findLast(_ data: String, size: Int) -> String {
        let lines = data.split(separator: "\n")
        var low = 0
        var high = lines.count

        while true {
            let mid = (low + high) / 2
            let maze = Maze(Input.Input, size: size, steps: mid)
            if maze.distance(to: maze.hash(x: size - 1, y: size - 1)) != Int.max {
                low = mid
            } else {
                high = mid
            }

            if low + 1 == high {
                return String(lines[low])
            }
        }
    }
}
