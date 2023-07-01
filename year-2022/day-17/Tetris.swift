//
//  Tetris.swift
//  Advent17
//
//  Created by Dragan Cecavac on 17.12.22.
//

import Foundation

class Tetris {
    var maxHeight = 0
    var trimmedRocks = 0
    var nextRock = -1 // start from -1 and loop 0-4
    var rockPallete = [Rock]()
    var stationaryRocks = [Rock]()

    // Pattern matching data
    var cycleResults = [Int]()
    var cycleDiff = [Int]()
    var cycleRocks = [Int]()

    init() {
        let rockData = Input.Data.split(separator: "\n\n")
        for data in rockData {
            rockPallete.append(Rock(String(data)))
        }

        // Fake rocks to prevent falling by supporting the others
        var bottomRock1 = Rock("####")
        bottomRock1.x = 0
        bottomRock1.y = -1
        stationaryRocks.append(bottomRock1)
        var bottomRock2 = Rock("###")
        bottomRock2.x = 4
        bottomRock2.y = -1
        stationaryRocks.append(bottomRock2)

        // Account for the fake bottom
        trimmedRocks -= 2

        cycleResults.append(0)
    }

    func getNextRock() -> Rock{
        nextRock += 1
        nextRock %= rockPallete.count
        return rockPallete[nextRock]
    }

    func trimmRocks() {
        var rocksToKeep = [Rock]()
        for rock in stationaryRocks {
            // Rocks burried deep under are no longer of interest
            // 30 seems to be enough to preserve all the supporting rocks
            if abs(rock.y - maxHeight) <= 30 {
                rocksToKeep.append(rock)
            }
        }

        trimmedRocks += stationaryRocks.count - rocksToKeep.count
        stationaryRocks = rocksToKeep
    }

    struct ResultPackage {
        let totalHeight: Int
        let heightPerCycle: Int
        let rocksPerCycle: Int
    }

    func fall(jets: String, count: Int?) -> ResultPackage {
        let jetArray = Array(jets)
        var fallingRock = getNextRock()
        fallingRock.y = 3

        while true {
            for i in 0..<jetArray.count {
                if jetArray[i] == "<" {
                    var canMoveLeft = true
                    for rock in stationaryRocks {
                        if !fallingRock.canMoveLeft(against: rock) {
                            canMoveLeft = false
                            break
                        }
                    }
                    if canMoveLeft {
                        fallingRock.moveLeft()
                    }
                } else {
                    var canMoveRight = true
                    for rock in stationaryRocks {
                        if !fallingRock.canMoveRight(against: rock) {
                            canMoveRight = false
                            break
                        }
                    }
                    if canMoveRight {
                        fallingRock.moveRight()
                    }
                }

                var canMoveDown = true
                for rock in stationaryRocks {
                    if !fallingRock.canMoveDown(against: rock) {
                        canMoveDown = false
                        break
                    }
                }
                if canMoveDown {
                    fallingRock.moveDown()
                } else {
                    stationaryRocks.append(fallingRock)
                    maxHeight = max(maxHeight, fallingRock.y + fallingRock.height - 1)

                    fallingRock = getNextRock()
                    fallingRock.y = maxHeight + 4

                    trimmRocks()

                    if count != nil {
                        if stationaryRocks.count + trimmedRocks == count! {
                            return ResultPackage(
                                totalHeight: maxHeight + 1,
                                heightPerCycle: 0,
                                rocksPerCycle: 0
                            )
                        }
                    }
                }

                if i == jetArray.count - 1 && count == nil {
                    cycleResults.append(maxHeight + 1 / 2)
                    cycleRocks.append(stationaryRocks.count + trimmedRocks)

                    let diff = cycleResults[cycleResults.count - 1] - cycleResults[cycleResults.count - 2]
                    cycleDiff.append(diff)

                    let cycleRepeat = cycleDetected(in: cycleDiff)
                    if cycleRepeat > 0 {
                        var combinedDiff = 0
                        for i in 0..<cycleRepeat {
                            combinedDiff += cycleDiff[cycleDiff.count - 1 - i]
                        }

                        var combinedRocks = 0
                        for i in 0..<cycleRepeat {
                            combinedRocks += cycleRocks[cycleRocks.count - 1 - i] - cycleRocks[cycleRocks.count - 1 - i - cycleRepeat]
                        }

                        return ResultPackage(
                            totalHeight: maxHeight + 1,
                            heightPerCycle: combinedDiff,
                            rocksPerCycle: combinedRocks / cycleRepeat
                        )
                    }
                }
            }
        }
    }

    // Find a repeating pattern
    func cycleDetected(in cycle: [Int]) -> Int {
        if cycle.count < 2 {
            return 0
        }

        for i in 1..<cycle.count / 2 {
            var matching = true
            for j in 0..<i {
                let index1 = cycle.count - 1 - j
                let index2 = cycle.count - 1 - i - j
                if cycle[index1] != cycle[index2] {
                    matching = false
                    break
                }
            }
            if matching {
                return i
            }
        }

        return 0
    }

    func pleaseTheElephants(jets: String) -> Int {
        let step1 = fall(jets: jets, count: nil)

        var target = 1000000000000
        target -= stationaryRocks.count + trimmedRocks

        let quickCount = target / step1.rocksPerCycle
        let remainingCount = target % step1.rocksPerCycle

        let tetris = Tetris()
        let step2 = tetris.fall(jets: jets, count: remainingCount + stationaryRocks.count + trimmedRocks)

        return step2.totalHeight + quickCount * step1.heightPerCycle
    }
}
