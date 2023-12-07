//
//  Poker.swift
//  day-07
//
//  Created by Dragan Cecavac on 07.12.23.
//

import Foundation

class Poker {
    public static let JOKER: Character = "*"
    var hands = [Hand]()

    init(_ input: String, jIsJoker: Bool) {
        let lines = input.split(separator: "\n")

        for line in lines {
            var adaptedLine = String(line)
            if jIsJoker {
                // Use "*" for jokers to have the same algorithm working for both parts
                adaptedLine = adaptedLine.replacingOccurrences(of: "J", with: String(Poker.JOKER))
            }

            let sections = adaptedLine.split(separator: " ")
            let cards = Array(String(sections[0]))
            let bid = Int(String(sections[1]))!

            let kind = Analyzer.kind(cards: cards)
            hands.append(Hand(bid: bid, cards: cards, kind: kind))
        }
    }

    func score() -> Int {
        return hands.sorted()
            .enumerated()
            .map { (index, hand) in
                (index + 1) * hand.bid
            }
            .reduce(0, +)
    }
}
