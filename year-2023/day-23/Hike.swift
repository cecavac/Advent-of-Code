//
//  Hike.swift
//  day-23
//
//  Created by Dragan Cecavac on 23.12.23.
//

import Foundation

class Hike {
    let height: Int
    let width: Int
    let offsets: [(Int, Int, Character)] = [
        (0, 1, ">"),
        (1, 0, "v"),
        (0, -1, "<"),
        (-1, 0, "^"),
    ]

    var matrix = [[Character]]()
    var bestResult = Int.min

    init(_ input: String, climbSlopes: Bool) {
        let input2: String
        if climbSlopes {
            input2 = input
                .replacingOccurrences(of: "v", with: ".")
                .replacingOccurrences(of: "^", with: ".")
                .replacingOccurrences(of: "<", with: ".")
                .replacingOccurrences(of: ">", with: ".")
        } else {
            input2 = input
        }

        for line in input2.split(separator: "\n") {
            matrix.append(Array(String(line)))
        }

        height = matrix.count
        width = matrix[0].count

        if climbSlopes {
            buildNodes()
            reduce()
        }
    }

    func getHash(_ i: Int, _ j: Int, _ array: [Character]) -> String {
        var hash = "\(i)#\(j)"

        if array.count > 0 {
            let inspected = min(0, array.count)
            for i in 0..<inspected {
                hash += "\(array[array.count - 1 - i])"
            }
        }

        return hash
    }

    func getHash(_ i: Int, _ j: Int) -> String {
        return "\(i)#\(j)"
    }

    func isValid(_ i: Int, _ j: Int) -> Bool {
        return i >= 0 && i < height && j >= 0 && j < width
    }

    func findPath(i: Int, j: Int, visited: [String]) -> Int {
        if i == height - 1 && j == width - 2 {
            bestResult = max(bestResult, visited.count)
            return visited.count
        }

        var result = Int.min
        for offset in offsets {
            let newI = i + offset.0
            let newJ = j + offset.1
            if !isValid(newI , newJ) {
                continue
            }

            let fromValue = matrix[i][j]
            let toValue = matrix[newI][newJ]

            let fromDotToAnyVisitable = fromValue == "." && (
                toValue == "." ||
                toValue == "<" ||
                toValue == ">" ||
                toValue == "^" ||
                toValue == "v"

            )
            let fromSlopeToDot = toValue == "." && fromValue == offset.2
            if !(fromDotToAnyVisitable || fromSlopeToDot) {
                continue
            }

            let newHash = getHash(newI, newJ)
            if visited.contains(newHash) {
                continue
            }

            var newVisited = visited
            newVisited.append(newHash)
            let newResult = findPath(i: newI, j: newJ, visited: newVisited)
            result = max(result, newResult)
        }

        bestResult = max(bestResult, result)
        return result
    }

    func path() -> Int {
        print("CPU goes brrrrrr!")

        let startI = 0
        let startJ = 1
        let hash = getHash(startI, startJ)
        var visited = [String]()
        visited.append(hash)

        return findPath(i: startI, j: startJ, visited: visited) - 1
    }

    var nodeMap = [String:Node]()
    var startHash: String? = nil
    var endHash: String? = nil

    func buildNodes() {
        for i in 0..<height {
            for j in 0..<width {
                if matrix[i][j] == "." {
                    let hashId = getHash(i, j)
                    nodeMap[hashId] = Node(id: hashId)

                    if i == 0 && j == 1 {
                        startHash = hashId
                    }

                    if i == height - 1 && j == height - 2 {
                        endHash = hashId
                    }
                }
            }
        }

        for i in 0..<height {
            for j in 0..<width {
                if let node1 = nodeMap[getHash(i, j)] {
                    for offset in offsets {
                        let newI = i + offset.0
                        let newJ = j + offset.1

                        if let node2 = nodeMap[getHash(newI, newJ)] {
                            node1.links.insert(node2)
                            node2.links.insert(node1)
                        }
                    }
                }
            }
        }
    }

    func reduce() {
        while true {
            var changed = false
            for key in nodeMap.keys {
                let node = nodeMap[key]!
                if node.links.count == 2 {
                    let previous = node.links.removeFirst()
                    let next = node.links.removeFirst()
                    if previous.links.count == 2 && next.links.count == 2 {
                        previous.distance += node.distance
                        previous.links.remove(node)
                        next.links.remove(node)
                        previous.links.insert(next)
                        next.links.insert(previous)
                        changed = true
                    } else {
                        node.links.insert(previous)
                        node.links.insert(next)
                    }
                }
            }

            if !changed {
                break
            }
        }
    }

    func findLongPath(current: Node, visited: Set<String>, distance: Int) -> Int {
        if current.id == endHash {
            bestResult = max(bestResult, distance)
            return distance
        }

        var result = Int.min
        for link in current.links {
            if visited.contains(link.id) {
                continue
            }

            var newVisited = visited
            newVisited.insert(link.id)

            let newDistance = distance + current.distance
            result = max(result, findLongPath(current: link, visited: newVisited, distance: newDistance))
        }

        bestResult = max(bestResult, result)
        return result
    }

    func longPath() -> Int {
        let start = nodeMap[startHash!]!
        var visited = Set<String>()
        visited.insert(start.id)
        return findLongPath(current: start, visited: visited, distance: 0)
    }
}
