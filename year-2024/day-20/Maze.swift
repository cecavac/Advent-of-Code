//
//  Maze.swift
//  day-20
//
//  Based on: AoC 2024 Day 18
//  Created by Dragan Cecavac on 20.12.24.
//

import Foundation

class Maze {
    var map: [[Character]]
    let height: Int
    let width: Int

    var startI = -1
    var startJ = -1
    var endI = -1
    var endJ = -1

    var startHash = -1
    var endHash = -1

    var fields = Set<Int>()
    var w = Set<Int>()
    var d: [Int:Int] = [:]
    var t: [Int:Int] = [:]

    func hash(x: Int, y: Int) -> Int {
        return x * 1000 + y
    }

    init(_ data: String, inverted: Bool) {
        map = data.split(separator: "\n")
            .map { Array(String($0)) }
        height = map.count
        width = map[0].count

        for i in 0..<height {
            for j in 0..<width {
                if map[i][j] == "." || map[i][j] == "S" || map[i][j] == "E" {
                    fields.insert(hash(x: i, y: j))
                }
                if map[i][j] == "S" {
                    startI = i
                    startJ = j
                    startHash = hash(x: i, y: j)
                }
                if map[i][j] == "E" {
                    endI = i
                    endJ = j
                    endHash = hash(x: i, y: j)
                }
            }
        }

        if inverted {
            swapEnds()
        }
        initWeights()
        dijkstra()
    }

    func swapEnds() {
        let i = startI
        let j = startJ
        startI = endI
        startJ = endJ
        endI = i
        endJ = j
        startHash = hash(x: startI, y: startJ)
        endHash = hash(x: endI, y: endJ)
    }

    func initWeights() {
        for i in 0..<height {
            for j in 0..<width {
                let hash1 = hash(x: i, y: j)
                if fields.contains(hash1) {
                    for delta in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                        let nextI = i + delta.0
                        let nextJ = j + delta.1
                        if nextI >= 0 && nextI < height && nextJ >= 0 && nextJ < width {
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

    private func neigborFields(key: Int) -> [Int] {
        let i = key / 1000
        let j = key % 1000
        var candidates = [Int]()
        for delta in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
            let nextI = i + delta.0
            let nextJ = j + delta.1
            let hash2 = hash(x: nextI, y: nextJ)
            if fields.contains(hash2) {
                candidates.append(hash2)
            }
        }
        return candidates
    }

    func dijkstra() {
        var s = Set<Int>()
        var counterS = fields

        s.insert(startHash)
        counterS.remove(startHash)

        let n1 = neigborFields(key: startHash)
        for field in n1 {
            if field == startHash {
                continue
            }

            let hash3 = startHash * 1000000 + field
            if w.contains(hash3) {
                d[field] = 1
                t[field] = startHash
            }
        }

        while true {
            var minD = Int.max
            var minHash = Int.max

            for key in counterS {
                let value = d[key] ?? Int.max
                if value < minD {
                    minD = value
                    minHash = key
                }
            }

            if minD == Int.max {
                break
            }

            s.insert(minHash)
            counterS.remove(minHash)

            let n2 = neigborFields(key: minHash)
            for field2 in n2 {
                let distance = 1
                let distance2 = d[field2] ?? Int.max

                if d[minHash]! + distance < distance2 {
                    d[field2] = d[minHash]! + distance
                    t[field2] = minHash
                }

                if field2 == endHash {
                    // Early exit
                    return
                }
            }
        }
    }

    public func distance(to target_hash: Int) -> Int {
        return d[target_hash]!
    }

    static var cheatMap: [Int:Set<Int>] = [:]
    static func generateCheats(maze: Maze) {
        for i1 in 0..<maze.height {
            for j1 in 0..<maze.width {
                let hash1 = maze.hash(x: i1, y: j1)
                if maze.map[i1][j1] == "." || maze.map[i1][j1] == "S"  {
                    for i2 in (i1 - 20)...(i1 + 20) {
                        for j2 in (j1 - 20)...(j1 + 20) {
                            let dist = abs(i1 - i2) + abs(j1 - j2)
                            if i2 >= 0 && i2 < maze.height && j2 >= 0 && j2 < maze.width
                                && dist >= 2 && dist <= 20
                                && (maze.map[i2][j2] == "." || maze.map[i2][j2] == "E")  {
                                let hash2 = maze.hash(x: i2, y: j2)

                                if Maze.cheatMap[dist] == nil {
                                    Maze.cheatMap[dist] = Set<Int>()
                                }

                                Maze.cheatMap[dist]!.insert(hash1 * 1000000 + hash2)
                            }
                        }
                    }
                }
            }
        }
    }

    static func spinCheats(maze: Maze, counterMaze: Maze, range: ClosedRange<Int>) -> Int {
        var result = 0
        let distance = maze.distance(to: maze.hash(x: maze.endI, y: maze.endJ))

        for length in range {
            for cheat in cheatMap[length]! {
                let field0 = cheat / 1000000
                let field1 = cheat % 1000000

                var d1 = 0
                if field0 != maze.startHash {
                    d1 += maze.distance(to: field0)
                }
                var d2 = 0
                if field1 != counterMaze.startHash {
                    d2 += counterMaze.distance(to: field1)
                }
                let newDistance = d1 + d2 + length

                if distance - newDistance >= 100 {
                    result += 1
                }
            }
        }

        return result
    }
}
