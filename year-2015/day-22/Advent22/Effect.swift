//
//  Effect.swift
//  Advent22
//
//  Created by Dragan Cecavac on 11.04.20.
//  Copyright © 2020 Dragan Cecavac. All rights reserved.
//

import Foundation

class Effect {
    public let name:String
    private let damage: Int
    public let armor: Int
    private let hp: Int
    private let mp: Int
    private(set) var ttl: Int

    public func apply(for character: Character) {
        character.heal(by: hp)
        character.replenishMana(by: mp)
        character.hurt(by: damage)
        ttl -= 1
    }

    init (name: String, damage: Int, armor: Int, hp: Int, mp: Int, ttl: Int) {
        self.name = name
        self.damage = damage
        self.armor = armor
        self.hp = hp
        self.mp = mp
        self.ttl = ttl
    }

    public var expired: Bool {
        return ttl <= 0
    }

    func copy() -> Effect {
        let copy = Effect(name: name, damage: damage, armor: armor, hp: hp, mp: mp, ttl: ttl)
        return copy
    }
}
