//
//  PathFinder.swift
//  Advent15
//
//  Created by Dragan Cecavac on 15.12.21.
//

import Foundation

class PathFinder {
    private var fields = [Int:Int]()
    private var distances = [Int:Int]()

    private var height: Int
    private var width: Int
    private let scale: Int

    private func hash(x: Int, y: Int) -> Int {
        return x * 1000 + y
    }

    init(_ input: String, scale: Int) {
        self.scale = scale
        let lines = input.split(separator: "\n")
        height = lines.count
        width = lines[0].count

        for i in 0..<height {
            let lineElements = Array(String(lines[i]))
            for j in 0..<width {
                let hash = hash(x: i, y: j)
                fields[hash] = Int(String(lineElements[j]))
            }
        }

        for scaleI in 0..<scale {
            for scaleJ in 0..<scale {
                for i in 0..<height {
                    for j in 0..<width {
                        let hash1 = hash(x: i, y: j)
                        let hash2 = hash(x: i + scaleI * height, y: j + scaleJ * width)
                        fields[hash2] = fields[hash1]! + scaleI + scaleJ
                        if fields[hash2]! > 9 {
                            fields[hash2]! -= 9
                        }
                    }
                }
            }
        }

        process()
    }

    private func process() {
        var changed: Bool
        repeat {
            changed = false
            for i in 0..<(height * scale) {
                for j in 0..<(width * scale) {
                    let hashMain = hash(x: i, y: j)
                    if i == 0 && j == 0 {
                        distances[hashMain] = 0
                        continue
                    }

                    var topDistance = Int.max
                    var leftDistance = Int.max
                    var bottomDistance = Int.max
                    var rightDistance = Int.max
                    let hashTop = hash(x: i - 1, y: j)
                    if let distance = distances[hashTop] {
                        topDistance = distance
                    }
                    let hashLeft = hash(x: i, y: j - 1)
                    if let distance = distances[hashLeft] {
                        leftDistance = distance
                    }
                    let hashBottom = hash(x: i + 1, y: j)
                    if let distance = distances[hashBottom] {
                        bottomDistance = distance
                    }
                    let hashRight = hash(x: i, y: j + 1)
                    if let distance = distances[hashRight] {
                        rightDistance = distance
                    }
                    var minDistance = min(topDistance, leftDistance)
                    minDistance = min(minDistance, bottomDistance)
                    minDistance = min(minDistance, rightDistance)
                    let distance = fields[hashMain]! + minDistance

                    if distances[hashMain] == nil || distances[hashMain]! > distance {
                        changed = true
                    }

                    distances[hashMain] = distance
                }
            }
        } while changed
    }

    public func endDistance() -> Int {
        let hash = hash(x: height * scale - 1, y: width * scale - 1)
        return distances[hash]!
    }
}
