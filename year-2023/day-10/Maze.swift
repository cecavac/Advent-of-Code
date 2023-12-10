//
//  Maze.swift
//  AoC 2023 Day 10: Based on AoC 2022 Day 12
//
//  Created by Dragan Cecavac on 10.12.23
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Maze {

    var matrix = [[Character]]()
    var loopFields = Set<Point>()
    var weight = [Path:Int]()
    var distance = [Point:Int]()
    var trajectory = [Point:Point]()

    var startI = 0
    var startJ = 0
    var height = 0
    var width = 0

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for i in lines.indices {
            let lineArray = Array(String(lines[i]))
            for j in lineArray.indices {
                if lineArray[j] == "S" {
                    startI = i
                    startJ = j
                }
            }
            matrix.append(lineArray)
        }

        height = lines.count
        width = lines[0].count

        initWeights()
        dijkstra()
    }

    private func initWeights() {
        let offsets = [
            (0, 1, ["-", "7", "J"]),     // right
            (0, -1, ["-", "F", "L"]),    // left
            (1, 0, ["|", "J", "L"]),     // down
            (-1, 0, ["|", "F", "7"])     // up
        ]

        for i in 0..<height {
            for j in 0..<width {
                let from = Point(i: i, j: j)
                for offset in offsets {
                    let offsetI = i + offset.0
                    let offsetJ = j + offset.1
                    if offsetI >= 0 && offsetI < height && offsetJ >= 0 && offsetJ < width {
                        let to = Point(i: offsetI, j: offsetJ)
                        let destinationVal = matrix[offsetI][offsetJ]
                        if offset.2.contains("\(destinationVal)") {
                            let path = Path(from: from, to: to)
                            weight[path] = 1
                        }
                    }
                }
            }
        }
    }

    private func dijkstra() {
        var all = Set<Point>()
        for i in 0..<height {
            for j in 0..<width {
                if matrix[i][j] != "." {
                    all.insert(Point(i: i, j: j))
                }
            }
        }

        let start = Point(i: startI, j: startJ)
        var collected = Set<Point>([start])
        var remaining = all.subtracting(collected)

        for key in remaining {
            let path = Path(from: start, to: key)
            if let value = weight[path] {
                distance[key] = value
                trajectory[key] = start
            } else {
                distance[key] = Int.max
            }
        }

        while true {
            let (selectedPoint, minDistance) = remaining.map { ($0, distance[$0]) }
                .sorted { $0.1! < $1.1! }
                .first!
            if minDistance == Int.max {
                break
            }

            collected.insert(selectedPoint)
            remaining.remove(selectedPoint)

            for to in remaining {
                let path = Path(from: selectedPoint, to: to)
                if let value = weight[path] {
                    if value != Int.max && distance[selectedPoint]! + 1 < distance[to]! {
                        distance[to] = distance[selectedPoint]! + 1
                        trajectory[to] = selectedPoint
                    }
                }
            }
        }
    }

    public func mostDistant() -> Int {
        return distance.values.filter { $0 < Int.max }.max()!
    }

    public func identifyLoop(_ furthestLoopElement: Int) {
        let secondFurthest = furthestLoopElement - 1

        var indexes = [Point]()
        for (key, value) in distance {
            if value == furthestLoopElement || value == secondFurthest {
                indexes.append(key)
            }
        }

        loopFields.insert(Point(i: startI, j: startJ))
        for index in indexes {
            var currentIndex: Point? = index
            while currentIndex != nil {
                loopFields.insert(currentIndex!)
                currentIndex = trajectory[currentIndex!]
            }
        }
    }

    public func patchStart() {
        var top: Character? = nil
        var down: Character? = nil
        var left: Character? = nil
        var right: Character? = nil

        if startI > 0 {
            top = matrix[startI - 1][startJ]
        }
        if startI < height - 1 {
            down = matrix[startI + 1][startJ]
        }
        if startJ > 0 {
            left = matrix[startI][startJ - 1]
        }
        if startJ < width - 1 {
            right = matrix[startI][startJ + 1]
        }

        if (left == "-" || left == "F" || left == "L") &&
            (top == "|" || top == "F" || top == "7") {
            matrix[startI][startJ] = "J"
        } else if (left! == "-" || left! == "F" || left! == "L") &&
            (down == "|" || down == "J" || down == "L") {
            matrix[startI][startJ] = "7"
        } else if (right == "-" || right == "7" || right == "J") &&
            (top == "|" || top == "F" || top == "7") {
            matrix[startI][startJ] = "L"
        } else if (right == "-" || right == "7" || right == "J") &&
            (down == "|" || down == "J" || down == "L") {
            matrix[startI][startJ] = "F"
        } else if left == "-" &&
            (right == "-" || right == "7" || right == "J") {
            matrix[startI][startJ] = "-"
        } else if right == "-" &&
            (left == "-" || left == "F" || left == "L") {
            matrix[startI][startJ] = "-"
        } else if top! == "|" &&
            (down == "|" || down == "J" || down == "L") {
            matrix[startI][startJ] = "-"
        } else if down == "|" &&
            (top == "|" || top == "F" || top == "7") {
            matrix[startI][startJ] = "|"
        }
    }

    public func nest() -> Int {
        var result = 0
        var horizontalSearch: [[Character]] = Array(repeating: Array(repeating: ".", count: width), count: height)
        var verticalSearch: [[Character]] = Array(repeating: Array(repeating: ".", count: width), count: height)

        for i in 0..<height {
            var lastEdge: Character = " "
            var inside = false
            for j in 0..<width {
                let currentPoint = Point(i: i, j: j)
                if loopFields.contains(currentPoint) {
                    let field = matrix[i][j]

                    if field == "|" {
                        inside = !inside
                    } else if field == "7" {
                        if lastEdge == "F" {
                            // pass
                        } else if lastEdge == "L" {
                            inside = !inside
                        }
                    } else if field == "J" {
                        if lastEdge == "L" {
                            // pass
                        } else if lastEdge == "F" {
                            inside = !inside
                        }
                    } else if field == "L" || field == "F" {
                        lastEdge = field
                    }

                    horizontalSearch[i][j] = field
                } else {
                    if inside {
                        horizontalSearch[i][j] = "I"
                    }
                }
            }
        }

        for j in 0..<width {
            var lastEdge: Character = " "
            var inside = false
            for i in 0..<height {
                let currentPoint = Point(i: i, j: j)
                if loopFields.contains(currentPoint) {
                    let field = matrix[i][j]

                    if field == "-" {
                        inside = !inside
                    } else if field == "L" {
                        if lastEdge == "7" {
                            inside = !inside
                        }
                    } else if field == "J" {
                        if lastEdge == "F" {
                            inside = !inside
                        }
                    } else if field == "7" || field == "F" {
                        lastEdge = field
                    }

                    verticalSearch[i][j] = field
                } else {
                    if inside {
                        verticalSearch[i][j] = "I"
                    }
                }
            }
        }

        for i in 0..<height {
            for j in 0..<width {
                if horizontalSearch[i][j] == "I" && verticalSearch[i][j] == "I" {
                    result += 1
                }
            }
        }

        return result
    }
}

struct Point: Hashable {
    let i: Int
    let j: Int
}

struct Path: Hashable {
    let from: Point
    let to: Point
}
