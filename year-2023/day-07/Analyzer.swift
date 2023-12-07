//
//  Analyzer.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.23.
//

import Foundation

struct Analyzer {
    static func kind(cards: [Int]) -> Kind {
        var cardCount = [Int:Int]()
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

        let jokers = cards.filter { $0 == Poker.JOKER }.count
        if jokers == 5 {
            return Kind.FIVE_OF_A_KIND
        }

        let sameCardCheck: (Int) -> Bool = { target in
            for (sameCards, times) in groupCount {
                if jokers + sameCards == target  && times > 0 {
                    return true
                }
            }
            return false
        }

        if sameCardCheck(5) {
            return Kind.FIVE_OF_A_KIND
        }

        if sameCardCheck(4) {
            return Kind.FOUR_OF_A_KIND
        }

        if (groupCount[3] == 1 && groupCount[2] == 1) ||
            (groupCount[2] == 2 && jokers == 1) {
            return Kind.FULL_HOUSE
        }

        if sameCardCheck(3) {
            return Kind.THREE_OF_A_KIND
        }

        if groupCount[2] == 2 {
            return Kind.TWO_PAIR
        }

        if sameCardCheck(2) {
            return Kind.ONE_PAIR
        }

        return Kind.HIGH_CARD
    }
}
