//
//  Tetris.swift
//  day-22
//
//  Created by Dragan Cecavac on 22.12.23.
//

import Foundation

class Tetris {
    var data = [Int]()
    var bricks = [Brick]()
    var neighbours = [Brick:Set<Brick>]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        for line in lines {
            let processedData = String(line).replacingOccurrences(of: "~", with: ",")
            let elements = processedData.split(separator: ",")
            let start = Point(
                x: Int(String(elements[0]))!,
                y: Int(String(elements[1]))!,
                z: Int(String(elements[2]))!
            )
            let end = Point(
                x: Int(String(elements[3]))!,
                y: Int(String(elements[4]))!,
                z: Int(String(elements[5]))!
            )
            let brick = Brick(start: start, end: end)
            bricks.append(brick)
        }

        findAxisNeighbours()
        fall()
    }

    func determineFallingHeight(brick1: Brick, skip: Set<Brick>) -> Int {
        var fallingHeight = 1

        for brick2 in neighbours[brick1]! {
            if skip.contains(brick2) {
                continue
            }

            let brick1MinHeight = min(brick1.start.z, brick1.end.z)
            let brick2MaxHeight = max(brick2.start.z, brick2.end.z)
            if brick2MaxHeight < brick1MinHeight {
                fallingHeight = max(fallingHeight, brick2MaxHeight + 1)
            }
        }

        return fallingHeight
    }

    func fall() {
        while true {
            var changed = false
            bricks = bricks.sorted { $0.end.z <= $1.start.z }
            for brick1 in bricks {
                let fallingHeight = determineFallingHeight(brick1: brick1, skip: Set<Brick>())

                if brick1.start.z != fallingHeight {
                    let height = brick1.end.z - brick1.start.z
                    brick1.start.z = fallingHeight
                    brick1.end.z = fallingHeight + height
                    changed = true
                }
            }

            if !changed {
                break
            }
        }
    }

    func findAxisNeighbours() {
        for brick1 in bricks {
            neighbours[brick1] = Set<Brick>()

            for brick2 in bricks {
                if brick1 == brick2 {
                    continue
                }

                if brick1.xyOverlap(other: brick2) {
                    neighbours[brick1]!.insert(brick2)
                }
            }
        }
    }

    func play() -> (Int, Int) {
        var result1 = 0
        var result2 = 0

        for i in bricks.indices {
            var skip = Set<Brick>()
            skip.insert(bricks[i])

            var everChanged = false
            while true {
                var changed = false
                for j in bricks.indices {
                    if skip.contains(bricks[j]) {
                        continue
                    }

                    let fallingHeight = determineFallingHeight(brick1: bricks[j], skip: skip)
                    if bricks[j].start.z != fallingHeight {
                        everChanged = true
                        skip.insert(bricks[j])
                        changed = true
                        result2 += 1
                    }
                }

                if !changed {
                    break
                }
            }


            if !everChanged {
                result1 += 1
            }
        }

        return (result1, result2)
    }
}
