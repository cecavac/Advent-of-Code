//
//  Basin.swift
//  Advent24
//
//  Created by Dragan Cecavac on 24.12.22.
//

import Foundation

class Basin {
    // If the result is Int.max it might be worth increasing the cache size
    static let stepsToCache = 1000
    var cachedMaps = [[[Bool]]]()
    var blizzards = [Blizzard]()

    let startI: Int
    let startJ: Int
    let endI: Int
    let endJ: Int

    let minI = 0
    let maxI: Int
    let minJ = 0
    let maxJ: Int

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        maxI = lines.count - 1
        maxJ = lines[0].count - 1

        startI = 0
        startJ = Array(String(lines[0])).firstIndex(of: ".")!
        endI = maxI
        endJ = Array(String(lines[lines.count - 1])).firstIndex(of: ".")!

        for i in minI..<maxI {
            let row = Array(String(lines[i]))
            for j in minJ..<maxJ {
                if row[j] != "." && row[j] != "#" {
                    let blizzard = Blizzard(
                        i: i, j: j, direction: row[j],
                        minI: minI, maxI: maxI,
                        minJ: minJ, maxJ: maxJ)
                    blizzards.append(blizzard)
                }
            }
        }
    }

    func getMapSnapshot() -> [[Bool]] {
        var map = Array(repeating: Array(repeating: false, count: maxJ + 1), count: maxI + 1)
        for blizzard in blizzards {
            map[blizzard.i][blizzard.j] = true
        }

        // Bake in walls with start and stop positions
        for j in 0..<maxJ + 1 {
            if j != startJ {
                map[minJ][j] = true
            }
            if j != endJ {
                map[maxI][j] = true
            }
        }
        for i in 0..<maxI + 1 {
            map[i][minJ] = true
            map[i][maxJ] = true
        }
        return map
    }

    func preCacheMaps() {
        for _ in 0..<Basin.stepsToCache {
            let map = getMapSnapshot()
            cachedMaps.append(map)
            for i in 0..<blizzards.count {
                blizzards[i].move()
            }
        }
    }

    func show(mapIndex: Int) {
        let map = cachedMaps[mapIndex]
        for i in 0..<map.count {
            var line = ""
            for j in 0..<map[0].count {
                if map[i][j] {
                    line += "#"
                } else {
                    line += "."
                }
            }
            print(line)
        }
    }

    var scoreCache = [String:Int]()
    var bestScore = Int.max

    private func walk(i: Int, j: Int, step: Int,
                      pickupSnacks: Bool, haveSnacks: Bool, reachedExit: Bool) -> Int {
        if i < minI || i > maxI || j < minJ || j > maxJ {
            return Int.max
        }

        if bestScore <= step {
            return Int.max
        }

        let atTheExit = i == endI && j == endJ
        if atTheExit && (!pickupSnacks || haveSnacks) {
            bestScore = min(bestScore, step)
            return step
        }

        let cacheHash = "\(i)#\(j)#\(step)\(reachedExit)\(haveSnacks)"
        if let cachedScore = scoreCache[cacheHash] {
            return cachedScore
        }

        if step >= Basin.stepsToCache {
            return Int.max
        }

        let map = cachedMaps[step]
        if map[i][j] {
            return Int.max
        }

        let atTheStart = i == startI && j == startJ
        let byTheSnacks = atTheStart && reachedExit

        // Try to go in all directions or simply wait
        var bestLocalScore = Int.max
        bestLocalScore = min(
            bestLocalScore,
            walk(i: i + 1, j: j + 0, step: step + 1,
                 pickupSnacks: pickupSnacks,
                 haveSnacks: haveSnacks || byTheSnacks,
                 reachedExit: reachedExit || atTheExit)
        )
        bestLocalScore = min(
            bestLocalScore,
            walk(i: i + 0, j: j + 1, step: step + 1,
                 pickupSnacks: pickupSnacks,
                 haveSnacks: haveSnacks || byTheSnacks,
                 reachedExit: reachedExit || atTheExit)
        )
        bestLocalScore = min(
            bestLocalScore,
            walk(i: i + 0, j: j - 1,
                 step: step + 1,
                 pickupSnacks: pickupSnacks,
                 haveSnacks: haveSnacks || byTheSnacks,
                 reachedExit: reachedExit || atTheExit)
        )
        bestLocalScore = min(
            bestLocalScore,
            walk(i: i - 1, j: j + 0,
                 step: step + 1,
                 pickupSnacks: pickupSnacks,
                 haveSnacks: haveSnacks || byTheSnacks,
                 reachedExit: reachedExit || atTheExit)
        )
        bestLocalScore = min(
            bestLocalScore,
            walk(i: i + 0, j: j + 0,
                 step: step + 1,
                 pickupSnacks: pickupSnacks,
                 haveSnacks: haveSnacks || byTheSnacks,
                 reachedExit: reachedExit || atTheExit)
        )
        scoreCache[cacheHash] = bestLocalScore

        return bestLocalScore
    }

    func walk(pickupSnacks: Bool) -> Int {
        return walk(i: startI, j: startJ, step: 0,
                    pickupSnacks: pickupSnacks,
                    haveSnacks: false,
                    reachedExit: false)
    }
}
