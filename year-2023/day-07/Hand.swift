//
//  Hand.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.23.
//

import Foundation

struct Hand: Comparable {
    let bid: Int
    let cards: [Character]
    let kind: Kind

    static func == (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.kind != rhs.kind {
            return false
        }
        for i in lhs.cards.indices {
            if Hand.strength(lhs.cards[i]) != Hand.strength(rhs.cards[i]) {
                return false
            }
        }
        return true
    }

    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.kind == rhs.kind {
            for i in lhs.cards.indices {
                let lhsStrength = Hand.strength(lhs.cards[i])
                let rhsStrength = Hand.strength(rhs.cards[i])
                if Hand.strength(lhs.cards[i]) == rhsStrength {
                    continue
                }
                return lhsStrength < rhsStrength
            }

            return false
        } else {
            return lhs.kind.rawValue < rhs.kind.rawValue
        }
    }

    private static func strength(_ input: Character) -> Int {
        switch input {
        case "A":
            return 14
        case "K":
            return 13
        case "Q":
            return 12
        case "J":
            return 11
        case "T":
            return 10
        case "*":
            return 0
        default:
            return Int(String(input))!
        }
    }
}
