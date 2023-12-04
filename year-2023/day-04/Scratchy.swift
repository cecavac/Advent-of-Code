//
//  Scratchy.swift
//  day-04
//
//  Created by Dragan Cecavac on 04.12.23.
//

import Foundation

class Scratchy {
    var cards = [Card]()

    init(_ input: String) {
        let lines = input.split(separator: "\n")
        for line in lines {
            cards.append(Card(String(line)))
        }
    }

    func points() -> Int {
        return cards.map { $0.points() }
            .reduce(0, +)
    }

    func totalCards() -> Int {
        var allCards = cards.count
        var cardCountChanged: Bool

        repeat {
            var newCards = cards
            cardCountChanged = false

            for i in cards.indices {
                if cards[i].quantity > 0 {
                    let cardsWon = cards[i].getWinning()
                    newCards[i].quantity -= cards[i].quantity
                    for wonIndex in cardsWon {
                        newCards[wonIndex].quantity += cards[i].quantity
                    }

                    cardCountChanged = true
                }
            }

            cards = newCards
            allCards += cards.map { $0.quantity }.reduce(0, +)
        } while cardCountChanged

        return allCards
    }
}
