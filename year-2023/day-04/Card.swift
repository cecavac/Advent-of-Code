//
//  Card.swift
//  day-04
//
//  Created by Dragan Cecavac on 04.12.23.
//

import Foundation

struct Card {
    var id: Int
    var winning = Set<Int>()
    var numbers = Set<Int>()
    var quantity = 1

    init(_ input: String) {
        let sections = input.split(separator: ": ")
        let idString = sections[0].split(separator: " ")
        id = Int(String(idString[1]))!

        let numberSections = sections[1].split(separator: " | ")
        let winningData = numberSections[0].split(separator: " ")
        let numberData = numberSections[1].split(separator: " ")

        for winner in winningData {
            winning.insert(Int(String(winner))!)
        }
        for number in numberData {
            numbers.insert(Int(String(number))!)
        }
    }

    var matches: Int {
        return winning.intersection(numbers).count
    }

    func points() -> Int {
        if matches == 0 {
            return 0
        }
        return (pow(2, matches - 1) as NSDecimalNumber).intValue
    }

    func getWinning() -> [Int] {
        var won = [Int]()

        for i in 0..<matches {
            won.append(id + i)
        }

        return won
    }
}
