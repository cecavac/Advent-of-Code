//
//  Game.swift
//  Advent21
//
//  Created by Dragan Cecavac on 10.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Game {
    private var weapons:[Item]
    private var armor:[Item]
    private var rings:[Item]
    private let bossInput: String

    private static func parseItems(input: String, offset: Int) -> [Item] {
        var items: [Item] = []
        let lines = input.split(separator: "\n")

        for line in lines {
            let words = line.split(separator: " ")
            let cost = Int(words[1 + offset])!
            let damage = Int(words[2 + offset])!
            let armor = Int(words[3 + offset])!

            items.append(Item(cost: cost, damage: damage, armor: armor))
        }

        return items
    }

    init(bossData: String, weaponData: String, armorData: String, ringsData: String) {
        bossInput = bossData

        weapons = Game.parseItems(input: weaponData, offset: 0)

        armor = Game.parseItems(input: armorData, offset: 0)
        armor.append(Item(cost: 0, damage: 0, armor: 0))

        rings = Game.parseItems(input: ringsData, offset: 1)
        rings.append(Item(cost: 0, damage: 0, armor: 0))
        rings.append(Item(cost: 0, damage: 0, armor: 0))
    }

    public func ChallangeTheBoss(_ player: Character) -> Bool {
        let boss = Character(bossInput)

        while true {
            player.attack(enemy: boss)
            if !boss.alive {
                return true
            }

            boss.attack(enemy: player)
            if !player.alive {
                return false
            }
        }
    }

    public func play() -> (Int, Int) {
        var lowestCost = Int.max
        var highestCost = 0

        for weapon in weapons {
            for armorPiece in armor {
                for i in 0..<rings.count {
                    for j in 0..<rings.count {
                        if i == j {
                            continue
                        }

                        let ring1 = rings[i]
                        let ring2 = rings[j]
                        var items: [Item] = []

                        items.append(weapon)
                        items.append(armorPiece)
                        items.append(ring1)
                        items.append(ring2)

                        let player = Character(items)
                        if ChallangeTheBoss(player) {
                            lowestCost = min(lowestCost, player.bill)
                        } else {
                            highestCost = max(highestCost, player.bill)
                        }
                    }
                }
            }
        }

        return (lowestCost, highestCost)
    }
}
