//
//  Analyzer.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.23.
//

import Foundation

struct Analyzer {
    private static func baseKind(cards: [Character]) -> Kind? {
        var cardCount = [Character:Int]()
        for card in cards {
            if card == Poker.JOKER {
                continue
            }
            cardCount[card] = (cardCount[card] ?? 0) + 1
        }

        var groupCount = [Int:Int]()
        for val in cardCount.values {
            groupCount[val] = (groupCount[val] ?? 0) + 1
        }

        if groupCount[5] == 1 {
            return Kind.FIVE_OF_A_KIND
        }
        if groupCount[4] == 1 {
            return Kind.FOUR_OF_A_KIND
        }
        if groupCount[3] == 1 && groupCount[2] == 1 {
            return Kind.FULL_HOUSE
        }
        if groupCount[3] == 1 {
            return Kind.THREE_OF_A_KIND
        }
        if groupCount[2] == 2 {
            return Kind.TWO_PAIR
        }
        if groupCount[2] == 1 {
            return Kind.ONE_PAIR
        }
        if groupCount[1] ?? 0 >= 1 {
            return Kind.HIGH_CARD
        }

        return Kind.ALL_JOKERS
    }

    static func kind(cards: [Character]) -> Kind {
        let base = baseKind(cards: cards)!
        let jokers = cards.filter { $0 == Poker.JOKER }.count
        if jokers == 0 {
            return base
        }

        if base == Kind.FIVE_OF_A_KIND ||
            base == Kind.ALL_JOKERS ||
            (base == Kind.FOUR_OF_A_KIND && jokers == 1) ||
            (base == Kind.THREE_OF_A_KIND && jokers == 2) ||
            (base == Kind.ONE_PAIR && jokers == 3) ||
            (base == Kind.HIGH_CARD && jokers == 4) {
            return Kind.FIVE_OF_A_KIND
        }

        if (base == Kind.FOUR_OF_A_KIND && jokers == 0) ||
            (base == Kind.THREE_OF_A_KIND && jokers == 1) ||
            (base == Kind.ONE_PAIR && jokers == 2) ||
            (base == Kind.HIGH_CARD && jokers == 3) {
            return Kind.FOUR_OF_A_KIND
        }

        if (base == Kind.FULL_HOUSE && jokers == 0) ||
            (base == Kind.TWO_PAIR && jokers == 1) {
            return Kind.FULL_HOUSE
        }

        if (base == Kind.THREE_OF_A_KIND && jokers == 0) ||
            (base == Kind.ONE_PAIR && jokers == 1) ||
            (base == Kind.HIGH_CARD && jokers == 2) {
            return Kind.THREE_OF_A_KIND
        }

        if (base == Kind.TWO_PAIR && jokers == 0) {
            return Kind.TWO_PAIR
        }

        if (base == Kind.ONE_PAIR && jokers == 0) ||
            (base == Kind.HIGH_CARD && jokers == 1) {
            return Kind.ONE_PAIR
        }

        return Kind.HIGH_CARD
    }
}
