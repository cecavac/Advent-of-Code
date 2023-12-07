//
//  Hand.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.23.
//

import Foundation

struct Hand: Comparable {
    let bid: Int
    let cards: [Int]
    let kind: Kind

    static func == (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.kind != rhs.kind {
            return false
        }
        for i in lhs.cards.indices {
            if lhs.cards[i] != rhs.cards[i] {
                return false
            }
        }
        return true
    }

    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.kind == rhs.kind {
            for i in lhs.cards.indices {
                if lhs.cards[i] == rhs.cards[i] {
                    continue
                }
                return lhs.cards[i] < rhs.cards[i]
            }

            return false
        } else {
            return lhs.kind.rawValue < rhs.kind.rawValue
        }
    }
}
