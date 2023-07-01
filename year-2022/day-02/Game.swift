//
//  Game.swift
//  Advent02
//
//  Created by Dragan Cecavac on 02.12.22.
//

import Foundation

class Game {
    var rounds = [Round]()

    init(_ input: String) {
        for line in input.split(separator: "\n") {
            rounds.append(Round(first: line.first!, second: line.last!))
        }
    }

    func assumedScore() -> UInt {
        return rounds.map { $0.assumedScore() }.reduce(0, +)
    }

    func actualScore() -> UInt {
        return rounds.map { $0.actualScore()! }.reduce(0, +)
    }
}
