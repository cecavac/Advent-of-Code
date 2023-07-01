//
//  Character.swift
//  Advent21
//
//  Created by Dragan Cecavac on 10.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Character {
    private var hp = 50
    private var mp = 500
    private var damage = 0
    private var armor = 0
    private var effects = Array<Effect>()
    private var spells = Array<(Character) -> Int>()
    private var permanentlyPoisoned = false

    public var alive: Bool {
        return hp > 0
    }

    private func magicMissle(enemy target: Character) -> Int {
        let manaCost = 53

        if mp < manaCost {
            return 0
        }

        mp -= manaCost
        target.hp -= 4

        return manaCost
    }

    private func drain(enemy target: Character) -> Int {
        let manaCost = 73

        if mp < manaCost {
            return 0
        }

        mp -= manaCost
        target.hp -= 2
        hp += 2

        return manaCost
    }

    private func shield(enemy target: Character) -> Int {
        let manaCost = 113
        let effectName = "Shield"

        if mp < manaCost {
            return 0
        }

        for effect in effects {
            if effect.name == effectName {
                return 0
            }
        }

        mp -= manaCost
        let effect = Effect(name: effectName, damage: 0, armor: 7, hp: 0, mp: 0, ttl: 6)
        effects.append(effect)

        return manaCost
    }

    private func poison(enemy target: Character) -> Int {
        let manaCost = 173
        let effectName = "Poison"

        if mp < manaCost {
            return 0
        }

        for effect in target.effects {
            if effect.name == effectName {
                return 0
            }
        }

        mp -= manaCost
        let effect = Effect(name: effectName, damage: 3, armor: 0, hp: 0, mp: 0, ttl: 6)
        target.effects.append(effect)

        return manaCost
    }

    private func recharge(enemy target: Character) -> Int {
        let manaCost = 229
        let effectName = "Recharge"

        if mp < manaCost {
            return 0
        }

        for effect in effects {
            if effect.name == effectName {
                return 0
            }
        }

        mp -= manaCost
        let effect = Effect(name: effectName, damage: 0, armor: 0, hp: 0, mp: 101, ttl: 5)
        effects.append(effect)

        return manaCost
    }

    init() {
        spells.append(shield(enemy:))
        spells.append(recharge(enemy:))
        spells.append(poison(enemy:))
        spells.append(drain(enemy:))
        spells.append(magicMissle(enemy:))
    }

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        let words0 = lines[0].split(separator: " ")
        hp = Int(words0[2])!

        let words1 = lines[1].split(separator: " ")
        damage = Int(words1[1])!
    }

    public func heal(by healthPoints: Int) {
        hp += healthPoints
    }

    public func replenishMana(by manaPoints: Int) {
        mp += manaPoints
    }

    public func hurt(by damagePoints: Int) {
        hp -= damagePoints
    }

    public func getTargetArmor(target: Character) -> Int {
        var extraArmor = target.armor

        for effect in target.effects {
            extraArmor += effect.armor
        }

        return extraArmor
    }

    public func applyEffects() {
        for effect in effects {
            effect.apply(for: self)
        }

        effects.removeAll(where: { $0.expired })
    }

    public func bruteAttack(enemy target: Character) {
        let targetArmor = getTargetArmor(target: target)
        applyEffects()
        target.applyEffects()

        let hpDamage = max(damage - targetArmor, 1)

        target.hp -= hpDamage
    }

    public var spellsCount: Int {
        return spells.count
    }

    public func fancyAttack(enemy target: Character, spell spellIndex: Int) -> Int {
        if permanentlyPoisoned {
            hp -= 1
            if !alive {
                return 0
            }
        }

        applyEffects()
        target.applyEffects()

        let spell = spells[spellIndex]
        return spell(target)
    }

    func copy() -> Character {
        let copy = Character()

        copy.hp = hp
        copy.mp = mp
        copy.damage = damage
        copy.armor = armor
        copy.permanentlyPoisoned = permanentlyPoisoned

        for effect in effects {
            let effectCopy = effect.copy()
            copy.effects.append(effectCopy)
        }

        return copy
    }

    public func permanentlyPoison() {
        permanentlyPoisoned = true
    }
}
