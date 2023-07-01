//
//  RobotFactory.swift
//  Advent19
//
//  Created by Dragan Cecavac on 19.12.22.
//

import Foundation

struct RobotFactory: Hashable {
    let id: Int
    let priceOreR: Int
    let priceClayR: Int
    let priceObsidianR1: Int
    let priceObsidianR2: Int
    let priceGeodeR1: Int
    let priceGeodeR2: Int

    var ore = 0
    var clay = 0
    var obsidian = 0
    var geodes = 0
    var oreR = 1
    var clayR = 0
    var obsidianR = 0
    var geodeR = 0

    let maxOreR: Int
    let maxClayR: Int
    let maxObsidianR: Int

    public static var cache = [String:Int]()

    init(_ input: String) {
        let elements = input.split(separator: " ")

        id = Int(String(elements[1].split(separator: ":")[0]))!
        priceOreR = Int(String(elements[6]))!
        priceClayR = Int(String(elements[12]))!
        priceObsidianR1 = Int(String(elements[18]))!
        priceObsidianR2 = Int(String(elements[21]))!
        priceGeodeR1 = Int(String(elements[27]))!
        priceGeodeR2 = Int(String(elements[30]))!

        maxOreR = max(priceOreR, priceClayR, priceObsidianR1, priceGeodeR1)
        maxClayR = priceObsidianR2
        maxObsidianR = priceGeodeR2
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(ore)
        hasher.combine(clay)
        hasher.combine(obsidian)
        hasher.combine(geodes)
        hasher.combine(oreR)
        hasher.combine(clayR)
        hasher.combine(obsidianR)
        hasher.combine(geodeR)
    }

    func build(minute: Int, depth: Int) -> Int {
        if minute == depth {
            return geodes
        }

        // Check if the current score can be beaten
        var bestRemainingPossibility = 0
        for i in minute..<depth {
            bestRemainingPossibility += geodeR + (i - minute)
        }
        if geodes + bestRemainingPossibility <= RobotFactory.bestEver {
            return 0
        }

        let stateHash = "\(minute)#\(self.hashValue)"
        if let cachedValue = RobotFactory.cache[stateHash] {
            return cachedValue
        }
        var bestResult = 0

        let geodeRCapacity = min(min(ore / priceGeodeR1, obsidian / priceGeodeR2), 1)
        let obsidianRCapacity = min(min(ore / priceObsidianR1, clay / priceObsidianR2), 1)
        let clayRCapacity = min(ore / priceClayR, 1)
        let oreRCapacity = min(ore / priceOreR, 1)

        for newGeodeR in (0...geodeRCapacity).reversed() {
            for newObsidianR in (0...obsidianRCapacity).reversed() {
                for newClayR in (0...clayRCapacity).reversed() {
                    for newOreR in (0...oreRCapacity).reversed() {
                        if  newGeodeR + newObsidianR + newClayR + newOreR > 1 ||
                            oreR + newOreR > maxOreR ||
                            clayR + newClayR > maxClayR ||
                            obsidianR + newObsidianR > maxObsidianR {
                            continue
                        }

                        var newFactory = self
                        newFactory.ore -= newOreR * priceOreR +
                                        newClayR * priceClayR +
                                        newObsidianR * priceObsidianR1 +
                                        newGeodeR * priceGeodeR1
                        newFactory.clay -= newObsidianR * priceObsidianR2
                        newFactory.obsidian -= newGeodeR * priceGeodeR2

                        if newFactory.ore >= 0 && newFactory.clay >= 0 && newFactory.obsidian >= 0 {
                            newFactory.ore += oreR
                            newFactory.clay += clayR
                            newFactory.obsidian += obsidianR
                            newFactory.geodes += geodeR

                            newFactory.oreR += newOreR
                            newFactory.clayR += newClayR
                            newFactory.obsidianR += newObsidianR
                            newFactory.geodeR += newGeodeR

                            bestResult = max(newFactory.build(minute: minute + 1, depth: depth), bestResult)
                        }
                    }
                }
            }
        }

        if bestResult > RobotFactory.bestEver {
            print(bestResult)
            RobotFactory.bestEver = bestResult
        }
        RobotFactory.cache[stateHash] = bestResult
        return bestResult
    }

    static var bestEver = 0
}
