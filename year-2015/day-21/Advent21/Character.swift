//
//  Character.swift
//  Advent21
//
//  Created by Dragan Cecavac on 10.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Character {
    private var hp = 100
    private var damage = 0
    private var armor = 0
    private(set) var bill = 0

    public var alive: Bool {
        return hp > 0
    }

    init(_ items: [Item]) {
        for item in items {
            damage += item.damage
            armor += item.armor
            bill += item.cost
        }
    }

    init(_ input: String) {
        let lines = input.split(separator: "\n")

        let words0 = lines[0].split(separator: " ")
        hp = Int(words0[2])!

        let words1 = lines[1].split(separator: " ")
        damage = Int(words1[1])!

        let words2 = lines[2].split(separator: " ")
        armor = Int(words2[1])!
    }

    public func attack(enemy target: Character) {
        let hpDamage = max(damage - target.armor, 1)

        target.hp -= hpDamage
    }
}
