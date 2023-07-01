//
//  SpiralMemory.swift
//  Advent3
//
//  Created by Dragan Cecavac on 05.08.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class SpiralMemory {
    private var matrix: [String:Int] = [:]

    public func getDistance(of value: Int) -> Int {
        var exponent = 3

        while true {
            let squared = exponent * exponent
            let nextSquared = (exponent + 2) * (exponent + 2)

            if squared <= value && value < nextSquared {
                break
            }

            exponent += 2
        }

        let ring = exponent / 2 + 1
        let squared = exponent * exponent
        let nextSquared = (exponent + 2) * (exponent + 2)
        let outerElements = nextSquared - squared
        let sectionSize = outerElements / 4
        let section = (value - squared) / sectionSize
        let sectionMidElement = squared + section * sectionSize + sectionSize / 2
        let distanceFromMid = abs(value - sectionMidElement)

        return ring + distanceFromMid
    }

    enum Direction {
        case Up
        case Down
        case Left
        case Right
    }

    private func fieldValue(i: Int, j: Int) -> Int {
        let hash = "\(i)#\(j)"

        if let value = matrix[hash] {
            return value
        } else {
            return 0
        }
    }

    private func calculateElement(i: Int, j: Int) -> Int {
        var result = 0

        result += fieldValue(i: i + 1, j: j + 1)
        result += fieldValue(i: i + 1, j: j)
        result += fieldValue(i: i, j: j + 1)
        result += fieldValue(i: i - 1, j: j - 1)
        result += fieldValue(i: i - 1, j: j)
        result += fieldValue(i: i, j: j - 1)
        result += fieldValue(i: i + 1, j: j - 1)
        result += fieldValue(i: i - 1, j: j + 1)

        return result
    }

    public func getNext(after value: Int) -> Int {
        matrix = [:]
        var i = 0
        var j = 0
        matrix["\(i)#\(j)"] = 1

        var direction = Direction.Right

        while true {
            switch direction {
            case .Up:
                i -= 1

                if matrix["\(i)#\(j - 1)"] == nil {
                    direction = .Left
                }
            case .Down:
                i += 1

                if matrix["\(i)#\(j + 1)"] == nil {
                    direction = .Right
                }
            case .Left:
                j -= 1

                if matrix["\(i + 1)#\(j)"] == nil {
                    direction = .Down
                }
            case .Right:
                j += 1

                if matrix["\(i - 1)#\(j)"] == nil {
                    direction = .Up
                }
            }

            let new = calculateElement(i: i, j: j)
            if new > value {
                return new
            }

            matrix["\(i)#\(j)"] = new
        }
    }
}
