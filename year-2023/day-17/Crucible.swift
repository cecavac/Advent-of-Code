//
//  Crucible.swift
//  day-17
//
//  Created by Dragan Cecavac on 17.12.23.
//

import Foundation

class Crucible {
    let height: Int
    let width: Int
    let hashBase: Int
    let offsets: [(Int, Int, Character)] = [
        (0, 1, ">"),
        (1, 0, "v"),
        (0, -1, "<"),
        (-1, 0, "^"),
    ]

    var matrix = [[Int]]()
    var bestResult = Int.max
    var cache = [String:Int]()
    var bestArrival = [String:Int]()

    init(_ input: String, hashBase: Int) {
        for line in input.split(separator: "\n") {
            var row = [Int]()
            for char in line {
                row.append(Int(String(char))!)
            }
            matrix.append(row)
        }

        height = matrix.count
        width = matrix[0].count
        self.hashBase = hashBase
    }

    func getHash(_ i: Int, _ j: Int, _ array: [Character]) -> String {
        var hash = "\(i)#\(j)"

        if array.count > 0 {
            let inspected = min(hashBase, array.count)
            for i in 0..<inspected {
                hash += "\(array[array.count - 1 - i])"
            }
        }

        return hash
    }

    func checkConstraints(_ array: [Character]) -> Bool {
        if array.count >= 2 {
            let last = array[array.count - 1]
            let preLast = array[array.count - 2]
            if (last == ">" && preLast == "<") ||
                (last == "<" && preLast == ">") ||
                (last == "^" && preLast == "v") ||
                (last == "v" && preLast == "^") {
                return false
            }
        }

        if array.count >= hashBase + 1 {
            var allEqual = true
            for i in 2...hashBase + 1 {
                allEqual = allEqual && array.last! == array[array.count - i]
            }
            if allEqual {
                return false
            }
        }

        return true
    }

    func isValid(_ i: Int, _ j: Int) -> Bool {
        return i >= 0 && i < height && j >= 0 && j < width
    }

    func findPath(i: Int, j: Int, moves: [Character], points: Int) -> Int {
        if i == height - 1 && j == width - 1 {
            bestResult = min(bestResult, points)
            return matrix[i][j]
        }

        var result = Int.max
        for offset in offsets {
            let newI = i + offset.0
            let newJ = j + offset.1
            if !isValid(newI , newJ) {
                continue
            }

            let newPoints = points + matrix[newI][newJ]
            if newPoints >= bestResult {
                continue
            }

            var newMoves = moves
            newMoves.append(offset.2)
            if !checkConstraints(newMoves) {
                continue
            }

            let newHash = getHash(newI, newJ, newMoves)
            if newPoints < bestArrival[newHash] ?? Int.max {
                cache[newHash] = nil
                bestArrival[newHash] = newPoints
            }

            if let cached = cache[newHash] {
                result = min(result, cached)
            } else {
                let newResult = findPath(i: newI, j: newJ, moves: newMoves, points: newPoints)
                cache[newHash] = newResult
                result = min(result, newResult)
            }
        }

        if result != Int.max {
            bestResult = min(bestResult, points + result)

            if moves.count == 0 {
                return result
            } else {
                return result + matrix[i][j]
            }
        } else {
            return result
        }
    }

    func path() -> Int {
        print("CPU goes brrrrrr!")
        return findPath(i: 0, j: 0, moves: [], points: 0)
    }
}
