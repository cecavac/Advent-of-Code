//
//  Game.swift
//  Advent21
//
//  Created by Dragan Cecavac on 10.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Game {
    private static func fight(boss: Character, player: Character, depth: Int) -> Int {
        var lowestMana = Int.max

        for i in 0..<player.spellsCount {
            let playerCopy = player.copy()
            let bossCopy = boss.copy()

            let spentMana = playerCopy.fancyAttack(enemy: bossCopy, spell: i)
            if spentMana == 0 {
                continue
            }

            if !bossCopy.alive {
                return spentMana
            }

            bossCopy.bruteAttack(enemy: playerCopy)
            if !bossCopy.alive {
                /*
                    Boss died from an effect
                    Even if player died afterwards,
                    it means that the player actaully won,
                    since the boss was not alive while dealing the final blow.
                */
                return spentMana
            }

            if !playerCopy.alive {
                continue
            }

            let remaniningSpentMana = Game.fight(boss: bossCopy, player: playerCopy, depth: depth + 1)
            if remaniningSpentMana == 0 || remaniningSpentMana == Int.max {
                continue
            }

            lowestMana = min(lowestMana, remaniningSpentMana + spentMana)
        }

        return lowestMana
    }

    public static func play() -> Int {
        let boss = Character(Input.Input1)
        let player = Character()

        return Game.fight(boss: boss, player: player, depth: 0)
    }

    public static func playHard() -> Int {
        let boss = Character(Input.Input1)
        let player = Character()
        player.permanentlyPoison()

        return Game.fight(boss: boss, player: player, depth: 0)
    }
}
